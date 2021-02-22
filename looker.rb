{
  title: 'Looker',
  connection: {
    fields: [
      {
        name: 'client_id',
        optional: false,
        label: 'Client ID',
        hint: 'Client_id part of API3 Key.'
      },
      {
        name: 'client_secret',
        control_type: 'password',
        optional: false,
        label: 'Client secret',
        hint: 'Client_secret part of API3 Key.'
      },
      {
        name: 'host_url',
        label: 'Host URL',
        optional: false,
        control_type: 'url',
        hint: 'Base URL for links in emails.' \
          ' E.g.<b>hostname.cloud.looker.com</b>'
      }
    ],
    authorization: {
      type: 'api_key',
      acquire: lambda { |connection|
        {
          auth_token:
          post("https://#{connection['host_url']}/api/3.1/login").
            payload(
              client_id: connection['client_id'],
              client_secret: connection['client_secret']
            ).
            request_format_www_form_urlencoded.
            dig('access_token')
        }
      },
      refresh_on: [401],
      apply: lambda { |connection|
        headers('Authorization': "token #{connection['auth_token']}")
      }
    },
    base_uri: lambda do |connection|
      "https://#{connection['host_url']}/api/3.1/"
    end
  },
  test: lambda do |_connection|
    get('looks?limit=1')
  end,
  methods:
  {
    looker_look_schema: lambda do
      [
        { name: 'can', type: 'object', properties: [
          { name: 'copy', type: 'boolean' },
          { name: 'create', type: 'boolean' },
          { name: 'destroy', type: 'boolean' },
          { name: 'download', type: 'boolean' },
          { name: 'download_unlimited', type: 'boolean',
            label: 'Download unlimited' },
          { name: 'explore', type: 'boolean' },
          { name: 'find_and_replace', type: 'boolean',
            label: 'Find and replace' },
          { name: 'index', type: 'boolean' },
          { name: 'move', type: 'boolean' },
          { name: 'recover', type: 'boolean' },
          { name: 'render', type: 'boolean' },
          { name: 'run', type: 'boolean' },
          { name: 'schedule', type: 'boolean' },
          { name: 'show', type: 'boolean' },
          { name: 'show_errors', type: 'boolean',
            label: 'Show errors' },
          { name: 'update', type: 'boolean' }
        ] },
        { name: 'content_metadata_id', type: 'integer', control_type: 'number',
          label: 'Content metadata ID' },
        { name: 'id', type: 'integer', control_type: 'number',
          label: 'Look ID',
          hint: 'Unique ID of look.' },
        { name: 'title', hint: 'Title of the look.' },
        { name: 'content_favorite_id', type: 'integer', control_type: 'number',
          label: 'Content favorite ID' },
        { name: 'created_at', type: 'date_time' },
        { name: 'deleted', type: 'boolean',
          control_type: 'checkbox',
          hint: "To soft delete a look, select the look's deleted property." \
          " to <b>Yes</b>. To undelete a look, select the look's deleted" \
          ' property to <b>No</b>.',
          label: 'Soft delete?',
          toggle_hint: 'Select from list',
          toggle_field: {
            name: 'deleted',
            type: 'string',
            control_type: 'text',
            label: 'Soft delete?',
            toggle_hint: 'Use custom value',
            hint: 'Allowed values are: <b>true</b> or <b>false</b>.'
          } },
        { name: 'deleted_at', type: 'date_time', control_type: 'date_time',
          label: 'Deleted at' },
        { name: 'deleter_id', type: 'integer', control_type: 'number',
          label: 'Deleter ID' },
        { name: 'description', hint: 'Description of look.' },
        { name: 'embed_url', label: 'Embed URL', control_type: 'url' },
        { name: 'excel_file_url', label: 'Excel file URL',
          control_type: 'url' },
        { name: 'favorite_count', type: 'integer', control_type: 'number',
          label: 'Favorite count' },
        { name: 'google_spreadsheet_formula',
          label: 'Google spreadsheet formula' },
        { name: 'image_embed_url', label: 'Image embed URL',
          control_type: 'url' },
        { name: 'is_run_on_load', type: 'boolean',
          control_type: 'checkbox',
          hint: 'Select <b>yes</b> to auto-run query when Look viewed.',
          label: 'Is run on load?',
          toggle_hint: 'Select from list',
          toggle_field: {
            name: 'is_run_on_load',
            type: 'string',
            control_type: 'text',
            label: 'Is run on load?',
            toggle_hint: 'Use custom value',
            hint: 'Allowed values are: <b>true</b> or <b>false</b>.'
          } },
        { name: 'last_accessed_at', type: 'date_time',
          control_type: 'date_time',
          label: 'Last accessed at' },
        { name: 'last_updater_id', type: 'integer', control_type: 'number',
          label: 'Last updater ID' },
        { name: 'last_viewed_at', type: 'date_time', control_type: 'date_time',
          label: 'Last viewed at' },
        { name: 'model', type: 'object', properties: [
          { name: 'id' },
          { name: 'label' }
        ] },
        { name: 'public', type: 'boolean',
          control_type: 'checkbox',
          label: 'Public access',
          hint: 'Select <b>Yes</b> to enable public access.',
          toggle_hint: 'Select from list',
          toggle_field: {
            name: 'public',
            type: 'string',
            control_type: 'text',
            label: 'Public access',
            toggle_hint: 'Use custom value',
            hint: 'Allowed values are: <b>true</b> or <b>false</b>.'
          } },
        { name: 'public_slug', label: 'Public slug' },
        { name: 'public_url', label: 'Public URL', control_type: 'url' },
        { name: 'query_id', type: 'integer', control_type: 'number',
          hint: 'ID of the query',
          label: 'Query ID' },
        { name: 'short_url', label: 'Short URL', control_type: 'url' },
        { name: 'folder', type: 'object', properties: [
          { name: 'name' },
          { name: 'parent_id', label: 'Parent ID' },
          { name: 'id' },
          { name: 'content_metadata_id', type: 'integer',
            control_type: 'number',
            label: 'Content metadata ID' },
          { name: 'created_at', type: 'date_time', control_type: 'date_time',
            label: 'Created at' },
          { name: 'creator_id', type: 'integer', control_type: 'number',
            label: 'Creator ID' },
          { name: 'child_count', type: 'integer', control_type: 'number',
            label: 'Child count' },
          { name: 'external_id',
            label: 'External ID' },
          { name: 'is_embed', type: 'boolean',
            label: 'Is embed?' },
          { name: 'is_embed_shared_root', type: 'boolean',
            label: 'Is embed shared root?' },
          { name: 'is_embed_users_root', type: 'boolean',
            label: 'Is embed userd root?' },
          { name: 'is_personal', type: 'boolean',
            label: 'Is personal?' },
          { name: 'is_personal_descendant', type: 'boolean',
            label: 'Is personal descendant?' },
          { name: 'is_shared_root', type: 'boolean',
            label: 'Is shared root?' },
          { name: 'is_users_root', type: 'boolean',
            label: 'Is users root?' },
          { name: 'can', type: 'object', properties: [
            { name: 'create', type: 'boolean' },
            { name: 'destroy', type: 'boolean' },
            { name: 'edit_content', type: 'boolean',
              label: 'Edit content' },
            { name: 'index', type: 'boolean' },
            { name: 'move_content', type: 'boolean',
              label: 'Move content' },
            { name: 'see_admin_spaces', type: 'boolean',
              label: 'See admin spaces' },
            { name: 'show', type: 'boolean' },
            { name: 'update', type: 'boolean' }
          ] }
        ] },
        { name: 'folder_id', hint: 'Folder ID',
          control_type: 'select',
          label: 'Folder ID',
          pick_list: :folder_id,
          toggle_hint: 'Select from list',
          toggle_field: {
            name: 'folder_id',
            label: 'Folder ID',
            type: 'string',
            control_type: 'text',
            toggle_hint: 'Use custom value',
            hint: 'Allowed values, <b>E.g.1, 2</b>'
          } },
        { name: 'updated_at', type: 'date_time', control_type: 'date_time',
          label: 'Updated at' },
        { name: 'user_id', hint: 'User ID',
          control_type: 'select',
          label: 'User ID',
          type: 'integer',
          pick_list: :user_id,
          toggle_hint: 'Select from list',
          toggle_field: {
            name: 'user_id',
            label: 'User ID',
            type: 'integer',
            control_type: 'text',
            toggle_hint: 'Use custom value',
            hint: 'Allowed values, <b>E.g.1, 2</b>'
          } },
        { name: 'view_count', type: 'integer', control_type: 'number',
          label: 'View count' },
        { name: 'user', type: 'object', properties: [
          { name: 'id', type: 'integer' }
        ] },
        { name: 'space_id', hint: 'Space ID',
          control_type: 'select',
          label: 'Space ID',
          pick_list: :space_id,
          toggle_hint: 'Select from list',
          toggle_field: {
            name: 'space_id',
            label: 'Space ID',
            type: 'string',
            control_type: 'text',
            toggle_hint: 'Use custom value',
            hint: 'Allowed values, <b>E.g.1, 2</b>'
          } },
        { name: 'space', type: 'object', properties: [
          { name: 'name' },
          { name: 'parent_id', label: 'Parent ID' },
          { name: 'id' },
          { name: 'content_metadata_id', type: 'integer',
            control_type: 'number',
            label: 'Content metadata ID' },
          { name: 'created_at', type: 'date_time', control_type: 'date_time',
            label: 'Created at' },
          { name: 'creator_id', type: 'integer', control_type: 'number',
            label: 'Creator ID' },
          { name: 'child_count', type: 'integer', control_type: 'number',
            label: 'Child count' },
          { name: 'external_id',
            label: 'External ID' },
          { name: 'is_embed', type: 'boolean',
            label: 'Is embed?' },
          { name: 'is_embed_shared_root', type: 'boolean',
            label: 'Is embed shared root?' },
          { name: 'is_embed_users_root', type: 'boolean',
            label: 'Is embed userd root?' },
          { name: 'is_personal', type: 'boolean',
            label: 'Is personal?' },
          { name: 'is_personal_descendant', type: 'boolean',
            label: 'Is personal descendant?' },
          { name: 'is_shared_root', type: 'boolean',
            label: 'Is shared root?' },
          { name: 'is_users_root', type: 'boolean',
            label: 'Is users root?' },
          { name: 'can', type: 'object', properties: [
            { name: 'create', type: 'boolean' },
            { name: 'destroy', type: 'boolean' },
            { name: 'edit_content', type: 'boolean',
              label: 'Edit content' },
            { name: 'index', type: 'boolean' },
            { name: 'move_content', type: 'boolean',
              label: 'Move content' },
            { name: 'see_admin_spaces', type: 'boolean',
              label: 'See admin spaces' },
            { name: 'show', type: 'boolean' },
            { name: 'update', type: 'boolean' }
          ] }
        ] },
        { name: 'query', type: 'object', properties: [
          { name: 'can', type: 'object', properties: [
            { name: 'cost_estimate', type: 'boolean',
              label: 'Cost estimate' },
            { name: 'create', type: 'boolean' },
            { name: 'download', type: 'boolean' },
            { name: 'download_unlimited', type: 'boolean',
              label: 'Download unlimited' },
            { name: 'explore', type: 'boolean' },
            { name: 'generate_drill_links', type: 'boolean',
              label: 'Generate drill links' },
            { name: 'index', type: 'boolean' },
            { name: 'render', type: 'boolean' },
            { name: 'run', type: 'boolean' },
            { name: 'schedule', type: 'boolean' },
            { name: 'see_aggregate_table_lookml', type: 'boolean',
              label: 'See aggregate table lookml' },
            { name: 'see_derived_table_lookml', type: 'boolean',
              label: 'See derived table lookml' },
            { name: 'see_lookml', type: 'boolean',
              label: 'See lookml' },
            { name: 'see_results', type: 'boolean',
              label: 'See results' },
            { name: 'see_sql', type: 'boolean',
              label: 'See SQL' },
            { name: 'show', type: 'boolean' },
            { name: 'use_custom_fields', type: 'boolean',
              label: 'Use custom fields' }
          ] },
          { name: 'id', type: 'integer' },
          { name: 'model' },
          { name: 'view' },
          { name: 'fields', type: 'array', of: 'string' },
          { name: 'pivots', type: 'array', of: 'string' },
          { name: 'fill_fields', label: 'Fill fields',
            type: 'array', of: 'string' },
          { name: 'filters', type: 'object', properties: [] },
          { name: 'filter_expression', label: 'Filter expression' },
          { name: 'sorts', type: 'array', of: 'string' },
          { name: 'limit' },
          { name: 'column_limit', label: 'Column limit' },
          { name: 'total', type: 'boolean' },
          { name: 'row_total', label: 'Row total' },
          { name: 'subtotals', type: 'array', of: 'string' },
          { name: 'vis_config', type: 'object', properties: [
            { name: 'conditional_formatting_include_nulls', type: 'boolean',
              label: 'Conditional formatting include nulls' },
            { name: 'conditional_formatting_include_totals', type: 'boolean',
              label: 'Conditional formatting include totals' },
            { name: 'enable_conditional_formatting', type: 'boolean',
              label: 'Enable conditional formatting' },
            { name: 'hide_row_totals', type: 'boolean',
              label: 'Hide row totals' },
            { name: 'hide_totals', type: 'boolean',
              label: 'Hide totals' },
            { name: 'show_row_numbers', type: 'boolean',
              label: 'Show row numbers' },
            { name: 'table_theme', label: 'Table theme' },
            { name: 'truncate_column_names', type: 'boolean',
              label: 'Truncate column names' },
            { name: 'defaults_version', type: 'integer',
              label: 'Defaults version' },
            { name: 'interpolation' },
            { name: 'label_density', type: 'integer',
              label: 'Label density' },
            { name: 'legend_position', label: 'Legend position' },
            { name: 'limit_displayed_rows', type: 'boolean',
              label: 'Limit displayed rows' },
            { name: 'ordering' },
            { name: 'plot_size_by_field', type: 'boolean',
              label: 'Plot size by field' },
            { name: 'point_style', label: 'Point style' },
            { name: 'series_types', type: 'object', properties: [] },
            { name: 'show_null_labels', type: 'boolean',
              label: 'Show null labels' },
            { name: 'show_null_points', type: 'boolean',
              label: 'Show null points' },
            { name: 'show_silhouette', type: 'boolean',
              label: 'Show silhouette' },
            { name: 'show_totals_labels', type: 'boolean',
              label: 'Show total labels' },
            { name: 'show_value_labels', type: 'boolean',
              label: 'Show value labels' },
            { name: 'show_view_names', type: 'boolean',
              label: 'Show view names' },
            { name: 'show_x_axis_label', type: 'boolean',
              label: 'Show x axis label' },
            { name: 'show_x_axis_ticks', type: 'boolean',
              label: 'Show x axis ticks' },
            { name: 'show_y_axis_labels', type: 'boolean',
              label: 'Show y axis labels' },
            { name: 'show_y_axis_ticks', type: 'boolean',
              label: 'Show y axis ticks' },
            { name: 'stacking' },
            { name: 'totals_color', label: 'Total color' },
            { name: 'trellis' },
            { name: 'type' },
            { name: 'x_axis_gridlines', type: 'boolean',
              label: 'X axis gridlines' },
            { name: 'x_axis_reversed', type: 'boolean',
              label: 'X axis reversed' },
            { name: 'x_axis_scale', label: 'X axis scale' },
            { name: 'y_axis_combined', type: 'boolean',
              label: 'Y axis combined' },
            { name: 'y_axis_gridlines', type: 'boolean',
              label: 'Y axis gridlines' },
            { name: 'y_axis_reversed', type: 'boolean',
              label: 'Y axis reversed' },
            { name: 'y_axis_scale_mode', label: 'Y axis scale mode' },
            { name: 'y_axis_tick_density', label: 'Y axis tick density' },
            { name: 'y_axis_tick_density_custom', type: 'integer',
              label: 'Y axis tick density custom' }
          ] },
          { name: 'filter_config', type: 'object', properties: [] },
          { name: 'visible_ui_sections', label: 'Visible UI sections' },
          { name: 'slug' },
          { name: 'dynamic_fields', label: 'Dynamic fields' },
          { name: 'client_id', label: 'Client ID' },
          { name: 'share_url', label: 'Share URL', control_type: 'url' },
          { name: 'expanded_share_url', label: 'Expanded share URL',
            control_type: 'url' },
          { name: 'url', label: 'URL', control_type: 'url' },
          { name: 'query_timezone', label: 'Query timezone' },
          { name: 'has_table_calculations', type: 'boolean',
            label: 'Has table calculations?' },
          { name: 'runtime', type: 'integer' }
        ] },
        { name: 'url', label: 'URL', control_type: 'url' }
      ]
    end,
    query_schema: lambda do
      [
        { name: 'can', type: 'object', properties: [
          { name: 'cost_estimate', type: 'boolean',
            label: 'Cost estimate' },
          { name: 'create', type: 'boolean' },
          { name: 'download', type: 'boolean' },
          { name: 'download_unlimited', type: 'boolean',
            label: 'Download unlimited' },
          { name: 'explore', type: 'boolean' },
          { name: 'generate_drill_links', type: 'boolean',
            label: 'Generate drill links' },
          { name: 'index', type: 'boolean' },
          { name: 'render', type: 'boolean' },
          { name: 'run', type: 'boolean' },
          { name: 'schedule', type: 'boolean' },
          { name: 'see_aggregate_table_lookml', type: 'boolean',
            label: 'See aggregate table lookml' },
          { name: 'see_derived_table_lookml', type: 'boolean',
            label: 'See derived table lookml' },
          { name: 'see_lookml', type: 'boolean',
            label: 'See lookml' },
          { name: 'see_results', type: 'boolean',
            label: 'See results' },
          { name: 'see_sql', type: 'boolean',
            label: 'See SQL' },
          { name: 'show', type: 'boolean' },
          { name: 'use_custom_fields', type: 'boolean',
            label: 'Use custom fields' }
        ] },
        { name: 'id', type: 'integer' },
        { name: 'model', optional: false,
          hint: 'Model name(Database name)',
          control_type: 'select',
          pick_list: :model_list,
          toggle_hint: 'Select from list',
          toggle_field: {
            name: 'model',
            label: 'Model',
            type: 'string',
            control_type: 'text',
            toggle_hint: 'Use custom value',
            hint: 'Valid DB name'
          } },
        { name: 'view', optional: false,
          hint: 'The view specifies a table to query and the fields to' \
          'include from that table.',
          control_type: 'select',
          pick_list: :view_list,
          pick_list_params: { model: 'model' },
          toggle_hint: 'Select from list',
          toggle_field: {
            name: 'view',
            label: 'View',
            type: 'string',
            control_type: 'text',
            toggle_hint: 'Use custom value',
            hint: 'View name'
          } },
        { name: 'fields',
          sticky: true,
          hint: 'Specify which fields from view are used to create look.',
          control_type: 'multiselect',
          delimeter: ',',
          extends_schema: true,
          pick_list: :fields_list,
          type: 'string',
          pick_list_params: { model: 'model', view: 'view' },
          toggle_hint: 'Select from list',
          toggle_field: {
            name: 'fields',
            label: 'Fields',
            type: 'string',
            control_type: 'text',
            toggle_hint: 'Use custom value',
            hint: 'Give valid field names.'
          } },
        { name: 'pivots',
          hint: 'Select any one of the field value which will become' \
          ' a column in look.',
          control_type: 'multiselect',
          extends_schema: true,
          type: 'string',
          delimeter: ',',
          pick_list: :pivot_list,
          pick_list_params: { fields: 'fields' },
          toggle_hint: 'Select from list',
          toggle_field: {
            name: 'pivots',
            label: 'Pivots',
            type: 'string',
            control_type: 'text',
            toggle_hint: 'Use custom value',
            hint: 'Give valid pivot name.'
          } },
        { name: 'fill_fields', type: 'array', of: 'string',
          label: 'Fill fields',
          hint: 'Add the field values when the missing fields are known.' },
        { name: 'filters', type: 'object', properties: [] },
        { name: 'filter_expression', label: 'Filter expression',
          hint: 'When using filter expressions in LookML, you should' \
          ' place the expression in quotation marks (click' \
         '<a href = "https://docs.looker.com/reference/filter-expressions">' \
          'here</a> for proper use of filter expressions).' },
        { name: 'sorts', type: 'array', of: 'string',
          hint: 'Specifies sort fields and sort direction ascending(asc) or' \
          ' descending (desc) for the query.' \
          ' <b>E.g. [order_items.total_sales: asc].',
          control_type: 'plain-text' },
        { name: 'limit', hint: 'Specifies the row limit of the query.' },
        { name: 'column_limit', label: 'Column limit',
          hint: 'Specifies the row limit of the query.' },
        { name: 'total', type: 'boolean', control_type: 'checkbox',
          hint: 'Click <b>Yes</b> to get the total of fields.',
          toggle_hint: 'Select from list',
          toggle_field: {
            name: 'total',
            type: 'string',
            control_type: 'text',
            label: 'Total',
            toggle_hint: 'Use custom value',
            hint: 'Allowed values are: <b>true</b> or <b>false</b>.'
          } },
        { name: 'row_total', label: 'Row total',
          hint: 'Total of the rows' },
        { name: 'subtotals', type: 'array', of: 'string',
          label: 'Sub totals of fields',
          hint: 'Specify fields on which to run subtotals.' },
        { name: 'vis_config', label: 'Visual configuration',
          hint: 'Visualization configuration properties.',
          type: 'object', properties: [] },
        { name: 'filter_config', label: 'Filter configuration',
          hint: 'Filter configuration properties.',
          type: 'object', properties: [] },
        { name: 'visible_ui_sections', label: 'Visible UI sections',
          hint: 'User interface visible sections.' },
        { name: 'slug' },
        { name: 'dynamic_fields', label: 'Dynamic fields',
          hint: 'Enter the name of dynamic field.' },
        { name: 'client_id', label: 'Client ID',
          hint: 'Must be a unique 22 character alphanumeric string.' \
          ' Otherwise default one will be generated' },
        { name: 'share_url', label: 'Share URL' },
        { name: 'expanded_share_url', label: 'Expanded share URL' },
        { name: 'url', label: 'URL' },
        { name: 'query_timezone', label: 'Query timezone',
          hint: 'Timezone in which the Dashboard will run by default.' },
        { name: 'has_table_calculations', type: 'boolean',
          label: 'Has table calculations?' }
      ]
    end,
    search_look_input_schema: lambda do
      [
        { name: 'id', label: 'Look ID',
          hint: 'ID of the <b>look</b>.' },
        { name: 'title', label: 'Look title',
          sticky: true,
          hint: 'Search look by its title.' },
        { name: 'description', sticky: true,
          hint: 'The look description.' },
        { name: 'content_favorite_id', type: 'integer',
          label: 'Content favorite ID', control_type: 'number',
          hint: 'Select looks with a particular content favorite id.' },
        { name: 'space_id', label: 'Space ID',
          hint: 'Select looks in a particular space.' },
        { name: 'user_id', label: 'User ID',
          hint: 'Select looks created by a particular user.' },
        { name: 'view_count', label: 'View count',
          hint: 'Select looks with particular number of views.' },
        { name: 'deleted', type: 'boolean', control_type: 'checkbox',
          hint: 'Select soft deleted looks.',
          toggle_hint: 'Select from list',
          toggle_field: {
            name: 'deleted',
            type: 'string',
            control_type: 'text',
            label: 'Deleted',
            toggle_hint: 'Use custom value',
            hint: 'Allowed values are: <b>true</b> or <b>false</b>.'
          } },
        { name: 'query_id', type: 'integer',
          label: 'Query ID', control_type: 'number',
          hint: 'Select looks that reference a particular query by query ID.' },
        { name: 'curate', type: 'boolean', control_type: 'checkbox',
          hint: 'Select looks which exist only in personal spaces.',
          toggle_hint: 'Select from list',
          toggle_field: {
            name: 'curate',
            type: 'string',
            control_type: 'text',
            label: 'Curate',
            toggle_hint: 'Use custom value',
            hint: 'Allowed values are: <b>true</b> or <b>false</b>.'
          } },
        { name: 'fields', hint: 'requested fields.' },
        { name: 'page', type: 'integer', control_type: 'number',
          hint: 'The current page to fetch results from.' },
        { name: 'per_page', type: 'integer', control_type: 'number',
          label: 'Per page', hint: 'How many looks to show per page.' },
        { name: 'limit', type: 'integer', control_type: 'number',
          hint: 'Maximum number of looks to retrieve. (used with offset and' \
            ' takes priority over page and per_page)' },
        { name: 'offset', type: 'integer', control_type: 'number',
          hint: 'Number of results to skip before returning any.' \
            ' (used with limit and takes priority over page and per_page)' },
        { name: 'sorts', control_type: 'select',
          pick_list: :sort_list,
          label: 'Sort fields',
          hint: 'Specifies the field that should be used to sort ' \
            'the results of the look.',
          toggle_hint: 'Select from list',
          type: 'string',
          toggle_field: {
            name: 'sorts',
            type: 'string',
            label: 'Sort fields',
            control_type: 'text',
            toggle_hint: 'Use custom value',
            hint: 'Allowed values, <b>E.g. title, id</b>'
          } },
        { name: 'filter_or', type: 'boolean', control_type: 'checkbox',
          hint: 'If Filter OR is Yes or True, results will include rows that' \
            ' match any of the search criteria. If Filter OR is No or False,' \
            ' results will return only rows that match all search criteria.' \
            ' Default: False',
          label: 'Filter OR',
          toggle_hint: 'Select from list',
          toggle_field: {
            name: 'filter_or',
            type: 'string',
            control_type: 'text',
            label: 'Filter OR',
            toggle_hint: 'Use custom value',
            hint: 'Allowed values are: <b>true</b> or <b>false</b>.'
          } }
      ]
    end,
    run_look_input_schema: lambda do
      [
        { name: 'id', hint: 'ID of the look.',
          control_type: 'number', label: 'Look ID',
          type: 'integer', optional: false },
        { name: 'result_format', hint: 'Format of result.',
          control_type: 'select',
          label: 'Result format',
          optional: false,
          extends_schema: true,
          pick_list: :result_format_list,
          toggle_hint: 'Select from list',
          type: 'string',
          toggle_field: {
            name: 'result_format',
            label: 'Result format',
            type: 'string',
            control_type: 'text',
            toggle_hint: 'Use custom value',
            hint: 'Allowed values, <b>E.g.json, csv</b>'
          } },
        { name: 'limit', type: 'integer', control_type: 'number',
          hint: 'Provide number of rows to be retunred.' },
        { name: 'apply_formatting', type: 'boolean',
          label: 'Apply formatting',
          control_type: 'checkbox',
          render_input: 'boolean_conversion',
          parse_output: 'boolean_conversion',
          hint: 'Apply model-specified formatting to each result.' },
        { name: 'apply_formatting', type: 'boolean',
          control_type: 'checkbox',
          hint: 'Select <b>Yes</b> to apply model-specified' \
          ' formatting to each result.',
          label: 'Apply formatting',
          toggle_hint: 'Select from list',
          toggle_field: {
            name: 'apply_formatting',
            type: 'string',
            control_type: 'text',
            label: 'Apply formatting',
            toggle_hint: 'Use custom value',
            hint: 'Allowed values are: <b>true</b> or <b>false</b>.'
          } },
        { name: 'apply_vis', type: 'boolean',
          control_type: 'checkbox',
          hint: 'Select <b>Yes</b> to apply visualization options to results.',
          label: 'Apply visualization',
          toggle_hint: 'Select from list',
          toggle_field: {
            name: 'apply_vis',
            type: 'string',
            control_type: 'text',
            label: 'Apply visualization',
            toggle_hint: 'Use custom value',
            hint: 'Allowed values are: <b>true</b> or <b>false</b>.'
          } },
        { name: 'cache', type: 'boolean',
          control_type: 'checkbox',
          hint: 'Select <b>Yes</b> to get results from cache if available.',
          label: 'Cache',
          toggle_hint: 'Select from list',
          toggle_field: {
            name: 'cache',
            type: 'string',
            control_type: 'text',
            label: 'Cache',
            toggle_hint: 'Use custom value',
            hint: 'Allowed values are: <b>true</b> or <b>false</b>.'
          } },
        { name: 'image_width', type: 'integer',
          label: 'Image width', control_type: 'number',
          hint: 'Render width for image formats.' },
        { name: 'image_height', type: 'integer',
          label: 'Image height', control_type: 'number',
          hint: 'Render height for image formats.' },
        { name: 'generate_drill_links', type: 'boolean',
          control_type: 'checkbox',
          hint: 'Generate drill links' \
          ' (only applicable to "json_detail" format).',
          label: 'Generate drill links',
          toggle_hint: 'Select from list',
          toggle_field: {
            name: 'generate_drill_links',
            type: 'string',
            control_type: 'text',
            label: 'Generate drill links',
            toggle_hint: 'Use custom value',
            hint: 'Allowed values are: <b>true</b> or <b>false</b>.'
          } },
        { name: 'force_production', type: 'boolean',
          control_type: 'checkbox',
          hint: 'Select <b>yes</b> to force use of production models even' \
          ' if the user is in development mode.',
          label: 'Force production',
          toggle_hint: 'Select from list',
          toggle_field: {
            name: 'force_production',
            type: 'string',
            control_type: 'text',
            label: 'Force production',
            toggle_hint: 'Use custom value',
            hint: 'Allowed values are: <b>true</b> or <b>false</b>.'
          } },
        { name: 'cache_only', type: 'boolean',
          control_type: 'checkbox',
          hint: 'Select <b>Yes</b> to retrieve any results from cache' \
          ' even if the results have expired.',
          label: 'Cache only',
          toggle_hint: 'Select from list',
          toggle_field: {
            name: 'cache_only',
            type: 'string',
            control_type: 'text',
            label: 'Cache only',
            toggle_hint: 'Use custom value',
            hint: 'Allowed values are: <b>true</b> or <b>false</b>.'
          } },
        { name: 'path_prefix', label: 'Path prefix',
          hint: 'Prefix to use for drill links (url encoded).' },
        { name: 'rebuild_pdts', type: 'boolean', control_type: 'checkbox',
          hint: 'Rebuild the persisted tables, if there is no valid' \
          ' persisted table in the database. Select <b>Yes</b>' \
          ' for rebuild persisted tables.',
          label: 'Rebuild persisted tables',
          toggle_hint: 'Select from list',
          toggle_field: {
            name: 'rebuild_pdts',
            type: 'string',
            control_type: 'text',
            label: 'Rebuild persisted tables',
            toggle_hint: 'Use custom value',
            hint: 'Allowed values are: <b>true</b> or <b>false</b>.'
          } },
        { name: 'server_table_calcs', type: 'boolean',
          control_type: 'checkbox',
          hint: 'Select <b>Yes</b> to perform table calculations' \
          ' on query results.',
          label: 'Server table calculations',
          toggle_hint: 'Select from list',
          toggle_field: {
            name: 'server_table_calcs',
            type: 'string',
            control_type: 'text',
            label: 'Server table calculations',
            toggle_hint: 'Use custom value',
            hint: 'Allowed values are: <b>true</b> or <b>false</b>.'
          } }
      ]
    end,
    # This method is for Custom action
    make_schema_builder_fields_sticky: lambda do |schema|
      schema.map do |field|
        if field['properties'].present?
          field['properties'] = call('make_schema_builder_fields_sticky',
                                     field['properties'])
        end
        field['sticky'] = true
        field
      end
    end,
    # Formats input/output schema to replace any special characters in name,
    # without changing other attributes (method required for custom action)
    format_schema: lambda do |input|
      input&.map do |field|
        if (props = field[:properties])
          field[:properties] = call('format_schema', props)
        elsif (props = field['properties'])
          field['properties'] = call('format_schema', props)
        end
        if (name = field[:name])
          field[:label] = field[:label].presence || name.labelize
          field[:name] = name.
                         gsub(/\W/) { |spl_chr| "__#{spl_chr.encode_hex}__" }
        elsif (name = field['name'])
          field['label'] = field['label'].presence || name.labelize
          field['name'] = name.
                          gsub(/\W/) { |spl_chr| "__#{spl_chr.encode_hex}__" }
        end
        field
      end
    end,
    # Formats payload to inject any special characters that previously removed
    format_payload: lambda do |payload|
      if payload.is_a?(Array)
        payload.map do |array_value|
          call('format_payload', array_value)
        end
      elsif payload.is_a?(Hash)
        payload.each_with_object({}) do |(key, value), hash|
          key = key.gsub(/__\w+__/) do |string|
            string.gsub(/__/, '').decode_hex.as_utf8
          end
          if value.is_a?(Array) || value.is_a?(Hash)
            value = call('format_payload', value)
          end
          hash[key] = value
        end
      end
    end,
    # Formats response to replace any special characters with valid strings
    # (method required for custom action)
    format_response: lambda do |response|
      response = response&.compact unless response.is_a?(String) || response
      if response.is_a?(Array)
        response.map do |array_value|
          call('format_response', array_value)
        end
      elsif response.is_a?(Hash)
        response.each_with_object({}) do |(key, value), hash|
          key = key.gsub(/\W/) { |spl_chr| "__#{spl_chr.encode_hex}__" }
          if value.is_a?(Array) || value.is_a?(Hash)
            value = call('format_response', value)
          end
          hash[key] = value
        end
      else
        response
      end
    end
  },

  object_definitions:
  {
    search_looks_input: {
      fields: lambda do |_connection, _config_fields|
        call('search_look_input_schema')
      end
    },
    get_look_input: {
      fields: lambda do |_connection, _config_fields|
        [
          { name: 'look_id', optional: false, type: 'integer',
            hint: 'Id of look' }
        ]
      end
    },
    create_look_input: {
      fields: lambda do |_connection, _config_fields|
        call('looker_look_schema').
          only('title', 'description', 'is_run_on_load', 'public',
               'query_id', 'folder_id', 'user_id', 'space_id').
          required('space_id', 'query_id', 'title')
      end
    },
    update_look_input: {
      fields: lambda do |_connection, _config_fields|
        call('looker_look_schema').
          only('id', 'title', 'deleted', 'description', 'is_run_on_load',
               'public', 'query_id', 'folder_id', 'user_id', 'space_id').
          required('id')
      end
    },
    run_look_input: {
      fields: lambda do |_connection, _config_fields|
        call('run_look_input_schema')
      end
    },
    delete_look_input: {
      fields: lambda do |_connection, _config_fields|
        [
          { name: 'look_id', optional: false, type: 'integer',
            hint: 'Id of look' }
        ]
      end
    },
    search_looks_output: {
      fields: lambda do |_connection, _config_fields|
        [
          { name: 'response', type: 'array', of: 'object', properties:
            call('looker_look_schema') }
        ]
      end
    },
    get_look_output: {
      fields: lambda do |_connection, _config_fields|
        call('looker_look_schema')
      end
    },
    create_look_output: {
      fields: lambda do |_connection, _config_fields|
        call('looker_look_schema')
      end
    },
    update_look_output: {
      fields: lambda do |_connection, _config_fields|
        call('looker_look_schema')
      end
    },
    run_look_output: {
      fields: lambda do |_connection, config_fields|
        next [] if config_fields.blank?
          { name: "#{config_fields['result_format']}",
            label: "#{config_fields['result_format']&.upcase}" }
        end
    },
    create_query_input: {
      fields: lambda do |_connection, _config_fields|
        call('query_schema').
          ignored('id', 'can', 'slug', 'share_url', 'expanded_share_url',
                  'url', 'has_table_calculations')
      end
    },
    create_query_output: {
      fields: lambda do |_connection, _config_fields|
        call('query_schema')
      end
    },
    custom_action_input: {
      fields: lambda do |connection, config_fields|
        verb = config_fields['verb']
        input_schema = parse_json(config_fields.dig('input', 'schema') || '[]')
        data_props =
          input_schema.map do |field|
            if config_fields['request_type'] == 'multipart' &&
               field['binary_content'] == 'true'
              field['type'] = 'object'
              field['properties'] = [
                { name: 'file_content', optional: false },
                {
                  name: 'content_type',
                  default: 'text/plain',
                  sticky: true
                },
                { name: 'original_filename', sticky: true }
              ]
            end
            field
          end
        data_props = call('make_schema_builder_fields_sticky', data_props)
        input_data =
          if input_schema.present?
            if input_schema.dig(0, 'type') == 'array' &&
               input_schema.dig(0, 'details', 'fake_array')
              {
                name: 'data',
                type: 'array',
                of: 'object',
                properties: data_props.dig(0, 'properties')
              }
            else
              { name: 'data', type: 'object', properties: data_props }
            end
          end
        [
          {
            name: 'path',
            hint: 'Base URI is <b>' \
            "#{connection['host_url']}/api/3.1/" \
            '</b> - path will be appended to this URI. Use absolute URI to ' \
            'override this base URI.',
            optional: false
          },
          if %w[post put patch].include?(verb)
            {
              name: 'request_type',
              default: 'json',
              sticky: true,
              extends_schema: true,
              control_type: 'select',
              pick_list: [
                ['JSON request body', 'json'],
                ['URL encoded form', 'url_encoded_form'],
                ['Mutipart form', 'multipart'],
                ['Raw request body', 'raw']
              ]
            }
          end,
          {
            name: 'response_type',
            default: 'json',
            sticky: false,
            extends_schema: true,
            control_type: 'select',
            pick_list: [['JSON response', 'json'], ['Raw response', 'raw']]
          },
          if %w[get options delete].include?(verb)
            {
              name: 'input',
              label: 'Request URL parameters',
              sticky: true,
              add_field_label: 'Add URL parameter',
              control_type: 'form-schema-builder',
              type: 'object',
              properties: [
                {
                  name: 'schema',
                  sticky: input_schema.blank?,
                  extends_schema: true
                },
                input_data
              ].compact
            }
          else
            {
              name: 'input',
              label: 'Request body parameters',
              sticky: true,
              type: 'object',
              properties:
                if config_fields['request_type'] == 'raw'
                  [{
                    name: 'data',
                    sticky: true,
                    control_type: 'text-area',
                    type: 'string'
                  }]
                else
                  [
                    {
                      name: 'schema',
                      sticky: input_schema.blank?,
                      extends_schema: true,
                      schema_neutral: true,
                      control_type: 'schema-designer',
                      sample_data_type: 'json_input',
                      custom_properties:
                        if config_fields['request_type'] == 'multipart'
                          [{
                            name: 'binary_content',
                            label: 'File attachment',
                            default: false,
                            optional: true,
                            sticky: true,
                            render_input: 'boolean_conversion',
                            parse_output: 'boolean_conversion',
                            control_type: 'checkbox',
                            type: 'boolean'
                          }]
                        end
                    },
                    input_data
                  ].compact
                end
            }
          end,
          {
            name: 'request_headers',
            sticky: false,
            extends_schema: true,
            control_type: 'key_value',
            empty_list_title: 'Does this HTTP request require headers?',
            empty_list_text: 'Refer to the API documentation and add ' \
            'required headers to this HTTP request',
            item_label: 'Header',
            type: 'array',
            of: 'object',
            properties: [{ name: 'key' }, { name: 'value' }]
          },
          unless config_fields['response_type'] == 'raw'
            {
              name: 'output',
              label: 'Response body',
              sticky: true,
              extends_schema: true,
              schema_neutral: true,
              control_type: 'schema-designer',
              sample_data_type: 'json_input'
            }
          end,
          {
            name: 'response_headers',
            sticky: false,
            extends_schema: true,
            schema_neutral: true,
            control_type: 'schema-designer',
            sample_data_type: 'json_input'
          }
        ].compact
      end
    },
    custom_action_output: {
      fields: lambda do |_connection, config_fields|
        response_body = { name: 'body' }
        [
          if config_fields['response_type'] == 'raw'
            response_body
          elsif (output = config_fields['output'])
            output_schema = call('format_schema', parse_json(output))
            if output_schema.dig(0, 'type') == 'array' &&
               output_schema.dig(0, 'details', 'fake_array')
              response_body[:type] = 'array'
              response_body[:properties] = output_schema.dig(0, 'properties')
            else
              response_body[:type] = 'object'
              response_body[:properties] = output_schema
            end
            response_body
          end,
          if (headers = config_fields['response_headers'])
            header_props = parse_json(headers)&.map do |field|
              if field[:name].present?
                field[:name] = field[:name].gsub(/\W/, '_').downcase
              elsif field['name'].present?
                field['name'] = field['name'].gsub(/\W/, '_').downcase
              end
              field
            end
            { name: 'headers', type: 'object', properties: header_props }
          end
        ].compact
      end
    }
  },

  actions:
  {
    search_looks:
    {
      title: 'Search looks',
      subtitle: 'Search looks in Looker',
      description: "<span class='provider'>Search looks</span> in " \
        "<span class='provider'>Looker</span>",
      input_fields: lambda do |object_definitions|
        object_definitions['search_looks_input']
      end,
      execute: lambda do |_connection, input|
        { response: get('looks/search').params(input)&.
          after_error_response(/.*/) do |_code, body, _header, message|
            error("#{message}: #{body}")
          end }
      end,
      output_fields: lambda do |object_definitions|
        object_definitions['search_looks_output']
      end,
      sample_output: lambda do |_connection, _input|
        { response: get('looks?limit=1') }
      end
    },
    get_look:
    {
      title: 'Get look',
      subtitle: 'Get look in Looker',
      description: "<span class='provider'>Get look</span> in " \
        "<span class='provider'>Looker</span> by ID",
      input_fields: lambda do |object_definitions|
        object_definitions['get_look_input']
      end,
      execute: lambda do |_connection, input|
        get("looks/#{input['look_id']}")&.
        after_error_response(/.*/) do |_code, body, _header, message|
          error("#{message}: #{body}")
        end
      end,
      output_fields: lambda do |object_definitions|
        object_definitions['get_look_output']
      end,
      sample_output: lambda do |_connection, _input|
        get('looks?limit=1')&.first
      end
    },
    create_look:
    {
      title: 'Create look',
      subtitle: 'Create look in Looker',
      description: "<span class='provider'>Create look</span> in " \
        "<span class='provider'>Looker</span>",
      input_fields: lambda do |object_definitions|
        object_definitions['create_look_input']
      end,
      execute: lambda do |_connection, input|
        post('looks').payload(input)&.
        after_error_response(/.*/) do |_code, body, _header, message|
          error("#{message}: #{body}")
        end
      end,
      output_fields: lambda do |object_definitions|
        object_definitions['create_look_output']
      end,
      sample_output: lambda do |_connection, _input|
        get('looks?limit=1')&.first
      end
    },
    update_look:
    {
      title: 'Update look',
      subtitle: 'Update look in Looker',
      description: "<span class='provider'>Update look</span> in " \
        "<span class='provider'>Looker</span> by ID",
      input_fields: lambda do |object_definitions|
        object_definitions['update_look_input']
      end,
      execute: lambda do |_connection, input|
        patch("looks/#{input['id']}").
          payload(input.except('id'))&.
          after_error_response(/.*/) do |_code, body, _header, message|
            error("#{message}: #{body}")
          end
      end,
      output_fields: lambda do |object_definitions|
        object_definitions['update_look_output']
      end,
      sample_output: lambda do |_connection, _input|
        get('looks?limit=1')&.first
      end
    },
    delete_look:
    {
      title: 'Delete look',
      subtitle: 'Delete look in Looker',
      description: "<span class='provider'>Delete look</span> in " \
        "<span class='provider'>Looker</span> by ID",
      input_fields: lambda do |object_definitions|
        object_definitions['delete_look_input']
      end,
      execute: lambda do |_connection, input|
        delete("looks/#{input['look_id']}")&.
        after_error_response(/.*/) do |_code, body, _header, message|
          error("#{message}: #{body}")
        end
      end
    },
    run_look:
    {
      title: 'Run look',
      subtitle: 'Run look in Looker',
      description: "<span class='provider'>Run look</span> in " \
        "<span class='provider'>Looker</span> by ID",
      input_fields: lambda do |object_definitions|
        object_definitions['run_look_input']
      end,
      execute: lambda do |_connection, input|
        output = get("looks/#{input['id']}/run/#{input['result_format']}").
        params(input.except('id', 'result_format'))&.
        after_error_response(/.*/) do |_code, body, _header, message|
          error("#{message}: #{body}")
        end&.response_format_raw
        { input['result_format'] => output }
      end,
      output_fields: lambda do |object_definitions|
        object_definitions['run_look_output']
      end,
      sample_output: lambda do |_connection, input|
        next [] if input.blank?
        if input['result_format'] == 'jpg' ||
              input['result_format'] == 'png' ||
              input['result_format'] == 'xlsx'
          { input['result_format'] => '0x89504e470d0a1a0a000' \
            '0000d4…(32786 bytes more)' }
        end
      end
    },
    create_query:
    {
      title: 'Create query',
      subtitle: 'Create query in Looker',
      description: "<span class='provider'>Create query</span> in " \
        "<span class='provider'>Looker</span>",
      input_fields: lambda do |object_definitions|
        object_definitions['create_query_input']
      end,
      execute: lambda do |_connection, input|
        post('queries').payload(input)&.
        after_error_response(/.*/) do |_code, body, _header, message|
          error("#{message}: #{body}")
        end
      end,
      output_fields: lambda do |object_definitions|
        object_definitions['create_query_output']
      end,
      sample_output: lambda do |_connection, _input|
        get('queries/1')
      end
    },
    custom_action: {
      subtitle: 'Build your own Looker action with a HTTP request',
      description: lambda do |object_value, _object_label|
        "<span class='provider'>" \
        "#{object_value[:action_name] || 'Custom action'}</span> in " \
        "<span class='provider'>Looker</span>"
      end,
      help: {
        body: 'Build your own Looker action with a HTTP request. ' \
        'The request will be authorized with your Looker connection.',
        learn_more_url: 'https://docs.looker.com/reference/api-and-integration',
        learn_more_text: 'Looker API documentation'
      },
      config_fields: [
        {
          name: 'action_name',
          hint: "Give this action you're building a descriptive name, e.g. " \
          'create record, get record',
          default: 'Custom action',
          optional: false,
          schema_neutral: true
        },
        {
          name: 'verb',
          label: 'Method',
          hint: 'Select HTTP method of the request',
          optional: false,
          control_type: 'select',
          pick_list: %w[get post put delete patch].
            map { |verb| [verb.upcase, verb] }
        }
      ],
      input_fields: lambda do |object_definition|
        object_definition['custom_action_input']
      end,
      execute: lambda do |_connection, input|
        verb = input['verb']
        if %w[get post put patch options delete].exclude?(verb)
          error("#{verb.upcase} not supported")
        end
        path = input['path']
        data = input.dig('input', 'data') || {}
        if input['request_type'] == 'multipart'
          data = data.each_with_object({}) do |(key, val), hash|
            hash[key] = if val.is_a?(Hash)
                          [val[:file_content],
                           val[:content_type],
                           val[:original_filename]]
                        else
                          val
                        end
          end
        end
        request_headers = input['request_headers']
          &.each_with_object({}) do |item, hash|
          hash[item['key']] = item['value']
        end || {}
        request = case verb
                  when 'get'
                    get(path, data)
                  when 'post'
                    if input['request_type'] == 'raw'
                      post(path).request_body(data)
                    else
                      post(path, data)
                    end
                  when 'put'
                    if input['request_type'] == 'raw'
                      put(path).request_body(data)
                    else
                      put(path, data)
                    end
                  when 'patch'
                    if input['request_type'] == 'raw'
                      patch(path).request_body(data)
                    else
                      patch(path, data)
                    end
                  when 'options'
                    options(path, data)
                  when 'delete'
                    delete(path, data)
                  end.headers(request_headers)
        request = case input['request_type']
                  when 'url_encoded_form'
                    request.request_format_www_form_urlencoded
                  when 'multipart'
                    request.request_format_multipart_form
                  else
                    request
                  end
        response =
          if input['response_type'] == 'raw'
            request.response_format_raw
          else
            request
          end.
          after_error_response(/.*/) do |code, body, headers, message|
            error({ code: code, message: message,
                    body: body, headers: headers }.
              to_json)
          end
        response.after_response do |_code, res_body, res_headers|
          {
            body: res_body ? call('format_response', res_body) : nil,
            headers: res_headers
          }
        end
      end,
      output_fields: lambda do |object_definition|
        object_definition['custom_action_output']
      end
    }
  },
  pick_lists: {
    space_id: lambda do |_connection|
      get('spaces/search').
        map { |space| [space['name'], space['id']] }
    end,
    folder_id: lambda do |_connection|
      get('folders/search').
        map { |folder| [folder['name'], folder['id']] }
    end,
    user_id: lambda do |_connection|
      get('users').
        map { |user| [user['first_name'], user['id']] }
    end,
    model_list: lambda do |_connection|
      get('lookml_models').reject do |model|
        model['name'] == 'system__activity'
      end&.
      map { |model| [model['label'], model['name']] }
    end,
    view_list: lambda do |_connection, model:|
      get("lookml_models/#{model}")['explores'].
        map { |view| [view['label'], view['name']] }
    end,
    fields_list: lambda do |_connection, model:, view:|
      get("lookml_models/#{model}/explores/#{view}").dig('sets', -1, 'value')&.
       map { |field| [field, field] }
    end,
    pivot_list: lambda do |_connection, fields:|
      fields.map { |field| [field, field] }
    end,
    sort_list: lambda do |_connection|
      [
        %w[Title title],
        %w[User\ id user_id],
        %w[Id id],
        %w[Created\ at created_at],
        %w[Space\ id space_id],
        %w[Folder\ id folder_id],
        %w[Description description],
        %w[Updated\ at updated_at],
        %w[Last\ updater\ id last_updater_id],
        %w[View\ count view_count],
        %w[Favorite\ count favorite_count],
        %w[Content\ favorite\ id content_favorite_id],
        %w[Deleted deleted],
        %w[Deleted\ at deleted_at],
        %w[Last\ viewed\ at last_viewed_at],
        %w[Last\ accessed\ at last_accessed_at],
        %w[Query\ id query_id]
      ]
    end,
    result_format_list: lambda do |_connection|
      [
        %w[Json json],
        %w[Json\ detail json_detail],
        %w[CSV csv],
        %w[Txt txt],
        %w[HTML html],
        %w[MD md],
        %w[MS\ Excel\ spreadsheet xlsx],
        %w[SQL sql],
        %w[PNG\ image png],
        %w[JPG\ image jpg]
      ]
    end
  }
}
