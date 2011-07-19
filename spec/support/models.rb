# encoding: UTF-8

class Garage < ActiveRecord::Base
  include Materializer 

  has_many :cars 

  materialize :into => :name, :using => :name_as_json
  materialize :into => :all,  :using => :as_json

  def name_as_json
    { :name => name }
  end

  def as_json
    { :name => name, :location => location, :cars => cars.map { |c| c.as_json } }
  end
end

class Car < ActiveRecord::Base
  belongs_to :garage

  def as_json 
    { :name => name } 
  end
end
