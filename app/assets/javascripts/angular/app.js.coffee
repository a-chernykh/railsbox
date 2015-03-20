app = angular.module 'app.railsbox', ['angularFileUpload', 'templates']
app.config [ '$httpProvider', '$provide', ($httpProvider, $provide) ->
    $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')

    # need to disable router behavior of URL modification
    # app does not uses router, but looks like angularFileUpload adds one which
    # preventing menu links from working
    $provide.decorator('$browser', ['$delegate', ($delegate) ->
        $delegate.onUrlChange = ->
        $delegate.url = -> ""
        $delegate
    ])
]
