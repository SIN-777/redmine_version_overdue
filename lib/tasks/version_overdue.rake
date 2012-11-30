
namespace :redmine do
  namespace :plugins do
    namespace :version_overdue do
      desc 'Run the Continous Integration tests for Redmine'
      task :handle_last_week_issues => :environment do
        last_week_versions = \
          Version.find(:all, :conditions => ['effective_date between ? and ?',
                                             1.week.ago(Date.today).beginning_of_week,
                                             1.week.ago(Date.today).end_of_week])
        target_issues = Issue.find(:all, :conditions => ['fixed_version_id in (?)', last_week_versions.map(&:id)])
        # do something with target_issues
      end
    end
  end
end
