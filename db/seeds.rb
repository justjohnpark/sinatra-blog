require 'faker'


tags = []

20.times { tags << Tag.create(content: Faker::Name.first_name) }

20.times do
  Entry.create!(title: Faker::Commerce.product_name, content: Faker::Lorem.sentence(200))
end

50.times do
  Entry.all.sample.tags << tags.sample
end


