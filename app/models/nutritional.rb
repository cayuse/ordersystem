class Nutritional < ActiveRecord::Base
  belongs_to :foodvendor

  define_index do
    indexes name, :sortable => true
    indexes codenum, :sortable => true
    indexes search

    group_by "foodvendor_id"
    has created_at, updated_at
  end
      #set_property :delta => true

  has_attached_file :attachment

  def <=> (other)
    foodvendor.name <=> other.foodvendor.name
  end

end
