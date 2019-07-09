class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def normalize(*string)
    string.squish.downcase
  end

end
