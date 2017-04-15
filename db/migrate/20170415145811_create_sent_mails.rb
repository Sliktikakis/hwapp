class CreateSentMails < ActiveRecord::Migration
  def change
    create_table :sent_mails do |t|
      t.string :sender_address
      t.string :recipient_address
      t.string :subject
      t.string :message

      t.timestamps null: false
    end
  end
end
