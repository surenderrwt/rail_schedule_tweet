Given("I am at user registration page") do
	@user2 = User.create!(email: "rawat.surender87@gmail.com", password: "password", password_confirmation: "password", role_id: 1)
	visit new_user_registration_path
end

When("I fill {string} field with {string}") do |string, string2|
	fill_in string, with: string2
end

Then("I Should see {string} message") do |string|
  expect(page).to have_content("#{string}")
end


When("I fill field with data") do |table|
	@user = table.rows_hash
	fill_in 'user_email', with: @user[:user_email]
	fill_in 'user_password', with: @user[:user_password]
	fill_in 'user_password_confirmation', with: @user[:user_password_confirmation]
end

And("click submit button") do
	sleep(3)
	find("#new_user_registration").click
end

Then("I Should see error message") do |table|
	errors = table.hashes
	errors.each do |error|
		expect(page).to have_content("#{error[:error_mesg]}")
	end
	# puts errors
end


# Given("I am not yet playing") do
#   pending # Write code here that turns the phrase above into concrete actions
# end

# When("I start a new game") do
#   pending # Write code here that turns the phrase above into concrete actions
# end

# Then("I should see {string}") do |string|
#   puts string
# end

# Given("the secret code is {string}") do |string|
#   puts string
# end

# When("I guess {string}") do |string|
#   puts string
# end

# Then("the mark should be {string}") do |string|
#   puts string
# end




# @important

# Feature: Only Admin can activate users
#         In order to activate user account
#         As I am logged in as admin
#         I want to activate user

# @javascript

# Scenario: Activate user
#     Given I am creating a new user
#     And I am move on to manage users page
#     When I click on activate link
#     Then I should be redirected to manage user pages
#     And I should see a success message




# Feature: code-breaker starts game
# As a code-breaker
# I want to start a game
# So that I can break the code

# Scenario Outline: submit guess
# Given the secret code is "<code>"
# When I guess "<guess>"
# Then the mark should be "<mark>"

# Scenarios: no matches
# | code | guess | mark |
# | 1234 | 5555 |	|

# Scenarios: 1 number correct
# | code |guess | mark |

# | 1234 |1555 | + |
# | 1234 |2555 | - |

# Scenarios: 1 number correct
# | code | guess| mark |
# | 1234 | 1555 | +    |
# | 1234 | 2555 | -    |

# Scenarios: 2 numbers correct
# | code | guess | mark |
# | 1234 | 5254 | ++	|
# | 1234 | 5154 | +-	|
# | 1234 | 2545 | --	|



# Scenarios: if empty password
# 	|	field_name					|	value	|	error_mesg				|
# 	| 	user_password				|			|	Password can't be blank	|


	# Scenarios: valid email, small password and small password_confirmation
	# |	field_name					|	value							|	error_mesg										|
	# | 	user_email 					| 	test@test.com 					|	 												|
	# | 	user_password				|		1234						|	Password is too short (minimum is 6 characters)	|
	# |	user_password_confirmation	|		1234						|													|


# 	Scenarios: valid email, valid password and unmatched password_confirmation
# 	|	field_name					|	value							|	error_mesg										|
# 	| 	user_email 					| 	ttest@test.com 					|	 												|
# 	| 	user_password				|		123456						|	Password confirmation doesn't match Password	|
# 	|	user_password_confirmation	|		123457						|													|
