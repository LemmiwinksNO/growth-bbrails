// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//  Third party vendor/library code
//= require modernizr
//= require jquery
//= require underscore
//= require backbone
//= require marionette
//= require js-routes
//= require syphon
//= require foundation.min
//= require highlight
//= require jquery-te-1.4.0.min
//= require medium_editor

//  Main config
//= require_tree ./config

//  Backbone app
//= require backbone/app

//  Support lib code
//= require_tree ./backbone/lib/entities
//= require_tree ./backbone/lib/utilities
//= require_tree ./backbone/lib/views
//= require_tree ./backbone/lib/controllers
//= require_tree ./backbone/lib/components

//  Shared app entities and working applications
//= require_tree ./backbone/entities
//= require_tree ./backbone/apps
