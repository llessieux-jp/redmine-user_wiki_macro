Redmine::Plugin.register :redmine_user_wiki_macro do
  name 'Redmine User Macros'
  author 'Jonas Thiel'
  description 'Add macros for user'
  version '0.0.2'
  url 'https://github.com/neopoly/redmine-user_wiki_macro'
  author_url 'https://github.com/neopoly'

  requires_redmine version_or_higher: '4.0'
end

require File.dirname(__FILE__) + '/lib/redmine_user_wiki_macro'
require File.dirname(__FILE__) + '/lib/redmine_user_wiki_macro/macros'


