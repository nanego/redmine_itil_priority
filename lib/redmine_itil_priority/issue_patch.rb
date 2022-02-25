require_dependency 'issue'

class Issue
  safe_attributes 'impact_id'
  safe_attributes 'urgency_id'

  def urgency_id=(pid)
    unless self.impact_id.nil?
      if @settings.nil?
        @settings = Setting['plugin_redmine_itil_priority']
      end
      write_attribute(:priority_id, @settings["priority_i" + self.impact_id.to_s + "_u" + pid])
    end
    write_attribute(:urgency_id, pid)
  end

  def impact_id=(pid)
    unless self.urgency_id.nil?
      if @settings.nil?
        @settings = Setting['plugin_redmine_itil_priority']
      end
      write_attribute(:priority_id, @settings["priority_i" + pid + "_u" + self.urgency_id.to_s])
    end
    write_attribute(:impact_id, pid)
  end
end
