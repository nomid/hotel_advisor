class Hotel < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy
  validates :title, presence: true, uniqueness:{ case_sensitive: false }
  validates :room_desc, presence: true, length: {maximum: 200}
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :adress, presence: true, length: {maximum: 60}
  validates :star_rating, presence: true, inclusion: {in: 1..5}
  validates :user_id, presence: true
  mount_uploader :photo, PhotoUploader

  def self.top_5
    sql = 'SELECT hotel_id 
          FROM comments 
          GROUP BY hotel_id 
          ORDER BY AVG(rate) DESC, 
                   COUNT(hotel_id) DESC 
          LIMIT 5'
    records_array = ActiveRecord::Base.connection.execute(sql)
    if records_array.empty? 
      return nil
    end
    ids = Array.new
    records_array.each do |v|
      ids.push v['hotel_id']
    end
    self.find(ids).index_by(&:id).slice(*ids).values
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
