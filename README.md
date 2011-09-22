facts-twitter
=============

Setup
-----

1. Copy `conf.rb.example` to `conf.rb`.
2. Go to https://dev.twitter.com/ and register a new application. Get an application key and secret and add them to `conf.rb` as `consumer_key` and `consumer_secret` respectively.
3. Run `bundle install`.
4. Run `bin/facts-oauth-setup` and go to the provided Twitter URL. Sign in as the account you want tweets posted to, authorize the application when prompted, and copy the resulting PIN code. Paste the PIN to the waiting `twitter-oauth-setup`. Get the OAuth token and secret that it prints, and copy them to `conf.rb` as `oauth_token` and `oauth_token_secret` respectively.
5. Running `bin/facts-twitter` will pull down a fact and post it through to Twitter. Set it up as a cron job for periodic tweets.
