class AddIndexToTestersEmail < ActiveRecord::Migration
  def change
    add_index :testers, :email, unique: true
  end
end
