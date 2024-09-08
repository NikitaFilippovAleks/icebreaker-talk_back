# frozen_string_literal: true

# Questions table creation
class CreateQuestions < ActiveRecord::Migration[7.2]
  def change
    create_table :questions do |t|
      t.text :text

      t.timestamps
    end
  end
end
