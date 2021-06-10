module BookingsHelper
  def pluralize_passengers
    pluralize(params[:tickets].to_i, 'passenger')
  end
end