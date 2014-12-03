class UrlMapper

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

  def get_url_from(page_title, options = {})
    if options[:track_pages_visited]
      @pages_accessed.push(page_title)
    else
      clean_slate
    end
    return @pages.fetch(page_title)
  end

  def get_all_page_names
    return @pages.keys
  end

  def get_restricted_pages
    restricted_pages = []
    @pages.each do |title, url|
      if !@pages_accessed.include? title
        restricted_pages.push(url)
      end
    end
    return restricted_pages
  end

  def get_user_id_string (who)
    return get_user_id(who).to_s
  end
end