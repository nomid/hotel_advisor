module StaticPagesHelper
  def get_top_5_ids
    hotels_ids = Comment.uniq.pluck(:hotel_id)
    hotels = Hotel.find(hotels_ids)
    ratings = Hash.new
    ids = Array.new
    count = 5
    hotels.each do |h|
      ratings[h.id] = h.get_rating
    end
    ratings = ratings.sort_by{|k, v| v}.reverse
    ratings.each do |k, v|
      if count == 0 
        break
      end
      ids.push k
      count -= 1
    end
    ids
  end
end
