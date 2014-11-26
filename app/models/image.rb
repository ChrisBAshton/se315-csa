class Image < ActiveRecord::Base
  belongs_to :user
  has_attached_file :photo, styles: { large: '124x124#',
                                      medium: '80x80#',
                                      small: '50x50#',
                                      tiny: '30x30#' }

  # fixes "Missing Validation" error
  # http://stackoverflow.com/questions/21897725/papercliperrorsmissingrequiredvalidatorerror-with-rails-4
  validates_attachment :photo, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
  validates_attachment :photo, :presence => true, :size => { :in => 0..500.kilobytes }
end
