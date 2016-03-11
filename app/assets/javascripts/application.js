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
    var source;
    var run = $('#run');
    var stop = $('#stop');

    run.submit(function (event) {
        event.preventDefault();
        source = new EventSource(run.attr('action'));
        source.onopen = function(ev) {
            run.hide();
            stop.show();
        }
        source.onmessage = function(ev) {
            var json = jQuery.parseJSON(ev.data);
            $.each(json, function(index, commodity) {
                var id = commodity.symbol.replace(/\./g,'-');
                var commoditytr = $('#commodity-' + id);
                var trHtml = '<td>' + commodity.symbol + '</td><td>' + commodity.name + '</td><td>' + commodity.last_trade_price + '</td><td>' + commodity.change + ' %</td>';

                if (commoditytr.length) {
                    commoditytr.html(trHtml)
                } else {
                    $('#last-commodities').show();
                    $('#last-commodities tr:last').after('<tr id="commodity-' + id + '">' + trHtml + '</tr>');
                    $('#commodities-empty').hide();
                }
            });
        }
        source.onerror = function(ev) {
            //TODO
            run.hide();
            stop.show();
        }
    });

    stop.click(function() {
        source.close();
        stop.hide();
        run.show();
    });
};

$(document).ready(ready);
$(document).on('page:load', ready);