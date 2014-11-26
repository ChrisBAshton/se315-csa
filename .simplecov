SimpleCov.minimum_coverage 50

SimpleCov.start 'rails' do
  add_filter 'features/'
  add_filter 'config/'
  add_filter 'helpers/'

  add_group 'Controllers', 'app/controllers'
  add_group 'Models', 'app/models'
  add_group 'Helpers', 'app/helpers'
  add_group 'Mailers', 'app/mailers'
  add_group 'Views', 'app/views'
end