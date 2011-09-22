facts-twitter
=============

A simple program that pulls a random fact from a Facts installation, and pushes it to Twitter. Provides an easy way to program a schedule for these pushes.

Setup
-----

1. Create a custom configuration file by copying the example:

    cp config/app.rb.example config/app.rb

2. Go to https://dev.twitter.com/ and register a new application. Get an application key and secret and add them to `app.rb` as `consumer_key` and `consumer_secret` respectively.

3. Install dependencies through Bundler:

    bundle install

4. Run setup:

    bin/facts-oauth-setup
    
5. Go to the provided Twitter URL. Sign in as the account you want tweets posted to, authorize the application when prompted, and copy the resulting PIN code. Paste the PIN to the waiting `twitter-oauth-setup`. Get the OAuth token and secret that it prints, and copy them to `app.rb` as `oauth_token` and `oauth_token_secret` respectively.

6. Pull down a random fact and post it to Twitter:

    bin/facts-twitter

Cron
----

You may want to have facts-twitter tweet periodically. One way to achieve this is through cron:

1. Install the Whenever gem:

    gem install whenever

2. Modify the schedule configuration in `config/schedule.rb` to your liking.

3. Run Whenever to get the corresponding Cron configuration:

    whenever

4. Add the given configuration to your crontab using `crontab -e`.
