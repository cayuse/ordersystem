class Worksheet < ActiveRecord::Base
  
    has_attached_file :sheet

  def <=> (other)
    worksheet.name <=> other.worksheet.name
  end
  
end
