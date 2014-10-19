class AddPasscodeIndexOnSections < ActiveRecord::Migration
  def change
    add_index :sections, :passcode
  end
end
