class Initial < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string  :name
      t.datetime  :dob
      t.integer :height_cm
      t.string  :gender
      t.timestamps
    end

    create_table :weights do |t|
      t.integer :user_id
      t.float :weight_kg
      t.timestamps
    end

    create_table :exercises do |t|
      t.string :detail
      t.datetime :exercise_date
      t.integer :user_id
      t.integer :exercise_type_id
      t.timestamps
    end

    create_table :exercise_details do |t|
      t.string :detail
      t.integer :calories
      t.integer :exercise_id
      t.timestamps
    end

    create_table :meals do |t|
      t.string :detail
      t.integer :user_id
      t.datetime :meal_date
      t.integer :meal_type_id
      t.timestamps
    end
    create_table :meal_details do |t|
      t.string :detail
      t.integer :calories
      t.integer :meal_id
      t.timestamps
    end

    create_table :exercise_types do |t|
      t.string :detail
      t.string :image
      t.timestamps
    end

    create_table :meal_types do |t|
      t.string :detail
      t.string :image
      t.timestamps
    end
end
end
