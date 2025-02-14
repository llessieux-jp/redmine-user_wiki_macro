[github]: https://github.com/llessieux-jp/redmine-user_wiki_macro
[doc]: http://rubydoc.info/github/llessieux-jp/redmine-user_wiki_macro/master/file/README.md

# redmine-user_wiki_macro

Forked from https://github.com/neopoly/redmine-user_wiki_macro

[Source][github] |
[Documentation][doc]

Adds a `{{user(login_name)}}` macro to the Redmine's wiki engine.
also adds an extended version of the issue macro


`{{user_issue(123, subject=true, project=true, priority=true, version=true }}`

This new macro follow the rules of the issue macro and adds the priority in [], followed by the version in {} and finally the assigned user in ().


![Screenshot](http://neopoly.github.io/redmine-user_wiki_macro/images/screenshot.png)

This version of the plugin has been tested on Redmine 5.1 and 6.0

## Installation

Extract the macro code into the redmine\plugins folder.

Then just build it.

```
$ bundle exec rake redmine:plugins:migrate NAME=redmine_user_wiki_macro RAILS_ENV=production
```

Restart the Redmine application

## Usage

This macros works best with enabled user avatars. Enable the Gravatar images via
the administration settings:

    Administration > Settings > Display -> Use Gravatar user icons

## Testing

No automatic tests, sir! But this Redmine plugin is used in production.

## TODO

* Find a way to test this Redmine plugin

## Contributing

1. Fork it ( https://github.com/neopoly/redmine-user_wiki_macro/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
