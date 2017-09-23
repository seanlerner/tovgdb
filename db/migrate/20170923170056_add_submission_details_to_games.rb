class AddSubmissionDetailsToGames < ActiveRecord::Migration
  def change
    add_column :games, :submission_notes, :text
    add_column :games, :submitted_by_contact_info, :string
  end
end
