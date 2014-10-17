class AddPasscodeToSections < ActiveRecord::Migration
  def change
    add_column :sections, :passcode, :string
  end
end
