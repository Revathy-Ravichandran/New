{
  title: 'BigCommerce',
  connection: {
    fields: [
      {
        name: 'access_token',
        control_type: 'password',
        optional: false,
        hint: 'Access token can be obtained by creating an API account or ' \
        'installing an app in a BigCommerce control panel.'
      },
      {
        name: 'store_hash',
        optional: false,
        hint: 'eg: https://api.bigcommerce.com/stores/<storehash>/v3'
      }
    ],
    authorization: {
      type: 'api_key',
      apply: lambda do |connection|
        headers("X-Auth-Token": "#{connection['access_token']}")
      end
    },
    base_uri: lambda do |connection|
      "https://api.bigcommerce.com/stores/#{connection['store_hash']}/"
    end
  },

  test: lambda do |_connection|
    get('v3/customers')
  end,

  methods:
  {
    customer_schema: lambda do |_input| [
      { name: 'email' },
      { name: 'first_name' },
      { name: 'last_name' },
      { name: 'company' },
      { name: 'phone' },
      { name: 'registration_ip_address' },
      { name: 'notes' },
      { name: 'tax_exempt_category' },
      { name: 'customer_group_id', type: 'integer' },
      { name: 'id', type: 'integer', render_input: 'integer_conversion',
       parse_output: 'integer_conversion', optional: false,
       hint: 'ID of the customer' },
      { name: 'date_modified' },
      { name: 'date_created' },
      { name: 'address_count', type: 'integer' },
      { name: 'attribute_count', type: 'integer' },
      { name: 'authentication', type: 'object', properties:[
        { name: 'force_password_reset', type: 'boolean',
        control_type: 'checkbox',
        optional: false,
        render_input: 'boolean_conversion',
        parse_output: 'boolean_conversion',
        toggle_hint: 'Select from list',
        toggle_field: {
          name: 'force_password_reset',
          type: 'boolean',
          label: 'force_password_reset',
          optional: false,
          control_type: 'text',
          render_input: 'boolean_conversion',
          parse_output: 'boolean_conversion',
          toggle_hint: 'Use custom value',
          hint: 'Allowed values are true or false'
        }},
        { name: 'new_password' }
      ]},
      { name: 'addresses', type: 'array', of: 'object', properties:[
        { name: 'first_name', optional: 'false' },
        { name: 'last_name', optional: 'false' },
        { name: 'company', optional: 'false' },
        { name: 'address1', optional: 'false' },
        { name: 'address2' },
        { name: 'city', optional: 'false' },
        { name: 'state_or_province', optional: 'false' },
        { name: 'postal_code', optional: 'false' },
        { name: 'country_code', optional: 'false' },
        { name: 'phone' },
        { name: 'address_type' },
        { name: 'customer_id', type: 'integer' },
        { name: 'id', type: 'integer' },
        { name: 'country' },
      ]},
      { name: 'attributes', type: 'array', of: 'object', properties:[
        { name: 'attribute_id', type: 'integer' },
        { name: 'value' },
        { name: 'id', type: 'integer' },
        { name: 'customer_id', type: 'integer' },
        { name: 'date_modified' },
        { name: 'date_created' },
      ]},
      { name: 'store_credit_amounts', type: 'array', of: 'object', properties:[
        { name: 'amount', type: 'integer'}
      ]},
      { name: 'accepts_product_review_abandoned_cart_emails', type: 'boolean',
        control_type: 'checkbox',
        optional: false,
        render_input: 'boolean_conversion',
        parse_output: 'boolean_conversion',
        toggle_hint: 'Select from list',
        toggle_field: {
          name: 'accepts_product_review_abandoned_cart_emails',
          type: 'boolean',
          label: 'accepts_product_review_abandoned_cart_emails',
          optional: false,
          control_type: 'text',
          render_input: 'boolean_conversion',
          parse_output: 'boolean_conversion',
          toggle_hint: 'Use custom value',
          hint: 'Allowed values are true or false'
        } },
      { name: 'channel_ids', type: 'array', of: 'object', properties:[
        { name: '__name'}
      ]},
    ]
    end,
    meta_schema: lambda do |_input|[
      { name: 'pagination', type: 'object', properties:[
        { name: 'total', type: 'integer' },
        { name: 'count', type: 'integer' },
        { name: 'per_page', type: 'integer' },
        { name: 'current_page', type: 'integer' },
        { name: 'total_pages', type: 'integer' },
      ]},
      { name: 'links', type: 'object', properties:[
        { name: 'previous' },
        { name: 'current' },
        { name: 'next' },
      ]}
    ]
    end,
    product_schema: lambda do |_input|[
      { name: 'availability', control_type: 'select',
        pick_list: :availability_list,
        toggle_hint: 'Select from list',
        toggle_field: {
          name: 'availability',
          label: 'availability',
          type: 'string', control_type: 'text',
          toggle_hint: 'Use custom value'
      }},
      { name: 'availability_description' },
      { name: 'bin_picking_number' },
      { name: 'brand_id' },
      { name: 'brand_name' },
      { name: 'brand_id' },
      { name: 'bulk_pricing_rules', type: 'array', of: 'object', properties:[
        { name: 'amount', type: 'integer' },
        { name: 'id', type: 'integer' },
        { name: 'quantity_max', type: 'integer' },
        { name: 'quantity_min', type: 'integer' },
        { name: 'type', control_type: 'select',
          pick_list: :bulk_pricing_rules_type_list,
          toggle_hint: 'Select from list',
          toggle_field: {
            name: 'type',
            label: 'type',
            type: 'string', control_type: 'text',
            toggle_hint: 'Use custom value'
        } },
      ]},
      { name: 'categories', type: 'array', of: 'object', properties:[
        { name: '__name' },
      ]},
      { name: 'condition', control_type: 'select',
        pick_list: :condition_list,
        toggle_hint: 'Select from list',
        toggle_field: {
          name: 'condition',
          label: 'condition',
          type: 'string', control_type: 'text',
          toggle_hint: 'Use custom value'
        } },
      { name: 'cost_price', type: 'integer' },
      { name: 'custom_fields', type: 'array', of: 'object', properties:[
        { name: 'id', type: 'integer' },
        { name: 'name' },
        { name: 'value'}
      ]},
      { name: 'custom_url', type: 'object', properties:[
        { name: 'is_customized', type: 'boolean', type: 'boolean',
          control_type: 'checkbox',
          optional: false,
          render_input: 'boolean_conversion',
          parse_output: 'boolean_conversion',
          toggle_hint: 'Select from list',
          toggle_field: {
            name: 'is_customized',
            type: 'boolean',
            label: 'is_customized',
            optional: false,
            control_type: 'text',
            render_input: 'boolean_conversion',
            parse_output: 'boolean_conversion',
            toggle_hint: 'Use custom value',
            hint: 'Allowed values are true or false'
          } },
        { name: 'url'}
      ]},
      { name: 'depth', type: 'integer' },
      { name: 'description' },
      { name: 'fixed_cost_shipping_price', type: 'integer' },
      { name: 'gift_wrapping_options_list', type: 'array', of: 'object', properties:[
        { name: '__name'}
      ]},
      { name: 'gift_wrapping_options_type', control_type: 'select',
        pick_list: :gift_wrapping_options_list,
        toggle_hint: 'Select from list',
        toggle_field: {
          name: 'gift_wrapping_options_type',
          label: 'gift_wrapping_options_type',
          type: 'string', control_type: 'text',
          toggle_hint: 'Use custom value'
        } },
      { name: 'gtin' },
      { name: 'height', type: 'integer' },
      { name: 'images', type: 'array', of: 'object', properties: [
        { name: 'description' },
        { name: 'image_file' },
        { name: 'image_url' },
        { name: 'is_thumbnail', type: 'boolean' },
        { name: 'sort_order', type: 'integer' },
        { name: 'date_modified' },
        { name: 'id', type: 'integer' },
        { name: 'product_id', type: 'integer' },
        { name: 'url_standard' },
        { name: 'url_thumbnail' },
        { name: 'url_tiny' },
        { name: 'url_zoom' },
      ]},
      { name: 'inventory_level', type: 'integer' },
      { name: 'inventory_tracking', control_type: 'select',
        pick_list: :inventory_tracking_list,
        toggle_hint: 'Select from list',
        toggle_field: {
          name: 'inventory_tracking',
          label: 'inventory_tracking',
          type: 'string', control_type: 'text',
          toggle_hint: 'Use custom value'
        } },
      { name: 'inventory_warning_level', type: 'integer' },
      { name: 'is_condition_shown', type: 'boolean',
        control_type: 'checkbox',
        optional: false,
        render_input: 'boolean_conversion',
        parse_output: 'boolean_conversion',
        toggle_hint: 'Select from list',
        toggle_field: {
          name: 'is_condition_shown',
          type: 'boolean',
          label: 'is_condition_shown',
          optional: false,
          control_type: 'text',
          render_input: 'boolean_conversion',
          parse_output: 'boolean_conversion',
          toggle_hint: 'Use custom value',
          hint: 'Allowed values are true or false'
      } },
      { name: 'is_featured', type: 'boolean',
        control_type: 'checkbox',
        optional: false,
        render_input: 'boolean_conversion',
        parse_output: 'boolean_conversion',
        toggle_hint: 'Select from list',
        toggle_field: {
          name: 'is_featured',
          type: 'boolean',
          label: 'is_featured',
          optional: false,
          control_type: 'text',
          render_input: 'boolean_conversion',
          parse_output: 'boolean_conversion',
          toggle_hint: 'Use custom value',
          hint: 'Allowed values are true or false'
        } },
      { name: 'is_free_shipping', type: 'boolean',
        control_type: 'checkbox',
        optional: false,
        render_input: 'boolean_conversion',
        parse_output: 'boolean_conversion',
        toggle_hint: 'Select from list',
        toggle_field: {
          name: 'is_free_shipping',
          type: 'boolean',
          label: 'is_free_shipping',
          optional: false,
          control_type: 'text',
          render_input: 'boolean_conversion',
          parse_output: 'boolean_conversion',
          toggle_hint: 'Use custom value',
          hint: 'Allowed values are true or false'
        } },
      { name: 'is_preorder_only', type: 'boolean',
        control_type: 'checkbox',
        optional: false,
        render_input: 'boolean_conversion',
        parse_output: 'boolean_conversion',
        toggle_hint: 'Select from list',
        toggle_field: {
          name: 'is_preorder_only',
          type: 'boolean',
          label: 'is_preorder_only',
          optional: false,
          control_type: 'text',
          render_input: 'boolean_conversion',
          parse_output: 'boolean_conversion',
          toggle_hint: 'Use custom value',
          hint: 'Allowed values are true or false'
        } },
      { name: 'is_price_hidden', type: 'boolean',
        control_type: 'checkbox',
        optional: false,
        render_input: 'boolean_conversion',
        parse_output: 'boolean_conversion',
        toggle_hint: 'Select from list',
        toggle_field: {
          name: 'is_price_hidden',
          type: 'boolean',
          label: 'is_price_hidden',
          optional: false,
          control_type: 'text',
          render_input: 'boolean_conversion',
          parse_output: 'boolean_conversion',
          toggle_hint: 'Use custom value',
          hint: 'Allowed values are true or false'
        } },
      { name: 'is_visible', type: 'boolean',
        control_type: 'checkbox',
        optional: false,
        render_input: 'boolean_conversion',
        parse_output: 'boolean_conversion',
        toggle_hint: 'Select from list',
        toggle_field: {
          name: 'is_visible',
          type: 'boolean',
          label: 'is_visible',
          optional: false,
          control_type: 'text',
          render_input: 'boolean_conversio',
          parse_output: 'boolean_conversion',
          toggle_hint: 'Use custom value',
          hint: 'Allowed values are true or false'
        } },
      { name: 'layout_file' },
      { name: 'meta_description' },
      { name: 'meta_keywords', type: 'array', of: 'object', properties:[
        { name: '__name'}
      ]},
      { name: 'mpn' },
      { name: 'name' },
      { name: 'open_graph_description' },
      { name: 'open_graph_title' },
      { name: 'open_graph_type' },
      { name: 'open_graph_use_image', type: 'boolean',
        control_type: 'checkbox',
        optional: false,
        render_input: 'boolean_conversion',
        parse_output: 'boolean_conversion',
        toggle_hint: 'Select from list',
        toggle_field: {
          name: 'open_graph_use_image',
          type: 'boolean',
          label: 'open_graph_use_image',
          optional: false,
          control_type: 'text',
          render_input: 'boolean_conversion',
          parse_output: 'boolean_conversion',
          toggle_hint: 'Use custom value',
          hint: 'Allowed values are true or false'
        } },
      { name: 'open_graph_use_meta_description', type: 'boolean',
        control_type: 'checkbox',
        optional: false,
        render_input: 'boolean_conversion',
        parse_output: 'boolean_conversion',
        toggle_hint: 'Select from list',
        toggle_field: {
          name: 'open_graph_use_meta_description',
          type: 'boolean',
          label: 'open_graph_use_meta_description',
          optional: false,
          control_type: 'text',
          render_input: 'boolean_conversion',
          parse_output: 'boolean_conversion',
          toggle_hint: 'Use custom value',
          hint: 'Allowed values are true or false'
        } },
      { name: 'open_graph_use_product_name', type: 'boolean',
        control_type: 'checkbox',
        optional: false,
        render_input: 'boolean_conversion',
        parse_output: 'boolean_conversion',
        toggle_hint: 'Select from list',
        toggle_field: {
          name: 'open_graph_use_product_name',
          type: 'boolean',
          label: 'open_graph_use_product_name',
          optional: false,
          control_type: 'text',
          render_input: 'boolean_conversion',
          parse_output: 'boolean_conversion',
          toggle_hint: 'Use custom value',
          hint: 'Allowed values are true or false'
        } },
      { name: 'order_quantity_maximum', type: 'integer' },
      { name: 'order_quantity_minimum', type: 'integer' },
      { name: 'page_title' },
      { name: 'preorder_message' },
      { name: 'preorder_release_date' },
      { name: 'price', type: 'integer' },
      { name: 'price_hidden_label' },
      { name: 'product_tax_code' },
      { name: 'related_products', type: 'array', of: 'object', properties:[
        { name: '__name'}
      ]},
      { name: 'retail_price', type: 'integer' },
      { name: 'reviews_count', type: 'integer' },
      { name: 'reviews_rating_sum', type: 'integer' },
      { name: 'sale_price', type: 'integer' },
      { name: 'search_keywords' },
      { name: 'sku' },
      { name: 'sort_order', type: 'integer' },
      { name: 'tax_class_id', type: 'integer' },
      { name: 'total_sold', type: 'integer' },
      { name: 'type', control_type: 'select',
        pick_list: :type_list,
        toggle_hint: 'Select from list',
        toggle_field: {
          name: 'type',
          label: 'type',
          type: 'string', control_type: 'text',
          toggle_hint: 'Use custom value'
        } },
      { name: 'upc' },
      { name: 'videos', type: 'array', of: 'object', properties:[
        { name: 'description' },
        { name: 'sort_order', type: 'integer' },
        { name: 'title' },
        { name: 'type' },
        { name: 'video_id' },
        { name: 'id', type: 'integer' },
        { name: 'length' },
        { name: 'product_id', type: 'integer'}
      ]},
      { name:'view_count', type: 'integer' },
      { name:'warranty' },
      { name:'weight', type: 'integer' },
      { name:'width', type: 'integer' },
      { name:'base_variant_id', type: 'integer' },
      { name:'calculated_price', type: 'integer' },
      { name:'date_created' },
      { name:'date_modified' },
      { name:'id', type: 'integer' },
      { name:'map_price', type: 'integer' },
      { name: 'modifiers', type: 'array', of: 'object', properties:[
        { name: 'config', type: 'object', properties:[
          { name: 'checkbox_label' },
          { name: 'checked_by_default', type: 'boolean' },
          { name: 'date_earliest_value' },
          { name: 'date_latest_value' },
          { name: 'date_limit_mode' },
          { name: 'date_limited', type: 'boolean' },
          { name: 'default_value' },
          { name: 'file_max_size', type: 'integer' },
          { name: 'file_types_mode' },
          { name: 'file_types_other', type: 'array', of: 'object', properties:[
            { name: '__name'}
          ]},
          { name: 'file_types_supported', type: 'array', of: 'object', properties:[
            { name: '__name'}
          ]},
          { name: 'number_highest_value', type: 'integer' },
          { name: 'number_integers_only', type: 'boolean' },
          { name: 'number_limit_mode' },
          { name: 'number_limited', type: 'boolean' },
          { name: 'number_lowest_value' },
          { name: 'product_list_adjusts_inventory', type: 'boolean' },
          { name: 'product_list_adjusts_pricing', type: 'boolean' },
          { name: 'product_list_shipping_calc', control_type: 'select',
            pick_list: :product_list_shipping_calc_list,
            toggle_hint: 'Select from list',
            toggle_field: {
              name: 'product_list_shipping_calc',
              label: 'product_list_shipping_calc',
              type: 'string', control_type: 'text',
              toggle_hint: 'Use custom value'
            } },
          { name: 'text_characters_limited', type: 'boolean' },
          { name: 'text_lines_limited', type: 'boolean' },
          { name: 'text_max_length', type: 'integer' },
          { name: 'text_max_lines', type: 'integer' },
          { name: 'text_min_length', type: 'integer'}
        ]},
        { name: 'display_name' },
        { name: 'required', type: 'boolean' },
        { name: 'sort_order', type: 'integer' },
        { name: 'type' },
        { name: 'id', type: 'integer' },
        { name: 'name' },
        { name: 'option_values', type: 'array', of: 'object', properties:[
          { name: 'adjusters', type: 'object', properties:[
            { name: 'image_url' },
            { name: 'price', type: 'object', properties:[
              { name: 'adjuster' },
              { name: 'adjuster_value', type: 'integer'}
            ]},
            { name: 'purchasing_disabled', type: 'object', properties:[
              { name: 'message' },
              { name: 'status', type: 'boolean'}
            ]},
            { name: 'weight', type: 'object', properties:[
              { name: 'adjuster' },
              { name: 'adjuster_value', type: 'integer'}
            ]},
            { name: 'is_default', type: 'boolean' },
            { name: 'label' },
            { name: 'sort_order', type: 'integer' },
            { name: 'value_data' },
            { name: 'id', type: 'integer' },
            { name: 'option_id', type: 'integer' },
          ]},
          { name: 'product_id', type: 'integer'}
        ]},
        { name: 'option_set_display' },
        { name: 'option_set_id', type: 'integer'}
      ]},
      { name: 'options', type: 'array', of: 'object', properties:[
        { name: 'config', type: 'object', properties:[
          { name: 'checkbox_label' },
          { name: 'checked_by_default', type: 'boolean' },
          { name: 'date_earliest_value' },
          { name: 'date_latest_value' },
          { name: 'date_limit_mode' },
          { name: 'date_limited', type: 'boolean' },
          { name: 'default_value' },
          { name: 'file_max_size', type: 'integer' },
          { name: 'file_types_mode' },
          { name: 'file_types_other', type: 'array', of: 'object', properties:[
            { name: '__name'}
          ]},
          { name: 'file_types_supported', type: 'array', of: 'object', properties:[
            { name: '__name'}
          ]},
          { name: 'number_highest_value', type: 'integer' },
          { name: 'number_integers_only', type: 'boolean' },
          { name: 'number_limit_mode' },
          { name: 'number_limited', type: 'boolean' },
          { name: 'number_lowest_value' },
          { name: 'product_list_adjusts_inventory', type: 'boolean' },
          { name: 'product_list_adjusts_pricing', type: 'boolean' },
          { name: 'product_list_shipping_calc' },
          { name: 'text_characters_limited', type: 'boolean' },
          { name: 'text_lines_limited', type: 'boolean' },
          { name: 'text_max_length', type: 'integer' },
          { name: 'text_max_lines', type: 'integer' },
          { name: 'text_min_length', type: 'integer'}
        ]},
        { name: 'display_name' },
        { name: 'id', type: 'integer' },
        { name: 'option_values', type: 'array', of: 'object', properties:[
          { name: 'is_default', type: 'boolean' },
          { name: 'label' },
          { name: 'sort_order', type: 'integer' },
          { name: 'value_data' },
          { name: 'id', type: 'integer' },
        ]},
        { name: 'product_id', type: 'integer' },
        { name: 'sort_order', type: 'integer' },
        { name: 'type' },
      ]},
      { name: 'variants', type: 'object', properties:[
        { name: 'bin_picking_number' },
        { name: 'cost_price', type: 'integer' },
        { name: 'depth', type: 'integer' },
        { name: 'fixed_cost_shipping_price', type: 'integer' },
        { name: 'height', type: 'integer' },
        { name: 'inventory_level', type: 'integer' },
        { name: 'inventory_warning_level', type: 'integer' },
        { name: 'is_free_shipping', type: 'boolean' },
        { name: 'price', type: 'integer' },
        { name: 'purchasing_disabled', type: 'boolean',
          control_type: 'checkbox',
          optional: false,
          render_input: 'boolean_conversion',
          parse_output: 'boolean_conversion',
          toggle_hint: 'Select from list',
          toggle_field: {
            name: 'purchasing_disabled',
            type: 'boolean',
            label: 'purchasing_disabled',
            optional: false,
            control_type: 'text',
            render_input: 'boolean_conversion',
            parse_output: 'boolean_conversion',
            toggle_hint: 'Use custom value',
            hint: 'Allowed values are true or false'
          }},
        { name: 'purchasing_disabled_message' },
        { name: 'retail_price', type: 'integer' },
        { name: 'sale_price', type: 'integer' },
        { name: 'upc' },
        { name: 'weight', type: 'integer' },
        { name: 'width', type: 'integer' },
        { name: 'calculated_price' },
        { name: 'id', type: 'integer' },
        { name: 'option_values', type: 'array', of: 'object', properties:[
          { name: 'label' },
          { name: 'option_display_name' },
          { name: 'id', type: 'integer' },
          { name: 'option_id', type: 'integer' },
        ]},
        { name: 'product_id', type: 'integer' },
        { name: 'sku' },
        { name: 'sku_id', type: 'integer'}
      ]}
    ]
    end,
    customer_search_output: lambda do |_input|[
      { name: 'data', type: 'array', of: 'object', properties:
        call('customer_schema','')
      },
      { name: 'meta', type: 'object', properties:
        call('meta_schema','')
      }
    ]
    end,
    product_search_output: lambda do |_input|[
      { name: 'data', type: 'array', of: 'object', properties:
        call('product_schema','')
      },
      { name: 'meta', type: 'object', properties:
        call('meta_schema','')
      }
    ]
    end,
    customer_get_input: lambda do |_input|
      { name: 'id:in', optional: false, type: 'integer'}
    end,
    product_get_input: lambda do |_input|[
      { name: 'product_id', type: 'integer', optional: false},
      { name: 'include' },
      { name: 'include_fields' },
      { name: 'exclude_fields'}
    ]
    end,
    customer_get_output: lambda do |_input|
      call('customer_search_output','')
    end,
    product_get_output: lambda do |_input|[
      { name: 'data', type: 'object', properties:
        call('product_schema','')
      },
      { name: 'meta', type: 'object', properties:
        call('meta_schema','')
      }
    ]
    end,
    customer_delete_input: lambda do |_input|
      { name: 'id_in', optional: false}
    end,
    product_delete_input: lambda do |_input|
      { name: 'product_id', optional: false}
    end,
    price_list_schema: lambda do |_input|
      [
          { name: 'id', type: 'integer' },
          { name: 'date_created' },
          { name: 'date_modified' },
          { name: 'name' },
          { name: 'active', type: 'boolean'}
      ]
    end,
    search_price_list_schema: lambda do |_input|
      [

        { name: 'data', type: 'array', of: 'object', properties:[
          call('price_list_schema','')
        ]},
        { name: 'meta', type: 'object', properties:[
          call('meta_schema','')
        ]}
      ]
    end,
    customer_search_input: lambda do |_input|
      [
        { name: 'page', type: 'integer' },
        { name: 'limit', type: 'number' },
        { name: 'date_created' },
        { name: 'date_created:max' },
        { name: 'date_created:min' },
        { name: 'date_modified' },
        { name: 'date_modified:max' },
        { name: 'date_modified:min' },
        { name: 'email:in' },
        { name: 'include' },
        { name: 'sort' },
      ]
    end,
    product_search_input: lambda do |_input|
      [
        { name: 'id', type: 'integer' },
        { name: 'name' },
        { name: 'sku' },
        { name: 'upc' },
        { name: 'price', type: 'number' },
        { name: 'weight', type: 'number' },
        { name: 'condition' },
        { name: 'brand_id', type: 'integer' },
        { name: 'date_modified' },
        { name: 'date_last_imported' },
        { name: 'is_visible', type: 'boolean' },
        { name: 'is_featured', type: 'integer' },
        { name: 'is_free_shipping', type: 'integer' },
        { name: 'inventory_level', type: 'integer' },
        { name: 'inventory_low', type: 'integer' },
        { name: 'out_of_stock', type: 'integer' },
        { name: 'total_sold', type: 'integer' },
        { name: 'type' },
        { name: 'categories', type: 'integer' },
        { name: 'keyword' },
        { name: 'keyword_context' },
        { name: 'status', type: 'integer' },
        { name: 'include' },
        { name: 'include_fields' },
        { name: 'exclude_fields' },
        { name: 'availability' },
        { name: 'price_list_id', type: 'integer' },
        { name: 'page', type: 'integer' },
        { name: 'limit', type: 'integer' },
        { name: 'direction' },
        { name: 'sort'}
      ]
    end,
    customer_create_input: lambda do |_input|
        call('customer_schema','').ignored('id','date_modified','date_created',
          'address_count','attribute_count','channel_ids','attributes').
          concat([{ name: 'attributes', type: 'array', of: 'object', properties:[
          { name: 'attribute_id', type: 'integer', optional: false},
          { name: 'attribute_value', optional: false},
        ]}]).required('email','first_name','last_name')
    end,
    product_create_input: lambda do |_input|
        call('product_schema','').ignored('options','option_set_display',
          'option_set_id','modifiers','base_variant_id','calculated_price',
        'date_created','date_modified','id','map_price')
        .required('name','price','type','weight')
    end,
    customer_update_input: lambda do |_input|
        call('customer_schema','').ignored('date_modified','date_created',
          'address_count','attribute_count','channel_ids','attributes','addresses')
    end,
    product_update_input: lambda do |_input|
        call('product_schema','').ignored('options','option_set_display',
          'option_set_id','modifiers','base_variant_id','calculated_price',
        'date_created','date_modified','map_price')
        .concat([{ name: 'product_id', optional: false,
          hint: 'ID of the product'}])
    end,
    customer_trigger_output: lambda do |_input|
      call('customer_schema','').ignored('address_count','attribute_count',
        'authentication','addresses','attributes','store_credit_amounts',
      'accepts_product_review_abandoned_cart_emails')
    end,
    product_trigger_output: lambda do |_input|
      call('product_schema','').ignored('bulk_pricing_rules','custom_fields',
      'images','videos','modifiers','options','variants')
    end,
    format_input: lambda do |input|
      input.each do |key, value|
        if value.is_a?(Array) && value&.first&.keys&.include?("__name")
          input[key] = value.map { |val| val['__name'] }
        end
      end
    end,
    format_output: lambda do |output|
      output.each do |key, value|
        if value.is_a?(Array) && !value&.first&.is_a?(Hash)
          output[key] = value.map { |val| { __name: val } }
        end
      end
    end,
    customer_sample_output: lambda do |_input|
      get('v3/customers')['data']&.first
    end,
    product_sample_output: lambda do |_input|
      get('v3/catalog/products')['data']&.first
    end,
    customer_search_get_sample_output: lambda do |_input|
      get('v3/customers')
    end,
    product_search_get_sample_output: lambda do |_input|
      get('v3/catalog/products')
    end,
    customer_search_url: lambda do |input|
      get('v3/customers').params(input.except('object'))
    end,
    product_search_url: lambda do |input|
      get('v3/catalog/products').params(input.except('object'))
    end,
    customer_get_url: lambda do |input|
      get("v3/customers").params(input.except('object'))
    end,
    product_get_url: lambda do |input|
      get("v3/catalog/products/#{input['product_id']}").
      params( {include: input['include'],
        include_fields: input['include_fields'],
        exclude_fields: input['exclude_fields']}.compact)
    end,
    customer_create_url: lambda do |input|
      call('format_input',input)
      response = post('v3/customers')
      &.after_error_response(/.*/) do |code, body, header, message|
          error("Error is #{code}: #{message}")
        end
      &.request_body([input.except('object')].to_json)&.first
      records = response&.last&.first
      call('format_output', records)
      records
    end,
    product_create_url: lambda do |input|
      call('format_input',input)
      response = post('v3/catalog/products')&.after_error_response(/.*/) do |code, body, header, message|
          error("Error is #{code}: #{message}")
        end
      .payload(input.except('object'))
      call('format_output',response['data'])
      response['data']
    end,
    customer_update_url: lambda do |input|
      call('format_input',input)
      response = put('v3/customers')
      &.after_error_response(/.*/) do |code, body, header, message|
          error("Error is #{code}: #{message}")
        end
      &.request_body([input.except('object')].to_json)&.first
      records = response&.last&.first
      call('format_output', records)
      records
    end,
    product_update_url: lambda do |input|
      call('format_input', input)
      response = put("v3/catalog/products/#{input['product_id']}")
      &.after_error_response(/.*/) do |code, body, header, message|
          error("Error is #{code}: #{message}")
        end
      &.payload(input.except('product_id'))
      call('format_output', response['data'])
    end,
    customer_delete_url: lambda do |input|
      delete("v3/customers?id:in=#{(input['id_in'])}")
    end,
    product_delete_url: lambda do |input|
      delete("v3/catalog/products/#{input['product_id']}")
    end,
  },

  object_definitions:
  {
    search_object_input: {
      fields: lambda do |_connection,config_fields|
        call("#{config_fields['object']}_search_input", '')
      end
    },
    search_object_output: {
      fields: lambda do |_connection, config_fields|
        call("#{config_fields['object']}_search_output",'')
      end
    },
    search_pricelist_input: {
      fields: lambda do |_connection, config_fields|
        [
          { name: 'page', type: 'integer' },
          { name: 'limit', type: 'integer' },
          { name: 'date_created' },
          { name: 'date_modified' },
          { name: 'name'}
        ]
      end
    },
    search_pricelist_output: {
      fields: lambda do |_connection, _config_fields|
        call("search_price_list_schema",'')
      end
    },
    get_object_input: {
      fields: lambda do |_connection, config_fields|
        call("#{config_fields['object']}_get_input", '')
      end
    },
    get_object_output: {
      fields: lambda do |_connection, config_fields|
        call("#{config_fields['object']}_get_output",'')
      end
    },
    get_pricelist_input: {
      fields: lambda do |_connection, _config_fields|
        [
          { name: 'price_list_id', type: 'integer', optional: false},
          { name: 'page', type: 'integer' },
          { name: 'limit', type: 'integer' },
          { name: 'date_created' },
          { name: 'date_modified' },
          { name: 'id', type: 'integer' },
          { name: 'name'}
        ]
      end
    },
    get_pricelist_output: {
      fields: lambda do |_connection, _config_fields|
        call("price_list_schema",'')
      end
    },
    delete_object_input: {
      fields: lambda do |_connection, config_fields|
        call("#{config_fields['object']}_delete_input", '')
      end
    },
    delete_pricelist_input: {
      fields: lambda do |_connection, _config_fields|
        { name: 'price_list_id', type: 'integer', optional: false}
      end
    },
    create_object_input: {
      fields: lambda do |_connection,config_fields|
        call("#{config_fields['object']}_create_input", '')
      end
    },
    create_object_output: {
      fields: lambda do |_connection, config_fields|
        call("#{config_fields['object']}_schema",'')
      end
    },
    create_pricelist_input: {
      fields: lambda do |_connection,config_fields|
        [
          { name: 'name', optional: false},
          { name: 'active', type: 'boolean',
            hint: 'Whether or not this Price List and its prices are active. Defaults to true.'}
        ]
      end
    },
    create_pricelist_output: {
      fields: lambda do |connection,config_fields|
        call("price_list_schema", '')
      end
    },
    update_object_input: {
      fields: lambda do |_connection,config_fields|
        call("#{config_fields['object']}_update_input", '')
      end
    },
    update_object_output: {
      fields: lambda do |_connection, config_fields|
        call("#{config_fields['object']}_schema", '')
      end
    },
    update_pricelist_input: {
      fields: lambda do |connection,config_fields|
        [
          { name: 'price_list_id', optional: false},
          { name: 'name', optional: false},
          { name: 'active', type: 'boolean',
            hint: 'Whether or not this Price List and its prices are active. Defaults to true.'}
        ]
      end
    },
    update_pricelist_output: {
      fields: lambda do |connection,config_fields|
        call("price_list_schema", '')
      end
    },
    event: {
      fields: lambda do |_connection, config_fields|
        [
          { name: 'created_at', type: 'date_time', parse_output: 'date_time_conversion' },
          { name: 'store_id' },
          { name: 'producer' },
          { name: 'scope' },
          { name: 'hash' },
          { name: 'data', type: 'object', properties:[
            { name: 'type' },
            { name: 'id', type: 'integer'}
          ]}
        ]
      end
    },
    trigger_output: {
      fields: lambda do |_connection, config_fields|
        call("#{config_fields['object']}_trigger_output",'')
      end
    },
    new_customer_trigger_output: {
      fields: lambda do |_connection, config_fields|
        call("customer_trigger_output",'')
      end
    },
  },

  triggers:
  {
    new__or_update_object_webhook: {
      title: 'New or update object',
      subtitle: 'Triggers immediately when new object created e.g. customer1 was created in BigCommerce',
      description: lambda do |_connection, search_object_list|
        "New/update <span class='provider'>" \
          "#{search_object_list['object']&.pluralize || 'records'}</span> " \
          'in <span class="provider">BigCommerce</span>'
      end,
      config_fields: [
        {
          name: 'object',
          optional: false,
          control_type: 'select',
          pick_list: :object_list,
          hint: 'Select the object from list.'
        }
      ],
      webhook_subscribe: lambda do |webhook_url, _connection, input|
        post('v2/hooks').
          payload(scope: "store/#{input['object']}/updated",
            destination: webhook_url)
      end,
      webhook_notification: lambda do |_input, payload|
        payload
      end,
      webhook_unsubscribe: lambda do |webhook|
        delete("v2/hooks/#{webhook['id']}")
      end,
      dedup: lambda do |event|
        event['hash']
      end,
      output_fields: lambda do |object_definitions|
        object_definitions['event']
      end,
      sample_output: lambda do |_connection, input|
        {
          "created_at": 1608997218,
          "store_id": "1001565393",
          "producer": "stores/rqiqa1qjms",
          "scope": "store/#{input['object']}/updated",
          "hash": "025b76076a6cf5f49407c37c19cf53648f8784e2",
          "data": {
            "type": input['object'],
            "id": 6
          }
        }
      end
    },
    new_customer: {
      title: 'New customer',
      subtitle: 'Triggers immediately when new customer created e.g. customer1 was created in BigCommerce',
      description: "New <span class='provider'>customer</span> " \
        "in <span class='provider'>BigCommerce</span>",
      input_fields: lambda do |_object_definitions|
        [{
          name: 'since',
          type: 'timestamp',
          label: 'When first started, this recipe should pick up events from',
          hint: 'When you start recipe for the first time, ' \
            'it picks up trigger events from this specified date and time. ' \
            'Leave empty to get records created or updated one hour ago',
          sticky: true
        }]
      end,
      poll: lambda do |_connection, input, closure|
        closure ||= {}
        limit = 1
        page = closure['page'] || 1
        date_created = (closure['date_created'] || input['since'] || 1.hour.ago).to_time.utc.iso8601
        response = get('v3/customers').
          params( page: page,
            limit: limit,
            'date_created:min': date_created,
            sort: 'date_created:asc')
        records = response['data']
        closure = if(has_more = records&.size >= limit)
        { 'page': page + 1 }
      else
        { 'date_created': records&.dig(-1, 'date_created') || date_created,
          'page': 1 }
      end
      {
        events: records,
        next_poll: closure,
        can_poll_more: has_more
      }
      end,
      dedup: lambda do |event|
        event['id']
      end,
      output_fields: lambda do |object_definitions|
        object_definitions['new_customer_trigger_output']
      end,
      sample_output: lambda do |_connection, _input|
        get("v3/customers")['data'][0]
      end
    },
    new_or_update_object: {
      title: 'New or update object',
      subtitle: 'Triggers immediately when new object created e.g. customer1 was created in BigCommerce',
      description: lambda do |_connection, search_object_list|
        "New/update <span class='provider'>" \
        "#{search_object_list['object']&.pluralize || 'records'}</span> " \
        'in <span class="provider">BigCommerce</span>'
      end,
      config_fields: [
        {
          name: 'object',
          optional: false,
          control_type: 'select',
          pick_list: :object_list,
          hint: 'Select the object from list.'
        }
      ],
      input_fields: lambda do |_object_definitions|
      [{
        name: 'since',
        type: 'timestamp',
        label: 'When first started, this recipe should pick up events from',
        hint: 'When you start recipe for the first time, ' \
          'it picks up trigger events from this specified date and time. ' \
          'Leave empty to get records created or updated one hour ago',
        sticky: true
      }]
      end,
      poll: lambda do |_connection, input, closure|
        closure ||= {}
        limit = 2
        page = closure['page'] || 1
        date_modified = (closure['date_modified'] || input['since'] || 1.hour.ago).to_time.utc.iso8601
        if input['object'] == 'product'
          response = get('v3/catalog/products').
          params( page: page,
            limit: limit,
            'date_modified:min': date_modified,
            sort: 'date_modified',
            direction: 'asc')
        else
          response = get("v3/#{input['object']&.pluralize}").
          params( page: page,
            limit: limit,
            'date_modified:min': date_modified,
            sort: 'date_created:asc' )
        end
        records = response['data']
        closure = if(has_more = records&.size >= limit)
          { 'page': page + 1 }
        else
          { 'date_modified': records&.dig(-1, 'date_modified') || date_modified,
            'page': 1 }
        end
      {
      events: records,
      next_poll: closure,
      can_poll_more: has_more
      }
      end,
      dedup: lambda do |event|
        "#{event['id']}@@#{event['date_modified']}"
      end,
      output_fields: lambda do |object_definitions|
        object_definitions['trigger_output']
      end,
      sample_output: lambda do |_connection, input|
        call("#{input['object']}_sample_output",'')
      end
    },
  },

  actions:
  {
    search_object:{
      title: 'Search objects',
      subtitle: 'Search objects in BigCommerce',
      description: lambda do |_connection, search_object_list|
        "Search <span class='provider'>" \
        "#{search_object_list['object']&.pluralize || 'records'}</span> " \
        'in <span class="provider">BigCommerce</span>'
      end,
      config_fields: [
        {
          name: 'object',
          optional: false,
          control_type: 'select',
          pick_list: :object_list,
          hint: 'Select the object from list.'
        }
      ],
      input_fields: lambda do |object_definitions|
        object_definitions['search_object_input']
      end,
      execute: lambda do |_connection, input|
        response = call("#{input['object']}_search_url",input)
        &.after_error_response(/.*/) do |code, body, header, message|
            error("Error is #{code}: #{message}")
        end
        call('format_output', response['data'])
        response
      end,
      output_fields: lambda do |object_definitions|
        object_definitions['search_object_output']
      end,
      sample_output: lambda do |_connection, input|
        call("#{input['object']}_search_get_sample_output",'')
      end
    },
    get_object:{
      title: 'Get object',
      subtitle: 'Get object in BigCommerce by unique ID',
      description: lambda do |_connection, search_object_list|
        "Get <span class='provider'>" \
        "#{search_object_list['object'] || 'records'}</span> " \
        "in <span class='provider'>BigCommerce</span>"
      end,
      config_fields: [
        {
          name: 'object',
          optional: false,
          control_type: 'select',
          pick_list: :object_list,
          hint: 'Select the object from list.'
        }
      ],
      input_fields: lambda do |object_definitions|
        object_definitions['get_object_input']
      end,
      execute: lambda do |connection, input|
        response = call("#{input['object']}_get_url",input)
        &.after_error_response(/.*/) do |code, body, header, message|
          error("Error is #{code}: #{message}")
        end
        call('format_output', response['data'])
        response
      end,
      output_fields: lambda do |object_definitions|
        object_definitions['get_object_output']
      end,
      sample_output: lambda do |connection, input|
        call("#{input['object']}_search_get_sample_output",'')
      end
    },
    delete_object:{
      title: 'Delete object',
      subtitle: 'Delete object in BigCommerce',
      description: lambda do |_connection, search_object_list|
        "Delete <span class='provider'>" \
        "#{search_object_list['object'] || 'record'}</span> " \
        'in <span class="provider">BigCommerce</span>'
      end,
      config_fields: [
        {
          name: 'object',
          optional: false,
          control_type: 'select',
          pick_list: :object_list,
          hint: 'Select the object from list.'
        }
      ],
      input_fields: lambda do |object_definitions|
        object_definitions['delete_object_input']
      end,
      execute: lambda do |_connection, input|
        call("#{input['object']}_delete_url",input)
        &.after_error_response(/.*/) do |code, body, header, message|
          error("Error is #{code}: #{message}")
        end
      end
    },
    update_object:{
      title: 'Update object',
      subtitle: 'Update object in BigCommerce',
      description: lambda do |_connection, search_object_list|
        "Update <span class='provider'> " \
        "#{search_object_list['object'] || 'record'}</span> " \
        'in <span class="provider">BigCommerce</span>'
      end,
      config_fields: [
        {
          name: 'object',
          optional: false,
          control_type: 'select',
          pick_list: :object_list,
          hint: 'Select the object from list.'
        }
      ],
      input_fields: lambda do |object_definitions|
        object_definitions['update_object_input']
      end,
      execute: lambda do |connection, input|
        call("#{input['object']}_update_url",input)
      end,
      output_fields: lambda do |object_definitions|
        object_definitions['update_object_output']
      end,
      sample_output: lambda do |_connection, input|
        call("#{input['object']}_sample_output",'')
      end
    },
    create_object:{
      title: 'Create object',
      subtitle: 'Create object in BigCommerce',
      description: lambda do |_connection, search_object_list|
        "Create <span class='provider'>" \
        "#{search_object_list['object'] || 'record'}</span> " \
        'in <span class="provider">BigCommerce</span>'
      end,
      config_fields: [
        {
          name: 'object',
          optional: false,
          control_type: 'select',
          pick_list: :object_list,
          hint: 'Select the object from list.'
        }
      ],
      input_fields: lambda do |object_definitions|
        object_definitions['create_object_input']
      end,
      execute: lambda do |_connection, input|
        call("#{input['object']}_create_url",input)
      end,
      output_fields: lambda do |object_definitions|
        object_definitions['create_object_output']
      end,
      sample_output: lambda do |_connection, input|
        call("#{input['object']}_sample_output",'')
      end
    },
    search_price_lists:{
      title: 'Search pricelists',
      subtitle: 'Search pricelists in BigCommerce',
      description: 'Search price lists in BigCommerce',
      input_fields: lambda do |object_definitions|
        object_definitions['search_pricelist_input']
      end,
      execute: lambda do |connection, input|
        get('v3/pricelists').params(input)
        &.after_error_response(/.*/) do |code, body, header, message|
          error("Error is #{code}: #{message}")
        end
      end,
      output_fields: lambda do |object_definitions|
        object_definitions['search_pricelist_output']
      end,
      sample_output: lambda do |connection, input|
        get('v3/pricelists')
      end
    },
    get_price_list:{
      title: 'Get pricelist',
      subtitle: 'Get pricelist in BigCommerce',
      description: 'Get pricelist in BigCommerce by ID',
      input_fields: lambda do |object_definitions|
        object_definitions['get_pricelist_input']
      end,
      execute: lambda do |connection, input|
        get("v3/pricelists/#{input['price_list_id']}").
        params( name: input['name'],
          limit: input['limit'],
          date_modified: input['date_modified'],
          date_created: input['date_created'],
          page: input['page'],
          id: input['id']
        )&.after_error_response(/.*/) do |code, body, header, message|
            error("Error is #{code}: #{message}")
          end
      end,
      output_fields: lambda do |object_definitions|
        object_definitions['get_pricelist_output']
      end,
      sample_output: lambda do |connection, input|
        get('v3/pricelists')
      end
    },
    delete_price_list:{
      title: 'Delete pricelist',
      subtitle: 'Delete pricelist in BigCommerce',
      description: 'Delete pricelist in BigCommerce',
      input_fields: lambda do |object_definitions|
        object_definitions['delete_pricelist_input']
      end,
      execute: lambda do |connection, input|
        delete("v3/pricelists/#{input['price_list_id']}")
        &.after_error_response(/.*/) do |code, body, header, message|
         error("Error is #{code}: #{message}")
       end
     end,
    },
    create_price_list:{
      title: 'Create pricelist',
      subtitle: 'Create pricelist in BigCommerce',
      description: 'Create pricelist in BigCommerce',
      input_fields: lambda do |object_definitions|
        object_definitions['create_pricelist_input']
      end,
      execute: lambda do |connection, input|
        post('v3/pricelists').payload(input)
        &.after_error_response(/.*/) do |code, body, header, message|
          error("Error is #{code}: #{message}")
        end
      end,
      output_fields: lambda do |object_definitions|
        object_definitions['create_pricelist_output']
      end,
      sample_output: lambda do |connection, input|
        get('v3/pricelists')
      end
    },
    update_price_list:{
      title: 'Update pricelist',
      subtitle: 'Update pricelist in BigCommerce',
      description: 'Update pricelist in BigCommerce by ID',
      input_fields: lambda do |object_definitions|
        object_definitions['update_pricelist_input']
      end,
      execute: lambda do |_connection, input|
        put("v3/pricelists/#{input['price_list_id']}").payload(input.except('price_list_id'))
        &.after_error_response(/.*/) do |code, body, header, message|
         error("Error is #{code}: #{message}")
       end
      end,
      output_fields: lambda do |object_definitions|
        object_definitions['update_pricelist_output']
      end,
      sample_output: lambda do |_connection, _input|
        get('v3/pricelists')
      end
    },
  },

  pick_lists: {
    object_list: lambda do |_connection|
      [
        %w[Customer customer],
        %w[Product product]
      ]
    end,
    availability_list: lambda do |_connection|
      [
        %w[Disabled disabled],
        %w[Available available],
        %w[Preorder preorder]
      ]
    end,
    bulk_pricing_rules_type_list: lambda do |_connection|
      [
        %w[Price price],
        %w[Percent percent],
        %w[Fixed fixed]
      ]
    end,
    condition_list: lambda do |_connection|
      [
        %w[New New],
        %w[Used Used],
        %w[Refurbished Refurbished]
      ]
    end,
    gift_wrapping_options_list: lambda do |_connection|
      [
        %w[Any any],
        %w[None none],
        %w[List list]
      ]
    end,
    inventory_tracking_list: lambda do |_connection|
      [
        %w[None none],
        %w[Product product],
        %w[Variant variant]
      ]
    end,
    type_list: lambda do |_connection|
      [
        %w[Physical physical],
        %w[Digital digital]
      ]
    end,
    product_list_shipping_calc_list: lambda do |_connection|
      [
        %w[None none],
        %w[Weight weight],
        %w[Package package]
      ]
    end,
  }
}
