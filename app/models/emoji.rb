class Emoji < ApplicationRecord
  include EmotesHelper
  def self.all
    self.new.all
  end

  def all
    list_of_emojis
  end


end
