class CreateReportHierarchies < ActiveRecord::Migration[6.0]
  def change
    create_table :report_hierarchies do |t|
      t.integer  :ancestor_id, :null => false
      t.integer  :descendant_id, :null => false
      t.integer  :generations, :null => false
    end

    add_index :report_hierarchies, [:ancestor_id, :descendant_id, :generations],
              unique: true, :name => "report_anc_desc_udx"

    add_index :report_hierarchies, [:descendant_id],
              name: "report_desc_idx"
  end
end
