# Describes the relationship between English language page titles (e.g. "the broadcasts list") and the actual URL (e.g. "/broadcasts").
# This way, we can keep our feature files nice and business-oriented.
class UrlMapper

  # Initialises or re-initialises the private attributes
  def clean_slate
    @pages = {
      "Home" => "/",
      "Login" => "/session/new",
      "Profile (own)" => "/users/" + get_user_id_string("my own"),
      "Profile (others)" => "/users/" + get_user_id_string("another user's"),
      "Profile (non-existent user)" => "/users/" + get_user_id_string("non-existent user's"),
      "Edit Profile (own)" => "/users/" + get_user_id_string("my own") + "/edit",
      "Edit Profile (others)" => "/users/" + get_user_id_string("another user's") + "/edit",
      "Edit Profile (non-existent user)" => "/users/" + get_user_id_string("non-existent user's") + "/edit",
      "the Users list" => "/users",
      "New user" => "/users/new",
      "the broadcasts list" => "/broadcasts",
      "a specific broadcast" => "/broadcasts/4",
      "a broadcast that doesn't exist" => "/broadcasts/-6",
      "New broadcast" => "/broadcasts/new"
    }
    @pages_accessed = []
  end

  # Given a page title (e.g. "the broadcasts list"), iterates over the private hash of key-value pairs and returns the value of the url associated with the page title.
  # If options[:track_pages_visited] is true, the class keeps track of which urls have been requested. This is useful for then deducing all of the urls that have NOT been requested. We can use this to test that a user has access to the pages they ought to be able to access, AND that they cannot access the other pages.
  def get_url_from(page_title, options = {})
    if options[:track_pages_visited]
      @pages_accessed.push(page_title)
    else
      clean_slate
    end
    return @pages.fetch(page_title)
  end

  # Returns a collection of all the page titles the class knows about.
  def get_all_page_names
    return @pages.keys
  end

  # Returns a collection of page titles that have NOT been requested since the last time clean_slate was ran. (See get_url_from).
  def get_restricted_pages
    restricted_pages = []
    @pages.each do |title, url|
      if !@pages_accessed.include? title
        restricted_pages.push(url)
      end
    end
    return restricted_pages
  end

  # Shortcut method, saves having to write .to_s lots of time when instantiating the @pages attribute.
  def get_user_id_string (who)
    return get_user_id(who).to_s
  end
end