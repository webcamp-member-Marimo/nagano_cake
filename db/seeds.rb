# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create!(
  email: "admin@admin.com",
  password: "admin001",
  password_confirmation: "admin001"
)

Customer.create!(
  last_name: "田中", first_name: "太郎", last_name_kana: "タナカ", first_name_kana: "太郎", email: "tanaka@test.com", password: "password", postal_code: "123-4567", address: "東京都千代田区1丁目", telephone_number: "09012345678"
)

Address.create!(
  customer_id: 1, name: "山本博", postal_code: "001-0001", address: "大阪府堺市一丁目"
)

Genre.create!(
  [
    {name: "ケーキ"},
    {name: "キャンディ"}
  ]
)

Item.create!(
  [
    {genre_id: 1, name: "フルーツタルト", introduction: "コストコのフルーツタルト", price: 2000, image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-item1.jpg"), filename:"sample-post1.jpg")},
    {genre_id: 1, name: "ショートケーキ（ホール）", introduction: "ホールサイズのイチゴのショートケーキ", price: 4000, image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-item2.jpg"), filename:"sample-post1.jpg")},
    {genre_id: 2, name: "カラフルキャンディ", introduction: "カラフルなキャンディ", price: 300, image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-item3.jpg"), filename:"sample-post1.jpg")}
  ]
)

CartItem.create!(
  item_id: 1, customer_id: 1, amount:3
)