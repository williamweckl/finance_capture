//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

var ready;
ready = function() {
    function createLog(type, message) {
        $('#capture-logs').prepend('<div class="alert alert-' + type + '" role="alert">' + message + '</div>')
    };

    function addError(message) {
        createLog('danger', message);
    };

    function addSuccess(message) {
        createLog('success', message);
    };

    var source;
    var run = $('#run');
    var stop = $('#stop');

    run.submit(function (event) {
        event.preventDefault();
        source = new EventSource(run.attr('action'));
        source.onopen = function(ev) {
            run.hide();
            stop.show();
            //show logs
            $('#capture-logs-title').show();
            $('#capture-logs').show();
        }
        source.onmessage = function(ev) {
            var json = jQuery.parseJSON(ev.data);
            if (json.error) {
                //Yahoo api errors
                addError(json.error);
            } else {
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

                    //Add log
                    log = commodity.symbol + ' - ' + commodity.name + ' - ' + commodity.last_trade_price + ' - ' + commodity.change
                    addSuccess(log);
                });
            }
        }
        source.onerror = function(ev) {
            addError('Something went wrong with the capture process. Please try again.');
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