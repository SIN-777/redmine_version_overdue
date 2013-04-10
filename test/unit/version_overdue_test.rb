# coding: utf-8

require File.dirname(__FILE__) + '/../test_helper'

class VersionOverdueTest < ActiveSupport::TestCase
  fixtures :projects,
    :enumerations,
    :versions,
    :trackers,
    :issues,
    :issue_statuses

  def setup
    @overdue_version = Version.create(
      :name => 'version-overdue',
      :project_id => 1,
      :description => 'this project due date must be on past',
      :effective_date => '2001-01-01',
      :status => 'open',
      :sharing => 'system'
    )
    @ontime_version = Version.create(
      :name => 'version-ontime',
      :project_id => 1,
      :description => 'this project due date must be on future',
      :effective_date => Time.now.since(1.year),
      :status => 'open',
      :sharing => 'system'
    )

    @version_overdue_issue = Issue.create(
      :project_id => 1,
      :priority_id => 1,
      :subject => 'this issue was version-overdue',
      :fixed_version_id => @overdue_version.id,
      :subject => 'this issue was version-overdue',
      :tracker_id => 1
    )
    @version_ontime_issue = Issue.create(
      :project_id => 1,
      :priority_id => 1,
      :subject => 'this issue was version-ontime',
      :fixed_version_id => @ontime_version.id,
      :subject => 'this issue was version-ontime',
      :tracker_id => 1
    )
    @no_versioned_issue = Issue.create(
      :project_id => 1,
      :priority_id => 1,
      :subject => 'this issue have no version',
      :fixed_version_id => nil,
      :subject => 'this issue have no version',
      :tracker_id => 1
    )
  end
  
  test 'version-overdue issue should have "version-overdue" css class' do
    assert_equal true, @version_overdue_issue.css_classes.include?('version-overdue')
  end

  test 'version-on-time issue should not have "version-overdue" css class' do
    assert_equal false, @version_ontime_issue.css_classes.include?('version-overdue')
  end

  test 'no-versioned issue should not have "version-overdue" css class' do
    assert_equal false, @no_versioned_issue.css_classes.include?('version-overdue')
  end
end



