# frozen_string_literal: true

# limited number of airports. Can be selected at '/flights'
class Airport < ApplicationRecord
  has_many :departing_flights, class_name: 'Flight', foreign_key: 'origin_id'
  has_many :arriving_flights,  class_name: 'Flight', foreign_key: 'destination_id'

  def self.options_for_select
    all.pluck(:location, :id)
  end
end
