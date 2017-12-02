class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def status_style_aa(status)
    
    case status
      when "beingInvited"
            :gray    
      when "finished"
            :green
      when "confirmed"
            :orange
      when "enrolled"
            :red
      when "applied"
      		:gray	
    end

end
end
