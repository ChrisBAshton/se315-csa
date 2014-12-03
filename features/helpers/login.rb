def store_page_body (body, index = 0)
  if (index == 0)
    $bodies = []
  end
  $bodies.push(body)
end

def expect_in_each_body (message)
  $bodies.each do |body|
    page = Capybara::Node::Simple.new(body)
    assert page.has_content?(message)
  end
end