class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.belongs_to :chat, index: true
      t.belongs_to :client, index: true

      t.text :body
      t.timestamps
    end
  end
end
