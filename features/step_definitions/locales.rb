When(/^I change my default language to a(?:n)? (valid|invalid) option$/) do |validity|
  visit_home
  if (validity == 'valid')
    select('Cymraeg', :from => 'locale')
  else
    visit '/home?locale=swahili'
  end
end

When(/^I submit it manually$/) do
  page.find('#locale-submit').click # required if JS is disabled, which it is in the Selenium driver
end

Then(/^the language of the page should change$/) do
  assert page.has_content?("Croeso Gwestai")
end

Then(/^I should see an error message$/) do
  message = page.find('.flash_notice .flash_message')
  assert message.has_content?("swahili translation not available")
end