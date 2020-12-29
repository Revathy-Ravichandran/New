{
  title: 'BigCommerce',
  connection: {
    fields: [
      {
        name: 'access_token',
        control_type: 'password',
        optional: false,
        hint: 'Access token can be
        obtained by creating an API account or installing an app in a BigCommerce control panel.'
      },
      {
        name: 'store_hash',
        optional: false,
        hint: 'eg: https://api.bigcommerce.com/stores/<storehash>/v3'
      }
    ],
    authorization: {
      type: 'api_key',
      credentials: lambda do |connection|
        headers("X-Auth-Token": "#{connection['access_token']}")
      end
    },
    base_uri: lambda do |connection|
      "https://api.bigcommerce.com/stores/#{connection['store_hash']}/"
    end
  },
  test: lambda do |connection|
    get("v3/customers")
  end,

  methods:
  {
    customer_schema: lambda do |input|
      [
        {name: 'data', type: 'array', of: 'object', properties:[
          {name: 'email'},
          {name: 'first_name'},
          {name: 'last_name'},
          {name: 'company'},
          {name: 'phone'},
          {name: 'registration_ip_address'},
          {name: 'notes'},
          {name: 'tax_exempt_category'},
          {name: 'customer_group_id', type: 'integer'},
          {name: 'id', type: 'integer'},
          {name: 'date_modified'},
          {name: 'date_created'},
          {name: 'address_count', type: 'integer'},
          {name: 'attribute_count', type: 'integer'},
          {name: 'authentication', type: 'object', properties:[
            {name: 'force_password_reset', type: 'boolean'}
          ]},
          {name: 'addresses', type: 'array', of: 'object', properties:[
            {name: 'first_name'},
            {name: 'last_name'},
            {name: 'company'},
            {name: 'address1'},
            {name: 'address2'},
            {name: 'city'},
            {name: 'state_or_province'},
            {name: 'postal_code'},
            {name: 'country_code'},
            {name: 'phone'},
            {name: 'address_type'},
            {name: 'customer_id', type: 'integer'},
            {name: 'id', type: 'integer'},
            {name: 'country'},
          ]},
          {name: 'attributes', type: 'array', of: 'object', properties:[
            {name: 'attribute_id', type: 'integer'},
            {name: 'value'},
            {name: 'id', type: 'integer'},
            {name: 'customer_id', type: 'integer'},
            {name: 'date_modified'},
            {name: 'date_created'},
          ]},
          {name: 'store_credit_amounts', type: 'array', of: 'object', properties:[
            {name: 'amount', type: 'integer'}
          ]},
          {name: 'accepts_product_review_abandoned_cart_emails', type: 'boolean'},
          {name: 'channel_ids', type: 'array', of: 'object', properties:[
            {name: '__name'}
          ]}
        ]},
        {name: 'meta', type: 'object', properties:[
          {name: 'pagination', type: 'object', properties:[
            {name: 'total', type: 'integer'},
            {name: 'count', type: 'integer'},
            {name: 'per_page', type: 'integer'},
            {name: 'current_page', type: 'integer'},
            {name: 'total_pages', type: 'integer'},
          ]},
          {name: 'links', type: 'object', properties:[
            {name: 'previous'},
            {name: 'current'},
            {name: 'next'},
          ]}
        ]},
      ]
    end,
    product_schema: lambda do |_input|
      [
        {name: 'data', type: 'object', properties:[
          {name: 'availability'},
          {name: 'availability_description'},
          {name: 'bin_picking_number'},
          {name: 'brand_id'},
          {name: 'brand_name'},
          {name: 'brand_id'},
          {name: 'bulk_pricing_rules', type: 'array', of: 'object', properties:[
            {name: 'amount', type: 'integer'},
            {name: 'id', type: 'integer'},
            {name: 'quantity_max', type: 'integer'},
            {name: 'quantity_min', type: 'integer'},
            {name: 'type'},
          ]},
          {name: 'categories', type: 'array', of: 'object', properties:[
            {name: '__name'},
          ]},
          {name: 'condition'},
          {name: 'cost_price', type: 'integer'},
          {name: 'custom_fields', type: 'array', of: 'object', properties:[
            {name: 'id', type: 'integer'},
            {name: 'name'},
            {name: 'value'}
          ]},
          {name: 'custom_url', type: 'object', properties:[
            {name: 'is_customized', type: 'boolean'},
            {name: 'url'}
          ]},
          {name: 'depth', type: 'integer'},
          {name: 'description'},
          {name: 'fixed_cost_shipping_price', type: 'integer'},
          {name: 'gift_wrapping_options_list', type: 'array', of: 'object', properties:[
            {name: '__name'}
          ]},
          {name: 'gift_wrapping_options_type'},
          {name: 'gtin'},
          {name: 'height', type: 'integer'},
          {name: 'images', type: 'array', of: 'object', properties: [
            {name: 'description'},
            {name: 'image_file'},
            {name: 'image_url'},
            {name: 'is_thumbnail', type: 'boolean'},
            {name: 'sort_order', type: 'integer'},
            {name: 'date_modified'},
            {name: 'id', type: 'integer'},
            {name: 'product_id', type: 'integer'},
            {name: 'url_standard'},
            {name: 'url_thumbnail'},
            {name: 'url_tiny'},
            {name: 'url_zoom'},
          ]},
          {name: 'inventory_level', type: 'integer'},
          {name: 'inventory_tracking'},
          {name: 'inventory_warning_level', type: 'integer'},
          {name: 'is_condition_shown', type: 'boolean'},
          {name: 'is_featured', type: 'boolean'},
          {name: 'is_free_shipping', type: 'boolean'},
          {name: 'is_preorder_only', type: 'boolean'},
          {name: 'is_price_hidden', type: 'boolean'},
          {name: 'is_visible', type: 'boolean'},
          {name: 'layout_file'},
          {name: 'meta_description'},
          {name: 'meta_keywords', type: 'array', of: 'object', properties:[
            {name: '__name'}
          ]},
          {name: 'mpn'},
          {name: 'name'},
          {name: 'open_graph_description'},
          {name: 'open_graph_title'},
          {name: 'open_graph_type'},
          {name: 'open_graph_use_image', type: 'boolean'},
          {name: 'open_graph_use_meta_description', type: 'boolean'},
          {name: 'open_graph_use_product_name', type: 'boolean'},
          {name: 'order_quantity_maximum', type: 'integer'},
          {name: 'order_quantity_minimum', type: 'integer'},
          {name: 'page_title'},
          {name: 'preorder_message'},
          {name: 'preorder_release_date'},
          {name: 'price', type: 'integer'},
          {name: 'price_hidden_label'},
          {name: 'product_tax_code'},
          {name: 'related_products', type: 'array', of: 'object', properties:[
            {name: '__name'}
          ]},
          {name: 'retail_price', type: 'integer'},
          {name: 'reviews_count', type: 'integer'},
          {name: 'reviews_rating_sum', type: 'integer'},
          {name: 'sale_price', type: 'integer'},
          {name: 'search_keywords'},
          {name: 'sku'},
          {name: 'sort_order', type: 'integer'},
          {name: 'tax_class_id', type: 'integer'},
          {name: 'total_sold', type: 'integer'},
          {name: 'type'},
          {name: 'upc'},
          {name: 'videos', type: 'array', of: 'object', properties:[
            {name: 'description'},
            {name: 'sort_order', type: 'integer'},
            {name: 'title'},
            {name: 'type'},
            {name: 'video_id'},
            {name: 'id', type: 'integer'},
            {name: 'length'},
            {name: 'product_id', type: 'integer'}
          ]},
          {name:'view_count', type: 'integer'},
          {name:'warranty'},
          {name:'weight', type: 'integer'},
          {name:'width', type: 'integer'},
          {name:'base_variant_id', type: 'integer'},
          {name:'calculated_price', type: 'integer'},
          {name:'date_created'},
          {name:'date_modified'},
          {name:'id', type: 'integer'},
          {name:'map_price', type: 'integer'},
          {name: 'modifiers', type: 'array', of: 'object', properties:[
            {name: 'config', type: 'object', properties:[
              {name: 'checkbox_label'},
              {name: 'checked_by_default', type: 'boolean'},
              {name: 'date_earliest_value'},
              {name: 'date_latest_value'},
              {name: 'date_limit_mode'},
              {name: 'date_limited', type: 'boolean'},
              {name: 'default_value'},
              {name: 'file_max_size', type: 'integer'},
              {name: 'file_types_mode'},
              {name: 'file_types_other', type: 'array', of: 'object', properties:[
                {name: '__name'}
              ]},
              {name: 'file_types_supported', type: 'array', of: 'object', properties:[
                {name: '__name'}
              ]},
              {name: 'number_highest_value', type: 'integer'},
              {name: 'number_integers_only', type: 'boolean'},
              {name: 'number_limit_mode'},
              {name: 'number_limited', type: 'boolean'},
              {name: 'number_lowest_value'},
              {name: 'product_list_adjusts_inventory', type: 'boolean'},
              {name: 'product_list_adjusts_pricing', type: 'boolean'},
              {name: 'product_list_shipping_calc'},
              {name: 'text_characters_limited', type: 'boolean'},
              {name: 'text_lines_limited', type: 'boolean'},
              {name: 'text_max_length', type: 'integer'},
              {name: 'text_max_lines', type: 'integer'},
              {name: 'text_min_length', type: 'integer'}
            ]},
            {name: 'display_name'},
            {name: 'required', type: 'boolean'},
            {name: 'sort_order', type: 'integer'},
            {name: 'type'},
            {name: 'id', type: 'integer'},
            {name: 'name'},
            {name: 'option_values', type: 'array', of: 'object', properties:[
              {name: 'adjusters', type: 'object', properties:[
                {name: 'image_url'},
                {name: 'price', type: 'object', properties:[
                  {name: 'adjuster'},
                  {name: 'adjuster_value', type: 'integer'}
                ]},
                {name: 'purchasing_disabled', type: 'object', properties:[
                  {name: 'message'},
                  {name: 'status', type: 'boolean'}
                ]},
                {name: 'weight', type: 'object', properties:[
                  {name: 'adjuster'},
                  {name: 'adjuster_value', type: 'integer'}
                ]},
                {name: 'is_default', type: 'boolean'},
                {name: 'label'},
                {name: 'sort_order', type: 'integer'},
                {name: 'value_data'},
                {name: 'id', type: 'integer'},
                {name: 'option_id', type: 'integer'},
              ]},
              {name: 'product_id', type: 'integer'}
            ]},
            {name: 'option_set_display'},
            {name: 'option_set_id', type: 'integer'}
          ]},
          {name: 'options', type: 'array', of: 'object', properties:[
            {name: 'config', type: 'object', properties:[
              {name: 'checkbox_label'},
              {name: 'checked_by_default', type: 'boolean'},
              {name: 'date_earliest_value'},
              {name: 'date_latest_value'},
              {name: 'date_limit_mode'},
              {name: 'date_limited', type: 'boolean'},
              {name: 'default_value'},
              {name: 'file_max_size', type: 'integer'},
              {name: 'file_types_mode'},
              {name: 'file_types_other', type: 'array', of: 'object', properties:[
                {name: '__name'}
              ]},
              {name: 'file_types_supported', type: 'array', of: 'object', properties:[
                {name: '__name'}
              ]},
              {name: 'number_highest_value', type: 'integer'},
              {name: 'number_integers_only', type: 'boolean'},
              {name: 'number_limit_mode'},
              {name: 'number_limited', type: 'boolean'},
              {name: 'number_lowest_value'},
              {name: 'product_list_adjusts_inventory', type: 'boolean'},
              {name: 'product_list_adjusts_pricing', type: 'boolean'},
              {name: 'product_list_shipping_calc'},
              {name: 'text_characters_limited', type: 'boolean'},
              {name: 'text_lines_limited', type: 'boolean'},
              {name: 'text_max_length', type: 'integer'},
              {name: 'text_max_lines', type: 'integer'},
              {name: 'text_min_length', type: 'integer'}
            ]},
            {name: 'display_name'},
            {name: 'id', type: 'integer'},
            {name: 'option_values', type: 'array', of: 'object', properties:[
              {name: 'is_default', type: 'boolean'},
              {name: 'label'},
              {name: 'sort_order', type: 'integer'},
              {name: 'value_data'},
              {name: 'id', type: 'integer'},
            ]},
            {name: 'product_id', type: 'integer'},
            {name: 'sort_order', type: 'integer'},
            {name: 'type'},
          ]},
          {name: 'variants', type: 'object', properties:[
            {name: 'bin_picking_number'},
            {name: 'cost_price', type: 'integer'},
            {name: 'depth', type: 'integer'},
            {name: 'fixed_cost_shipping_price', type: 'integer'},
            {name: 'height', type: 'integer'},
            {name: 'inventory_level', type: 'integer'},
            {name: 'inventory_warning_level', type: 'integer'},
            {name: 'is_free_shipping', type: 'boolean'},
            {name: 'price', type: 'integer'},
            {name: 'purchasing_disabled', type: 'boolean'},
            {name: 'purchasing_disabled_message'},
            {name: 'retail_price', type: 'integer'},
            {name: 'sale_price', type: 'integer'},
            {name: 'upc'},
            {name: 'weight', type: 'integer'},
            {name: 'width', type: 'integer'},
            {name: 'calculated_price'},
            {name: 'id', type: 'integer'},
            {name: 'option_values', type: 'array', of: 'object', properties:[
              {name: 'label'},
              {name: 'option_display_name'},
              {name: 'id', type: 'integer'},
              {name: 'option_id', type: 'integer'},
            ]},
            {name: 'product_id', type: 'integer'},
            {name: 'sku'},
            {name: 'sku_id', type: 'integer'}
          ]}
        ]},
        {name: 'meta', type: 'object', properties:[
          {name: 'pagination', type: 'object', properties:[
            {name: 'count', type: 'integer'},
            {name: 'current_page', type: 'integer'},
            {name: 'links', type: 'object', properties:[
              {name: 'previous'},
              {name: 'current'},
              {name: 'next'},
            ]},
            {name: 'per_page', type: 'integer'},
            {name: 'total', type: 'integer'},
            {name: 'total_pages', type: 'integer'},
          ]}
        ]}
      ]
    end,
    search_product_schema: lambda do |_input|
      [
        {name: 'data', type: 'array', of: 'object', properties:[
          {name: 'availability'},
          {name: 'availability_description'},
          {name: 'bin_picking_number'},
          {name: 'brand_id'},
          {name: 'brand_name'},
          {name: 'brand_id'},
          {name: 'bulk_pricing_rules', type: 'array', of: 'object', properties:[
            {name: 'amount', type: 'integer'},
            {name: 'id', type: 'integer'},
            {name: 'quantity_max', type: 'integer'},
            {name: 'quantity_min', type: 'integer'},
            {name: 'type'},
          ]},
          {name: 'categories', type: 'array', of: 'object', properties:[
            {name: '__name'},
          ]},
          {name: 'condition'},
          {name: 'cost_price', type: 'integer'},
          {name: 'custom_fields', type: 'array', of: 'object', properties:[
            {name: 'id', type: 'integer'},
            {name: 'name'},
            {name: 'value'}
          ]},
          {name: 'custom_url', type: 'object', properties:[
            {name: 'is_customized', type: 'boolean'},
            {name: 'url'}
          ]},
          {name: 'depth', type: 'integer'},
          {name: 'description'},
          {name: 'fixed_cost_shipping_price', type: 'integer'},
          {name: 'gift_wrapping_options_list', type: 'array', of: 'object', properties:[
            {name: '__name'}
          ]},
          {name: 'gift_wrapping_options_type'},
          {name: 'gtin'},
          {name: 'height', type: 'integer'},
          {name: 'images', type: 'array', of: 'object', properties: [
            {name: 'description'},
            {name: 'image_file'},
            {name: 'image_url'},
            {name: 'is_thumbnail', type: 'boolean'},
            {name: 'sort_order', type: 'integer'},
            {name: 'date_modified'},
            {name: 'id', type: 'integer'},
            {name: 'product_id', type: 'integer'},
            {name: 'url_standard'},
            {name: 'url_thumbnail'},
            {name: 'url_tiny'},
            {name: 'url_zoom'},
          ]},
          {name: 'inventory_level', type: 'integer'},
          {name: 'inventory_tracking'},
          {name: 'inventory_warning_level', type: 'integer'},
          {name: 'is_condition_shown', type: 'boolean'},
          {name: 'is_featured', type: 'boolean'},
          {name: 'is_free_shipping', type: 'boolean'},
          {name: 'is_preorder_only', type: 'boolean'},
          {name: 'is_price_hidden', type: 'boolean'},
          {name: 'is_visible', type: 'boolean'},
          {name: 'layout_file'},
          {name: 'meta_description'},
          {name: 'meta_keywords', type: 'array', of: 'object', properties:[
            {name: '__name'}
          ]},
          {name: 'mpn'},
          {name: 'name'},
          {name: 'open_graph_description'},
          {name: 'open_graph_title'},
          {name: 'open_graph_type'},
          {name: 'open_graph_use_image', type: 'boolean'},
          {name: 'open_graph_use_meta_description', type: 'boolean'},
          {name: 'open_graph_use_product_name', type: 'boolean'},
          {name: 'order_quantity_maximum', type: 'integer'},
          {name: 'order_quantity_minimum', type: 'integer'},
          {name: 'page_title'},
          {name: 'preorder_message'},
          {name: 'preorder_release_date'},
          {name: 'price', type: 'integer'},
          {name: 'price_hidden_label'},
          {name: 'product_tax_code'},
          {name: 'related_products', type: 'array', of: 'object', properties:[
            {name: '__name'}
          ]},
          {name: 'retail_price', type: 'integer'},
          {name: 'reviews_count', type: 'integer'},
          {name: 'reviews_rating_sum', type: 'integer'},
          {name: 'sale_price', type: 'integer'},
          {name: 'search_keywords'},
          {name: 'sku'},
          {name: 'sort_order', type: 'integer'},
          {name: 'tax_class_id', type: 'integer'},
          {name: 'total_sold', type: 'integer'},
          {name: 'type'},
          {name: 'upc'},
          {name: 'videos', type: 'array', of: 'object', properties:[
            {name: 'description'},
            {name: 'sort_order', type: 'integer'},
            {name: 'title'},
            {name: 'type'},
            {name: 'video_id'},
            {name: 'id', type: 'integer'},
            {name: 'length'},
            {name: 'product_id', type: 'integer'}
          ]},
          {name:'view_count', type: 'integer'},
          {name:'warranty'},
          {name:'weight', type: 'integer'},
          {name:'width', type: 'integer'},
          {name:'base_variant_id', type: 'integer'},
          {name:'calculated_price', type: 'integer'},
          {name:'date_created'},
          {name:'date_modified'},
          {name:'id', type: 'integer'},
          {name:'map_price', type: 'integer'},
          {name: 'modifiers', type: 'array', of: 'object', properties:[
            {name: 'config', type: 'object', properties:[
              {name: 'checkbox_label'},
              {name: 'checked_by_default', type: 'boolean'},
              {name: 'date_earliest_value'},
              {name: 'date_latest_value'},
              {name: 'date_limit_mode'},
              {name: 'date_limited', type: 'boolean'},
              {name: 'default_value'},
              {name: 'file_max_size', type: 'integer'},
              {name: 'file_types_mode'},
              {name: 'file_types_other', type: 'array', of: 'object', properties:[
                {name: '__name'}
              ]},
              {name: 'file_types_supported', type: 'array', of: 'object', properties:[
                {name: '__name'}
              ]},
              {name: 'number_highest_value', type: 'integer'},
              {name: 'number_integers_only', type: 'boolean'},
              {name: 'number_limit_mode'},
              {name: 'number_limited', type: 'boolean'},
              {name: 'number_lowest_value'},
              {name: 'product_list_adjusts_inventory', type: 'boolean'},
              {name: 'product_list_adjusts_pricing', type: 'boolean'},
              {name: 'product_list_shipping_calc'},
              {name: 'text_characters_limited', type: 'boolean'},
              {name: 'text_lines_limited', type: 'boolean'},
              {name: 'text_max_length', type: 'integer'},
              {name: 'text_max_lines', type: 'integer'},
              {name: 'text_min_length', type: 'integer'}
            ]},
            {name: 'display_name'},
            {name: 'required', type: 'boolean'},
            {name: 'sort_order', type: 'integer'},
            {name: 'type'},
            {name: 'id', type: 'integer'},
            {name: 'name'},
            {name: 'option_values', type: 'array', of: 'object', properties:[
              {name: 'adjusters', type: 'object', properties:[
                {name: 'image_url'},
                {name: 'price', type: 'object', properties:[
                  {name: 'adjuster'},
                  {name: 'adjuster_value', type: 'integer'}
                ]},
                {name: 'purchasing_disabled', type: 'object', properties:[
                  {name: 'message'},
                  {name: 'status', type: 'boolean'}
                ]},
                {name: 'weight', type: 'object', properties:[
                  {name: 'adjuster'},
                  {name: 'adjuster_value', type: 'integer'}
                ]},
                {name: 'is_default', type: 'boolean'},
                {name: 'label'},
                {name: 'sort_order', type: 'integer'},
                {name: 'value_data'},
                {name: 'id', type: 'integer'},
                {name: 'option_id', type: 'integer'},
              ]},
              {name: 'product_id', type: 'integer'}
            ]},
            {name: 'option_set_display'},
            {name: 'option_set_id', type: 'integer'}
          ]},
          {name: 'options', type: 'array', of: 'object', properties:[
            {name: 'config', type: 'object', properties:[
              {name: 'checkbox_label'},
              {name: 'checked_by_default', type: 'boolean'},
              {name: 'date_earliest_value'},
              {name: 'date_latest_value'},
              {name: 'date_limit_mode'},
              {name: 'date_limited', type: 'boolean'},
              {name: 'default_value'},
              {name: 'file_max_size', type: 'integer'},
              {name: 'file_types_mode'},
              {name: 'file_types_other', type: 'array', of: 'object', properties:[
                {name: '__name'}
              ]},
              {name: 'file_types_supported', type: 'array', of: 'object', properties:[
                {name: '__name'}
              ]},
              {name: 'number_highest_value', type: 'integer'},
              {name: 'number_integers_only', type: 'boolean'},
              {name: 'number_limit_mode'},
              {name: 'number_limited', type: 'boolean'},
              {name: 'number_lowest_value'},
              {name: 'product_list_adjusts_inventory', type: 'boolean'},
              {name: 'product_list_adjusts_pricing', type: 'boolean'},
              {name: 'product_list_shipping_calc'},
              {name: 'text_characters_limited', type: 'boolean'},
              {name: 'text_lines_limited', type: 'boolean'},
              {name: 'text_max_length', type: 'integer'},
              {name: 'text_max_lines', type: 'integer'},
              {name: 'text_min_length', type: 'integer'}
            ]},
            {name: 'display_name'},
            {name: 'id', type: 'integer'},
            {name: 'option_values', type: 'array', of: 'object', properties:[
              {name: 'is_default', type: 'boolean'},
              {name: 'label'},
              {name: 'sort_order', type: 'integer'},
              {name: 'value_data'},
              {name: 'id', type: 'integer'},
            ]},
            {name: 'product_id', type: 'integer'},
            {name: 'sort_order', type: 'integer'},
            {name: 'type'},
          ]},
          {name: 'variants', type: 'object', properties:[
            {name: 'bin_picking_number'},
            {name: 'cost_price', type: 'integer'},
            {name: 'depth', type: 'integer'},
            {name: 'fixed_cost_shipping_price', type: 'integer'},
            {name: 'height', type: 'integer'},
            {name: 'inventory_level', type: 'integer'},
            {name: 'inventory_warning_level', type: 'integer'},
            {name: 'is_free_shipping', type: 'boolean'},
            {name: 'price', type: 'integer'},
            {name: 'purchasing_disabled', type: 'boolean'},
            {name: 'purchasing_disabled_message'},
            {name: 'retail_price', type: 'integer'},
            {name: 'sale_price', type: 'integer'},
            {name: 'upc'},
            {name: 'weight', type: 'integer'},
            {name: 'width', type: 'integer'},
            {name: 'calculated_price'},
            {name: 'id', type: 'integer'},
            {name: 'option_values', type: 'array', of: 'object', properties:[
              {name: 'label'},
              {name: 'option_display_name'},
              {name: 'id', type: 'integer'},
              {name: 'option_id', type: 'integer'},
            ]},
            {name: 'product_id', type: 'integer'},
            {name: 'sku'},
            {name: 'sku_id', type: 'integer'}
          ]}
        ]},
        {name: 'meta', type: 'object', properties:[
          {name: 'pagination', type: 'object', properties:[
            {name: 'count', type: 'integer'},
            {name: 'current_page', type: 'integer'},
            {name: 'links', type: 'object', properties:[
              {name: 'previous'},
              {name: 'current'},
              {name: 'next'},
            ]},
            {name: 'per_page', type: 'integer'},
            {name: 'total', type: 'integer'},
            {name: 'total_pages', type: 'integer'},
          ]}
        ]}
      ]
    end,
    search_customer_schema: lambda do |input|
      []
    end,
    price_list_schema: lambda do |_input|
      [
        {name: 'data', type: 'object', properties:[
          {name: 'id', type: 'integer'},
          {name: 'date_created'},
          {name: 'date_modified'},
          {name: 'name'},
          {name: 'active', type: 'boolean'}
        ]},
        {name: 'meta', type: 'object', properties:[
          {name: 'pagination', type: 'object', properties:[
            {name: 'total', type: 'integer'},
            {name: 'count', type: 'integer'},
            {name: 'per_page', type: 'integer'},
            {name: 'current_page', type: 'integer'},
            {name: 'total_pages', type: 'integer'},
          ]},
          {name: 'links', type: 'object', properties:[
            {name: 'previous'},
            {name: 'current'},
            {name: 'next'},
          ]}
        ]}

      ]
    end,
    search_price_list_schema: lambda do |_input|
      [

        {name: 'data', type: 'array', of: 'object', properties:[
          {name: 'id', type: 'integer'},
          {name: 'date_created'},
          {name: 'date_modified'},
          {name: 'name'},
          {name: 'active', type: 'boolean'}
        ]},
        {name: 'meta', type: 'object', properties:[
          {name: 'pagination', type: 'object', properties:[
            {name: 'total', type: 'integer'},
            {name: 'count', type: 'integer'},
            {name: 'per_page', type: 'integer'},
            {name: 'current_page', type: 'integer'},
            {name: 'total_pages', type: 'integer'},
          ]},
          {name: 'links', type: 'object', properties:[
            {name: 'previous'},
            {name: 'current'},
            {name: 'next'},
          ]}
        ]}

      ]
    end,
    customer_search_input: lambda do |input|
      [
        {name: 'page', type: 'integer'},
        {name: 'limit', type: 'number'},
        {name: 'date_created'},
        {name: 'date_created:max'},
        {name: 'date_created:min'},
        {name: 'date_modified'},
        {name: 'date_modified:max'},
        {name: 'date_modified:min'},
        {name: 'email:in'},
        {name: 'include'},
        {name: 'sort'},
      ]
    end,
    product_search_input: lambda do |input|
      [
        {name: 'id', type: 'integer'},
        {name: 'name'},
        {name: 'sku'},
        {name: 'upc'},
        {name: 'price', type: 'number'},
        {name: 'weight', type: 'number'},
        {name: 'condition'},
        {name: 'brand_id', type: 'integer'},
        {name: 'date_modified'},
        {name: 'date_last_imported'},
        {name: 'is_visible', type: 'boolean'},
        {name: 'is_featured', type: 'integer'},
        {name: 'is_free_shipping', type: 'integer'},
        {name: 'inventory_level', type: 'integer'},
        {name: 'inventory_low', type: 'integer'},
        {name: 'out_of_stock', type: 'integer'},
        {name: 'total_sold', type: 'integer'},
        {name: 'type'},
        {name: 'categories', type: 'integer'},
        {name: 'keyword'},
        {name: 'keyword_context'},
        {name: 'status', type: 'integer'},
        {name: 'include'},
        {name: 'include_fields'},
        {name: 'exclude_fields'},
        {name: 'availability'},
        {name: 'price_list_id', type: 'integer'},
        {name: 'page', type: 'integer'},
        {name: 'limit', type: 'integer'},
        {name: 'direction'},
        {name: 'sort'}
      ]
    end,
    customer_schema_input: lambda do |input|
      [
        {name: 'email'},
        {name: 'first_name'},
        {name: 'last_name'},
        {name: 'company'},
        {name: 'phone'},
        {name: 'notes'},
        {name: 'tax_exempt_category'},
        {name: 'customer_group_id', type: 'integer'},
        {name: 'authentication', type: 'object', properties:[
          {name: 'force_password_reset', type: 'boolean',
            control_type: 'checkbox',
            render_input: 'boolean_conversion',
            parse_output: 'boolean_conversion',
            hint: 'If true, this customer will be forced to change password on next login.'},
          {name: 'new_password'}
        ]},
        {name: 'addresses', type: 'array', of: 'object', properties:[
          {name: 'first_name', optional: false},
          {name: 'last_name', optional: false},
          {name: 'company'},
          {name: 'address1', optional: false},
          {name: 'address2'},
          {name: 'city', optional: false},
          {name: 'state_or_province', optional: false},
          {name: 'postal_code', optional: false},
          {name: 'country_code', optional: false},
          {name: 'phone'},
          {name: 'address_type'}
        ]},
        {name: 'attributes', type: 'array', of: 'object', properties:[
          {name: 'attribute_id', type: 'integer', optional: false},
          {name: 'attribute_value', optional: false},
        ]},
        {name: 'store_credit_amounts', type: 'array', of: 'object', properties:[
          {name: 'amount', type: 'number'}
        ]},
        {name: 'accepts_product_review_abandoned_cart_emails', type: 'boolean'}]
    end,
    product_schema_input: lambda do |input|
      [
        {name: 'availability'},
        {name: 'availability_description'},
        {name: 'bin_picking_number'},
        {name: 'brand_id'},
        {name: 'brand_name'},
        {name: 'bulk_pricing_rules', type: 'array', of: 'object', properties:[
          {name: 'amount', type: 'integer'},
          {name: 'id', type: 'integer'},
          {name: 'quantity_max', type: 'integer'},
          {name: 'quantity_min', type: 'integer'},
          {name: 'type'},
        ]},
        {name: 'categories', type: 'array', of: 'object', properties:[
          {name: '__name', type: 'integer', render_input: 'integer_conversion',
          parse_output: 'integer_conversion'},
        ]},
        {name: 'condition'},
        {name: 'cost_price', type: 'integer'},
        {name: 'custom_fields', type: 'array', of: 'object', properties:[
          {name: 'id', type: 'integer'},
          {name: 'name'},
          {name: 'value'}
        ]},
        {name: 'custom_url', type: 'object', properties:[
          {name: 'is_customized', type: 'boolean'},
          {name: 'url'}
        ]},
        {name: 'depth', type: 'integer'},
        {name: 'description'},
        {name: 'fixed_cost_shipping_price', type: 'integer'},
        {name: 'gift_wrapping_options_list', type: 'array', of: 'object', properties:[
          {name: '__name'}
        ]},
        {name: 'gift_wrapping_options_type'},
        {name: 'gtin'},
        {name: 'height', type: 'integer'},
        {name: 'images', type: 'array', of: 'object', properties: [
          {name: 'description'},
          {name: 'image_file'},
          {name: 'image_url'},
          {name: 'is_thumbnail', type: 'boolean'},
          {name: 'sort_order', type: 'integer'},
          {name: 'date_modified'},
          {name: 'id', type: 'integer'},
          {name: 'product_id', type: 'integer'},
          {name: 'url_standard'},
          {name: 'url_thumbnail'},
          {name: 'url_tiny'},
          {name: 'url_zoom'},
        ]},
        {name: 'inventory_level', type: 'integer'},
        {name: 'inventory_tracking'},
        {name: 'inventory_warning_level', type: 'integer'},
        {name: 'is_condition_shown', type: 'boolean'},
        {name: 'is_featured', type: 'boolean'},
        {name: 'is_free_shipping', type: 'boolean'},
        {name: 'is_preorder_only', type: 'boolean'},
        {name: 'is_price_hidden', type: 'boolean'},
        {name: 'is_visible', type: 'boolean'},
        {name: 'layout_file'},
        {name: 'meta_description'},
        {name: 'meta_keywords', type: 'array', of: 'object', properties:[
          {name: '__name'}
        ]},
        {name: 'mpn'},
        {name: 'name'},
        {name: 'open_graph_description'},
        {name: 'open_graph_title'},
        {name: 'open_graph_type'},
        {name: 'open_graph_use_image', type: 'boolean'},
        {name: 'open_graph_use_meta_description', type: 'boolean'},
        {name: 'open_graph_use_product_name', type: 'boolean'},
        {name: 'order_quantity_maximum', type: 'integer'},
        {name: 'order_quantity_minimum', type: 'integer'},
        {name: 'page_title'},
        {name: 'preorder_message'},
        {name: 'preorder_release_date'},
        {name: 'price', type: 'number'},
        {name: 'price_hidden_label'},
        {name: 'product_tax_code'},
        {name: 'related_products', type: 'array', of: 'object', properties:[
          {name: '__name'}
        ]},
        {name: 'retail_price', type: 'integer'},
        {name: 'reviews_count', type: 'integer'},
        {name: 'reviews_rating_sum', type: 'integer'},
        {name: 'sale_price', type: 'integer'},
        {name: 'search_keywords'},
        {name: 'sku'},
        {name: 'sort_order', type: 'integer'},
        {name: 'tax_class_id', type: 'integer'},
        {name: 'total_sold', type: 'integer'},
        {name: 'type'},
        {name: 'upc'},
        {name: 'videos', type: 'array', of: 'object', properties:[
          {name: 'description'},
          {name: 'sort_order', type: 'integer'},
          {name: 'title'},
          {name: 'type'},
          {name: 'video_id'},
          {name: 'id', type: 'integer'},
          {name: 'length'},
          {name: 'product_id', type: 'integer'}
        ]},
        {name:'view_count', type: 'integer'},
        {name:'warranty'},
        {name:'weight', type: 'integer'},
        {name:'width', type: 'integer'},
        {name: 'variants', type: 'object', properties:[
          {name: 'bin_picking_number'},
          {name: 'cost_price', type: 'integer'},
          {name: 'depth', type: 'integer'},
          {name: 'fixed_cost_shipping_price', type: 'integer'},
          {name: 'height', type: 'integer'},
          {name: 'inventory_level', type: 'integer'},
          {name: 'inventory_warning_level', type: 'integer'},
          {name: 'is_free_shipping', type: 'boolean'},
          {name: 'price', type: 'integer'},
          {name: 'purchasing_disabled', type: 'boolean'},
          {name: 'purchasing_disabled_message'},
          {name: 'retail_price', type: 'integer'},
          {name: 'sale_price', type: 'integer'},
          {name: 'upc'},
          {name: 'weight', type: 'integer'},
          {name: 'width', type: 'integer'},
          {name: 'option_values', type: 'array', of: 'object', properties:[
            {name: 'label'},
            {name: 'option_display_name'},
          ]},
          {name: 'sku'},
        ]},
      ]
    end,
    customer_trigger_output: lambda do |input|
      [
        {name: 'id', type: 'integer'},
        {name: 'authentication', type: 'object', properties:[
          {name: 'force_password_reset', type: 'boolean'}
        ]},
        {name: 'company'},
        {name: 'customer_group_id', type: 'integer'},
        {name: 'email'},
        {name: 'first_name'},
        {name: 'last_name'},
        {name: 'notes'},
        {name: 'phone'},
        {name: 'registration_ip_address'},
        {name: 'tax_exempt_category'},
        {name: 'date_created'},
        {name: 'date_modified'},
        {name: 'accepts_product_review_abandoned_cart_emails', type: 'boolean'},
        {name: 'channel_ids', type: 'array', of: 'object', properties:[
          {name: '__name'}
        ]},
      ]
    end,
    product_trigger_output: lambda do |input|
      [
        {name: 'id', type: 'integer'},
        {name: 'name'},
        {name: 'type'},
        {name: 'sku'},
        {name: 'description'},
        {name: 'weight', type: 'integer'},
        {name: 'width', type: 'integer'},
        {name: 'depth', type: 'integer'},
        {name: 'height', type: 'integer'},
        {name: 'price', type: 'integer'},
        {name: 'cost_price', type: 'integer'},
        {name: 'retail_price', type: 'integer'},
        {name: 'sale_price', type: 'integer'},
        {name: 'map_price', type: 'integer'},
        {name: 'tax_class_id', type: 'integer'},
        {name: 'product_tax_code'},
        {name: 'calculated_price', type: 'integer'},
        {name: 'categories', type: 'array', of: 'object', properties:[
          {name: '__name', type: 'integer'}
        ]},
        {name: 'brand_id', type: 'integer'},
        {name: 'option_set_id', type: 'integer'},
        {name: 'option_set_display'},
        {name: 'inventory_level', type: 'integer'},
        {name: 'inventory_warning_level', type: 'integer'},
        {name: 'inventory_tracking'},
        {name: 'reviews_rating_sum', type: 'integer'},
        {name: 'reviews_count', type: 'integer'},
        {name: 'total_sold', type: 'integer'},
        {name: 'fixed_cost_shipping_price', type: 'integer'},
        {name: 'is_free_shipping', type: 'boolean'},
        {name: 'is_visible', type: 'boolean'},
        {name: 'is_featured', type: 'boolean'},
        {name: 'related_products', type: 'array', of: 'object', properties:[
          {name: '__name'}
        ]},
        {name: 'warranty'},
        {name: 'bin_picking_number'},
        {name: 'layout_file'},
        {name: 'upc'},
        {name: 'mpn'},
        {name: 'gtin'},
        {name: 'search_keywords'},
        {name: 'availability'},
        {name: 'availability_description'},
        {name: 'gift_wrapping_options_type'},
        {name: 'gift_wrapping_options_list', type: 'array', of: 'object', properties:[
          {name: '__name'}
        ]},
        {name: 'sort_order', type: 'integer'},
        {name: 'condition'},
        {name: 'is_condition_shown', type: 'boolean'},
        {name: 'order_quantity_minimum', type: 'integer'},
        {name: 'order_quantity_maximum', type: 'integer'},
        {name: 'page_title'},
        {name: 'meta_keywords', type: 'array', of: 'object', properties:[
          {name: '__name'}
        ]},
        {name: 'meta_description'},
        {name: 'date_created'},
        {name: 'date_modified'},
        {name: 'view_count', type: 'integer'},
        {name: 'preorder_release_date'},
        {name: 'preorder_message'},
        {name: 'is_preorder_only', type: 'boolean'},
        {name: 'is_price_hidden', type: 'boolean'},
        {name: 'price_hidden_label'},
        {name: 'custom_url', type: 'object', properties:[
          {name: '__name'}
        ]},
        {name: 'base_variant_id', type: 'integer'},
        {name: 'open_graph_type'},
        {name: 'open_graph_title'},
        {name: 'open_graph_description'},
        {name: 'open_graph_use_meta_description', type: 'boolean'},
        {name: 'open_graph_use_product_name', type: 'boolean'},
        {name: 'open_graph_use_image', type: 'boolean'},
      ]
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
    end
  },

  object_definitions: {
    search_object_input: {
      fields: lambda do |connection,config_fields|
        call("#{config_fields['object']}_search_input", '')
      end
    },
    search_object_output: {
      fields: lambda do |_connection, config_fields|
        if config_fields['object'] == 'product'
          call("search_#{config_fields['object']}_schema",'')
        else
          call("#{config_fields['object']}_schema",'')
        end
      end
    },
    search_pricelist_input: {
      fields: lambda do |_connection, config_fields|
        [
          {name: 'page', type: 'integer'},
          {name: 'limit', type: 'integer'},
          {name: 'date_created'},
          {name: 'date_modified'},
          {name: 'name'}
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
        if config_fields['object'] == 'product'
          [
            {name: 'product_id', type: 'integer', optional: false},
            {name: 'include'},
            {name: 'include_fields'},
            {name: 'exclude_fields'},
          ]
        else
          {name: 'id:in', optional: false, type: 'integer'}
        end
      end
    },
    get_object_output: {
      fields: lambda do |_connection, config_fields|
        call("#{config_fields['object']}_schema",'')
      end
    },
    get_pricelist_input: {
      fields: lambda do |_connection, _config_fields|
        [
          {name: 'price_list_id', type: 'integer', optional: false},
          {name: 'page', type: 'integer'},
          {name: 'limit', type: 'integer'},
          {name: 'date_created'},
          {name: 'date_modified'},
          {name: 'id', type: 'integer'},
          {name: 'name'}
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
        if config_fields['object'] == 'customer'
          {name: 'id_in', optional: false}
        else
          {name: 'product_id', optional: false}
        end
      end
    },
    delete_pricelist_input: {
      fields: lambda do |_connection, _config_fields|
        {name: 'price_list_id', type: 'integer', optional: false}
      end
    },
    create_object_input: {
      fields: lambda do |connection,config_fields|
        if config_fields['object'] == 'customer'
          call("#{config_fields['object']}_schema_input", '').required('email','first_name','last_name')
        else
          call("#{config_fields['object']}_schema_input", '').required('name','price','type','weight')
        end
      end
    },
    create_object_output: {
      fields: lambda do |_connection, config_fields|
        call("#{config_fields['object']}_schema",'')
      end
    },
    create_pricelist_input: {
      fields: lambda do |connection,config_fields|
        [
          {name: 'name', optional: false},
          {name: 'active', type: 'boolean',
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
      fields: lambda do |connection,config_fields|
        if config_fields['object'] == 'customer'
          call("#{config_fields['object']}_schema_input", '').ignored('attributes','addresses').
            concat([{ name: 'id', type: 'integer', render_input: 'integer_conversion',
             parse_output: 'integer_conversion', optional: false, hint: 'ID of the customer'}])
        else
          call("#{config_fields['object']}_schema_input", '').concat([{ name: 'product_id', optional: false, hint: 'ID of the product'}])
        end
      end
    },
    update_object_output: {
      fields: lambda do |_connection, config_fields|
        call("#{config_fields['object']}_schema",'')
      end
    },
    update_pricelist_input: {
      fields: lambda do |connection,config_fields|
        [
          {name: 'price_list_id', optional: false},
          {name: 'name', optional: false},
          {name: 'active', type: 'boolean',
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
          {name: 'created_at', type: 'date_time', parse_output: 'date_time_conversion'},
          {name: 'store_id'},
          {name: 'producer'},
          {name: 'scope'},
          {name: 'hash'},
          {name: 'data', type: 'object', properties:[
            {name: 'type'},
            {name: 'id', type: 'integer'}
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

  triggers: {
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
      dedup: lambda do |_event|
        Time.now
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
            "type": "#{input['object']}",
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
        closure = if(has_more = response&.size >= limit)
        { 'page': response['meta']['pagination']['current_page'] + 1 }
      else
        { 'date_created': response&.dig(-1, 'date_created') || date_created,
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
      closure = if(has_more = response&.size >= limit)
      { 'page': response['meta']['pagination']['current_page'] + 1 }
    else
      { 'date_modified': response&.dig(-1, 'date_modified') || date_modified,
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
    if input['object'] == 'product'
      get("v3/catalog/products")['data']&.first
    else
      get("v3/#{input['object']&.pluralize}")['data']&.first
    end
  end
},
},

actions:
{
  search_object:
  {
    title: 'Search Object',
    subtitle: 'Search Object in BigCommerce',
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
      response = (if input[:object] == 'product'
        get("v3/catalog/products").params(input.except('object'))
      else
        get("v3/#{input['object']&.pluralize}").params(input.except('object'))
      end)
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
    if input['object'] == 'product'
      get("v3/catalog/#{input['object']&.pluralize}")
    else
      get("v3/#{input['object']&.pluralize}")
    end
  end
},
  get_object:
  {
  title: 'get Object',
  subtitle: 'get object in BigCommerce',
  description: lambda do |_connection, search_object_list|
    "Get <span class='provider'>" \
      "#{search_object_list[:object]&.pluralize || 'records'}</span> " \
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
    object_definitions['get_object_input']
  end,
  execute: lambda do |connection, input|
    response = (if input['object'] == 'product'
      get("v3/catalog/products/#{input['product_id']}").
        params( {include: input['include'],
          include_fields: input['include_fields'],
          exclude_fields: input['exclude_fields']}.compact
        )
    else
      get("v3/#{input['object']&.pluralize}").
      params(input.except('object'))
      end)
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
    if input[:object] == 'customer'
      get("v3/#{input['object']&.pluralize}")
    else
      get("v3/catalog/#{input['object']&.pluralize}")
    end
  end
},
  delete_object:
  {
  title: 'delete Object',
  subtitle: 'delete object in BigCommerce',
  description: lambda do |_connection, search_object_list|
    "Delete <span class='provider'>" \
      "#{search_object_list[:object]&.pluralize || 'records'}</span> " \
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
    (if input['object'] == 'product'
      delete("v3/catalog/products/#{input['product_id']}")
    else
      delete("v3/#{input['object']&.pluralize}?id:in=#{(input['id_in'])}")
    end)
    &.after_error_response(/.*/) do |code, body, header, message|
      error("Error is #{code}: #{message}")
    end
  end
},
  update_object:
  {
  title: 'update Object',
  subtitle: 'update object in BigCommerce',
  description: lambda do |_connection, search_object_list|
    "Update <span class='provider'> " \
      "#{search_object_list[:object]&.pluralize || 'records'}</span> " \
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
    call('format_input', input)
    response = if input['object'] == 'product'
      put("v3/catalog/products/#{input['product_id']}")
      &.after_error_response(/.*/) do |code, body, header, message|
          error("Error is #{code}: #{message}")
      end
      .payload(input.except('product_id'))
    else
       put("v3/#{input['object']&.pluralize}")
       &.after_error_response(/.*/) do |code, body, header, message|
          error("Error is #{code}: #{message}")
       end
       .request_body([input.except('object')].to_json)&.first
    end
    call('format_output', response['data'])
    {response: response}
  end,
  output_fields: lambda do |object_definitions|
    object_definitions['update_object_output']
  end,
  sample_output: lambda do |connection, input|
    if input[:object] == 'customer'
      get("v3/#{input['object']&.pluralize}")
    else
      get("v3/catalog/#{input['object']&.pluralize}")
    end
  end
},
   create_object:
  {
  title: 'create Object',
  subtitle: 'create object in BigCommerce',
  description: lambda do |_connection, search_object_list|
    "Create <span class='provider'>" \
      "#{search_object_list[:object]&.pluralize || 'records'}</span> " \
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
  execute: lambda do |connection, input|
    call('format_input', input)
    response = if input['object'] == 'product'
      post("v3/catalog/products").payload(input.except('object'))
       &.after_error_response(/.*/) do |code, body, header, message|
           error("Error is #{code}: #{message}")
       end
    else
      post("v3/#{input['object']&.pluralize}")
      &.after_error_response(/.*/) do |code, body, header, message|
          error("Error is #{code}: #{message}")
      end
      .request_body([input.except('object')].to_json)&.first
    end
     call('format_output', response['data'])
     {response: response}
  end,
  output_fields: lambda do |object_definitions|
    object_definitions['create_object_output']
  end,
  sample_output: lambda do |connection, input|
    if input['object'] == 'customer'
      get("v3/#{input['object']&.pluralize}")
    else
      get("v3/catalog/#{input['object']&.pluralize}")
    end
  end
},
  search_price_lists:
  {
  title: 'search price_lists',
  subtitle: 'search price_lists in BigCommerce',
  description: 'search price_lists in BigCommerce',
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
  get_price_list:
  {
  title: 'get price_list',
  subtitle: 'get price_list in BigCommerce',
  description: 'get price_list in BigCommerce by ID',
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
  delete_price_list:
  {
  title: 'delete price_list',
  subtitle: 'delete price_list in BigCommerce',
  description: 'delete price_list in BigCommerce',
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
  create_price_list:
  {
  title: 'create price_list',
  subtitle: 'create price_list in BigCommerce',
  description: 'create price_list in BigCommerce',
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
  update_price_list:
  {
  title: 'update price_list',
  subtitle: 'update price_list in BigCommerce',
  description: 'update price_list in BigCommerce by ID',
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
  object_list: lambda do |connection|
    [
      %w[Customer customer],
      %w[Product product]
    ]
  end
}
}
