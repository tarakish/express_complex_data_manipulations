class Photo < ApplicationRecord
  has_many :taggings, class_name: "PhotoTagging"
  has_many :tags, through: :taggings

  def self.tagged_with(tag, *others, any: false)
    tags = [tag, *others]

    joins(:tags)
      .merge(reflect_on_association(:tags).klass.with_name(tags))
      .merge(
        if tags.size == 1
          all
        elsif any
          distinct
        else
          group(primary_key).having("COUNT(*) = ?", tags.size)
        end
      )
  end
end