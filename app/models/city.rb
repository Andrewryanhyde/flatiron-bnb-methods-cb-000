class City < ActiveRecord::Base
  has_many :neighborhoods
  has_many :listings, :through => :neighborhoods


  def city_openings(start_date, end_date
    start_date = DateTime.parse(start_date).to_date
    end_date = DateTime.parse(end_date).to_date

    openings = []
    conflicts = []

    self.listings.each do |listing|
      listing.reservation.each do |reservation|
        if ((start_date <= reservation.checkout) && (end_date >= reservation.checkin))
          conflicts << reservation
        end
      end

      if conflicts.empty?
        openings << listing
      end
      conflicts.clear
    end
    openings
  end


end
