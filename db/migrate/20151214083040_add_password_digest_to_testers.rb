class AddPasswordDigestToTesters < ActiveRecord::Migration
  def change
    add_column :testers, :password_digest, :string
  end
end
