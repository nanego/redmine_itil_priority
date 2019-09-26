Deface::Override.new :virtual_path  => "issues/_attributes",
                     :name          => "replace-priority-form",
                     :replace       => "erb[loud]:contains('f.select :priority_id')",
                     :partial       => "issues/itil_priority"
