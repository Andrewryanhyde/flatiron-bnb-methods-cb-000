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

  def self.highest_ratio_res_to_listings
    best = []
    best_ratio = 0
    City.all.each do |city|
      reservation_count = 0
      listings_count = city.listings.count

      city.listings.each do |listing|
        reservation_count += listing.reservations.count
      end

      city_ratio = reservation_count.to_f / listings_count.to_f

      if city_ratio > best_ratio
        best_ratio = city_ratio
        best << city
      end

    end
    best.last
  end


end
