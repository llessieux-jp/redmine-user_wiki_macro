Redmine::Plugin.register :redmine_user_wiki_macro do
  name 'Redmine User Macros'
  author 'Jonas Thiel -> Laurent Lessieux'
  description 'Add macros for user'
  version '0.0.3'
  url 'https://github.com/llessieux-jp/redmine-user_wiki_macro'
  author_url 'https://github.com/llessieux-jp'

  requires_redmine version_or_higher: '4.0'
end

require File.dirname(__FILE__) + '/lib/redmine_user_wiki_macro'
require File.dirname(__FILE__) + '/lib/redmine_user_wiki_macro/macros'


