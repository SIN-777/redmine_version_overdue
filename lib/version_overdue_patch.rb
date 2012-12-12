module VersionOverduePatch
  def self.included(klass)
    klass.send(:extend, ClassMethods)
    klass.send(:include, InstanceMethods)
    klass.class_eval do
      alias_method_chain :css_classes, :version_overdue
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

