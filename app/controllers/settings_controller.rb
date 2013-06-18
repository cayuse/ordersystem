class SettingsController < ApplicationController
  
  def show
    redirect_to edit_setting_path
  end
  
  def edit
    @setting = Setting.new_or_old_setting(Goldberg.user)
    @sites = Site.find(Goldberg.user.site_ids).sort_by{|s| s.name}
    @tracks = Track.find(:all)
  end
  
  def new
    @setting = Setting.new
  end
  
  def update
    @setting = Setting.new_or_old_setting(Goldberg.user)
    if @setting.id
      if @setting.update_attributes(params[:setting])
        flash[:note] = 'Settings was successfully updated.'
        redirect_to edit_setting_path
      else
        redirect_to edit_setting_path
      end
    else
      params[:setting][:user_id] = Goldberg.user.id
      @setting = Setting.new(params[:setting])
      if @setting.save
        flash[:note] = 'Settings were successfully created.'
        redirect_to edit_setting_path
      else
        redirect_to edit_setting_path
      end
    end
  end

  
  def settrack
    track = Track.find(params[:settings][:id])
    Goldberg.user.setting.track = track
    redirect_to('/settings')
  end
  
  
end
