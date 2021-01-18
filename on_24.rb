{
  title: 'ON24',
  connection:
  {
    fields:
    [
      {
        name: 'clientId',
        label: 'Client ID',
        optional: false,
        hint: "Click <a href='https://wcc.on24.com/webcast/apitokensdashboard'"\
          " target='_blank'>here</a> to get client id."
      },
      {
        name: 'accessTokenKey',
        optional: false,
        hint: 'The client access token key.'
      },
      {
        name: 'accessTokenSecret',
        control_type: 'password',
        optional: false,
        hint: 'The client access token secret.'
      }
    ],
    authorization: {
      apply: lambda do |connection|
        headers('accessTokenKey': connection['accessTokenKey'],
                'accessTokenSecret': connection['accessTokenSecret'])
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
        { name: 'eventId', type: 'integer', label: 'Event Id' },
        { name: 'title',
          hint: "Event's name. Limited to less than 251 characters." },
        { name: 'eventAbstract', hint: "Event's description or summary.",
          label: 'Event abstract' },
        { name: 'promotionalSummary', label: 'Promotional summary' },
        { name: 'liveStart', type: 'date_time', hint: "Event's start date.",
          label: 'Live start',
          render_input: lambda do |field|
            field&.to_s
          end,
          parse_output: lambda do |field|
            field&.to_s
          end },
        { name: 'liveDuration', hint: 'LiveDuration value in 15 minute' \
            ' increments (e.g. 15, 30, 45, 60, etc.) up to 120 minutes. Above' \
            ' 120 minutes, increments will be 30 minutes up to 480 minutes.',
          label: 'Live duration' },
        { name: 'liveEnd', type: 'date_time', label: 'Live end',
          parse_output: lambda do |field|
            field&.to_s
          end },
        { name: 'archiveStart', type: 'date_time', label: 'Archive start',
          parse_output: lambda do |field|
            field&.to_s
          end },
        { name: 'archiveEnd', type: 'date_time', label: 'Archive end',
          parse_output: lambda do |field|
            field&.to_s
          end },
        { name: 'clientId', type: 'integer', label: 'Client Id' },
        { name: 'timeZone', control_type: 'select',
          pick_list: :time_zones,
          label: 'Time zone',
          toggle_hint: 'Select from list',
          type: 'string',
          toggle_field: {
            name: 'timeZone',
            label: 'Time zone',
            optional: true,
            type: 'string',
            control_type: 'text',
            toggle_hint: 'Use custom value',
            hint: 'Allowed values, <b>E.g. Etc/GMT+12, Pacific/Midway</b>'
          } },
        { name: 'eventType', control_type: 'select',
          pick_list: :event_types,
          type: 'string',
          label: 'Event type',
          toggle_hint: 'Select from list',
          toggle_field:
          {
            name: 'eventType',
            label: 'Event type',
            optional: true,
            type: 'string',
            control_type: 'text',
            toggle_hint: 'Use custom value',
            hint: 'Allowed values, <b>E.g. fav, simulive, ondemand</b>'
          } },
        { name: 'goodAfter', type: 'date_time', label: 'Good after',
          parse_output: lambda do |field|
            field&.to_s
          end },
        { name: 'dialInNumber', label: 'Dial in number' },
        { name: 'bridgeDialInNumber', label: 'Bridge dial-in number' },
        { name: 'dialInPasscode', label: 'Dial-in passcode' },
        { name: 'audienceUrl', label: 'Audience URL' },
        { name: 'reportsUrl', label: 'Reports URL' },
        { name: 'previewUrl', label: 'Preview URL' },
        { name: 'archiveDuration', type: 'integer', label: 'Archive duration' },
        { name: 'shortTimeZone', label: 'Short time zone' },
        { name: 'isLiveStartPast', type: 'boolean',
          label: 'Is live start past' },
        { name: 'isLiveEndPast', type: 'boolean', label: 'Is live end past' },
        { name: 'archiveEndInPast', type: 'boolean',
          label: 'Archive end in past' },
        { name: 'monthsAvailableToExtend', type: 'integer',
          label: 'Months available to extend' },
        { name: 'canExtendArchive', type: 'boolean',
          label: 'Can extend archive' },
        { name: 'archiveAvailable', control_type: 'select',
          pick_list: :boolean_list,
          type: 'string',
          label: 'Archive available',
          hint: 'Indicates if the Archive Option is Enabled or Disabled for' \
          ' this event.',
          toggle_hint: 'Select from list',
          toggle_field: {
            name: 'archiveAvailable',
            label: 'Archive available',
            optional: true,
            type: 'string',
            control_type: 'text',
            toggle_hint: 'Use custom value',
            hint: 'Allowed values are <b>Y,N</b>'
          } },
        { name: 'autoArchiveProcessed', type: 'boolean',
          label: 'Auto archive processed' },
        { name: 'canManipulateArchive', type: 'boolean',
          label: 'Can manipulate archive' },
        { name: 'canToggleArchiveAvailability', type: 'boolean',
          label: 'Can toggle archive availability' },
        { name: 'showFaaBridgeNumber', type: 'boolean',
          label: 'Show faa bridge number' },
        { name: 'showColossusLink', type: 'boolean',
          label: 'Show colossus link' },
        { name: 'languageCd', control_type: 'select',
          pick_list: :languages,
          type: 'string',
          label: 'Language code',
          toggle_hint: 'Select from list',
          toggle_field: {
            name: 'languageCd',
            label: 'Language code',
            optional: true,
            type: 'string',
            control_type: 'text',
            toggle_hint: 'Use custom value',
            hint: 'Allowed values, <b>E.g. bg, zh, cs</b>'
          } },
        { name: 'countrycd', control_type: 'select',
          pick_list: :country,
          type: 'string',
          label: 'Country code',
          toggle_hint: 'Select from list',
          toggle_field: {
            name: 'countrycd',
            label: 'Country code',
            optional: true,
            type: 'string',
            control_type: 'text',
            toggle_hint: 'Use custom value',
            hint: 'Allowed values are <b>CN, UK, TW</b>'
          } },
        { name: 'campaignCode', label: 'Campaign code' },
        { name: 'sourceEventId', type: 'integer', label: 'Source event Id' },
        { name: 'rolloverAudio', type: 'boolean', label: 'Roll over audio' },
        { name: 'rolloverAudioDisabled', type: 'boolean',
          label: 'Roll over audio disabled' },
        { name: 'tags', type: 'array', of: 'object', properties: [
          { name: '__name', label: 'Name' }
        ] },
        { name: 'customaccounttags', label: 'Custom account tags',
          type: 'array', of: 'object',
          properties: [
            { name: 'groupid', type: 'integer' },
            { name: 'groupname' },
            { name: 'tagid', type: 'integer' },
            { name: 'tagname' }
          ] },
        { name: 'defaultPlayerConsoleTemplateId', type: 'integer',
          label: 'Default player console template Id' },
        { name: 'simuliveWaitingMode', type: 'boolean',
          label: 'Simu live waiting mode' },
        { name: 'pmurl', label: 'Pm URL' },
        { name: 'simuliveEPMode', type: 'boolean', label: 'Simu live EP mode' },
        { name: 'simuliveMode', type: 'boolean', label: 'Simu live mode' }
      ]
    end,
    event_level_schema: lambda do |_input|
      [
        { name: 'eventid', type: 'integer', label: 'Event Id' },
        { name: 'eventname', label: 'Event name' },
        { name: 'clientid', type: 'integer', label: 'Client Id' },
        { name: 'eventduration', type: 'integer', label: 'Event duration' },
        { name: 'goodafter', type: 'date_time', label: 'Good after' },
        { name: 'isactive', type: 'boolean', label: 'Is active' },
        { name: 'goodtill', label: 'Good till' },
        { name: 'regrequired', type: 'boolean', label: 'Reg required' },
        { name: 'description' },
        { name: 'promotionalsummary', label: 'Promotional summary' },
        { name: 'regnotificationrequired', type: 'boolean',
          label: 'Reg notification required' },
        { name: 'displaytimezonecd', label: 'Display time zone code' },
        { name: 'qandaemail' },
        { name: 'eventlocation', label: 'Event location' },
        { name: 'eventtype', label: 'Event type' },
        { name: 'category' },
        { name: 'servicetype', label: 'Service type' },
        { name: 'sponsor' },
        { name: 'createtimestamp', type: 'date_time',
          label: 'Create timestamp' },
        { name: 'keyword' },
        { name: 'localelanguagecd', label: 'Locale language code' },
        { name: 'localecountrycd', label: 'Locale country code' },
        { name: 'lastmodified', type: 'date_time', label: 'Last modified' },
        { name: 'lastupdated', type: 'date_time', label: 'Last Updated' },
        { name: 'iseliteexpired', type: 'Is elite expired' },
        { name: 'application' },
        { name: 'industry' },
        { name: 'livestart', type: 'date_time', label: 'Live start' },
        { name: 'liveend', type: 'date_time', label: 'Live end' },
        { name: 'archivestart', type: 'date_time', label: 'Archive start' },
        { name: 'archiveend', type: 'date_time', label: 'Archive end' },
        { name: 'eventprofile', label: 'Event profile' },
        { name: 'streamtype', label: 'Stream type' },
        { name: 'audiencekey', label: 'Audience key' },
        { name: 'extaudienceurl', label: 'Ext audience URL' },
        { name: 'reporturl', label: 'Report URL' },
        { name: 'uploadurl', label: 'Upload URL' },
        { name: 'pmurl', label: 'Pm URL' },
        { name: 'previewurl', label: 'Preview URL' },
        { name: 'audienceurl', label: 'Audience URL' },
        { name: 'contenttype', label: 'Content type' },
        { name: 'partnerrefstats', label: 'Partner ref stats',
          type: 'array', of: 'object', properties: [
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
        { name: 'eventstd1', label: 'Event standard1' },
        { name: 'eventstd2', label: 'Event standard2' },
        { name: 'eventstd3', label: 'Event standard3' },
        { name: 'eventstd4', label: 'Event standard4' },
        { name: 'eventstd5', label: 'Event standard5' },
        { name: 'surveyurls', label: 'Survey_URLs', type: 'array', of: 'object',
          properties: [
            { name: '__name', label: 'Name' }
          ] },
        { name: 'customaccounttags', label: 'Custom account tags',
          type: 'array', of: 'object', properties: [
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
          { name: 'totalregistrants', type: 'integer',
            label: 'Total registrants' },
          { name: 'totalattendees', type: 'integer', label: 'Total attendees' },
          { name: 'liveattendees', type: 'integer', label: 'Live attendees' },
          { name: 'ondemandattendees', type: 'integer',
            label: 'On demand attendees' },
          { name: 'numberofquestionsasked', type: 'integer',
            label: 'Number of question asked' },
          { name: 'numberofquestionsanswered', type: 'integer',
            label: 'Number of question answered' },
          { name: 'numberofpollspushed', type: 'integer',
            label: 'Number of polls pushed' },
          { name: 'numberofpollresponses', type: 'integer',
            label: 'Number of poll responses' },
          { name: 'numberofsurveyspresented', type: 'integer',
            label: 'Number of surveys presented' },
          { name: 'numberofsurveyresponses', type: 'integer',
            label: 'Number of survey responses' },
          { name: 'noshowcount', type: 'integer', label: 'No show count' },
          { name: 'registrationpagehits', type: 'integer',
            label: 'Registration page hits' },
          { name: 'sharethiswidgetuniqueviews', type: 'integer',
            label: 'Share this widget unique views' },
          { name: 'sharethiswidgettotalviews', type: 'integer',
            label: 'Share this widget total views' },
          { name: 'twitterwidgetuniqueviews', type: 'integer',
            label: 'Twitter widget unique views' },
          { name: 'twitterwidgettotalviews', type: 'integer',
            label: 'Twitter widget total views' },
          { name: 'numberofctaclicks', type: 'integer',
            label: 'Number of cta clicks' },
          { name: 'numberofmeetingconversions', type: 'integer',
            label: 'Number of meeting conversions' },
          { name: 'numberofdemoconversions', type: 'integer',
            label: 'Number of demo conversions' },
          { name: 'numberoffreetrialrequests', type: 'integer',
            label: 'Number of free trial requests' },
          { name: 'numberofgroupchatmessagessubmitted', type: 'integer',
            label: 'Number of group chat messages submitted' },
          { name: 'numberofresourcesavailable', type: 'integer',
            label: 'Number of resources available' },
          { name: 'attendeeswhodownloadedresource', type: 'integer',
            label: 'Attendees who downloaded resource' },
          { name: 'uniqueattendeeresourcedownloads', type: 'integer',
            label: 'Unique attendee resource downloads' },
          { name: 'eventengagementscore', type: 'number',
            label: 'Event engagement score' },
          { name: 'averageliveminutes', type: 'integer',
            label: 'Average live minutes' },
          { name: 'averagecumulativeliveminutes', type: 'integer',
            label: 'Average cumulative live minutes' },
          { name: 'averagecumulativearchiveminutes', type: 'integer',
            label: 'Average cumulative archive minutes' },
          { name: 'averagearchiveminutes', type: 'integer',
            label: 'Average archive minutes' }
        ] }
      ]
    end,
    registrant_schema: lambda do |_input|
      [
        { name: 'firstname', label: 'First name' },
        { name: 'lastname', label: 'Last name' },
        { name: 'email', control_type: 'email' },
        { name: 'company' },
        { name: 'jobtitle', label: 'Job title' },
        { name: 'addressstreet1', label: 'Address street 1' },
        { name: 'addressstreet2', label: 'Address street 2' },
        { name: 'city' },
        { name: 'state' },
        { name: 'zip', hint: 'Postal Code.' },
        { name: 'country' },
        { name: 'homephone', label: 'Home phone' },
        { name: 'workphone', label: 'Work phone' },
        { name: 'fax' },
        { name: 'username' },
        { name: 'exteventusercd', label: 'Ext event user code',
          hint: 'External code used to identify the user.' },
        { name: 'other' },
        { name: 'notes' },
        { name: 'jobfunction', label: 'Job function' },
        { name: 'companyindustry', label: 'Company industry' },
        { name: 'companysize', label: 'Company size' },
        { name: 'partnerref', label: 'Partner reference' },
        { name: 'clientid', type: 'integer', label: 'Client Id' },
        { name: 'eventid', type: 'integer', label: 'Event Id' },
        { name: 'eventuserid', type: 'integer', label: 'Event user Id' },
        { name: 'std1', label: 'Custom Field #1' },
        { name: 'std2', label: 'Custom Field #2' },
        { name: 'std3', label: 'Custom Field #3' },
        { name: 'std4', label: 'Custom Field #4' },
        { name: 'std5', label: 'Custom Field #5' },
        { name: 'std6', label: 'Custom Field #6' },
        { name: 'std7', label: 'Custom Field #7' },
        { name: 'std8', label: 'Custom Field #8' },
        { name: 'std9', label: 'Custom Field #9' },
        { name: 'std10', label: 'Custom Field #10' },
        { name: 'marketingemail', label: 'Marketing email' },
        { name: 'eventemail', label: 'Event email' },
        { name: 'userprofileurl', label: 'User profile URL' },
        { name: 'createtimestamp', type: 'date_time',
          label: 'Create timestamp' },
        { name: 'lastactivity', label: 'Last activity' },
        { name: 'engagementprediction', label: 'Engagement prediction' },
        { name: 'ipaddress', label: 'IP address' },
        { name: 'os' },
        { name: 'browser' },
        { name: 'emailformat', label: 'Email format' },
        { name: 'campaigncode', label: 'Campaign code' },
        { name: 'sourcecampaigncode', label: 'Source campaign code' },
        { name: 'sourceeventid', type: 'integer', label: 'Source event id' },
        { name: 'userstatus', label: 'User status' }
      ]
    end,
    attendee_schema: lambda do |_input|
      [
        { name: 'email', control_type: 'email' },
        { name: 'clientid', type: 'integer', label: 'Client Id' },
        { name: 'eventid', type: 'integer', label: 'Event Id' },
        { name: 'eventuserid', type: 'integer', label: 'Event user Id' },
        { name: 'exteventusercd', label: 'Ext event user code' },
        { name: 'userstatus', label: 'User status' },
        { name: 'attendeesessions', type: 'integer',
          label: 'Attendee sessions' },
        { name: 'isblocked', label: 'Is blocked' },
        { name: 'engagementscore', type: 'number', label: 'Engagement score' },
        { name: 'liveminutes', type: 'integer', label: 'Live minutes' },
        { name: 'firstliveactivity', type: 'date_time',
          label: 'First live activity' },
        { name: 'lastliveactivity', type: 'date_time',
          label: 'Last live activity' },
        { name: 'archiveminutes', type: 'integer', label: 'Archive minutes' },
        { name: 'firstarchiveactivity', type: 'date_time',
          label: 'First archive activity' },
        { name: 'lastarchiveactivity', type: 'date_time',
          label: 'Last archive activity' },
        { name: 'askedquestions', type: 'integer', label: 'Asked questions' },
        { name: 'resourcesdownloaded', type: 'integer',
          label: 'Resources downloaded' },
        { name: 'answeredpolls', type: 'integer', label: 'Answered polls' },
        { name: 'answeredsurveys', type: 'integer', label: 'Answered surveys' },
        { name: 'questions', type: 'array', of: 'object', properties:
          [{ name: 'questionid', type: 'integer', label: 'Question Id' },
           { name: 'createtimestamp', type: 'date_time',
             label: 'Create timestamp' },
           { name: 'content' },
           { name: 'answer', type: 'object', properties:
              [{ name: 'createtimestamp', type: 'date_time',
                 label: 'Create timestamp' },
               { name: 'content' },
               { name: 'presenterid', type: 'integer', label: 'Presenter Id' },
               { name: 'presentername', label: 'Presenter name' },
               { name: 'privacy' }] }] },
        { name: 'polls', type: 'array', of: 'object', properties:
          [{ name: 'pollid', type: 'integer', label: 'Poll Id' },
           { name: 'pollsubmittedtimestamp', type: 'date_time',
             label: 'Poll submitted timestamp' },
           { name: 'pollquestionid', type: 'integer',
             label: 'Poll question Id' },
           { name: 'pollquestion', label: 'Poll question' },
           { name: 'pollanswers', label: 'Poll answers',
             type: 'array', of: 'object', properties:
              [{ name: '__name', label: 'Name' }] },
           { name: 'pollanswersdetail', label: 'Poll answers detail',
             type: 'array', of: 'object', properties:
              [{ name: 'answercode', label: 'Answer code' },
               { name: 'answer' }] }] },
        { name: 'resources', type: 'array', of: 'object', properties:
          [{ name: 'resourceid', type: 'integer', label: 'Resource Id' },
           { name: 'resourceviewed', label: 'Resource viewed' },
           { name: 'resourceviewedtimestamp', type: 'date_time',
             label: 'Resource viewed timestamp' }] },
        { name: 'surveys', type: 'array', of: 'object', properties:
          [{ name: 'surveyid', label: 'Survey Id' },
           { name: 'surveysubmittedtimestamp', type: 'date_time',
             label: 'Survey submitted timestamp' },
           { name: 'surveyquestions', label: 'Survey questions',
             type: 'array', of: 'object', properties:
              [{ name: 'surveyquestionid', type: 'integer',
                 label: 'Survey question Id' },
               { name: 'surveyquestion', label: 'Survey question' },
               { name: 'surveyanswers', type: 'array', of: 'object',
                 label: 'Survey answers', properties:
                  [{ name: '__name', label: 'Name' }] },
               { name: 'surveyanswersdetail', type: 'array', of: 'object',
                 label: 'Survey answers detail', properties:
                  [{ name: 'answercode', label: 'Answer code' },
                   { name: 'answer' }] }] }] },
        { name: 'twitterwidget', type: 'array', of: 'object',
          label: 'Twitter widget', properties:
          [{ name: 'date', type: 'date_time' },
           { name: 'tweetdescription', label: 'Tweet description' }] },
        { name: 'calltoactions', type: 'array', of: 'object',
          label: 'Call to actions', properties:
          [{ name: 'ctaid', label: 'Cta Id' },
           { name: 'ctaname', label: 'Cta name' },
           { name: 'clicks' },
           { name: 'date' }] },
        { name: 'testwidgets', type: 'array', of: 'object',
          label: 'Test widgets', properties:
          [{ name: 'testwidgetresult', label: 'Test widget result' },
           { name: 'retries', type: 'integer' },
           { name: 'correctanswersneeded', type: 'integer',
             label: 'Correct answers needed' },
           { name: 'correctanswersprovided', type: 'integer',
             label: 'Correct answers provided' }] },
        { name: 'testwidgetresult', label: 'Test widget result' },
        { name: 'certificationwidgetresult',
          label: 'Certification widget result' },
        { name: 'certificationcredit', label: 'Certification credit' },
        { name: 'certificationtimestamp', type: 'date_time',
          label: 'Certification timestamp' },
        { name: 'userprofileurl', label: 'User profile URL' },
        { name: 'campaigncode', label: 'Campaign code' },
        { name: 'sourcecampaigncode', label: 'Source campaign code' },
        { name: 'cumulativeliveminutes', type: 'integer',
          label: 'Cumulative live minutes' },
        { name: 'cumulativearchiveminutes', type: 'integer',
          label: 'Cumulative archive minutes' },
        { name: 'partnerref', label: 'Partner reference' },
        { name: 'attendancepartnerref', label: 'Attendance partner ref' },
        { name: 'certifications', type: 'array', of: 'object', properties:
          [{ name: 'certificationid', type: 'integer',
             label: 'Certification Id' },
           { name: 'certificationresult', label: 'Certification result' },
           { name: 'certificationname', label: 'Certification name' },
           { name: 'certificationcredit', label: 'Certification credit' },
           { name: 'certificationtimestamp', type: 'date_time',
             label: 'Certification timestamp' },
           { name: 'certificationurl', label: 'Certification URL' }] },
        { name: 'meetingconversions', type: 'array', of: 'object',
          label: 'Meeting conversions', properties:
          [{ name: 'widgetid', label: 'Widget Id' },
           { name: 'widgetname', label: 'Widget name' },
           { name: 'widgettype', label: 'Widget type' },
           { name: 'widgetaction', label: 'Widget action' },
           { name: 'widgetsubmittedtimestamp', type: 'date_time',
             label: 'Widget submitted timestamp' }] },
        { name: 'democonversions', type: 'array', of: 'object',
          label: 'Demo conversions', properties:
          [{ name: 'widgetid', label: 'Widget Id' },
           { name: 'widgetname', label: 'Widget name' },
           { name: 'widgettype', label: 'Widget type' },
           { name: 'widgetaction', label: 'Widget action' },
           { name: 'widgetsubmittedtimestamp', type: 'date_time',
             label: 'Widget submitted timestamp' }] },
        { name: 'freetrial', type: 'array', of: 'object', label: 'Free trial',
          properties:
          [{ name: 'widgetid', label: 'Widget Id' },
           { name: 'widgetname', label: 'Widget name' },
           { name: 'widgettype', label: 'Widget type' },
           { name: 'widgetaction', label: 'Widget action' },
           { name: 'widgetsubmittedtimestamp', type: 'date_time',
             label: 'Widget submitted timestamp' }] }
      ]
    end,
    lead_schema: lambda do |_input|
      [
        { name: 'email' },
        { name: 'businessinterests', label: 'Business interests',
          type: 'array', of: 'object', properties:
          [{ name: '__name', label: 'Name' }] },
        { name: 'engagementlevel', label: 'Engagement level' },
        { name: 'userprofileurl', label: 'User profile URL' }
      ]
    end,
    create_event_input: lambda do |_input|
      call('event_management_schema', '').
        required('title', 'liveStart', 'liveDuration').
        ignored('eventType', 'languageCd', 'timeZone', 'customAccountTag').
        concat([{ name: 'eventType', control_type: 'select',
                  pick_list: :event_types,
                  type: 'string',
                  label: 'Event type',
                  optional: false,
                  toggle_hint: 'Select from list',
                  toggle_field: {
                    name: 'eventType',
                    label: 'Event type',
                    optional: false,
                    type: 'string',
                    control_type: 'text',
                    toggle_hint: 'Use custom value',
                    hint: 'Allowed values, <b>E.g. fav, simulive, ondemand</b>'
                  } },
                { name: 'languageCd', control_type: 'select',
                  pick_list: :languages,
                  type: 'string',
                  label: 'Language code',
                  optional: false,
                  toggle_hint: 'Select from list',
                  toggle_field:
                  {
                    name: 'languageCd',
                    label: 'Language code',
                    optional: false,
                    type: 'string',
                    control_type: 'text',
                    toggle_hint: 'Use custom value',
                    hint: 'Allowed values, <b>E.g. bg, zh, cs</b>'
                  } },
                { name: 'timeZone', control_type: 'select',
                  pick_list: :time_zones,
                  toggle_hint: 'Select from list',
                  optional: false,
                  label: 'Time zone',
                  type: 'string',
                  toggle_field: {
                    name: 'timeZone',
                    label: 'Time zone',
                    optional: false,
                    type: 'string',
                    control_type: 'text',
                    toggle_hint: 'Use custom value',
                    hint: 'Allowed values, <b>E.g. Etc/GMT+12,' \
                    ' Pacific/Midway</b>'
                  } },
                {
                  name: 'customAccountTag', sticky: true, type: 'integer',
                  hint: 'An account with enabled custom account tags, it' \
                       ' is required to provide at least 1 tag id via the' \
                       ' customAccountTag parameter.',
                  label: 'Custom account tag'
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
        [{ name: '__name', label: 'ID' }] }]
    end,
    search_records_input: lambda do |_input|
      [
        { name: 'startDate', type: 'date', hint: 'If startDate is' \
          ' not sent, response will return all events from the past 3 months.' \
          ' The startDate will filter the list of events based on' \
          ' dateFilterMode parameter value.', label: 'Start date' },
        { name: 'endDate', type: 'date', hint: 'If endDate is not sent,' \
          ' response will return all events from the past 3 months. The' \
          ' endDate will filter the list of events based on dateFilterMode' \
          ' parameter value.', label: 'End date' },
        { name: 'dateInterval', type: 'integer', label: 'Date interval',
          hint: 'Number of days returned in a response.' },
        { name: 'dateIntervalOffset', type: 'integer',
          label: 'Date interval offset',
          hint: 'Number of days from which the interval should encompass.' },
        { name: 'dateIntervalTimezone', hint: 'Timezone to be used for' \
          ' determining the 24 hour period that constitutes a day.',
          label: 'Date interval timezone' },
        { name: 'includeSubaccounts', control_type: 'select',
          pick_list: :boolean_list,
          type: 'string',
          label: 'Include subaccounts',
          hint: "If 'Yes' then sub-accounts will be included in the response.",
          toggle_hint: 'Select from list',
          toggle_field: {
            name: 'includeSubaccounts',
            label: 'Include subaccounts',
            optional: true,
            type: 'string',
            control_type: 'text',
            toggle_hint: 'Use custom value',
            hint: 'Allowed values are <b>Y,N</b>'
          } },
        { name: 'subaccounts', label: 'Sub accounts',
          hint: 'Comma separated list of child client ids.' \
          ' <b>E.g. "22921, 32295"</b>' },
        { name: 'dateFilterMode', control_type: 'select',
          pick_list: :date_filter_mode_list,
          type: 'string',
          label: 'Date filter mode',
          hint: 'Type of filter to be used with the date value.',
          toggle_hint: 'Select from list',
          toggle_field: {
            name: 'dateFilterMode',
            label: 'Date filter mode',
            optional: true,
            type: 'string',
            control_type: 'text',
            toggle_hint: 'Use custom value',
            hint: 'Only allowed value is <b>"lastActivity"</b>'
          } },
        { name: 'filterOrder', control_type: 'select',
          pick_list: :filter_order_list,
          type: 'string',
          label: 'Filter order',
          toggle_hint: 'Select from list',
          toggle_field: {
            name: 'filterOrder',
            label: 'Filter order',
            optional: true,
            type: 'string',
            control_type: 'text',
            toggle_hint: 'Use custom value',
            hint: 'Allowed values are <b>asc, desc</b>'
          } },
        { name: 'includeInactive', control_type: 'select',
          pick_list: :boolean_list,
          type: 'string',
          label: 'Include inactive',
          hint: "If 'Yes' then inactive events will be included in the" \
          ' response.',
          toggle_hint: 'Select from list',
          toggle_field: {
            name: 'includeInactive',
            label: 'Include inactive',
            optional: true,
            type: 'string',
            control_type: 'text',
            toggle_hint: 'Use custom value',
            hint: 'Allowed values are <b>Y, N</b>'
          } },
        { name: 'contentType', control_type: 'select',
          pick_list: :content_type_list,
          type: 'string',
          label: 'Content type',
          hint: 'Filter events by contentType.',
          toggle_hint: 'Select from list',
          toggle_field: {
            name: 'contentType',
            label: 'Content type',
            optional: true,
            type: 'string',
            control_type: 'text',
            toggle_hint: 'Use custom value',
            hint: 'Allowed values, <b>E.g. experience, gateway, pdf</b>'
          } },
        { name: 'itemsPerPage', type: 'integer', hint: 'Number of items to be' \
          ' retrieved per page. If "includesubaccounts = Yes", then only' \
          ' itemsPerPage will available.', label: 'Items per page' },
        { name: 'pageOffset', type: 'integer', hint: 'Number of' \
          ' page to retrieve. If "includesubaccounts = Yes",' \
          ' then only itemsPerPage will available.', label: 'Page offset' },
        { name: 'excludeSubaccounts', control_type: 'select',
          pick_list: :boolean_list,
          type: 'string',
          label: 'Exclude subaccounts',
          hint: "If 'Yes' then sub-accounts will be excluded in the response.",
          toggle_hint: 'Select from list',
          toggle_field: {
            name: 'excludeSubaccounts',
            label: 'Exclude subaccounts',
            optional: true,
            type: 'string',
            control_type: 'text',
            toggle_hint: 'Use custom value',
            hint: 'Allowed values are Y,N'
          } },
        { name: 'partnerref', hint: 'Filter by partner reference E.g. EM',
          label: 'Partner reference' },
        { name: 'excludeLive', control_type: 'select',
          pick_list: :boolean_list,
          type: 'string',
          label: 'Exclude live',
          hint: 'Filter to exclude registrants which register after' \
          ' event ends.',
          toggle_hint: 'Select from list',
          toggle_field: {
            name: 'excludeLive',
            label: 'Exclude live',
            optional: true,
            type: 'string',
            control_type: 'text',
            toggle_hint: 'Use custom value',
            hint: 'Allowed values are <b>Y, N</b>'
          } },
        { name: 'userStatus', control_type: 'select',
          pick_list: :user_status_list,
          type: 'string',
          label: 'User status',
          hint: 'Filter to users based on their status.',
          toggle_hint: 'Select from list',
          toggle_field: {
            name: 'userStatus',
            label: 'User status',
            optional: true,
            type: 'string',
            control_type: 'text',
            toggle_hint: 'Use custom value',
            hint: 'Allowed values are <b>all, any, deleted, forgotten</b>'
          } },
        { name: 'filterforgotten', control_type: 'select',
          pick_list: :boolean_list,
          type: 'string',
          label: 'Filter forgotten',
          hint: 'Forgotten registrants filter.',
          toggle_hint: 'Select from list',
          toggle_field: {
            name: 'filterforgotten',
            label: 'Filter forgotten',
            optional: true,
            type: 'string',
            control_type: 'text',
            toggle_hint: 'Use custom value',
            hint: 'Allowed values are <b>Y, N</b>'
          } },
        { name: 'excludeAnonymous', control_type: 'select',
          pick_list: :boolean_list,
          type: 'string',
          label: 'Exclude anonymous',
          hint: 'Filter to exclude System-Generated Email Addresses.',
          toggle_hint: 'Select from list',
          toggle_field: {
            name: 'excludeAnonymous',
            label: 'Exclude anonymous',
            optional: true,
            type: 'string',
            control_type: 'text',
            toggle_hint: 'Use custom value',
            hint: 'Allowed values are <b>Y, N</b>'
          } }
      ]
    end,
    search_event_input: lambda do |_input|
      call('search_records_input', '').
        ignored('dateFilterMode', 'excludeSubaccounts', 'partnerref',
                'excludeLive', 'userStatus', 'filterforgotten',
                'excludeAnonymous').
        concat([{ name: 'dateFilterMode', control_type: 'select',
                  pick_list: :event_date_filter_mode_list,
                  default: 'creation',
                  type: 'string',
                  label: 'Date filter mode',
                  hint: 'Type of filter to be used with the date value.',
                  toggle_hint: 'Select from list',
                  toggle_field: {
                    name: 'dateFilterMode',
                    label: 'Date filter mode',
                    optional: true,
                    type: 'string',
                    control_type: 'text',
                    toggle_hint: 'Use custom value',
                    hint: 'Allowed values, <b>E.g. goodafter,' \
                    ' updated, creation</b>'
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
        concat([{ name: 'email', hint: 'Email registrant filter.',
                  control_type: 'email' },
                { name: 'noshow',
                  hint: 'Registrants who did not show up for the event.' },
                { name: 'eventId', optional: false, label: 'Event Id' }])
    end,
    search_event_attendee_input: lambda do |_input|
      call('search_records_input', '').
        ignored('includeSubaccounts', 'subaccounts', 'filterOrder',
                'includeInactive', 'contentType', 'itemsPerPage', 'pageOffset',
                'excludeLive', 'excludeSubaccounts').
        concat([{ name: 'eventId', optional: false, label: 'Event Id' }])
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
         hint: 'Id of the particular event.', label: 'Event Id' }]
    end,
    get_registrant_input: lambda do |_input|
      [{ name: 'email', optional: false, control_type: 'email',
         hint: 'Unique email id used in the registration.' },
       { name: 'partnerref', label: 'Partner reference',
         hint: 'Filter by partner reference. <b>E.g. EM</b>' }]
    end,
    get_attendee_input: lambda do |_input|
      [{ name: 'email', optional: false, control_type: 'email',
         hint: 'Unique email id used in the registration.' }]
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
    execute_url: lambda do |input|
      if input['object'] == 'registrant' && input['eventId'].present? ||
         input['object'] == 'event_registrant'
        "event/#{input['eventId']}/registrant"
      elsif input['object'] == 'event_attendee'
        "event/#{input['eventId']}/attendee"
      elsif input['email'].present? ||
            input['object'] == 'event' && input['eventId'].present?
        "#{input['object']}/#{input['email'] || input['eventId']}"
      else
        input['object']
      end
    end,
    trigger_url: lambda do |input|
      if input['object'] == 'event'
        get('event?dateFilterMode=creation&filterOrder=asc&
             includesubaccounts=Y')
      else
        get(input['object'])
      end
    end,
    update_trigger_url: lambda do |input|
      if input['object'] == 'event'
        get('event?dateFilterMode=modified&filterOrder=asc&
             includesubaccounts=Y')
      else
        get('registrant?dateFilterMode=lastActivity')
      end
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
        call('event_management_schema', '').
          concat([{ name: 'eventid', optional: false, type: 'integer' }]).
          required('liveStart', 'liveDuration').
          ignored('eventAbstract')
      end
    },
    copy_event_output: {
      fields: lambda do |_connection, _config_fields|
        call('event_management_schema', '')
      end
    },
    trigger_input: {
      fields: lambda do |_connection, _config_fields|
        [{ name: 'since', type: 'date_time', hint: 'When you start recipe for' \
        ' the first time, it picks up trigger events from this specified date' \
        ' and time. Leave empty to get records created or updated' \
        ' one hour ago.',
           sticky: true,
           render_input: lambda do |field|
             field&.(:to_s)
           end,
           parse_output: lambda do |field|
             field&.(:to_s)
           end }]
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
          hint: 'Select any ON24 object, <b>e.g. Registrant.</b>'
        }
      ],
      input_fields: lambda do |object_definitions|
        object_definitions['search_input']
      end,
      execute: lambda do |_connection, input|
        response = get(call('execute_url', input), input.except('object'))&.
        after_error_response(/.*/) do |code, _body, _header, message|
          error("#{code}: #{message}")
        end
        call('format_response_data', response.presence)
      end,
      output_fields: lambda do |object_definitions|
        object_definitions['search_output']
      end,
      sample_output: lambda do |_connection, input|
        if input['object'] == 'event_registrant'
          get('registrant?itemsPerPage=1')
        elsif input['object'] == 'event_attendee'
          get('attendee?itemsPerPage=1')
        else
          get("#{input['object']}?includeSubaccounts=Y&itemsPerPage=1")
        end
      end
    },
    get_object:
    {
      title: 'Get object',
      subtitle: 'Get object in ON24',
      description: lambda do |_connection, get_object_list|
        "Get <span class='provider'>" \
        "#{get_object_list[:object] || 'record'}</span> " \
        'in <span class="provider">ON24</span> '
      end,
      config_fields: [
        {
          name: 'object',
          optional: false,
          control_type: 'select',
          pick_list: :get_records_object_list,
          hint: 'Select any ON24 object, <b>e.g. Registrant.</b>'
        }
      ],
      input_fields: lambda do |object_definitions|
        object_definitions['get_input']
      end,
      execute: lambda do |_connection, input|
        response = get(call('execute_url', input), input.
          except('eventId', 'email', 'object'))&.
        after_error_response(/.*/) do |code, _body, _header, message|
          error(" #{code}: #{message}")
        end
        response = response[input['object']] || response
        call('format_response_data', response.presence)
      end,
      output_fields: lambda do |object_definitions|
        object_definitions['get_output']
      end,
      sample_output: lambda do |_connection, input|
        get("#{input['object']}?includeSubaccounts=Y&
            itemsPerPage=1")[input['object'].pluralize][0]
      end
    },
    create_object:
    {
      title: 'Create object',
      subtitle: 'Create object in ON24',
      description: lambda do |_connection, create_object_list|
        "Create <span class='provider'>" \
        "#{create_object_list[:object] || 'record'}</span> " \
        'in <span class="provider">ON24</span>'
      end,
      help: lambda do |_connection, object_list|
        if object_list['object'] == 'Registrant'
          'If a field is configured as "required" on the registration page,' \
          ' you must pass in a valid value, or the request will not be' \
          ' successful.'
        end
      end,
      config_fields: [
        {
          name: 'object',
          optional: false,
          control_type: 'select',
          pick_list: :object_list,
          hint: 'Select any ON24 object, <b>e.g. Registrant.</b>'
        }
      ],
      input_fields: lambda do |object_definitions|
        object_definitions['create_input']
      end,
      execute: lambda do |_connection, input|
        response = post(call('execute_url', input)).
                   payload(input.except('object', 'eventId')).
                   request_format_www_form_urlencoded&.
          after_error_response(/.*/) do |code, _body, _header, message|
            error("#{code}: #{message}")
          end
        response = response['wccevent'] || response
        call('format_response_data', response.presence)
      end,
      output_fields: lambda do |object_definitions|
        object_definitions['create_output']
      end,
      sample_output: lambda do |_connection, input|
        if input['object'] == 'event'
          call('event_management_sample_output', '')
        else
          get("#{input['object']}?includeSubaccounts=Y&
          itemsPerPage=1")[input['object'].pluralize][0]
        end
      end
    },
    update_object:
    {
      title: 'Update object',
      subtitle: 'Update object in ON24 by ID',
      description: lambda do |_connection, update_object_list|
        "Update <span class='provider'>" \
        "#{update_object_list[:object] || 'record'}</span> " \
        'in <span class="provider">ON24</span> by ID'
      end,
      config_fields: [
        {
          name: 'object',
          optional: false,
          control_type: 'select',
          pick_list: :object_list,
          hint: 'Select any ON24 object, <b>e.g. Registrant.</b>'
        }
      ],
      input_fields: lambda do |object_definitions|
        object_definitions['update_input']
      end,
      execute: lambda do |_connection, input|
        request = if input['object'] == 'registrant'
                    patch(call('execute_url', input))
                  else
                    put(call('execute_url', input))
                  end
        response = request.payload(input.except('object', 'email', 'eventId')).
                   request_format_www_form_urlencoded&.
          after_error_response(/.*/) do |code, _body, _header, message|
            error("#{code}: #{message}")
          end
        response = response['wccevent'] || response
        call('format_response_data', response.presence)
      end,
      output_fields: lambda do |object_definitions|
        object_definitions['update_output']
      end,
      sample_output: lambda do |_connection, input|
        if input['object'] == 'event'
          call('event_management_sample_output', '')
        elsif input['object'] == 'registrant'
          { 'updatedregistrants': [
            { '__name': '399133565' }
          ] }
        else
          get("#{input['object']}?includeSubaccounts=Y&
          itemsPerPage=1")[input['object'].pluralize][0]
        end
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
        response = post("event?eventsource=#{input['eventid']}").
                   payload(input.except('eventid')).
                   request_format_www_form_urlencoded&.
                   after_error_response(/.*/) do |code, _body, _header, message|
                     error("#{code}: #{message}")
                   end
        response = response['wccevent']
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
          'create record, get record.',
          default: 'Custom action',
          optional: false,
          schema_neutral: true
        },
        {
          name: 'verb',
          label: 'Method',
          hint: 'Select HTTP method of the request.',
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
      subtitle: 'Triggers when new record created',
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
          hint: 'Select any ON24 object, <b>e.g. Registrant.</b>'
        }
      ],
      input_fields: lambda do |object_definitions|
        object_definitions['trigger_input']
      end,
      poll: lambda do |_connection, input, closure|
        closure ||= {}
        limit = input['object'] == 'lead' ? 50 : 100
        page_off_set = closure['page_off_set'] || 0
        date_created = closure['date_created'] || input['since'] || 1.hour.ago
        response = call('trigger_url', '').
                   params(itemsPerPage: limit,
                          startDate: date_created,
                          pageOffset: page_off_set)
        records = response[input['object'].pluralize]
        if input['object'] == 'registrant'
          records = records.sort_by { |value| value['createtimestamp'] }
        end
        closure = if (has_more = records&.size&. >= limit)
                    if input['object'] == 'lead'
                      { 'date_created': date_created,
                        'page_off_set': page_off_set + 1 }
                    else
                      { 'date_created': records&.dig(-1, 'createtimestamp') ||
                        date_created, 'page_off_set': page_off_set + 1 }
                    end
                  else
                    if input['object'] == 'lead'
                      { 'date_created': Time.now,
                        'page_off_set': 0 }
                    else
                      { 'date_created': records&.dig(-1, 'createtimestamp') ||
                        date_created, 'page_off_set': 0 }
                    end
                  end
        {
          events: records,
          next_poll: closure,
          can_poll_more: has_more
        }
      end,
      dedup: lambda do |event|
        "#{event['eventid']}@@#{event['eventuserid']} || #{event['email']}"
      end,
      output_fields: lambda do |object_definitions|
        object_definitions['trigger_output']
      end,
      sample_output: lambda do |_connection, input|
        get("#{input['object']}?includeSubaccounts=Y&
            itemsPerPage=1")[input['object'].pluralize][0]
      end
    },
    new_or_update_record:
    {
      title: 'New or Update record',
      subtitle: 'Triggers when new record created or updated',
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
          hint: 'Select any ON24 object, <b>e.g. Registrant.</b>'
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
        response = call('update_trigger_url', '').
                   params(itemsPerPage: limit,
                          startDate: date_updated,
                          pageOffset: page_off_set)
        records = response[input['object'].pluralize]
        if input['object'] == 'registrant'
          records = records.sort_by { |value| value['lastmodified'] }
        end
        closure = if (has_more = records&.size&. >= limit)
                    { 'date_updated': date_updated,
                      'page_off_set': page_off_set + 1 }
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
        "#{event['eventid']}@@#{event['eventuserid']}@@
        #{event['lastmodified']} || #{event['lastactivity']}"
      end,
      output_fields: lambda do |object_definitions|
        object_definitions['trigger_output']
      end,
      sample_output: lambda do |_connection, input|
        get("#{input['object']}?includeSubaccounts=Y&
            itemsPerPage=1")[input['object'].pluralize][0]
      end
    }
  },

  pick_lists: {
    event_types: lambda do |_connection|
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
    time_zones: lambda do |_connection|
      get('timezones')['timezones'].
        map { |folder| [folder['label'], folder['value']] }
    end,
    content_type_list: lambda do |_connection|
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
    event_date_filter_mode_list: lambda do |_connection|
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
    filter_order_list: lambda do |_connection|
      [
        %w[Asc asc],
        %w[Desc desc]
      ]
    end,
    date_filter_mode_list: lambda do |_connection|
      [
        %w[Last\ activity lastActivity]
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
