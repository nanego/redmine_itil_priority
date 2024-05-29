class AddImpactAndUrgencyToIssues < ActiveRecord::Migration[4.2]
  def change
    add_column :issues, :impact_id, :integer
    add_column :issues, :urgency_id, :integer
  end
end
