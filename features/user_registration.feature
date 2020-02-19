Feature: Registration validation check
	In order to register a user with the website
	As a visitor user
	I want to be registered with the website with only valid email and password

Background:
	Given I am at user registration page

@javascript

Scenario Outline:  User validation page check 
	When I fill "<field_name>" field with "<value>"	
	And click submit button
	Then I Should see "<error_mesg>" message 

Scenarios: if empty user_email
	|	field_name					|	value						|	error_mesg							|
	| 	user_email 					| 								|	Email can't be blank 				|
	| 	user_email 					| 	rawat.surender87@gmail.com	|	Email has already been taken 		|
	| 	user_email 					| 	@!23@testefasdfaest.com		|	Email is invalid					|

Scenarios: if empty password
	|	field_name					|	value						|	error_mesg										|
	| 	user_password				|								|	Password can't be blank							|
	| 	user_password				|	1234						|	Password is too short (minimum is 6 characters)	|
	|	user_password_confirmation	|	123457						|	Password confirmation doesn't match Password	|


Scenario: in case full form submission
	When I fill field with data
	| 	user_email 					| 	test@test.com 					|	
	| 	user_password				|		1234						|	
	|	user_password_confirmation	|		1234						|													

	And click submit button

	Then I Should see error message 
	|	error_mesg										|
	|	Password is too short (minimum is 6 characters)	|