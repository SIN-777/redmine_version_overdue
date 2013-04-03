require 'redmine'

Redmine::Plugin.register :redmine_version_overdue do
  name 'Redmine Version Overdue plugin'
  author 'Shingo Sekiguchi'
  description 'Set "version-overdue" class to version-overdued issue in list'
  version '0.0.1'
  url 'https://github.com/SIN-777/redmine_version_overdue'
  author_url ''
end

require File.dirname(__FILE__) + '/lib/version_overdue_patch.rb'
Issue.send(:include, VersionOverduePatch)
