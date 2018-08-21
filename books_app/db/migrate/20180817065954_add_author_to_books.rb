# frozen_string_literal: true

class AddAuthorToBooks < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :author, :string
  end
end
