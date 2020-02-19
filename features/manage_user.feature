@important

Feature: Only Admin can activate users
	In order to activate user account
	As I am logged in as admin
	I want to activate user

@javascript

Scenario: Activate user
	Given I am creating a new user
	And I am move on to manage users page
	When I click on activate link
	Then I should be redirected to manage user pages
	And I should see a success message