class AddResetToTesters < ActiveRecord::Migration
  def change
    add_column :testers, :reset_digest, :string
    add_column :testers, :reset_sent_at, :datetime
  end
end
