class AddActivationToTesters < ActiveRecord::Migration
  def change
    add_column :testers, :activation_digest, :string
    add_column :testers, :activated, :boolean, default: false
    add_column :testers, :activated_at, :datetime
  end
end
