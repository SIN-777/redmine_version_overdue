namespace :redmine do

  namespace :plugins do

    namespace :version_overdue do

      desc "Update lastweek version-overdued issue's custom_field values. OPTIONS => [<custom_field_id>, <custom_field_value>]."
      task :update_lastweek_issues_custom_field, [:custom_field_id, :custom_field_value] => :environment do |task, args|
        unless CustomField.find(:first, :conditions => ['id = ?', args.custom_field_id.to_i])
          puts 'custom field not found'
          exit
        end
        Issue.update_lastweek_issues_custom_field(args.custom_field_id.to_i, args.custom_field_value)
      end

    end

  end

end
