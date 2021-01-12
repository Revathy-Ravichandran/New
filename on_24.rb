{
  title: 'ON24',
  connection:
  {
    fields:
    [
      {
        name: 'clientId',
        label: 'Client_id',
        optional: false,
        hint: "Click <a href='https://wcc.on24.com/webcast/apitokensdashboard'"\
          " target='_blank'>here</a> to find client id"
      },
      {
        name: 'accessTokenKey',
        optional: false,
        hint: 'The client access token key'
      },
      {
        name: 'accessTokenSecret',
        control_type: 'password',
        optional: false,
        hint: 'The client access token secret'
      }
    ],
    authorization: {
      apply: lambda do |connection|
        headers('accessTokenKey': connection['accessTokenKey'],
                'accessTokenSecret': connection['accessTokenSecret'],
                'content-type': 'application/x-www-form-urlencoded')
      end
    },
    base_uri: lambda do |connection|
      "https://api.on24.com/v2/client/#{connection['clientId']}/"
    end
  },
  test: lambda do |_connection|
    get('event?includeSubaccounts=Y&itemsPerPage=1')
  end,

  methods:
  {
    event_management_schema: lambda do |_input|
      [
        { name: 'eventId', type: 'integer' },
        { name: 'title', hint: "Event's name. Limited to less than" \
            ' 251 characters' },
        { name: 'eventAbstract', hint: "Event's description or summary" },
        { name: 'promotionalSummary' },
        { name: 'liveStart', type: 'date_time', hint: "Event's start date.",
          render_input: lambda do |field|
            field&.to_s
          end,
          parse_output: lambda do |field|
            field&.to_s
          end },
        { name: 'liveDuration', hint: 'LiveDuration value in 15 minute' \
            ' increments (e.g. 15, 30, 45, 60, etc.) up to 120 minutes. Above' \
            ' 120 minutes, increments will be 30 minutes up to 480 minutes.' },
        { name: 'liveEnd', type: 'date_time',
          parse_output: lambda do |field|
            field&.to_s
          end },
        { name: 'archiveStart', type: 'date_time',
          parse_output: lambda do |field|
            field&.to_s
          end },
        { name: 'archiveEnd', type: 'date_time',
          parse_output: lambda do |field|
            field&.to_s
          end },
        { name: 'clientId', type: 'integer' },
        { name: 'timeZone', control_type: 'select',
          pick_list: :Time_zones,
          toggle_hint: 'Select from list',
          type: 'string',
          toggle_field: {
            name: 'timeZone',
            label: 'Time_zone',
            optional: true,
            type: 'string',
            control_type: 'text',
            toggle_hint: 'Use custom value',
            hint: 'Allowed values, E.g. Etc/GMT+12, Pacific/Midway'
          } },
        { name: 'eventType', control_type: 'select',
          pick_list: :Event_types,
          type: 'string',
          toggle_hint: 'Select from list',
          toggle_field:
          {
            name: 'eventType',
            label: 'Event_type',
            optional: true,
            type: 'string',
            control_type: 'text',
            toggle_hint: 'Use custom value',
            hint: 'Allowed values, E.g. fav, simulive, ondemand'
          } },
        { name: 'goodAfter', type: 'date_time',
          parse_output: lambda do |field|
            field&.to_s
          end },
        { name: 'dialInNumber' },
        { name: 'bridgeDialInNumber' },
        { name: 'dialInPasscode' },
        { name: 'audienceUrl', label: 'Audience_URL' },
        { name: 'reportsUrl', label: 'Reports_URL' },
        { name: 'previewUrl', label: 'Preview_URL' },
        { name: 'archiveDuration', type: 'integer' },
        { name: 'shortTimeZone' },
        { name: 'isLiveStartPast', type: 'boolean' },
        { name: 'isLiveEndPast', type: 'boolean' },
        { name: 'archiveEndInPast', type: 'boolean' },
        { name: 'monthsAvailableToExtend', type: 'integer' },
        { name: 'canExtendArchive', type: 'boolean' },
        { name: 'archiveAvailable', control_type: 'select',
          pick_list: :boolean_list,
          type: 'string',
          hint: 'Indicates if the Archive Option is Enabled or Disabled for' \
            ' this event',
          toggle_hint: 'Select from list',
          toggle_field: {
            name: 'archiveAvailable',
            label: 'Archive_available',
            optional: true,
            type: 'string',
            control_type: 'text',
            toggle_hint: 'Use custom value',
            hint: 'Allowed values are Y,N'
          } },
        { name: 'autoArchiveProcessed', type: 'boolean' },
        { name: 'canManipulateArchive', type: 'boolean' },
        { name: 'canToggleArchiveAvailability', type: 'boolean' },
        { name: 'showFaaBridgeNumber', type: 'boolean' },
        { name: 'showColossusLink', type: 'boolean' },
        { name: 'languageCd', control_type: 'select',
          pick_list: :languages,
          type: 'string',
          toggle_hint: 'Select from list',
          toggle_field: {
            name: 'languageCd',
            label: 'Language_code',
            optional: true,
            type: 'string',
            control_type: 'text',
            toggle_hint: 'Use custom value',
            hint: 'Allowed values, E.g. bg, zh, cs'
          } },
        { name: 'countrycd', control_type: 'select',
          pick_list: :country,
          type: 'string',
          toggle_hint: 'Select from list',
          toggle_field: {
            name: 'countrycd',
            label: 'Country_code',
            optional: true,
            type: 'string',
            control_type: 'text',
            toggle_hint: 'Use custom value',
            hint: 'Allowed values are CN, UK, TW'
          } },
        { name: 'campaignCode' },
        { name: 'sourceEventId', type: 'integer' },
        { name: 'rolloverAudio', type: 'boolean' },
        { name: 'rolloverAudioDisabled', type: 'boolean' },
        { name: 'tags', type: 'array', of: 'object', properties: [
          { name: '__name', label: 'Name' }
        ] },
        { name: 'customaccounttags', type: 'array', of: 'object',
          properties: [
            { name: 'groupid', type: 'integer' },
            { name: 'groupname' },
            { name: 'tagid', type: 'integer' },
            { name: 'tagname' }
          ] },
        { name: 'defaultPlayerConsoleTemplateId', type: 'integer' },
        { name: 'simuliveWaitingMode', type: 'boolean' },
        { name: 'pmurl', label: 'Pm_URL' },
        { name: 'simuliveEPMode', type: 'boolean' },
        { name: 'simuliveMode', type: 'boolean' }
      ]
    end,
    event_level_schema: lambda do |_input|
      [
        { name: 'eventid', type: 'integer' },
        { name: 'eventname' },
        { name: 'clientid', type: 'integer' },
        { name: 'eventduration', type: 'integer' },
        { name: 'goodafter', type: 'date_time' },
        { name: 'isactive', type: 'boolean' },
        { name: 'goodtill' },
        { name: 'regrequired', type: 'boolean' },
        { name: 'description' },
        { name: 'promotionalsummary' },
        { name: 'regnotificationrequired', type: 'boolean' },
        { name: 'displaytimezonecd' },
        { name: 'qandaemail' },
        { name: 'eventlocation' },
        { name: 'eventtype' },
        { name: 'category' },
        { name: 'servicetype' },
        { name: 'sponsor' },
        { name: 'createtimestamp', type: 'date_time' },
        { name: 'keyword' },
        { name: 'localelanguagecd' },
        { name: 'localecountrycd' },
        { name: 'lastmodified', type: 'date_time' },
        { name: 'lastupdated', type: 'date_time' },
        { name: 'iseliteexpired' },
        { name: 'application' },
        { name: 'industry' },
        { name: 'livestart', type: 'date_time' },
        { name: 'liveend', type: 'date_time' },
        { name: 'archivestart', type: 'date_time' },
        { name: 'archiveend', type: 'date_time' },
        { name: 'eventprofile' },
        { name: 'streamtype' },
        { name: 'audiencekey' },
        { name: 'extaudienceurl', label: 'Ext_audience_URL' },
        { name: 'reporturl', label: 'Report_URL' },
        { name: 'uploadurl', label: 'Upload_URL' },
        { name: 'pmurl', label: 'Pm_URL' },
        { name: 'previewurl', label: 'Preview_URL' },
        { name: 'audienceurl', label: 'Audience_URL' },
        { name: 'contenttype' },
        { name: 'partnerrefstats', type: 'array', of: 'object', properties: [
          { name: 'code' },
          { name: 'count', type: 'integer' }
        ] },
        { name: 'tags', type: 'array', of: 'object', properties: [
          { name: '__name', label: 'Name' }
        ] },
        { name: 'funnelstages', type: 'array', of: 'object', properties: [
          { name: '__name', label: 'Name' }
        ] },
        { name: 'speakers', type: 'array', of: 'object', properties: [
          { name: 'name' },
          { name: 'title' },
          { name: 'company' },
          { name: 'description' }
        ] },
        { name: 'encoders', type: 'array', of: 'object', properties: [
          { name: 'encoder' },
          { name: 'url', label: 'URL' },
          { name: 'streamid' }
        ] },
        { name: 'eventstd1', label: 'Event_standard1' },
        { name: 'eventstd2', label: 'Event_standard2' },
        { name: 'eventstd3', label: 'Event_standard3' },
        { name: 'eventstd4', label: 'Event_standard4' },
        { name: 'eventstd5', label: 'Event_standard5' },
        { name: 'surveyurls', label: 'Survey_URLs', type: 'array', of: 'object',
          properties: [
            { name: '__name', label: 'Name' }
          ] },
        { name: 'customaccounttags', type: 'array', of: 'object', properties: [
          { name: 'groupid', type: 'integer' },
          { name: 'groupname' },
          { name: 'tagid', type: 'integer' },
          { name: 'tagname' }
        ] },
        { name: 'media', type: 'object', properties: [
          { name: 'audios', type: 'array', of: 'object', properties: [
            { name: '__name', label: 'Name' }
          ] },
          { name: 'polls', type: 'array', of: 'object', properties: [
            { name: '__name', label: 'Name' }
          ] },
          { name: 'slides', type: 'array', of: 'object', properties: [
            { name: '__name', label: 'Name' }
          ] },
          { name: 'urls', label: 'URLs', type: 'array', of: 'object',
            properties: [
              { name: '__name', label: 'Name' }
            ] },
          { name: 'videoclips', type: 'array', of: 'object', properties: [
            { name: '__name', label: 'Name' }
          ] },
          { name: 'videos', type: 'array', of: 'object', properties: [
            { name: '__name', label: 'Name' }
          ] }
        ] },
        { name: 'eventanalytics', type: 'object', properties: [
          { name: 'totalregistrants', type: 'integer' },
          { name: 'totalattendees', type: 'integer' },
          { name: 'liveattendees', type: 'integer' },
          { name: 'ondemandattendees', type: 'integer' },
          { name: 'numberofquestionsasked', type: 'integer' },
          { name: 'numberofquestionsanswered', type: 'integer' },
          { name: 'numberofpollspushed', type: 'integer' },
          { name: 'numberofpollresponses', type: 'integer' },
          { name: 'numberofsurveyspresented', type: 'integer' },
          { name: 'numberofsurveyresponses', type: 'integer' },
          { name: 'noshowcount', type: 'integer' },
          { name: 'registrationpagehits', type: 'integer' },
          { name: 'sharethiswidgetuniqueviews', type: 'integer' },
          { name: 'sharethiswidgettotalviews', type: 'integer' },
          { name: 'twitterwidgetuniqueviews', type: 'integer' },
          { name: 'twitterwidgettotalviews', type: 'integer' },
          { name: 'numberofctaclicks', type: 'integer' },
          { name: 'numberofmeetingconversions', type: 'integer' },
          { name: 'numberofdemoconversions', type: 'integer' },
          { name: 'numberoffreetrialrequests', type: 'integer' },
          { name: 'numberofgroupchatmessagessubmitted', type: 'integer' },
          { name: 'numberofresourcesavailable', type: 'integer' },
          { name: 'attendeeswhodownloadedresource', type: 'integer' },
          { name: 'uniqueattendeeresourcedownloads', type: 'integer' },
          { name: 'eventengagementscore', type: 'number' },
          { name: 'averageliveminutes', type: 'integer' },
          { name: 'averagecumulativeliveminutes', type: 'integer' },
          { name: 'averagecumulativearchiveminutes', type: 'integer' },
          { name: 'averagearchiveminutes', type: 'integer' }
        ] }
      ]
    end,
    registrant_schema: lambda do |_input|
      [
        { name: 'firstname', label: 'First_name' },
        { name: 'lastname', label: 'Last_name' },
        { name: 'email', control_type: 'email' },
        { name: 'company' },
        { name: 'jobtitle' },
        { name: 'addressstreet1' },
        { name: 'addressstreet2' },
        { name: 'city' },
        { name: 'state' },
        { name: 'zip', hint: 'Postal Code' },
        { name: 'country' },
        { name: 'homephone' },
        { name: 'workphone' },
        { name: 'fax' },
        { name: 'username' },
        { name: 'exteventusercd',
          hint: 'External code used to identify the user' },
        { name: 'other' },
        { name: 'notes' },
        { name: 'jobfunction' },
        { name: 'companyindustry' },
        { name: 'companysize' },
        { name: 'partnerref' },
        { name: 'clientid', type: 'integer' },
        { name: 'eventid', type: 'integer' },
        { name: 'eventuserid', type: 'integer' },
        { name: 'std1', hint: 'Custom Field #1' },
        { name: 'std2', hint: 'Custom Field #2' },
        { name: 'std3', hint: 'Custom Field #3' },
        { name: 'std4', hint: 'Custom Field #4' },
        { name: 'std5', hint: 'Custom Field #5' },
        { name: 'std6', hint: 'Custom Field #6' },
        { name: 'std7', hint: 'Custom Field #7' },
        { name: 'std8', hint: 'Custom Field #8' },
        { name: 'std9', hint: 'Custom Field #9' },
        { name: 'std10', hint: 'Custom Field #10' },
        { name: 'marketingemail' },
        { name: 'eventemail' },
        { name: 'userprofileurl', label: 'User_profile_URL' },
        { name: 'createtimestamp', type: 'date_time' },
        { name: 'lastactivity' },
        { name: 'engagementprediction' },
        { name: 'ipaddress' },
        { name: 'os' },
        { name: 'browser' },
        { name: 'emailformat' },
        { name: 'campaigncode' },
        { name: 'sourcecampaigncode' },
        { name: 'sourceeventid', type: 'integer' },
        { name: 'userstatus' }
      ]
    end,
    attendee_schema: lambda do |_input|
      [
        { name: 'email', control_type: 'email' },
        { name: 'clientid', type: 'integer' },
        { name: 'eventid', type: 'integer' },
        { name: 'eventuserid', type: 'integer' },
        { name: 'exteventusercd' },
        { name: 'userstatus' },
        { name: 'attendeesessions', type: 'integer' },
        { name: 'isblocked' },
        { name: 'engagementscore', type: 'number' },
        { name: 'liveminutes', type: 'integer' },
        { name: 'firstliveactivity', type: 'date_time' },
        { name: 'lastliveactivity', type: 'date_time' },
        { name: 'archiveminutes', type: 'integer' },
        { name: 'firstarchiveactivity', type: 'date_time' },
        { name: 'lastarchiveactivity', type: 'date_time' },
        { name: 'askedquestions', type: 'integer' },
        { name: 'resourcesdownloaded', type: 'integer' },
        { name: 'answeredpolls', type: 'integer' },
        { name: 'answeredsurveys', type: 'integer' },
        { name: 'questions', type: 'array', of: 'object', properties:
          [{ name: 'questionid', type: 'integer' },
           { name: 'createtimestamp', type: 'date_time' },
           { name: 'content' },
           { name: 'answer', type: 'object', properties:
              [{ name: 'createtimestamp', type: 'date_time' },
               { name: 'content' },
               { name: 'presenterid', type: 'integer' },
               { name: 'presentername' },
               { name: 'privacy' }] }] },
        { name: 'polls', type: 'array', of: 'object', properties:
          [{ name: 'pollid', type: 'integer' },
           { name: 'pollsubmittedtimestamp', type: 'date_time' },
           { name: 'pollquestionid', type: 'integer' },
           { name: 'pollquestion' },
           { name: 'pollanswers', type: 'array', of: 'object', properties:
              [{ name: '__name', label: 'Name' }] },
           { name: 'pollanswersdetail', type: 'array', of: 'object', properties:
              [{ name: 'answercode' },
               { name: 'answer' }] }] },
        { name: 'resources', type: 'array', of: 'object', properties:
          [{ name: 'resourceid', type: 'integer' },
           { name: 'resourceviewed' },
           { name: 'resourceviewedtimestamp', type: 'date_time' }] },
        { name: 'surveys', type: 'array', of: 'object', properties:
          [{ name: 'surveyid' },
           { name: 'surveysubmittedtimestamp', type: 'date_time' },
           { name: 'surveyquestions', type: 'array', of: 'object', properties:
              [{ name: 'surveyquestionid', type: 'integer' },
               { name: 'surveyquestion' },
               { name: 'surveyanswers', type: 'array', of: 'object', properties:
                  [{ name: '__name', label: 'Name' }] },
               { name: 'surveyanswersdetail', type: 'array', of: 'object',
                 properties:
                  [{ name: 'answercode' },
                   { name: 'answer' }] }] }] },
        { name: 'twitterwidget', type: 'array', of: 'object', properties:
          [{ name: 'date', type: 'date_time' },
           { name: 'tweetdescription' }] },
        { name: 'calltoactions', type: 'array', of: 'object', properties:
          [{ name: 'ctaid' },
           { name: 'ctaname' },
           { name: 'clicks' },
           { name: 'date' }] },
        { name: 'testwidgets', type: 'array', of: 'object', properties:
          [{ name: 'testwidgetresult' },
           { name: 'retries', type: 'integer' },
           { name: 'correctanswersneeded', type: 'integer' },
           { name: 'correctanswersprovided', type: 'integer' }] },
        { name: 'testwidgetresult' },
        { name: 'certificationwidgetresult' },
        { name: 'certificationcredit' },
        { name: 'certificationtimestamp', type: 'date_time' },
        { name: 'userprofileurl', label: 'User_profile_URL' },
        { name: 'campaigncode' },
        { name: 'sourcecampaigncode' },
        { name: 'cumulativeliveminutes', type: 'integer' },
        { name: 'cumulativearchiveminutes', type: 'integer' },
        { name: 'partnerref' },
        { name: 'attendancepartnerref' },
        { name: 'certifications', type: 'array', of: 'object', properties:
          [{ name: 'certificationid', type: 'integer' },
           { name: 'certificationresult' },
           { name: 'certificationname' },
           { name: 'certificationcredit' },
           { name: 'certificationtimestamp', type: 'date_time' },
           { name: 'certificationurl', label: 'Certification_URL' }] },
        { name: 'meetingconversions', type: 'array', of: 'object', properties:
          [{ name: 'widgetid' },
           { name: 'widgetname' },
           { name: 'widgettype' },
           { name: 'widgetaction' },
           { name: 'widgetsubmittedtimestamp', type: 'date_time' }] },
        { name: 'democonversions', type: 'array', of: 'object', properties:
          [{ name: 'widgetid' },
           { name: 'widgetname' },
           { name: 'widgettype' },
           { name: 'widgetaction' },
           { name: 'widgetsubmittedtimestamp', type: 'date_time' }] },
        { name: 'freetrial', type: 'array', of: 'object', properties:
          [{ name: 'widgetid' },
           { name: 'widgetname' },
           { name: 'widgettype' },
           { name: 'widgetaction' },
           { name: 'widgetsubmittedtimestamp', type: 'date_time' }] }
      ]
    end,
    lead_schema: lambda do |_input|
      [
        { name: 'email' },
        { name: 'businessinterests', type: 'array', of: 'object', properties:
          [{ name: '__name', label: 'Name' }] },
        { name: 'engagementlevel' },
        { name: 'userprofileurl' }
      ]
    end,
    create_event_input: lambda do |_input|
      call('event_management_schema', '').
        required('title', 'liveStart', 'liveDuration').
        ignored('eventType', 'languageCd', 'timeZone', 'customAccountTag').
        concat([{ name: 'eventType', control_type: 'select',
                  pick_list: :Event_types,
                  type: 'string',
                  optional: false,
                  toggle_hint: 'Select from list',
                  toggle_field: {
                    name: 'eventType',
                    label: 'Event_type',
                    optional: false,
                    type: 'string',
                    control_type: 'text',
                    toggle_hint: 'Use custom value',
                    hint: 'Allowed values, E.g. fav, simulive, ondemand'
                  } },
                { name: 'languageCd', control_type: 'select',
                  pick_list: :languages,
                  type: 'string',
                  optional: false,
                  toggle_hint: 'Select from list',
                  toggle_field:
                  {
                    name: 'languageCd',
                    label: 'Language_code',
                    optional: false,
                    type: 'string',
                    control_type: 'text',
                    toggle_hint: 'Use custom value',
                    hint: 'Allowed values, E.g. bg, zh, cs'
                  } },
                { name: 'timeZone', control_type: 'select',
                  pick_list: :Time_zones,
                  toggle_hint: 'Select from list',
                  optional: false,
                  type: 'string',
                  toggle_field: {
                    name: 'timeZone',
                    label: 'Time_zone',
                    optional: false,
                    type: 'string',
                    control_type: 'text',
                    toggle_hint: 'Use custom value',
                    hint: 'Allowed values, E.g. Etc/GMT+12, Pacific/Midway'
                  } },
                {
                  name: 'customAccountTag', sticky: true, type: 'integer',
                  hint: 'An account with enabled custom account tags, it' \
                       ' is required to provide at least 1 tag id via the' \
                       ' customAccountTag parameter.'
                }])
    end,
    create_event_output: lambda do |_input|
      call('event_management_schema', '')
    end,
    create_registrant_input: lambda do |_input|
      call('registrant_schema', '').
        concat([{ name: 'eventId', optional: false, type: 'integer' }]).
        ignored('eventid', 'eventuserid', 'userprofileurl', 'createtimestamp',
                'lastactivity', 'browser', 'ipaddress', 'os', 'userstatus',
                'campaigncode', 'sourcecampaigncode', 'engagementprediction')
    end,
    create_registrant_output: lambda do |_input|
      call('registrant_schema', '').
        ignored('createtimestamp', 'lastactivity', 'browser', 'ipaddress',
                'os', 'userstatus', 'campaigncode', 'sourcecampaigncode',
                'engagementprediction')
    end,
    update_event_input: lambda do |_input|
      call('event_management_schema', '').
        required('eventId').
        ignored('eventAbstract')
    end,
    update_event_output: lambda do |_input|
      call('event_management_schema', '')
    end,
    update_registrant_input: lambda do |_input|
      call('registrant_schema', '').
        required('email').
        ignored('eventid', 'eventuserid', 'userprofileurl', 'createtimestamp',
                'lastactivity', 'browser', 'ipaddress', 'os', 'userstatus',
                'campaigncode', 'sourcecampaigncode', 'engagementprediction')
    end,
    update_registrant_output: lambda do |_input|
      [{ name: 'updatedregistrants', type: 'array', of: 'object', properties:
        [{ name: '__name', label: 'Name' }] }]
    end,
    copy_event_input: lambda do |_input|
      call('event_management_schema', '').
        required('liveStart', 'liveDuration').
        ignored('eventAbstract').
        concat([{ name: 'eventid', optional: false, type: 'integer' }])
    end,
    copy_event_output: lambda do |_input|
      call('event_management_schema', '')
    end,
    search_records_input: lambda do |_input|
      [
        { name: 'startDate', type: 'date', hint: 'If startDate is' \
          ' not sent, response will return all events from the past 3 months.' \
          ' The startDate will filter the list of events based on' \
          ' dateFilterMode parameter value.' },
        { name: 'endDate', type: 'date', hint: 'If endDate is not sent,' \
          ' response will return all events from the past 3 months. The' \
          ' endDate will filter the list of events based on dateFilterMode' \
          ' parameter value.' },
        { name: 'dateInterval', type: 'integer', hint: 'Number of days' \
          ' returned in a response.' },
        { name: 'dateIntervalOffset', type: 'integer', hint: 'Number of' \
          ' days from which the interval should encompass.' },
        { name: 'dateIntervalTimezone', hint: 'Timezone to be used for' \
          ' determining the 24 hour period that constitutes a day.' },
        { name: 'includeSubaccounts', control_type: 'select',
          pick_list: :boolean_list,
          type: 'string',
          hint: "If 'Yes' then sub-accounts will be included in the response",
          toggle_hint: 'Select from list',
          toggle_field: {
            name: 'includeSubaccounts',
            label: 'IncludeSubaccounts',
            optional: true,
            type: 'string',
            control_type: 'text',
            toggle_hint: 'Use custom value',
            hint: 'Allowed values are Y,N'
          } },
        { name: 'subaccounts', hint: 'Comma separated list of child' \
          ' client ids' },
        { name: 'dateFilterMode', control_type: 'select',
          pick_list: :Date_filter_mode_list,
          type: 'string',
          hint: 'Type of filter to be used with the date value.',
          toggle_hint: 'Select from list',
          toggle_field: {
            name: 'dateFilterMode',
            label: 'Date_filter_mode',
            optional: true,
            type: 'string',
            control_type: 'text',
            toggle_hint: 'Use custom value',
            hint: 'Only allowed value is "lastActivity"'
          } },
        { name: 'filterOrder', control_type: 'select',
          pick_list: :Filter_order_list,
          type: 'string',
          toggle_hint: 'Select from list',
          toggle_field: {
            name: 'filterOrder',
            label: 'Filter_order',
            optional: true,
            type: 'string',
            control_type: 'text',
            toggle_hint: 'Use custom value',
            hint: 'Allowed values are asc, desc'
          } },
        { name: 'includeInactive', control_type: 'select',
          pick_list: :boolean_list,
          type: 'string',
          hint: "If 'Yes' then inactive events will be included in the" \
          ' response.',
          toggle_hint: 'Select from list',
          toggle_field: {
            name: 'includeInactive',
            label: 'Include_inactive',
            optional: true,
            type: 'string',
            control_type: 'text',
            toggle_hint: 'Use custom value',
            hint: 'Allowed values are Y, N'
          } },
        { name: 'contentType', control_type: 'select',
          pick_list: :Content_type_list,
          type: 'string',
          hint: 'Filter events by contentType',
          toggle_hint: 'Select from list',
          toggle_field: {
            name: 'contentType',
            label: 'Content_type',
            optional: true,
            type: 'string',
            control_type: 'text',
            toggle_hint: 'Use custom value',
            hint: 'Allowed values, E.g. experience, gateway, pdf'
          } },
        { name: 'itemsPerPage', type: 'integer', hint: 'Number of items to be' \
          ' retrieved per page. If "includesubaccounts = Y", then only' \
          ' itemsPerPage will available.' },
        { name: 'pageOffset', type: 'integer', hint: 'Number of' \
          ' page to retrieve. If "includesubaccounts = Y",' \
          ' then only itemsPerPage will available.' },
        { name: 'excludeSubaccounts', control_type: 'select',
          pick_list: :boolean_list,
          type: 'string',
          hint: "If 'Yes' then sub-accounts will be excluded in the response",
          toggle_hint: 'Select from list',
          toggle_field: {
            name: 'excludeSubaccounts',
            label: 'ExcludeSubaccounts',
            optional: true,
            type: 'string',
            control_type: 'text',
            toggle_hint: 'Use custom value',
            hint: 'Allowed values are Y,N'
          } },
        { name: 'partnerref', hint: 'Filter by partnerref	E.g. EM' },
        { name: 'excludeLive', control_type: 'select',
          pick_list: :boolean_list,
          type: 'string',
          hint: 'Filter to exclude registrants which register after event ends',
          toggle_hint: 'Select from list',
          toggle_field: {
            name: 'excludeLive',
            label: 'Exclude_live',
            optional: true,
            type: 'string',
            control_type: 'text',
            toggle_hint: 'Use custom value',
            hint: 'Allowed values are Y,N'
          } },
        { name: 'userStatus', control_type: 'select',
          pick_list: :user_status_list,
          type: 'string',
          hint: 'Filter to users based on their status.',
          toggle_hint: 'Select from list',
          toggle_field: {
            name: 'userStatus',
            label: 'User_status',
            optional: true,
            type: 'string',
            control_type: 'text',
            toggle_hint: 'Use custom value',
            hint: 'Allowed values are all, any, deleted, forgotten'
          } },
        { name: 'filterforgotten', control_type: 'select',
          pick_list: :boolean_list,
          type: 'string',
          hint: 'Forgotten registrants filter.',
          toggle_hint: 'Select from list',
          toggle_field: {
            name: 'filterforgotten',
            label: 'Filter_forgotten',
            optional: true,
            type: 'string',
            control_type: 'text',
            toggle_hint: 'Use custom value',
            hint: 'Allowed values are Y,N'
          } },
        { name: 'excludeAnonymous', control_type: 'select',
          pick_list: :boolean_list,
          type: 'string',
          hint: 'Filter to exclude System-Generated Email Addresses.',
          toggle_hint: 'Select from list',
          toggle_field: {
            name: 'excludeAnonymous',
            label: 'Exclude_anonymous',
            optional: true,
            type: 'string',
            control_type: 'text',
            toggle_hint: 'Use custom value',
            hint: 'Allowed values are Y,N'
          } }
      ]
    end,
    search_event_input: lambda do |_input|
      call('search_records_input', '').
        ignored('dateFilterMode', 'excludeSubaccounts', 'partnerref',
                'excludeLive', 'userStatus', 'filterforgotten',
                'excludeAnonymous').
        concat([{ name: 'dateFilterMode', control_type: 'select',
                  pick_list: :Event_date_filter_mode_list,
                  default: 'creation',
                  type: 'string',
                  hint: 'Type of filter to be used with the date value.',
                  toggle_hint: 'Select from list',
                  toggle_field: {
                    name: 'dateFilterMode',
                    label: 'Date_filter_mode',
                    optional: true,
                    type: 'string',
                    control_type: 'text',
                    toggle_hint: 'Use custom value',
                    hint: 'Allowed values, E.g. goodafter, updated, creation'
                  } }])
    end,
    search_registrant_input: lambda do |_input|
      call('search_records_input', '').
        ignored('filterOrder', 'includeInactive', 'contentType')
    end,
    search_attendee_input: lambda do |_input|
      call('search_records_input', '').
        ignored('dateIntervalTimezone', 'includeSubaccounts', 'filterOrder',
                'includeInactive', 'contenttype', 'itemsPerPage')
    end,
    search_event_registrant_input: lambda do |_input|
      call('search_records_input', '').
        ignored('includeSubaccounts', 'subaccounts', 'filterOrder',
                'includeInactive', 'contentType', 'itemsPerPage', 'pageOffset',
                'excludeLive').
        concat([{ name: 'email', hint: 'Email registrant filter',
                  control_type: 'email' },
                { name: 'noshow',
                  hint: 'Registrants who did not show up for the event' },
                { name: 'eventId', optional: false }])
    end,
    search_event_attendee_input: lambda do |_input|
      call('search_records_input', '').
        ignored('includeSubaccounts', 'subaccounts', 'filterOrder',
                'includeInactive', 'contentType', 'itemsPerPage', 'pageOffset',
                'excludeLive', 'excludeSubaccounts').
        concat([{ name: 'eventId', optional: false }])
    end,
    search_lead_input: lambda do |_input|
      call('search_records_input', '').
        only('startDate', 'endDate', 'dateInterval', 'dateIntervalOffset',
             'dateIntervalTimezone', 'pageOffset', 'itemsPerPage')
    end,
    search_event_output: lambda do |_input|
      [{ name: 'events', type: 'array', of: 'object', properties:
        call('event_level_schema', '').
          ignored('encoders', 'eventduration', 'eventlocation', 'eventname',
                  'goodtill', 'industry', 'keyword', 'qandaemail',
                  'servicetype', 'sponsor', 'eventanalytics') }]
    end,
    search_registrant_output: lambda do |_input|
      [{ name: 'registrants', type: 'array', of: 'object', properties:
        call('registrant_schema', '') }]
    end,
    search_attendee_output: lambda do |_input|
      [{ name: 'attendees', type: 'array', of: 'object', properties:
        call('attendee_schema', '').
          ignored('attendeesessions') }]
    end,
    search_event_registrant_output: lambda do |_input|
      [{ name: 'registrants', type: 'array', of: 'object', properties:
        call('registrant_schema', '').
          ignored('clientid', 'sourceeventid') }]
    end,
    search_event_attendee_output: lambda do |_input|
      { name: 'attendees', type: 'array', of: 'object', properties:
        call('attendee_schema', '').
          ignored('clientid') }
    end,
    search_lead_output: lambda do |_input|
      { name: 'leads', type: 'array', of: 'object', properties:
        call('lead_schema', '') }
    end,
    get_event_input: lambda do |_input|
      [{ name: 'eventId', type: 'integer', optional: false,
         hint: 'Id of the particular event' }]
    end,
    get_registrant_input: lambda do |_input|
      [{ name: 'email', optional: false, control_type: 'email',
         hint: 'Unique email id used in the registration' },
       { name: 'partnerref', hint: 'Filter by partnerref. E.g. EM' }]
    end,
    get_attendee_input: lambda do |_input|
      [{ name: 'email', optional: false, control_type: 'email',
         hint: 'Unique email id used in the registration' }]
    end,
    get_event_output: lambda do |_input|
      call('event_level_schema', '').
        ignored('media')
    end,
    get_registrant_output: lambda do |_input|
      call('registrant_schema', '').
        ignored('createtimestamp', 'emailformat', 'engagementprediction',
                'lastactivity')
    end,
    get_attendee_output: lambda do |_input|
      call('attendee_schema', '').
        ignored('attendeesessions')
    end,
    event_trigger_output: lambda do |_input|
      call('event_level_schema', '').
        ignored('customaccounttags', 'encoders', 'eventanalytics',
                'eventduration', 'eventlocation', 'eventname', 'eventstd1',
                'eventstd2', 'eventstd3', 'eventstd4', 'eventstd5',
                'extaudienceurl', 'funnelstages', 'goodtill', 'industry',
                'keyword', 'localecountrycd', 'partnerrefstats',
                'promotionalsummary', 'qandaemail', 'servicetype', 'sponsor',
                'surveyurls', 'tags', 'media')
    end,
    registrant_trigger_output: lambda do |_input|
      call('registrant_schema', '').
        only('firstname', 'lastname', 'email', 'company', 'eventid',
             'eventuserid', 'marketingemail', 'eventemail', 'createtimestamp',
             'lastactivity', 'ipaddress', 'browser', 'emailformat',
             'engagementprediction', 'sourceeventid', 'userstatus')
    end,
    lead_trigger_output: lambda do |_input|
      call('lead_schema', '')
    end,
    search_event_url: lambda do |_input|
      url = 'event'
      url
    end,
    search_registrant_url: lambda do |_input|
      url = 'registrant'
      url
    end,
    search_attendee_url: lambda do |_input|
      url = 'attendee'
      url
    end,
    search_event_registrant_url: lambda do |input|
      url = "event/#{input['eventId']}/registrant"
      url
    end,
    search_event_attendee_url: lambda do |input|
      url = "event/#{input['eventId']}/attendee"
      url
    end,
    search_lead_url: lambda do |_input|
      url = 'lead'
      url
    end,
    get_event_url: lambda do |input|
      get("event/#{input['eventId']}")&.
        after_error_response(/.*/) do |code, _body, _header, message|
          error(" #{code}: #{message}")
        end
    end,
    get_registrant_url: lambda do |input|
      response = get("registrant/#{input['email']}")&.
        after_error_response(/.*/) do |code, _body, _header, message|
          error(" #{code}: #{message}")
        end
      response['registrant']
    end,
    get_attendee_url: lambda do |input|
      get("attendee/#{input['email']}")&.
        after_error_response(/.*/) do |code, _body, _header, message|
          error(" #{code}: #{message}")
        end
    end,
    create_event_url: lambda do |input|
      response = post('event').
                 payload(input).
                 request_format_www_form_urlencoded&.
        after_error_response(/.*/) do |code, _body, _header, message|
          error("#{code}: #{message}")
        end
      response['wccevent']
    end,
    create_registrant_url: lambda do |input|
      post("event/#{input['eventId']}/registrant").
        payload(input).
        request_format_www_form_urlencoded&.
        after_error_response(/.*/) do |code, _body, _header, message|
          error("#{code}: #{message}")
        end
    end,
    update_event_url: lambda do |input|
      response = put("event/#{input['eventId']}").payload(input).
                 request_format_www_form_urlencoded&.
        after_error_response(/.*/) do |code, _body, _header, message|
          error("#{code}: #{message}")
        end
      response['wccevent']
    end,
    update_registrant_url: lambda do |input|
      patch("registrant/#{input['email']}").payload(input).
        request_format_www_form_urlencoded&.
        after_error_response(/.*/) do |code, _body, _header, message|
          error("#{code}: #{message}")
        end
    end,
    event_trigger_url: lambda do |_input|
      get('event?dateFilterMode=creation')
    end,
    registrant_trigger_url: lambda do |_input|
      get('registrant')
    end,
    lead_trigger_url: lambda do |_input|
      get('lead')
    end,
    event_update_trigger_url: lambda do |_input|
      get('event?dateFilterMode=modified')
    end,
    registrant_update_trigger_url: lambda do |_input|
      get('registrant?dateFilterMode=lastActivity')
    end,
    event_get_sample_output: lambda do |_input|
      get('event?dateFilterMode=creation')['events']&.first
    end,
    registrant_get_sample_output: lambda do |_input|
      get('registrant')['registrants']&.first
    end,
    attendee_get_sample_output: lambda do |_input|
      get('attendee')['attendees']&.first
    end,
    create_event_sample_output: lambda do |_input|
      call('event_management_sample_output', '')
    end,
    create_registrant_sample_output: lambda do |_input|
      get('registrant')['registrants']&.first
    end,
    update_event_sample_output: lambda do |_input|
      call('event_management_sample_output', '')
    end,
    update_registrant_sample_output: lambda do |_input|
      { 'updatedregistrants': [
        { '__name': '399133565' }
      ] }
    end,
    event_trigger_sample_output: lambda do |_input|
      get('event?dateFilterMode=creation')['events']&.first
    end,
    registrant_trigger_sample_output: lambda do |_input|
      get('registrant')['registrants']&.first
    end,
    lead_trigger_sample_output: lambda do |_input|
      get('lead')['leads']&.first
    end,
    event_management_sample_output: lambda do |_input|
      {
        'eventId': '1418636',
        'title': 'Event created from API',
        'eventAbstract': 'Event Abstract Sample',
        'promotionalSummary': 'Event Promotional Summary Sample',
        'liveStart': '12/20/2017 08:45 AM',
        'liveDuration': 3600,
        'liveEnd': '12/20/2017 10:00 AM',
        'archiveStart': '12/20/2017 10:30 AM',
        'archiveEnd': '12/20/2018 10:30 AM',
        'clientId': 4467,
        'timeZone': 'America/Los_Angeles',
        'eventType': 'webcam',
        'goodAfter': '12/20/2017 09:00 AM',
        'audienceUrl': 'https://event.on24.com/wcc/r/1418636/' \
         '15545789BB2677BD0FB3F6FAA3F8B557',
        'reportsUrl': 'https://api.on24.com/webcast/report?e=1418636&' \
         'k=93263D3E106F0243316315BE767D8550',
        'previewUrl': 'http://api.on24.com/webcast/previewlobby?e=1418636&' \
         'k=93263D3E106F0243316315BE767D8550',
        'archiveDuration': '525600',
        'shortTimeZone': 'PST',
        'isLiveStartPast': false,
        'isLiveEndPast': false,
        'archiveEndInPast': false,
        'monthsAvailableToExtend': -1,
        'canExtendArchive': false,
        'archiveAvailable': true,
        'autoArchiveProcessed': false,
        'canManipulateArchive': false,
        'canToggleArchiveAvailability': true,
        'showFaaBridgeNumber': true,
        'showColossusLink': true,
        'languageCd': 'en',
        'countryCd': 'UK',
        'sourceEventId': 0,
        'rolloverAudio': false,
        'rolloverAudioDisabled': false,
        'tags': [
          'tag1'
        ],
        'customaccounttags': [
          {
            'groupid': 101,
            'groupname': 'Group 1',
            'tagid': 741,
            'tagname': 'Option 1-A'
          }
        ],
        'defaultPlayerConsoleTemplateId': 0,
        'simuliveWaitingMode': false,
        'PMUrl': 'https://api.on24.com/webcast/present?e=1418636&' \
         'k=93263D3E106F0243316315BE767D8550',
        'simuliveEPMode': true,
        'simuliveMode': false
      }
    end,
    format_response_data: lambda do |input|
      if input.is_a?(Array)
        input.map do |array_value|
          if !array_value.is_a?(Array) && !array_value.is_a?(Hash)
            { __name: array_value }
          else
            call('format_response_data', array_value)
          end
        end
      elsif input.is_a?(Hash)
        input.each_with_object({}) do |(key, value), hash|
          hash[key] = call('format_response_data', value)
        end
      else
        input
      end
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
    search_input: {
      fields: lambda do |_connection, config_fields|
        call("search_#{config_fields['object']}_input", '')
      end
    },
    search_output: {
      fields: lambda do |_connection, config_fields|
        call("search_#{config_fields['object']}_output", '')
      end
    },
    get_input: {
      fields: lambda do |_connection, config_fields|
        call("get_#{config_fields['object']}_input", '')
      end
    },
    get_output: {
      fields: lambda do |_connection, config_fields|
        call("get_#{config_fields['object']}_output", '')
      end
    },
    create_input: {
      fields: lambda do |_connection, config_fields|
        call("create_#{config_fields['object']}_input", '')
      end
    },
    create_output: {
      fields: lambda do |_connection, config_fields|
        call("create_#{config_fields['object']}_output", '')
      end
    },
    update_input: {
      fields: lambda do |_connection, config_fields|
        call("update_#{config_fields['object']}_input", '')
      end
    },
    update_output: {
      fields: lambda do |_connection, config_fields|
        call("update_#{config_fields['object']}_output", '')
      end
    },
    copy_event_input: {
      fields: lambda do |_connection, _config_fields|
        call('copy_event_input', '')
      end
    },
    copy_event_output: {
      fields: lambda do |_connection, _config_fields|
        call('copy_event_output', '')
      end
    },
    trigger_input: {
      fields: lambda do |_connection, _config_fields|
        { name: 'since', type: 'date_time', hint: 'When you start recipe for' \
        ' the first time, it picks up trigger events from this specified date' \
        ' and time. Leave empty to get records created or updated one hour ago',
          sticky: true,
          render_input: lambda do |field|
            field&.(:to_s)
          end,
          parse_output: lambda do |field|
            field&.(:to_s)
          end }
      end
    },
    trigger_output: {
      fields: lambda do |_connection, config_fields|
        call("#{config_fields['object']}_trigger_output", '')
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
            "#{connection['environment']}/v1/" \
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
    search_objects:
    {
      title: 'Search objects',
      subtitle: 'Search objects in ON24',
      description: lambda do |_connection, search_object_list|
        "Search <span class='provider'>" \
        "#{search_object_list[:object]&.pluralize || 'records'}</span> " \
        'in <span class="provider">ON24</span>'
      end,
      config_fields: [
        {
          name: 'object',
          optional: false,
          control_type: 'select',
          pick_list: :search_records_object_list,
          hint: 'Select any On24 Record object, e.g. Registrant'
        }
      ],
      input_fields: lambda do |object_definitions|
        object_definitions['search_input']
      end,
      execute: lambda do |_connection, input|
        response = get(call("search_#{input['object']}_url", input), input)&.
        after_error_response(/.*/) do |code, _body, _header, message|
          error("#{code}: #{message}")
        end
        call('format_response_data', response.presence)
      end,
      output_fields: lambda do |object_definitions|
        object_definitions['search_output']
      end,
      sample_output: lambda do |_connection, input|
        get("#{input['object']}?includeSubaccounts=Y&itemsPerPage=1")
      end
    },
    get_object:
    {
      title: 'Get object',
      subtitle: 'Get object in ON24',
      description: lambda do |_connection, get_object_list|
        "Get <span class='provider'>" \
        "#{get_object_list[:object] || 'records'}</span> " \
        'in <span class="provider">ON24</span> '
      end,
      config_fields: [
        {
          name: 'object',
          optional: false,
          control_type: 'select',
          pick_list: :get_records_object_list,
          hint: 'Select the object from list.'
        }
      ],
      input_fields: lambda do |object_definitions|
        object_definitions['get_input']
      end,
      execute: lambda do |_connection, input|
        response = call("get_#{input['object']}_url", input)
        call('format_response_data', response.presence)
      end,
      output_fields: lambda do |object_definitions|
        object_definitions['get_output']
      end,
      sample_output: lambda do |_connection, input|
        call("#{input['object']}_get_sample_output", '')
      end
    },
    create_object:
    {
      title: 'Create object',
      subtitle: 'Create object in ON24',
      description: lambda do |_connection, create_object_list|
        "Create <span class='provider'>" \
        "#{create_object_list[:object] || 'records'}</span> " \
        'in <span class="provider">ON24</span>'
      end,
      help: lambda do |_connection, _object_list|
        'If a field is configured as "required" on the registration page,' \
        ' you must pass in a valid value, or the request will not be' \
        ' successful. Note: Only for Registrant'
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
        object_definitions['create_input']
      end,
      execute: lambda do |_connection, input|
        response = call("create_#{input['object']}_url", input)
        call('format_response_data', response.presence)
      end,
      output_fields: lambda do |object_definitions|
        object_definitions['create_output']
      end,
      sample_output: lambda do |_connection, input|
        call("create_#{input['object']}_sample_output", '')
      end
    },
    update_object:
    {
      title: 'Update object',
      subtitle: 'Update object in ON24 by ID',
      description: lambda do |_connection, update_object_list|
        "Update <span class='provider'>" \
        "#{update_object_list[:object] || 'records'}</span> " \
        'in <span class="provider">ON24</span> by ID'
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
        object_definitions['update_input']
      end,
      execute: lambda do |_connection, input|
        response = call("update_#{input['object']}_url", input)
        call('format_response_data', response.presence)
      end,
      output_fields: lambda do |object_definitions|
        object_definitions['update_output']
      end,
      sample_output: lambda do |_connection, input|
        call("update_#{input['object']}_sample_output", '')
      end
    },
    copy_event:
    {
      title: 'Copy event',
      subtitle: 'Copy event in ON24 by ID',
      description: "Copy <span class='provider'>event</span> " \
        "in <span class='provider'>ON24</span> by ID",
      input_fields: lambda do |object_definitions|
        object_definitions['copy_event_input']
      end,
      execute: lambda do |_connection, input|
        response = post("event?eventsource=#{input['eventid']}").payload(input).
                   request_format_www_form_urlencoded&.
                   after_error_response(/.*/) do |code, _body, _header, message|
                     error("#{code}: #{message}")
                   end
        response['wccevent']
        call('format_response_data', response.presence)
      end,
      output_fields: lambda do |object_definitions|
        object_definitions['copy_event_output']
      end,
      sample_output: lambda do |_connection, _input|
        call('event_management_sample_output', '')
      end
    },
    custom_action: {
      subtitle: 'Build your own ON24 action with a HTTP request',
      description: lambda do |object_value, _object_label|
        "<span class='provider'>" \
        "#{object_value[:action_name] || 'Custom action'}</span> in " \
        "<span class='provider'>ON24</span>"
      end,
      help: {
        body: 'Build your own ON24 action with a HTTP request. ' \
        'The request will be authorized with your ON24 connection.',
        learn_more_url: 'https://apidoc.on24.com/home',
        learn_more_text: 'ON24 API documentation'
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
            error({ code: code, message: message, body: body,
                    headers: headers }.
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

  triggers:
  {
    new_record:
    {
      title: 'New record',
      subtitle: 'Triggers immediately when new record created',
      description: lambda do |_connection, create_object_list|
        "New <span class='provider'>" \
        "#{create_object_list[:object] || 'records'}</span> " \
        'in <span class="provider">ON24</span>'
      end,
      config_fields: [
        {
          name: 'object',
          optional: false,
          control_type: 'select',
          pick_list: :trigger_object_list,
          hint: 'Select the object from list.'
        }
      ],
      input_fields: lambda do |object_definitions|
        object_definitions['trigger_input']
      end,
      poll: lambda do |_connection, input, closure|
        closure ||= {}
        limit = 50
        page_off_set = closure['page_off_set'] || 0
        date_created = closure['date_created'] || input['since'] || 1.hour.ago
        response = call("#{input['object']}_trigger_url", '').
                   params(itemsPerPage: limit,
                          startDate: date_created,
                          filterOrder: 'asc',
                          includesubaccounts: 'Y',
                          pageOffset: page_off_set)
        records = response[input['object'].pluralize]
        closure = if (has_more = records&.size&. >= limit)
                    { 'page_off_set': page_off_set + 1 }
                  else
                    { 'date_created': records&.dig(-1, 'createtimestamp') ||
                      date_created, 'page_off_set': 0 }
                  end
        {
          events: records,
          next_poll: closure,
          can_poll_more: has_more
        }
      end,
      dedup: lambda do |event|
        "#{event['eventid']} @@ #{event['eventuserid']} @@ #{event['email']}"
      end,
      output_fields: lambda do |object_definitions|
        object_definitions['trigger_output']
      end,
      sample_output: lambda do |_connection, input|
        call("#{input['object']}_trigger_sample_output", '')
      end
    },
    new_or_update_record:
    {
      title: 'New or Update record',
      subtitle: 'Triggers immediately when new record created or updated',
      description: lambda do |_connection, create_object_list|
        "New/Update <span class='provider'>" \
        "#{create_object_list[:object] || 'records'}</span> " \
        'in <span class="provider">ON24</span>'
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
        object_definitions['trigger_input']
      end,
      poll: lambda do |_connection, input, closure|
        closure ||= {}
        limit = 100
        page_off_set = closure['page_off_set'] || 0
        date_updated = closure['date_updated'] || input['since'] || 1.hour.ago
        response = call("#{input['object']}_update_trigger_url", '').
                   params(itemsPerPage: limit,
                          startDate: date_updated,
                          filterOrder: 'asc',
                          includesubaccounts: 'Y',
                          pageOffset: page_off_set)
        records = response[input['object'].pluralize]
        closure = if (has_more = records&.size&. >= limit)
                    { 'page_off_set': page_off_set + 1 }
                  else
                    { 'date_updated': records&.dig(-1, 'lastmodified') ||
                      records&.dig(-1, 'lastactivity') ||
                      date_updated, 'page_off_set': 0 }
                  end
        {
          events: records,
          next_poll: closure,
          can_poll_more: has_more
        }
      end,
      dedup: lambda do |event|
        "#{event['eventid']} @@ #{event['eventuserid']} @@
        #{event['lastmodified']} @@ #{event['lastactivity']}"
      end,
      output_fields: lambda do |object_definitions|
        object_definitions['trigger_output']
      end,
      sample_output: lambda do |_connection, input|
        call("#{input['object']}_trigger_sample_output", '')
      end
    }
  },

  pick_lists: {
    Event_types: lambda do |_connection|
      get('eventtypes')['eventtypes'].
        map { |folder| [folder['label'], folder['value']] }
    end,
    languages: lambda do |_connection|
      get('languages')['languagecodes'].
        map { |folder| [folder['label'], folder['languagecd']] }
    end,
    country: lambda do |_connection|
      [
        %w[English\ (UK) UK],
        %w[Chinese\ (Traditional) TW],
        %w[Chinese\ (Simplified) CN]
      ]
    end,
    Time_zones: lambda do |_connection|
      get('timezones')['timezones'].
        map { |folder| [folder['label'], folder['value']] }
    end,
    Content_type_list: lambda do |_connection|
      [
        %w[All all],
        %w[Experience experience],
        %w[Gateway gateway],
        %w[PDF pdf],
        %w[Video video],
        %w[Webcast webcast],
        %w[Webpage webpage]
      ]
    end,
    Event_date_filter_mode_list: lambda do |_connection|
      [
        %w[Good\ after goodafter],
        %w[Updated updated],
        %w[Modified modified],
        %w[Creation creation],
        %w[Livestart livestart],
        %w[Liveend liveend],
        %w[Archivestart archivestart],
        %w[Archiveend archiveend]
      ]
    end,
    boolean_list: lambda do |_connection|
      [
        %w[Yes Y],
        %w[No N]
      ]
    end,
    Filter_order_list: lambda do |_connection|
      [
        %w[Asc asc],
        %w[Desc desc]
      ]
    end,
    Date_filter_mode_list: lambda do |_connection|
      [
        %w[Last_activity lastActivity]
      ]
    end,
    user_status_list: lambda do |_connection|
      [
        %w[Any any],
        %w[Deleted deleted],
        %w[Forgotten forgotten],
        %w[All all]
      ]
    end,
    trigger_object_list: lambda do |_connection|
      [
        %w[Event event],
        %w[Registrant registrant],
        %w[Lead lead]
      ]
    end,
    object_list: lambda do |_connection|
      [
        %w[Event event],
        %w[Registrant registrant]
      ]
    end,
    search_records_object_list: lambda do |_connection|
      [
        %w[Event event],
        %w[Registrant registrant],
        %w[Attendee attendee],
        %w[Specific\ event\ registrant event_registrant],
        %w[Specific\ event\ attendee event_attendee],
        %w[Lead lead]
      ]
    end,
    get_records_object_list: lambda do |_connection|
      [
        %w[Event event],
        %w[Registrant registrant],
        %w[Attendee attendee]
      ]
    end
  }
}
