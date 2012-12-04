module VersionOverduePatch
  def self.included(klass)
    klass.send(:extend, ClassMethods)
    klass.send(:include, InstanceMethods)
    klass.class_eval do
      alias_method_chain :css_classes, :version_overdue
    end
  end

  module ClassMethods
    def update_lastweek_issues_custom_field(custom_field_id, custom_field_value)
      Issue.version_overdued_lastweek.each do |issue|
        issue.custom_value_for(custom_field_id).update_attributes :value => custom_field_value
      end
    end

    def version_overdued_lastweek
      last_week_versions = Version.find(
        :all,
        :conditions => ['effective_date between ? and ?',
                         1.week.ago(Date.today).beginning_of_week,
                         1.week.ago(Date.today).end_of_week]
      )
      Issue.find(:all, :conditions => ['fixed_version_id in (?)', last_week_versions.map(&:id)])
    end
  end

  module InstanceMethods
    def css_classes_with_version_overdue
      s = css_classes_without_version_overdue
      s << ' version-overdue' if fixed_version.present? && fixed_version.due_date < Date.today && !status.is_closed?
      s
    end
  end
end

