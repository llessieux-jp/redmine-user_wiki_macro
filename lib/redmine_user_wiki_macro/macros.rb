module RedmineUserWikiMacro
	USER_SIZES = {
		"default" => 24,
		"small"   => 14,
		"large"   => 50
	}.freeze

	module Macros

		Redmine::WikiFormatting::Macros.register do
			desc "Creates link to a user page including an avatar. Examples:\n\n" \
				 "{{user(the_user_login)}}\n" \
				 "{{user(the_user_login, size=small)}}"
			macro :user do |_obj, args|
			  args, options = extract_macro_options(args, :size)
			  return nil unless args.first.present?
			  username = args.first.strip
			  user     = User.find_by_login(username)
			  return nil unless user
	
			  image = avatar(user, size: RedmineUserWikiMacro.determine_size(options))
	
			  css   = ["user-wiki-macro user-wiki-macro-user"]
			  label = []
	
			  if image.present?
				css   << "user-wiki-macro-user-with-avatar"
				label << image
				label << content_tag(:span, user.login)
			  else
				label << user.login
			  end
	
			  content_tag :span, class: css do
				link_to label.join.html_safe, user_path(user)
			  end
			end
		end
	
		#Extended version of the issue macro displaying the assigned user
		Redmine::WikiFormatting::Macros.register do
			desc "Displays an issue link including additional information with the assigned user name (if assigned). Examples:\n\n" +
							"{{user_issue(123)}}                              -- Issue #123: Enhance macro capabilities\n" +
							"{{user_issue(123, project=true)}}                -- Andromeda - Issue #123: Enhance macro capabilities\n" +
							"{{user_issue(123, tracker=false)}}               -- #123: Enhance macro capabilities\n" +
							"{{user_issue(123, subject=false, project=true, priority=true, version=true )}} -- Andromeda - Issue #123 [High] {Deadline1} (someone) \n"
			macro :user_issue do |obj, args|
				 args, options = extract_macro_options(args, :project, :subject, :tracker, :assigned_to, :priority, :version)
				 id = args.first
				 issue = Issue.visible.find_by(id: id)
				 user = nil
				 if issue
					 # remove invalid options
					 options.delete_if {|k, v| v != 'true' && v != 'false'}
 
					 # turn string values into boolean
					 options.each do |k, v|
						 options[k] = v == 'true'
					 end

					 user_txt = ""
					 user = nil
					if issue.assigned_to_id 
						user = User.find_by_id(issue.assigned_to_id)
						if user 
							user_txt = " (" + user.login + ")"
						end
					end
					
					 version_name = nil;
					 if options[:version] 					
					 	if issue.fixed_version  
					  	version_name = " {"+issue.fixed_version.name+"}"
					 	end 
					end	

					 priority_name = nil;
					 if issue.priority != nil  
					 	priority_name =" ["+issue.priority.name+"]"
					 end 
					
					 s = link_to_issue(issue, options)								 
					 s << h(priority_name) if priority_name
					 s << link_to(version_name, issue.fixed_version) if version_name
					 s << link_to(user_txt, user.login) if user
			     s
				 else
					 # Fall back to regular issue link format to indicate, that there
					 # should have been something.
					 "##{id}"
				 end
			 end
	 end
	end
	 def self.determine_size(options)
		 if options[:size]
			 USER_SIZES[options[:size]] || options[:size]
		 else
			 USER_SIZES["default"]
		 end
	 end
end
