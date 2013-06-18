module SettingsHelper

  def display_site(user)
    if user.setting && user.setting.site
      user.setting.site.name
    else
      "None"
    end
  end

  def display_track(user)
    if user.setting && user.setting.track
      user.setting.track.name
    else
      "None"
    end
  end

  def just_display_site
    # debugger;1;1
    if Goldberg.user.setting && Goldberg.user.setting.site
      Goldberg.user.setting.site.name
    else
      "None"
    end
  end

  def just_display_track
    if Goldberg.user.setting && Goldberg.user.setting.track
      Goldberg.user.setting.track.name
    else
      "None"
    end
  end

end
