def visit_home
  $map.clean_slate
  visit $map.get_url_from('Home')
end