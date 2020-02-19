Given("I am creating a new user") do
	@user2 = User.create!(email: "test3@test.com", password: "password", password_confirmation: "password", role_id: 1)
end

And(/^I am move on to manage users page/) do
	visit admin_users_path
end

When(/^I click on activate link/) do
	@user = User.all
	puts @user.inspect	
	find("#user_#{@user2.id}_activate").click
end


Then(/^I should be redirected to manage user pages/) do
	puts current_url 
	puts current_url =~ /admin\/users/
	puts current_url.match /admin\/users/
	puts current_url.match?(/admin\/users/)
end

And(/^I should see a success message/) do
	page.save_screenshot('input_keyword.png')
	page.should have_content "User activated!"
end
