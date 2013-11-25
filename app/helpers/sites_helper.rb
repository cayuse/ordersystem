module SitesHelper
  def display_manager(site)
    if site.user_id
      Goldberg::User.find(site.user_id).fullname
    else
      "None"
    end
  end
  
  def display_sitetype(site)
    if site.sitetype_id
      Sitetype.find(site.sitetype_id).name
    else
      "None"
    end
  end
  
  def self.just_site_number
      if Goldberg.user.setting && Goldberg.user.setting.site
      return Goldberg.user.setting.site.number
    else
      return nil
    end
  end
  
  def self.just_track_code
      if Goldberg.user.setting && Goldberg.user.setting.track
      return Goldberg.user.setting.track.code
    else
      return nil
    end
  end
end
