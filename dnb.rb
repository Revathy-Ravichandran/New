{
  title: 'DnB Direct',

  # API key authentication example. See more examples at https://docs.workato.com/developing-connectors/sdk/authentication.html
  connection: {
    fields: [
      {
        name: 'api_key'
      },
      {
        name: 'api_secret'
      }
    ],

    authorization: {
      type: 'custom_auth',

      acquire: lambda do |connection|
        {
          token: post('https://plus.dnb.com/v2/token').payload(
            'grant_type' => 'client_credentials'
          ).headers('Content-Type' => 'application/json',
                    'Host' => 'plus.dnb.com',
                    'Cache-Control' => 'no-cache',
                    'Authorization' => 'Basic ' +
                    (connection['api_key'] + ':' +
                     connection['api_secret']).encode_base64)['access_token']
        }
      end,

      apply: lambda do |connection|
        headers('Authorization' => 'Bearer ' + connection['token'],
                'content-type' => 'application/json',
                'accept' => 'application/json')
      end
    },

    refresh_on: [
      401,
      'Unauthorized',
      /Unauthorized/
    ],

    base_uri: lambda do |_connection|
      'https://plus.dnb.com'
    end

  },

  test: lambda do |_connection|
    get('v1/referenceData/categories')
  end,

  methods: {

    identity_resolution_schema: lambda do
      [
        { name: 'Candidates', type: 'array', of: 'object',
          properties: [
            { name: 'displaySequence', type: 'integer' },
            { name: 'organization', type: 'object',
              properties: call('organization_schema') },
            { name: 'matchQualityInformation', type: 'object',
              properties: call('match_quality_schema') }
          ] }
      ]
    end,
    search_identity_resolution_input_schema: lambda do
      [
        { name: 'inLanguage',
          control_type: 'select',
          hint: 'An IETF BCP 47 code value that defines the' \
            ' language to be used to perform the match.' \
            ' Default: en-US (English)',
          toggle_hint: 'Select from list',
          pick_list: :language_list,
          sticky: true,
          toggle_field: {
            name: 'inLanguage',
            label: 'In language',
            type: 'string',
            control_type: 'text',
            optional: true,
            toggle_hint: 'Use custom value',
            hint: 'Allowed values: <b>auto, ja-JP, zh-hans-CN, en-US,' \
              ' zh-hant-TW, ko-hang-KR.</b>'
          } },
        { name: 'duns',
          sticky: true,
          hint: 'A 9-character numeric string identifying the entity by' \
            ' its Dun & Bradstreet D-U-N-S number.' },
        { name: 'registrationNumber',
          hint: 'The number either uniquely identifies or helps to' \
            ' identify an organization.' },
        { name: 'registrationNumberType', type: 'integer',
          hint: 'The unique code used to identify the type of' \
          ' registration number.' },
        { name: 'name',
          sticky: true,
          hint: 'Up to 240 characters used to find the entity by its primary' \
          ' name tradestyle names, or former names.' },
        { name: 'streetAddressLine1',
          hint: "The first line of the entity's street address." },
        { name: 'streetAddressLine2',
          hint: "The second line of the entity's street address." },
        { name: 'countryISOAlpha2Code',
          hint: 'The 2letter country/market code used to identify the country' \
            'of the entity. E.g. US' },
        { name: 'postalCode',
          hint: "The local country's postal authority to identify where the" \
          ' address is located.' },
        { name: 'addressLocality',
          hint: 'Identifies the city, town, township, village, borough, etc.' \
            ' where the entity is located.' },
        { name: 'addressRegion',
          hint: 'The name of the locally governed area that forms part of a' \
          ' centrally governed nation to identify where the address is' \
          ' located.' },
        { name: 'addressCounty',
          hint: 'The name of the county in which this address is located.' },
        { name: 'telephoneNumber',
          hint: 'The sequence of digits used for voice communication with the' \
          ' entity.' },
        { name: 'url',
          hint: 'A URL used to identify an entity by its email domain.' },
        { name: 'email',
          sticky: true,
          hint: 'An email address used to identify an entity by its email' \
          ' domain.' },
        { name: 'customerBillingEndorsement',
          hint: 'Text that is filled in by customer and reference used during' \
            ' the billing process.' },
        { name: 'customerReference1',
          hint: 'request reference text 1' },
        { name: 'customerReference2',
          hint: 'request reference text 2' },
        { name: 'customerReference3',
          hint: 'request reference text 3' },
        { name: 'customerReference4',
          hint: 'request reference text 4' },
        { name: 'customerReference5',
          hint: 'request reference text 5' },
        { name: 'candidateMaximumQuantity', type: 'integer',
          hint: 'The maximum number of results to be returned.' \
            ' Valid values: 1 to 100, Default: 10' },
        { name: 'confidenceLowerLevelThresholdValue', type: 'integer',
          hint: 'The lowest confidence level for entities returned' \
          ' in the response. Valid values: 1 to 10, Default: 4' },
        { name: 'exclusionCriteria',
          hint: 'Provides the ability to exclude entities based on' \
          ' several properties.',
          control_type: 'multiselect',
          delimeter: ',',
          pick_list: :exclusion_criteria_list,
          type: 'string',
          toggle_hint: 'Select from list',
          toggle_field: {
            name: 'exclusionCriteria',
            label: 'Exclusion criteria',
            type: 'string',
            optional: true,
            control_type: 'text',
            toggle_hint: 'Use custom value',
            hint: 'Some allowed values are.' \
              '<b>E.g. ExcludeNonHeadQuarters, ExcludeNonMarketable</b>'
          } },
        { name: 'isCleanseAndStandardizeInformationRequired',
          type: 'boolean',
          control_type: 'checkbox',
          render_input: 'boolean_conversion',
          parse_output: 'boolean_conversion',
          hint: 'Indicates if the cleanse and standardize information' \
            ' should be returned with the response.',
          toggle_hint: 'Select from list',
          toggle_field: {
            name: 'isCleanseAndStandardizeInformationRequired',
            type: 'boolean',
            label: 'Is cleanse and standardize information required',
            optional: true,
            control_type: 'text',
            render_input: 'boolean_conversion',
            parse_output: 'boolean_conversion',
            toggle_hint: 'Use custom value',
            hint: 'Allowed values are true or false'
          } }
      ]
    end,
    organization_schema: lambda do
      [
        { name: 'duns' },
        { name: 'primaryName' },
        { name: 'isStandalone', type: 'boolean' },
        { name: 'dunsControlStatus', type: 'object',
          properties: [
            { name: 'isMailUndeliverable', type: 'boolean' },
            { name: 'operatingStatus', type: 'object',
              properties: [
                { name: 'description' },
                { name: 'dnbCode', type: 'integer' }
              ] }
          ] },
        { name: 'tradeStyleNames', type: 'array', of: 'object',
          properties: [
            { name: 'name' },
            { name: 'priority', type: 'integer' }
          ] },
        { name: 'telephone', type: 'array', of: 'object',
          properties: [
            { name: 'telephoneNumber' },
            { name: 'isUnreachable', type: 'boolean' }
          ] },
        { name: 'websiteAddress', type: 'array', of: 'object',
          properties: [
            { name: 'url' },
            { name: 'domainName' }
          ] },
        { name: 'primaryAddress', type: 'object',
          properties: call('address_schema') },
        { name: 'mailingAddress', type: 'object',
          properties: call('address_schema') },
        { name: 'registrationNumbers', type: 'array', of: 'object',
          properties: [
            { name: 'registrationNumber' },
            { name: 'typeDescription' },
            { name: 'typeDnBCode', type: 'integer' }
          ] },
        { name: 'mostSeniorPrincipals', type: 'array', of: 'object',
          properties: [
            { name: 'fullName' }
          ] },
        { name: 'corporateLinkage', type: 'object',
          properties: [
            { name: 'familytreeRolesPlayed', type: 'array',
              of: 'object',
              properties: [
                { name: 'description' },
                { name: 'dnbCode', type: 'integer' }
              ] }
          ] }
      ]
    end,
    match_quality_schema: lambda do
      [
        { name: 'matchGradeComponents', type: 'array', of: 'object',
          properties: [
            { name: 'componentType' },
            { name: 'componentRating' }
          ] },
        { name: 'matchDataProfileComponents', type: 'array', of: 'object',
          properties: [
            { name: 'componentType' },
            { name: 'componentValue' }
          ] },
        { name: 'confidenceCode', type: 'integer' },
        { name: 'matchGrade' },
        { name: 'matchGradeComponentsCount', type: 'integer' },
        { name: 'matchDataProfile' },
        { name: 'matchDataProfileComponentsCount', type: 'integer' },
        { name: 'nameMatchScore', type: 'number' }
      ]
    end,
    address_schema: lambda do
      [
        { name: 'postalCode' },
        { name: 'postalCodeExtension' },
        { name: 'addressCountry', type: 'object',
          properties: [
            { name: 'isoAlpha2Code' },
            { name: 'name' }
          ] },
        { name: 'addressLocality', type: 'object',
          properties: [
            { name: 'name' }
          ] },
        { name: 'addressRegion', type: 'object',
          properties: [
            { name: 'name' },
            { name: 'abbreviatedName' }
          ] },
        { name: 'streetAddress', type: 'object',
          properties: [
            { name: 'line1' },
            { name: 'line2' }
          ] }
      ]
    end,
    search_type_ahead_input_schema: lambda do
      [
        { name: 'searchTerm',
          sticky: true,
          hint: 'Find entities by its primary name or one of its tradestyle' \
          ' names.' },
        { name: 'countryISOAlpha2Code',
          hint: 'The 2letter country/market code used to identify the country' \
            'of the entity. E.g. US' },
        { name: 'isOutOfBusiness',
          sticky: true,
          type: 'boolean',
          control_type: 'checkbox',
          render_input: 'boolean_conversion',
          parse_output: 'boolean_conversion',
          hint: 'Limits the search to entities with an isOutOfBusiness' \
          ' flag set to the specified value.',
          toggle_hint: 'Select from list',
          toggle_field: {
            name: 'isOutOfBusiness',
            type: 'boolean',
            label: 'Is out of business',
            optional: true,
            control_type: 'text',
            render_input: 'boolean_conversion',
            parse_output: 'boolean_conversion',
            toggle_hint: 'Use custom value',
            hint: 'Allowed values are true or false'
          } },
        { name: 'isMarketable',
          type: 'boolean',
          control_type: 'checkbox',
          render_input: 'boolean_conversion',
          parse_output: 'boolean_conversion',
          hint: 'Limits the search to entities with an isMarketable flag set' \
            ' to the specified value.',
          toggle_hint: 'Select from list',
          toggle_field: {
            name: 'isMarketable',
            type: 'boolean',
            label: 'Is marketable',
            optional: true,
            control_type: 'text',
            render_input: 'boolean_conversion',
            parse_output: 'boolean_conversion',
            toggle_hint: 'Use custom value',
            hint: 'Allowed values are true or false'
          } },
        { name: 'isDelisted',
          type: 'boolean',
          control_type: 'checkbox',
          render_input: 'boolean_conversion',
          parse_output: 'boolean_conversion',
          hint: 'Limits the search to entities with an isDelisted flag set' \
            ' to the specified value.',
          toggle_hint: 'Select from list',
          toggle_field: {
            name: 'isDelisted',
            type: 'boolean',
            label: 'Is delisted',
            optional: true,
            control_type: 'text',
            render_input: 'boolean_conversion',
            parse_output: 'boolean_conversion',
            toggle_hint: 'Use custom value',
            hint: 'Allowed values are true or false'
          } },
        { name: 'isMailUndeliverable',
          type: 'boolean',
          control_type: 'checkbox',
          render_input: 'boolean_conversion',
          parse_output: 'boolean_conversion',
          hint: 'Limits the search to entities with an isMailDeliverable' \
          ' flag set to the specified value.',
          toggle_hint: 'Select from list',
          toggle_field: {
            name: 'isMailUndeliverable',
            type: 'boolean',
            label: 'Is mail undeliverable',
            optional: true,
            control_type: 'text',
            render_input: 'boolean_conversion',
            parse_output: 'boolean_conversion',
            toggle_hint: 'Use custom value',
            hint: 'Allowed values are true or false'
          } },
        { name: 'addressLocality',
          sticky: true,
          hint: 'Identifies the city, town, township, village, borough, etc.' \
            ' where the entity is located.' },
        { name: 'addressRegion',
          hint: 'The name of the locally governed area that forms part of a' \
          ' centrally governed nation to identify where the address' \
          ' is located.' },
        { name: 'streetAddressLine1',
          hint: "The first line of the entity's street address." },
        { name: 'postalCode',
          sticky: true,
          hint: "The local country's postal authority to identify where the" \
          ' address is located.' },
        { name: 'radiusLat', type: 'number',
          hint: 'The latitude to be used as the center of the radius search.' },
        { name: 'radiusLon', type: 'number',
          hint: 'The longitude to be used as the center of radius search.' },
        { name: 'radiusPostalCode',
          hint: '5 digits for the US postal code used as the center of' \
          ' the radius search.' },
        { name: 'radiusDistance', type: 'number',
          hint: 'The circle radius in units specified to be considered along' \
            ' with the latitude and longitude to locate entities.' },
        { name: 'radiusUnit',
          control_type: 'select',
          hint: 'The unit of measure for the specified radius.',
          toggle_hint: 'Select from list',
          pick_list: :radius_unit_list,
          toggle_field: {
            name: 'radiusUnit',
            label: 'Radius unit',
            type: 'string',
            control_type: 'text',
            optional: true,
            toggle_hint: 'Use custom value',
            hint: 'Allowed values: m, km, mi, yd, ft' \
              ' E.g: "m"-(meters), "km"-(kilometers), "mi"-(miles),' \
              ' "yd"-(yards), "ft"-(feet).'
          } },
        { name: 'candidateMaximumQuantity', type: 'integer',
          sticky: true,
          hint: 'The maximum number of results to be returned.' \
            'Valid values: 1 to 25, Default: 10' },
        { name: 'customerReference',
          sticky: true,
          hint: 'customer reference text.' }
      ]
    end,
    type_ahead_canditate_schema: lambda do
      [
        { name: 'displaySequence' },
        { name: 'organization', type: 'object',
          properties: [
            { name: 'duns' },
            { name: 'primaryName' },
            { name: 'dunsControlStatus', type: 'object',
              properties: [
                { name: 'isOutOfBusiness', type: 'boolean' }
              ] },
            { name: 'tradeStyleNames', type: 'array', of: 'object',
              properties: [
                { name: 'priority', type: 'integer' },
                { name: 'name' }
              ] },
            { name: 'primaryAddress', type: 'object',
              properties: call('address_schema') },
            { name: 'financials', type: 'array', of: 'object',
              properties: [
                { name: 'yearlyRevenue', type: 'array', of: 'object',
                  properties: [
                    { name: 'currency' },
                    { name: 'value', type: 'number' }
                  ] }
              ] },
            { name: 'corporateLinkage', type: 'object',
              properties: [
                { name: 'isBranch', type: 'boolean' },
                { name: 'globalUltimate', type: 'object',
                  properties: [
                    { name: 'duns' },
                    { name: 'primaryName' }
                  ] }
              ] },
            { name: 'primaryIndustryCodes', type: 'array', of: 'object',
              properties: [
                { name: 'usSicV4' },
                { name: 'usSicV4Description' }
              ] }
          ] }
      ]
    end,
    search_type_ahead_output_schema: lambda do
      [{ name: 'Candidates', type: 'array', of: 'object',
         properties: call('type_ahead_canditate_schema') }]
    end,
    search_criteria_input_schema: lambda do
      [
        { name: 'searchTerm',
          sticky: true,
          hint: 'Find entities by its primary name or one of its tradestyle' \
          ' names.' },
        { name: 'countryISOAlpha2Code',
          sticky: true,
          hint: 'The 2letter country/market code used to identify the country' \
            'of the entity. E.g. US' },
        { name: 'duns',
          sticky: true,
          hint: 'A 9-character numeric string identifying the entity by' \
            ' its Dun & Bradstreet D-U-N-S number.' },
        { name: 'dunsList', type: 'array', of: 'string',
          sticky: true,
          hint: 'A list of 9-character numeric string identifying the' \
            ' entity by its Dun & Bradstreet D-U-N-S number.' },
        { name: 'isOutOfBusiness',
          type: 'boolean',
          control_type: 'checkbox',
          render_input: 'boolean_conversion',
          parse_output: 'boolean_conversion',
          hint: 'Limits the search to entities with isOutOfBusiness flag set' \
            ' to the specified value.',
          toggle_hint: 'Select from list',
          toggle_field: {
            name: 'isOutOfBusiness',
            type: 'boolean',
            label: 'Is out of business',
            optional: true,
            control_type: 'text',
            render_input: 'boolean_conversion',
            parse_output: 'boolean_conversion',
            toggle_hint: 'Use custom value',
            hint: 'Allowed values are true or false'
          } },
        { name: 'isMarketable',
          type: 'boolean',
          control_type: 'checkbox',
          render_input: 'boolean_conversion',
          parse_output: 'boolean_conversion',
          hint: 'Limits the search to entities with an isMarketable flag set' \
            ' to the specified value.',
          toggle_hint: 'Select from list',
          toggle_field: {
            name: 'isMarketable',
            type: 'boolean',
            label: 'Is marketable',
            optional: true,
            control_type: 'text',
            render_input: 'boolean_conversion',
            parse_output: 'boolean_conversion',
            toggle_hint: 'Use custom value',
            hint: 'Allowed values are true or false'
          } },
        { name: 'isDelisted',
          type: 'boolean',
          control_type: 'checkbox',
          render_input: 'boolean_conversion',
          parse_output: 'boolean_conversion',
          hint: 'Limits the search to entities with an isDelisted flag set' \
            ' to the specified value.',
          toggle_hint: 'Select from list',
          toggle_field: {
            name: 'isDelisted',
            type: 'boolean',
            label: 'Is delisted',
            optional: true,
            control_type: 'text',
            render_input: 'boolean_conversion',
            parse_output: 'boolean_conversion',
            toggle_hint: 'Use custom value',
            hint: 'Allowed values are true or false'
          } },
        { name: 'isMailUndeliverable',
          type: 'boolean',
          control_type: 'checkbox',
          render_input: 'boolean_conversion',
          parse_output: 'boolean_conversion',
          hint: 'Limits the search to entities with an isMailDeliverable flag' \
          ' set to the specified value.',
          toggle_hint: 'Select from list',
          toggle_field: {
            name: 'isMailUndeliverable',
            type: 'boolean',
            label: 'Is mail undeliverable',
            optional: true,
            control_type: 'text',
            render_input: 'boolean_conversion',
            parse_output: 'boolean_conversion',
            toggle_hint: 'Use custom value',
            hint: 'Allowed values are true or false'
          } },
        { name: 'usSicV4', type: 'array', of: 'string',
          sticky: true,
          hint: '4digit code denote the industry in which the business entity' \
            ' does most of its business.' },
        { name: 'yearlyRevenue', type: 'object',
          properties: [
            { name: 'minimumValue', type: 'integer',
              hint: 'Valid value: 1 to 100000000000000' },
            { name: 'maximumValue', type: 'integer',
              hint: 'Valid value: 1 to 100000000000000' }
          ] },
        { name: 'isTelephoneDisconnected',
          type: 'boolean',
          control_type: 'checkbox',
          render_input: 'boolean_conversion',
          parse_output: 'boolean_conversion',
          toggle_hint: 'Select from list',
          toggle_field: {
            name: 'isTelephoneDisconnected',
            type: 'boolean',
            label: 'Is telephone disconnected',
            optional: true,
            control_type: 'text',
            render_input: 'boolean_conversion',
            parse_output: 'boolean_conversion',
            toggle_hint: 'Use custom value',
            hint: 'Allowed values are true or false'
          } },
        { name: 'telephoneNumber', sticky: true },
        { name: 'domain',
          sticky: true,
          hint: '4 to 216 characters used to find entities by' \
          ' their domain names.' },
        { name: 'registrationNumbers', type: 'array', of: 'string',
          sticky: true,
          hint: 'The number either uniquely identifies or helps to' \
            ' identify an organization.' },
        { name: 'businessEntityType', type: 'array', of: 'integer' },
        { name: 'addressLocality',
          sticky: true,
          hint: 'Identifies the city, town, township, village, borough, etc.' \
            ' where the entity is located.' },
        { name: 'addressRegion',
          hint: 'The name of the locally governed area that forms part of' \
          ' a centrally governed nation to identify where the address' \
          ' is located.' },
        { name: 'streetAddressLine1', sticky: true },
        { name: 'postalCode',
          sticky: true,
          hint: "The local country's postal authority to identify where" \
          ' the address is located.' },
        { name: 'locationRadius', type: 'object',
          sticky: true,
          properties: [
            { name: 'lat', label: 'Latitude',
              type: 'number',
              hint: 'The latitude to be used as the center of the' \
              ' radius search.' },
            { name: 'lon', label: 'Longitude',
              type: 'number',
              hint: 'The longitude to be used as the center of the' \
              ' radius search.' },
            { name: 'postalCode' },
            { name: 'radius', type: 'number' },
            { name: 'unit',
              control_type: 'select',
              hint: 'The unit of measure for the specified radius.',
              toggle_hint: 'Select from list',
              pick_list: :radius_unit_list,
              toggle_field: {
                name: 'unit',
                label: 'Unit',
                type: 'string',
                control_type: 'text',
                optional: true,
                toggle_hint: 'Use custom value',
                hint: 'Allowed values: m, km, mi, yd, ft' \
                  ' E.g: "m"-(meters), "km"-(kilometers), "mi"-(miles),' \
                  ' "yd"-(yards), "ft"-(feet).'
              } }
          ] },
        { name: 'primaryName', sticky: true },
        { name: 'tradeStyleName', sticky: true },
        { name: 'tickerSymbol',
          sticky: true,
          hint: '1 to 6 characters that identifies the entity for share' \
          ' trading purposes.' },
        { name: 'familytreeRolesPlayed',
          hint: 'To identify the family tree roles the entity plays in the' \
            ' organization hierarchy.',
          control_type: 'multiselect',
          delimeter: ',',
          pick_list: :family_tree_list,
          type: 'integer',
          toggle_hint: 'Select from list',
          toggle_field: {
            name: 'familytreeRolesPlayed',
            label: 'Family tree roles played',
            type: 'integer',
            optional: true,
            control_type: 'text',
            toggle_hint: 'Use custom value',
            hint: 'Some allowed values are:' \
              'E.g. 12775, 12774'
          } },
        { name: 'globalUltimateFamilyTreeMembersCount',
          type: 'object',
          properties: [
            { name: 'minimumValue', type: 'integer' },
            { name: 'maximumValue', type: 'integer' }
          ] },
        { name: 'numberOfEmployees', type: 'object',
          properties: [
            { name: 'informationScope',
              control_type: 'select',
              type: 'integer',
              hint: 'A code that represents the scope the requested values' \
                ' are checked against.',
              toggle_hint: 'Select from list',
              pick_list: :information_scope_list,
              toggle_field: {
                name: 'informationScope',
                label: 'Information scope',
                type: 'integer',
                control_type: 'text',
                optional: true,
                toggle_hint: 'Use custom value',
                hint: 'Allowed values are:' \
                  'E.g. 9066, 9067'
              } },
            { name: 'minimumValue', type: 'integer' },
            { name: 'maximumValue', type: 'integer' }
          ] },
        { name: 'industryCodes', type: 'array', of: 'object',
          sticky: true,
          properties: [
            { name: 'typeDnbCode',
              control_type: 'select',
              type: 'integer',
              hint: 'To identify the industry coding scheme for this' \
              ' Industry Code.',
              toggle_hint: 'Select from list',
              pick_list: :dnb_code_list,
              toggle_field: {
                name: 'typeDnbCode',
                label: 'Type dnb code',
                type: 'integer',
                control_type: 'text',
                optional: true,
                toggle_hint: 'Use custom value',
                hint: 'Some allowed values are' \
                  'E.g. 25838, 30832, 3599'
              } },
            { name: 'description', type: 'array', of: 'string' },
            { name: 'code', type: 'array', of: 'string' }
          ] },
        { name: 'isManufacturingLocation',
          type: 'boolean',
          control_type: 'checkbox',
          render_input: 'boolean_conversion',
          parse_output: 'boolean_conversion',
          hint: 'Manufacturing activity is performed at this facility' \
          ' by the subject.',
          toggle_hint: 'Select from list',
          toggle_field: {
            name: 'isManufacturingLocation',
            type: 'boolean',
            label: 'Is manufacturing location',
            optional: true,
            control_type: 'text',
            render_input: 'boolean_conversion',
            parse_output: 'boolean_conversion',
            toggle_hint: 'Use custom value',
            hint: 'Allowed values are true or false'
          } },
        { name: 'isPubliclyTradedCompany',
          type: 'boolean',
          control_type: 'checkbox',
          render_input: 'boolean_conversion',
          parse_output: 'boolean_conversion',
          hint: 'Organization offers its securities to general public,' \
          ' typically through a stock exchange.',
          toggle_hint: 'Select from list',
          toggle_field: {
            name: 'isPubliclyTradedCompany',
            type: 'boolean',
            label: 'Is publicly traded company',
            optional: true,
            control_type: 'text',
            render_input: 'boolean_conversion',
            parse_output: 'boolean_conversion',
            toggle_hint: 'Use custom value',
            hint: 'Allowed values are true or false'
          } },
        { name: 'isMinorityOwned',
          type: 'boolean',
          control_type: 'checkbox',
          render_input: 'boolean_conversion',
          parse_output: 'boolean_conversion',
          toggle_hint: 'Select from list',
          toggle_field: {
            name: 'isMinorityOwned',
            type: 'boolean',
            label: 'Is minority owned',
            optional: true,
            control_type: 'text',
            render_input: 'boolean_conversion',
            parse_output: 'boolean_conversion',
            toggle_hint: 'Use custom value',
            hint: 'Allowed values are true or false'
          } },
        { name: 'isFemaleOwned',
          type: 'boolean',
          control_type: 'checkbox',
          render_input: 'boolean_conversion',
          parse_output: 'boolean_conversion',
          toggle_hint: 'Select from list',
          toggle_field: {
            name: 'isFemaleOwned',
            type: 'boolean',
            label: 'Is female owned',
            optional: true,
            control_type: 'text',
            render_input: 'boolean_conversion',
            parse_output: 'boolean_conversion',
            toggle_hint: 'Use custom value',
            hint: 'Allowed values are true or false'
          } },
        { name: 'isImporter',
          type: 'boolean',
          control_type: 'checkbox',
          render_input: 'boolean_conversion',
          parse_output: 'boolean_conversion',
          toggle_hint: 'Select from list',
          toggle_field: {
            name: 'isImporter',
            type: 'boolean',
            label: 'Is importer',
            optional: true,
            control_type: 'text',
            render_input: 'boolean_conversion',
            parse_output: 'boolean_conversion',
            toggle_hint: 'Use custom value',
            hint: 'Allowed values are true or false'
          } },
        { name: 'isExporter',
          type: 'boolean',
          control_type: 'checkbox',
          render_input: 'boolean_conversion',
          parse_output: 'boolean_conversion',
          toggle_hint: 'Select from list',
          toggle_field: {
            name: 'isExporter',
            type: 'boolean',
            label: 'Is exporter',
            optional: true,
            control_type: 'text',
            render_input: 'boolean_conversion',
            parse_output: 'boolean_conversion',
            toggle_hint: 'Use custom value',
            hint: 'Allowed values are true or false'
          } },
        { name: 'isFortune1000Listed',
          type: 'boolean',
          control_type: 'checkbox',
          render_input: 'boolean_conversion',
          parse_output: 'boolean_conversion',
          toggle_hint: 'Select from list',
          toggle_field: {
            name: 'isFortune1000Listed',
            type: 'boolean',
            label: 'Is fortune 1000 listed',
            optional: true,
            control_type: 'text',
            render_input: 'boolean_conversion',
            parse_output: 'boolean_conversion',
            toggle_hint: 'Use custom value',
            hint: 'Allowed values are true or false'
          } },
        { name: 'sort', type: 'object',
          properties: [
            { name: 'item',
              control_type: 'select',
              hint: 'The property by which the response is to be sorted.',
              toggle_hint: 'Select from list',
              pick_list: :item_list,
              toggle_field: {
                name: 'item',
                label: 'Item',
                type: 'string',
                control_type: 'text',
                optional: true,
                toggle_hint: 'Use custom value',
                hint: 'Some allowed values are:' \
                  'numberOfEmployees, primaryName, isBranch'
              } },
            { name: 'direction',
              control_type: 'select',
              hint: 'This determines the ordering direction in the response.',
              toggle_hint: 'Select from list',
              pick_list: :direction_list,
              toggle_field: {
                name: 'direction',
                label: 'Direction',
                type: 'string',
                control_type: 'text',
                optional: true,
                toggle_hint: 'Use custom value',
                hint: 'Allowed values are:' \
                  'E.g. ascending, ascending'
              } }
          ] },
        { name: 'pageSize', type: 'integer',
          hint: 'Valid values: Integers from 1 to 50.' },
        { name: 'pageNumber', type: 'integer',
          hint: 'Search results can be paginated.' },
        { name: 'returnNavigators',
          type: 'boolean',
          control_type: 'checkbox',
          render_input: 'boolean_conversion',
          parse_output: 'boolean_conversion',
          hint: 'Indicates if Navigators should be returned in the search' \
          ' response.',
          toggle_hint: 'Select from list',
          toggle_field: {
            name: 'returnNavigators',
            type: 'boolean',
            label: 'returnNavigators',
            optional: true,
            control_type: 'text',
            render_input: 'boolean_conversion',
            parse_output: 'boolean_conversion',
            toggle_hint: 'Use custom value',
            hint: 'Allowed values are true or false'
          } },
        { name: 'customerReference',
          hint: 'customer reference text.' },
        { name: 'globalUltimateCountryISOAlpha2Code' }
      ]
    end,
    search_criteria_output_schema: lambda do
      [
        { name: 'Candidates', type: 'array', of: 'object',
          properties: [
            { name: 'displaySequence', type: 'integer' },
            { name: 'organization', type: 'object',
              properties: call('criteria_organization_schema') }
          ] }
      ]
    end,
    criteria_organization_schema: lambda do
      [
        { name: 'duns' },
        { name: 'primaryName' },
        { name: 'isImporter', type: 'boolean' },
        { name: 'isExporter', type: 'boolean' },
        { name: 'isFortune1000Listed',
          type: 'boolean' },
        { name: 'domain' },
        { name: 'tickerSymbol' },
        { name: 'isStandalone', type: 'boolean' },
        { name: 'isPubliclyTradedCompany',
          type: 'boolean' },
        { name: 'dunsControlStatus', type: 'object',
          properties: [
            { name: 'isOutOfBusiness', type: 'boolean' },
            { name: 'isMarketable', type: 'boolean' },
            { name: 'isMailUndeliverable', type: 'boolean' },
            { name: 'isTelephoneDisconnected', type: 'boolean' },
            { name: 'isDelisted', type: 'boolean' },
            { name: 'subjectHandlingDetails', type: 'array',
              of: 'object',
              properties: [
                { name: 'dnbCode', type: 'integer' },
                { name: 'description' }
              ] }
          ] },
        { name: 'tradeStyleNames', type: 'array', of: 'object',
          properties: [
            { name: 'priority', type: 'integer' },
            { name: 'name' }
          ] },
        { name: 'formerPrimaryNames', type: 'array', of: 'object',
          properties: [
            { name: 'name' },
            { name: 'startDate', type: 'date_time',
              parse_output: 'date_time_conversion' },
            { name: 'endDate', type: 'date_time',
              parse_output: 'date_time_conversion' }
          ] },
        { name: 'primaryAddress', type: 'object',
          properties: call('address_schema') },
        { name: 'registeredAddress', type: 'object',
          properties: call('address_schema') },
        { name: 'mailingAddress', type: 'object',
          properties: call('address_schema') },
        { name: 'telephone', type: 'array', of: 'object',
          properties: [
            { name: 'telephoneNumber' },
            { name: 'isdCode' }
          ] },
        { name: 'registrationNumbers', type: 'array', of: 'object',
          properties: [
            { name: 'typeDnBCode', type: 'integer' },
            { name: 'registrationNumber' },
            { name: 'typeDescription' }
          ] },
        { name: 'numberOfEmployees', type: 'array', of: 'object',
          properties: [
            { name: 'value', type: 'integer' },
            { name: 'informationScopeDescription' },
            { name: 'informationScopeDnBCode', type: 'integer' },
            { name: 'reliabilityDescription' },
            { name: 'reliabilityDnBCode', type: 'integer' }
          ] },
        { name: 'businessEntityType', type: 'object',
          properties: [
            { name: 'dnbCode', type: 'integer' },
            { name: 'description' }
          ] },
        { name: 'financials', type: 'array', of: 'object',
          properties: [
            { name: 'yearlyRevenue', type: 'array',
              of: 'object',
              properties: [
                { name: 'currency' },
                { name: 'value', type: 'number' }
              ] }
          ] },
        { name: 'corporateLinkage', type: 'object',
          properties: [
            { name: 'isBranch', type: 'boolean' },
            { name: 'globalUltimateFamilyTreeMembersCount',
              type: 'integer' },
            { name: 'familytreeRolesPlayed', type: 'array',
              of: 'object',
              properties: [
                { name: 'dnbCode', type: 'integer' },
                { name: 'description' }
              ] },
            { name: 'globalUltimate', type: 'object',
              properties: [
                { name: 'duns' },
                { name: 'primaryName' },
                { name: 'primaryAddress', type: 'object',
                  properties: [
                    { name: 'addressCountry', type: 'object',
                      properties: [
                        { name: 'isoAlpha2Code' }
                      ] }
                  ] }
              ] },
            { name: 'parent', type: 'object',
              properties: [
                { name: 'duns' },
                { name: 'primaryName' }
              ] },
            { name: 'headQuarter', type: 'object',
              properties: [
                { name: 'duns' },
                { name: 'primaryName' }
              ] }
          ] },
        { name: 'primaryIndustryCodes', type: 'array', of: 'object',
          properties: [
            { name: 'usSicV4' },
            { name: 'usSicV4Description' }
          ] },
        { name: 'industryCodes', type: 'array', of: 'object',
          properties: [
            { name: 'code' },
            { name: 'description' },
            { name: 'priority', type: 'integer' },
            { name: 'typeDescription' },
            { name: 'typeDnBCode', type: 'integer' }
          ] },
        { name: 'socioEconomicInformation', type: 'object',
          properties: [
            { name: 'isMinorityOwned', type: 'boolean' },
            { name: 'isFemaleOwned', type: 'boolean' }
          ] }
      ]
    end,
    search_contact_input_schema: lambda do
      call('search_criteria_input_schema').
        only('searchTerm', 'duns', 'countryISOAlpha2Code',
             'addressRegion', 'addressLocality', 'usSicV4',
             'postalCode', 'industryCodes', 'tickerSymbol',
             'sort', 'pageSize', 'pageNumber', 'returnNavigators',
             'customerReference').
        concat([
                 { name: 'familyTreeScope',
                   hint: 'Allows the customer to request for contacts to' \
                   ' be returned from a defined universe of companies.' },
                 { name: 'contactID',
                   sticky: true,
                   hint: 'ID of the contact' },
                 { name: 'contactEmail',
                   sticky: true,
                   hint: "Contact's email address." },
                 { name: 'givenName',
                   sticky: true,
                   hint: 'Used to find entities by their given name.' },
                 { name: 'familyName',
                   sticky: true,
                   hint: 'Used to find entities by their family name.' },
                 { name: 'primaryName',
                   sticky: true,
                   hint: 'Used to find entities by the primary names.' },
                 { name: 'jobTitles', type: 'array', of: 'string',
                   sticky: true,
                   hint: 'List of strings used to search contact job titles.' },
                 { name: 'mrcCode', type: 'array', of: 'string',
                   sticky: true,
                   hint: 'Identifies the business function of the principal.' },
                 { name: 'telephoneAccuracyScoreThresholdValue',
                   type: 'integer',
                   hint: 'Valid Values: 0 to 100' },
                 { name: 'view',
                   control_type: 'select',
                   hint: 'Indicates the level of content to be returned.',
                   toggle_hint: 'Select from list',
                   pick_list: :view_list,
                   toggle_field: {
                     name: 'view',
                     label: 'View',
                     type: 'string',
                     control_type: 'text',
                     optional: true,
                     toggle_hint: 'Use custom value',
                     hint: 'Allowed values are: standard, premium.' \
                     ' Default: standard'
                   } },
                 { name: 'emailAccuracyScoreThresholdValue', type: 'integer',
                   hint: 'Valid Values: 0 to 100.' }
               ])
    end,
    search_contact_output_schema: lambda do
      [
        { name: 'Candidates', type: 'array', of: 'object',
          properties: [
            { name: 'displaySequence', type: 'integer' },
            { name: 'contact', type: 'object',
              properties: [
                { name: 'id' },
                { name: 'email' },
                { name: 'emailDomainName' },
                { name: 'givenName' },
                { name: 'middleName' },
                { name: 'familyName' },
                { name: 'namePrefix' },
                { name: 'nameSuffix' },
                { name: 'additionalName' },
                { name: 'isTitleMatched', type: 'boolean' },
                { name: 'isSocialVerified', type: 'boolean' },
                { name: 'dataFreshnessScore', type: 'integer' },
                { name: 'confidenceLevel' },
                { name: 'verifiedDate', type: 'date_time',
                  parse_output: 'date_time_conversion' },
                { name: 'emailAccuracy', type: 'object',
                  properties: [
                    { name: 'deliverabilityScore', type: 'integer' },
                    { name: 'verifiedDate', type: 'date_time',
                      parse_output: 'date_time_conversion' }
                  ] },
                { name: 'titleAccuracy', type: 'object',
                  properties: [
                    { name: 'accuracyScore', type: 'integer' }
                  ] },
                { name: 'organization', type: 'object',
                  properties: call('contact_organization_schema') },
                { name: 'telephone', type: 'array', of: 'object',
                  properties: [
                    { name: 'telephoneNumber' },
                    { name: 'telephoneAccuracy', type: 'object',
                      properties: [
                        { name: 'accuracyScore', type: 'integer' }
                      ] }
                  ] },
                { name: 'socialMedia', type: 'array', of: 'object',
                  properties: [
                    { name: 'url' },
                    { name: 'platform', type: 'object',
                      properties: [
                        { name: 'dnbCode', type: 'integer' },
                        { name: 'description' }
                      ] }
                  ] },
                { name: 'jobTitles', type: 'array', of: 'object',
                  properties: [
                    { name: 'title' }
                  ] },
                { name: 'vanityTitles', type: 'array', of: 'object',
                  properties: [
                    { name: 'title' }
                  ] },
                { name: 'managementResponsibilities', type: 'array',
                  of: 'object',
                  properties: [
                    { name: 'mrcCode' }
                  ] },
                { name: 'matchQualityInformation', type: 'object',
                  properties: [
                    { name: 'confidenceCode', type: 'integer' },
                    { name: 'matchGrade' },
                    { name: 'matchDataProfile', type: 'integer' }
                  ] }
              ] }
          ] }
      ]
    end,
    contact_organization_schema: lambda do
      call('criteria_organization_schema').
        only('duns', 'primaryName', 'tickerSymbol', 'primaryIndustryCodes',
             'numberOfEmployees', 'industryCodes').
        concat([
                 { name: 'globalUltimate', type: 'object',
                   properties: [
                     { name: 'duns' }
                   ] },
                 { name: 'primaryAddress', type: 'object',
                   properties: call('address_schema') },
                 { name: 'dunsControlStatus', type: 'object',
                   properties: [
                     { name: 'operatingStatus', type: 'object',
                       properties: [
                         { name: 'dnbCode', type: 'integer' },
                         { name: 'description' }
                       ] },
                     { name: 'isMarketable', type: 'boolean' },
                     { name: 'isMailUndeliverable', type: 'boolean' },
                     { name: 'isTelephoneDisconnected', type: 'boolean' },
                     { name: 'isDelisted', type: 'boolean' }
                   ] }
               ])
    end

  },

  object_definitions: {

    search_identity_resolution_input: {
      fields: lambda do |_connection|
        call('search_identity_resolution_input_schema')
      end
    },
    search_identity_resolution_output: {
      fields: lambda do |_connection|
        call('identity_resolution_schema')
      end
    },
    search_type_ahead_input: {
      fields: lambda do |_connection|
        call('search_type_ahead_input_schema')
      end
    },
    search_type_ahead_output: {
      fields: lambda do |_connection|
        call('search_type_ahead_output_schema')
      end
    },
    search_criteria_input: {
      fields: lambda do |_connection|
        call('search_criteria_input_schema')
      end
    },
    search_criteria_output: {
      fields: lambda do |_connection|
        call('search_criteria_output_schema')
      end
    },
    search_contact_input: {
      fields: lambda do |_connection|
        call('search_contact_input_schema')
      end
    },
    search_contact_output: {
      fields: lambda do |_connection|
        call('search_contact_output_schema')
      end
    }

  },

  actions: {

    search_identity_resolution: {
      title: 'Search identity resolution',
      subtitle: 'Search identity resolution in D&B',
      description: "Search <span class='provider'>identity resolution</span> " \
                   "in <span class='provider'>D&B</span>",
      help: 'Identity Resolution returns the best matches for given' \
      ' search criteria.',

      input_fields: lambda do |object_definitions|
        object_definitions['search_identity_resolution_input']
      end,

      execute: lambda do |_connection, input|
        { Candidates: get('v1/match/cleanseMatch', input).
          after_error_response(/.*/) do |_code, body, _header, message|
            error("#{message}: #{body}")
          end.
          dig('matchCandidates') }
      end,

      output_fields: lambda do |object_definitions|
        object_definitions['search_identity_resolution_output']
      end,

      sample_output: lambda do |_connection, _input|
        { Candidates: get('v1/match/cleanseMatch?url=www.dnb.com')&.
          dig('matchCandidates') }
      end
    },
    search_type_ahead: {
      title: 'Search type ahead',
      subtitle: 'Search type ahead in D&B',
      description: "Search <span class='provider'>type ahead</span> " \
                   "in <span class='provider'>D&B</span>",
      help: 'Typeahead search enables users to quickly find company' \
            ' records without having to type the entire company' \
            ' information in the search request.',

      input_fields: lambda do |object_definitions|
        object_definitions['search_type_ahead_input']
      end,

      execute: lambda do |_connection, input|
        { Candidates: get('v1/search/typeahead', input).
          after_error_response(/.*/) do |_code, body, _header, message|
            error("#{message}: #{body}")
          end.
          dig('searchCandidates') }
      end,

      output_fields: lambda do |object_definitions|
        object_definitions['search_type_ahead_output']
      end,

      sample_output: lambda do |_connection, _input|
        { Candidates: get('v1/search/typeahead?searchTerm=duns')&.
          dig('searchCandidates') }
      end
    },
    search_criteria: {
      title: 'Search criteria',
      subtitle: 'Search criteria in D&B',
      description: "Search <span class='provider'>criteria</span> " \
                   "in <span class='provider'>D&B</span>",
      help: 'Locates possible entities from the Dun & Bradstreet' \
            ' Data Cloud using specified criteria.',

      input_fields: lambda do |object_definitions|
        object_definitions['search_criteria_input']
      end,

      execute: lambda do |_connection, input|
        { Candidates: post('v1/search/criteria').
          payload(input).
          after_error_response(/.*/) do |_code, body, _header, message|
            error("#{message}: #{body}")
          end.
          dig('searchCandidates') }
      end,

      output_fields: lambda do |object_definitions|
        object_definitions['search_criteria_output']
      end,

      sample_output: lambda do |_connection, _input|
        { Candidates: post('v1/search/criteria').
          payload(searchTerm: 'duns')&.
          dig('searchCandidates') }
      end
    },
    search_contact: {
      title: 'Search contact',
      subtitle: 'Search contact in D&B',
      description: "Search <span class='provider'>contact</span> " \
                   "in <span class='provider'>D&B</span>",
      help: 'The search contact allows D&B Direct+ customers to' \
            ' find individuals using a variety of criteria.',

      input_fields: lambda do |object_definitions|
        object_definitions['search_contact_input']
      end,

      execute: lambda do |_connection, input|
        { Candidates: post('v1/search/contact').
          payload(input).
          after_error_response(/.*/) do |_code, body, _header, message|
            error("#{message}: #{body}")
          end.
          dig('searchCandidates') }
      end,

      output_fields: lambda do |object_definitions|
        object_definitions['search_contact_output']
      end,

      sample_output: lambda do |_connection, _input|
        { Candidates: post('v1/search/contact').
          payload(searchTerm: 'duns')&.
          dig('searchCandidates') }
      end
    }
  },

  pick_lists: {

    language_list: lambda do |_connection|
      [
        %w[Auto auto],
        %w[Japanese ja-JP],
        %w[Simplified\ Chinese zh-hans-CN],
        %w[Traditional\ Chinese zh-hant-TW],
        %w[Hangul ko-hang-KR],
        %w[English en-US]
      ]
    end,
    exclusion_criteria_list: lambda do |_connection|
      [
        %w[Exclude\ non\ head\ quarters ExcludeNonHeadQuarters],
        %w[Exclude\ non\ marketable ExcludeNonMarketable],
        %w[Exclude\ out\ of\ business ExcludeOutofBusiness],
        %w[Exclude\ undeliverable ExcludeUndeliverable],
        %w[Exclude\ unreachable ExcludeUnreachable]
      ]
    end,
    radius_unit_list: lambda do |_connection|
      [
        %w[Meters m],
        %w[Kilometers km],
        %w[Miles mi],
        %w[Yards yd],
        %w[Feet ft]
      ]
    end,
    family_tree_list: lambda do |_connection|
      [
        ['Global Ultimate', 12775],
        ['Domestic Ultimate', 12774],
        ['Parent/Headquarters', 9141],
        ['Branch/Division', 9140],
        ['Subsidiary', 9159]
      ]
    end,
    information_scope_list: lambda do |_connection|
      [
        ['Individual', 9066],
        ['Consolidated', 9067]
      ]
    end,
    dnb_code_list: lambda do |_connection|
      [
        ['D&B Hoovers Industry Code', 25838],
        ['NAICS 2012', 24664],
        ['NAICS 2017', 30832],
        ['UK Standard Industry Code 2007', 19295],
        ['US SIC 8 digit', 3599]
      ]
    end,
    item_list: lambda do |_connection|
      [
        %w[Number\ of\ employees numberOfEmployees],
        %w[Country\ ISO\ Alpha2\ code countryISOAlpha2Code],
        %w[Primary\ name primaryName],
        %w[Is\ out\ of\ business isOutOfBusiness],
        %w[Is\ branch isBranch],
        %w[Yearly\ revenue yearlyRevenue]
      ]
    end,
    direction_list: lambda do |_connection|
      [
        %w[Ascending ascending],
        %w[Descending descending]
      ]
    end,
    view_list: lambda do |_connection|
      [
        %w[Standard standard],
        %w[Premium premium]
      ]
    end

  }

}
