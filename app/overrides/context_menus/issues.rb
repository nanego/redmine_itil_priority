Deface::Override.new :virtual_path  => "context_menus/issues",
                     :name          => "replace-priority-context-menu",
                     :replace       => "erb[silent]:contains('@priorities.present?')",
                     :partial       => "context_menus/itil_priority"
