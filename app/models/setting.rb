class Setting < ActiveRecord::Base
  belongs_to :goldberg_user
  belongs_to :site
  belongs_to :track
  
  def self.new_or_old_setting(user)
    "Class method"
    if user.setting
      setting = Setting.find_by_user_id(user)
    else
      setting = Setting.new
    end
      return setting
  end
  
  def self.just_site_number
      if Goldberg.user && Goldberg.user.setting && Goldberg.user.setting.site
      return Goldberg.user.setting.site.number
    else
      return nil
    end
  end
  
  def self.just_track_code
      if Goldberg.user && Goldberg.user.setting && Goldberg.user.setting.track
      return Goldberg.user.setting.track.code
    else
      return nil
    end
  end

  def self.just_site_id
      if Goldberg.user && Goldberg.user.setting && Goldberg.user.setting.site
      return Goldberg.user.setting.site.id
    else
      return nil
    end
  end
  
  def self.current_site
    if Goldberg.user && Goldberg.user.setting && Goldberg.user.setting.site
      return Goldberg.user.setting.site
    else
      return nil
    end
  end
  
end
