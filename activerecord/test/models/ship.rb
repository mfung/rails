class Ship < ApplicationRecord
  self.record_timestamps = false

  belongs_to :pirate
  belongs_to :update_only_pirate, :class_name => 'Pirate'
  has_many :parts, :class_name => 'ShipPart'

  accepts_nested_attributes_for :parts, :allow_destroy => true
  accepts_nested_attributes_for :pirate, :allow_destroy => true, :reject_if => proc(&:empty?)
  accepts_nested_attributes_for :update_only_pirate, :update_only => true

  validates_presence_of :name

  attr_accessor :cancel_save_from_callback
  before_save :cancel_save_callback_method, :if => :cancel_save_from_callback
  def cancel_save_callback_method
    throw(:abort)
  end
end

class FamousShip < ActiveRecord::Base
  self.table_name = 'ships'
  belongs_to :famous_pirate
  validates_presence_of :name, on: :conference
end
