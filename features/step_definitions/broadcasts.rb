Then(/^I should see a list of broadcasts$/) do
  assert page.has_content?(I18n.t('broadcasts.list'))
  page.assert_selector("table.sortable tbody tr", :count => 8)
end

Then(/^I should see the broadcast history$/) do
  assert page.has_content?(I18n.t('broadcasts.details'))
  assert page.has_content?("Hello, World... yet again.")
end

When(/^I attempt to delete the history of a specific broadcast$/) do
  # item number 3 from seeds.rb
  selector_of_broadcast_to_delete = "a[data-method='delete'][href='/broadcasts/3?page=1']"
  assert page.has_selector?(selector_of_broadcast_to_delete)
  page.find(selector_of_broadcast_to_delete).click
end

Then(/^I should be successful in deleting it$/) do
  assert !page.has_selector?("a[data-method='delete'][href='/broadcasts/3?page=1']")
end