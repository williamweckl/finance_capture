#Yahoo Finance API Commodities Capture Example

This application was developed for a job test to work in [YouDo](http://youdo.co.nz).

The goal is to capture five commodity prices from Yahoo Finance at a configurable regular time interval.

## Technologies used

- Ruby 2.3.0
- Rails 4.2.6
- Redis
- SSE with Rails Live Stream technology
- minitest
- Capybara
- Jquery
- Twitter bootstrap

## How it works

The application have a web page with the last commodities captured from the Yahoo API and a button to start the capture process.
There is an input to configure the time to get new commodities from the API and a button to stop the process too.
Every commodity the process collect, is shown in the screen.

## Faced obstacles

- Tried to do integrations tests with SSE events with Capybara, Poltergeist and Capybara-webkit without success. Rails documentation does not provides a way to test the Live Stream. I was forced to abandon the idea of testing the SSE.
- I do not know much about finances, that's why I'm not sure if the data that I've got from the API is useful.
- To SSE thread does not lock the server and prevent new requests, I had to change development environment configs: `config.cache_classes` and `config.eager_load` to `true`.

## Final considerations

Thank you for the challenge.