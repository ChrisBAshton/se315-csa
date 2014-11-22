Given(/^I am a(?:n)? (.+)$/) do |account_type|
  case account_type
  when "user"
    login_user
  when "admin"
    login_admin
  end
end

When(/^I access the homepage$/) do
  visit root_path
end

Then(/^I should see links for the following pages: (.+)$/) do |titles|
  titles.split(", ").each do |title|
    title = title.downcase
    page.assert_selector(".navigation ul li\##{title}", :count => 1)
  end
end
