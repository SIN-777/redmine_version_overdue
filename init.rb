require 'redmine'

Redmine::Plugin.register :redmine_version_overdue do
  name 'Redmine Version Overdue plugin'
  author 'Author name'
  description 'This is a plugin for Redmine'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://example.com/about'
end

require File.dirname(__FILE__) + '/lib/version_overdue_patch.rb'
Issue.send(:include, VersionOverduePatch)
