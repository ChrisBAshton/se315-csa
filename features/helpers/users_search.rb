def extract_elements (array)
  array.gsub(' ', '').split(',')
end

def results_contain_result (results, result)
  results.each do |result_html|
    if result_html.has_content?(result)
      return true
    end
  end
  return false
end

def set_boxes(boxes)
  page.find('#firstname').set(boxes.include? 'firstname')
  page.find('#surname').set(boxes.include? 'surname')
  page.find('#grad_year').set(boxes.include? 'grad_year')
  page.find('#phone').set(boxes.include? 'phone')
  page.find('#email').set(boxes.include? 'email')
  if $js
    # odd bug - have to click all the checkboxes again is JS enabled. But we still have
    # to run the page.find() code above. For some reason, Poltergeist seems to need the
    # checkboxes clicking twice!
    page.execute_script("$('.user_search_checkbox').click()")
  end
end