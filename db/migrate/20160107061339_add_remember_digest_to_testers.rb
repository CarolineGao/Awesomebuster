class AddRememberDigestToTesters < ActiveRecord::Migration
  def change
    add_column :testers, :remember_digest, :string
  end
end
