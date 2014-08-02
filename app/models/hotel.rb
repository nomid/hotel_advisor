class Hotel < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_one :adress, dependent: :destroy
  accepts_nested_attributes_for :adress, allow_destroy: true
  validates :title, presence: true, uniqueness:{ case_sensitive: false }
  validates :room_desc, presence: true, length: {maximum: 200}
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  #validates :adress, presence: true, length: {maximum: 60}
  validates :star_rating, presence: true, inclusion: {in: 1..5}
  validates :user_id, presence: true
  mount_uploader :photo, PhotoUploader

  def self.top_5
    sql = 'SELECT hotels.* FROM hotels
          INNER JOIN comments
          ON hotels.id = comments.hotel_id
          WHERE hotels.status = \'a\'
          GROUP BY comments.hotel_id 
          ORDER BY AVG(comments.rate) DESC, 
                   COUNT(comments.hotel_id) DESC 
          LIMIT 5'
    hotels = Hotel.find_by_sql(sql)
  end

  def get_status
    case self.status
    when 'a'
      'approved'
    when 'r'
      'rejected'
    when 'p'
      'pending'
    end
  end
  
  def get_rating
    comments = self.comments
    if (comments.count == 0)
      return 'not rated'
    end
    summ = 0
    n = 0
    comments.each do |c|
      summ += c.rate
      n += 1
    end
    '%.2f' % (summ.to_f / n)
  end

end
