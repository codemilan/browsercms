@cli
Feature: New Project Generator
  Developers should be able to create new projects from the command line.

  Background:

  Scenario: Output the Version
    When I run `bcms -v`
    Then the output should contain "BrowserCMS 3.4.0"

  Scenario: Create a new BrowserCMS project
    When I create a new BrowserCMS project named "hello"
    Then a rails application named "hello" should exist
    And a file named "public/index.html" should not exist
    And the output should contain "rake  cms:install:migrations"
    And the output should contain "Copied migration"
    And the output should contain "browsercms300.rb from cms"
    And the output should contain "browsercms305.rb from cms"
    And the output should contain "browsercms330.rb from cms"
    And the output should contain "browsercms340.rb from cms"
    And the file "hello/config/routes.rb" should contain "mount_browsercms"
    And the file "hello/db/seeds.rb" should contain "require File.expand_path('../browsercms.seeds.rb', __FILE__)"
    And a file named "hello/db/browsercms.seeds.rb" should exist
    And a file named "hello/config/initializers/browsercms.rb" should exist
    And a file named "hello/app/views/layouts/templates/default.html.erb" should exist
    And the output should not contain "identical"
    And BrowserCMS should be added the Gemfile
    And the correct version of Rails should be added to the Gemfile

  Scenario: With a specific database
    When I run `bcms new hello_world -d mysql`
    Then the file "hello_world/Gemfile" should contain "mysql2"

  Scenario: With an application template
      The exact template is irrelevant, so long as bcms command passes it to rails.

      When I run `bcms new hello_world -m sometemplate.rb`
      Then the output should contain "sometemplate.rb] could not be loaded"

  Scenario: Creating a new CMS project without a  name
    When I run `bcms new`
    Then the output should contain:
    """
    "new" was called incorrectly. Call as "bcms new [NAME]".
    """
    And the exit status should be 0

  Scenario: Creating a CMS module without a  name
    When I run `bcms module`
    Then the output should contain:
    """
    "module" was called incorrectly. Call as "bcms module [NAME]".
    """
    And the exit status should be 0