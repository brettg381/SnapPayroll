modules = {
    payroll {
        dependsOn 'jquery, backbone, underscore, jqueryui, bootstrap, handlebars'
        resource url: '/js/abtesting.js'
        resource url: '/css/harmony-custom.css'
        resource url: '/css/site.css'
        resource url: '/js/iop.js'
        resource url: '/js/app.js'
        resource url: '/js/calculate.js'
        resource url: '/js/landing.js'
        resource url: '/js/ee.js'
        resource url: '/js/custom.js'
    }
    jquery {
        resource url: '/libs/backbone.marionette/jquery.js'
    }
    backbone {
        dependsOn 'jquery, underscore'
        resource url: '/libs/backbone.marionette/backbone.js'
    }
    underscore {
        resource url: '/libs/backbone.marionette/underscore.js'
    }
    jqueryui {
        dependsOn 'jquery'
        resource url: '/libs/jquery-ui-1.10.3-intuit.custom/js/jquery-ui-1.10.3.custom.js'
        resource url: '/libs/jquery-ui-1.10.3-intuit.custom/css/custom-theme/jquery-ui-1.10.3.custom.css'
    }
    bootstrap {
        dependsOn 'jquery'
        resource url: '/libs/bootstrap-no-gutter/css/bootstrap.min.css'
        resource url: '/libs/bootstrap-no-gutter/js/bootstrap.min.js'
    }
    handlebars {
        dependsOn 'jquery'
        resource url: '/libs/handlebars.js'
    }
}