// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

var ready;
ready = function() {
    var run = $('#run');
    var stop = $('#stop');

    run.click(function() {
        run.hide();
        stop.show();

        var name = 'GOOG'
        var commoditytr = $('#commodity-' + name);
        var trHtml = '<td>' + name + '</td><td>' + '11.0' + '</td>'
        if (commoditytr.length) {
            commoditytr.html(trHtml)
        } else {
            $('#last-commodities tr:first').after('<tr id="commodity-' + name + '">' + trHtml + '</tr>');
        }
    });

    stop.click(function() {
        stop.hide();
        run.show();
    });
};

$(document).ready(ready);
$(document).on('page:load', ready);