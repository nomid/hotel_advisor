class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def reject_hotel(hotel)
    @hotel = hotel
    mail(to: @hotel.user.email, subject: 'hotel rejected')
  end

  def approve_hotel(hotel)
    @hotel = hotel
    mail(to: @hotel.user.email, subject: 'hotel approved')
  end
end
