class Tag < ActiveRecord::Base
  has_and_belongs_to_many :entries

  validates :content, presence: true
  validates :content, uniqueness: true

  def self.string_to_tags(tags)
    tag_contents = tags.split(' ').map { |tag| tag.strip }
    tags = tag_contents.map { |tag| Tag.find_or_create_by(content: tag) }
    tags
  end

  def self.tags_to_string(tags)
    tags.map { |tag| tag.content }.join(' ')
  end
end
