class AddSearchkeyToWords < ActiveRecord::Migration[5.2]
  def change
    add_column :words, :search_key, :string
  end
end
