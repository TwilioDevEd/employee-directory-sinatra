<a href="https://www.twilio.com">
  <img src="https://static0.twilio.com/marketing/bundles/marketing/img/logos/wordmark-red.svg" alt="Twilio" width="250" />
</a>

# Employee Directory with Sinatra

[![Build Status](https://travis-ci.org/TwilioDevEd/employee-directory-sinatra.svg?branch=master)](https://travis-ci.org/TwilioDevEd/employee-directory-sinatra)

<!--
  You can grab the appropriate description from https://www.twilio.com/docs/tutorials.
-->
Use Twilio to accept SMS messages and turn them into queries against a PostgreSQL database. This example functions as an Employee Directory where a mobile phone user can send a text message with a partial string of a person's name and it will return their picture and contact information (e-mail address and phone number).

## Local Development

This project is built using [Sinatra](http://www.sinatrarb.com/) Framework.

1. First clone this repository and `cd` into it.

   ```bash
   $ git clone git@github.com:TwilioDevEd/employee-directory-sinatra.git
   $ cd employee-directory-sinatra
   ```

1. Install the dependencies.

   ```bash
   $ bundle install
   ```

1. Copy the sample configuration file and edit it to match your configuration.

   ```bash
   $ cp .env.example .env
   ```

   Run `source .env` to export the environment variables.

1. Make sure the tests succeed.

   ```bash
   $ bundle exec rspec
   ```

1. Start the server.

   ```bash
   $ bundle exec rackup
   ```

1. Check it out at [http://localhost:9292](http://localhost:9292).

## Meta

* No warranty expressed or implied. Software is as is. Diggity.
* [MIT License](http://www.opensource.org/licenses/mit-license.html)
* Lovingly crafted by Twilio Developer Education.

