module ApplicationHelper
  def hotel_commented?(hotel)
    comments = current_user.comments
    comment = comments.find_by(hotel_id: hotel.id)
    puts comment.to_yaml
    !comment.nil?
  end
end
