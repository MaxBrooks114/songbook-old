class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true


  def self.used(attribute)
    pluck(attribute).uniq
  end

  def self.favorite(arg)
    group(arg).count.sort_by{|k,v| v}.last.first
  end


end
