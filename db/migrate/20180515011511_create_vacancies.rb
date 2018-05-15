class CreateVacancies < ActiveRecord::Migration[5.1]
  def change
    create_table :vacancies do |t|
      t.string :title
      t.string :salary
      t.text :requipment
      t.text :description
      t.date :expired

      t.timestamps
    end
  end
end
