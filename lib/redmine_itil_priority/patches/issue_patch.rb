require_dependency 'issue'

class Issue < ActiveRecord::Base
  safe_attributes 'impact_id'
  safe_attributes 'urgency_id'

  def urgency_id=(pid)
    unless self.impact_id.nil?
      @settings = Setting['plugin_redmine_itil_priority'] if @settings.nil?
      write_attribute(:priority_id, @settings["priority_i" + self.impact_id.to_s + "_u" + pid.to_s])
    end
    write_attribute(:urgency_id, pid)
  end
  
  def impact_id=(pid)
    unless self.urgency_id.nil?
      @settings = Setting['plugin_redmine_itil_priority'] if @settings.nil?
      write_attribute(:priority_id, @settings["priority_i" + pid.to_s + "_u" + self.urgency_id.to_s])
    end
    write_attribute(:impact_id, pid)
  end
end

module RedmineItilPriority
  module Patches
    module IssuePatch
      def priority_id=(pid)
        self.priority = nil
        write_attribute(:priority_id, pid)
        @settings = Setting['plugin_redmine_itil_priority'] if @settings.nil?
        unless self.impact_id.nil? || self.urgency_id.nil?
          priority = @settings["priority_i" + self.impact_id.to_s + "_u" + self.urgency_id.to_s]
        end
        if priority.nil? || pid != priority
          for i in 1..3 do
            for u in 1..3 do
              if pid == @settings["priority_i" + i.to_s + "_u" + u.to_s]
                write_attribute(:urgency_id, u)
                write_attribute(:impact_id, i)
              end
            end
          end
        end
      end    
    end
  end
end

Issue.prepend RedmineItilPriority::Patches::IssuePatch
