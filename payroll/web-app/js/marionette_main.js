// Create Application
var App = new Backbone.Marionette.Application();

// Setup Application regions
App.addRegions({
    north: '#north_container',        // App.north = new Backbone.Marionette.Region({el:'#north'}
    center: '#center_container',
    south: '#south_container',
    west: '#west_container',
    east: '#east_container'
});

/**
 * Module: AppHeader
 */
App.module('AppHeader', function(AppHeader, App, Backbone, Marionette, $, _) {
    // private data and functions
    var privateData = "this is private data";
    var privateFunction = function() {
        console.log(privateData);
    }

    // public data and functions
    AppHeader.someData = "public data";
    AppHeader.someFunction = function() {
        privateFunction();
        console.log(AppHeader.someData);
    }
});

/**
 *
 */
    // Add an initializer for each module
//    App.addInitializer(function(options) {
//    });

//    App.on('initialize:after', function() {
//        Backbone.history.start();
//    });
//    App.addInitializer(function(options) {
//        App.header = new AppHeader(options);
//    });

    // Start Application
App.start();
