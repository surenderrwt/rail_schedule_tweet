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
end