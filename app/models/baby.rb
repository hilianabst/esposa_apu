class Baby < ApplicationRecord
    has_many :breastfeedings, dependent: :destroy

    def to_s
        name
        
    end
    
    def total_drinking
        breastfeedings.sum(:quantity)    
    end

    def total_duration
        breastfeedings.sum(:duration)
    end

    def breastfeeding_times_today
        breastfeedings.where("created_at >= :start_at AND created_at <= :end_date", {start_at: Time.now.beginning_of_day, end_date: Time.now}).count
    end

    def last_time_drinking
        if breastfeedings.count > 0
            breastfeedings.last.created_at
        else
            ''
        end
    end
    
    def breastfeeding_duration_today
        breastfeedings.where("created_at >= :start_at AND created_at <= :end_date", {start_at: Time.now.beginning_of_day, end_date: Time.now}).sum(:duration)
    end

    def breastfeeding_quantity_today
        breastfeedings.where("created_at >= :start_at AND created_at <= :end_date", {start_at: Time.now.beginning_of_day, end_date: Time.now}).sum(:quantity)
    end
end
