class StudentsController < ApplicationController
  # GET /students
  def index
    if Setting.just_site_number && Setting.just_track_code
      site = Setting.just_site_number
      track = Setting.just_track_code
      @students = Student.find(:all, :conditions => "site_id = '#{site}' AND track = '#{track}'",
                                     :order => "name")
    else
      flash[:error] = 'No Site or Track Selected. Please ensure you have both selected before continuing.'
      redirect_to(setting_url, :action=>'edit')
    end
  end
  
  def intersession
    if Setting.just_site_number && Setting.just_track_code
      site = Setting.just_site_number
      track = Setting.just_track_code
      @students = Student.find(:all, :conditions => "site_id = '#{site}' AND track = '#{track}' and intersession='Y'",
                                     :order => "name")
    else
      flash[:error] = 'No Site or Track Selected. Please ensure you have both selected before continuing.'
      redirect_to(setting_url, :action=>'edit')
    end
  end
  
  def drop_all
    if Setting.just_site_number && Setting.just_track_code
      site = Setting.just_site_number
      track = Setting.just_track_code
          Student.update_all( "intersession='f'", "site_id = '#{site}' AND track = '#{track}'" )
      redirect_to (students_url)
    else
      flash[:error] = 'No Site or Track Selected. Please ensure you have both selected before continuing.'
      redirect_to(setting_url, :action=>'edit')
    end
  end

  # GET /students/1/edit
  def edit
    @student = Student.find(params[:id])
    @student.intersession = !@student.intersession
    if @student.save!
      respond_to do |format|
        format.js
      end
    else
      flash[:error] = "Unabel to Update"
      render :action => :index
    end
    
  end
  
end
