# encoding: UTF-8

require 'spec_helper'

describe Garage do 

  it "should populate materializers" do 
    @garage = Factory.create(:garage, :name => 'the-name', :location => 'the-location')

    @garage.materializers.should == [
      { :into => :name, :using => :name_as_json },
      { :into => :all,  :using => :as_json }
    ]
  end

  it "should materialize into names after save" do 
    @garage = Factory.create(:garage, :name => 'the-name', :location => 'the-location')

    @garage.name_json.should == @garage.from_materialized(:profile => :name)
    @garage.name_json.should == {:name => "the-name"}.to_json
  end

  it "should materialize into all after save" do 
    @garage = Factory.create(:garage, :name => 'the-name', :location => 'the-location')

    @garage.all_json.should == @garage.from_materialized(:profile => :all)
    @garage.all_json.should == {:name => "the-name", :location => "the-location", :cars => []}.to_json
  end

  it "should render the objects faster than normally" do 
    @garages = []
    @output = []

    10.times do 
      @garage = Factory.create(:garage)
      2.times do 
        @car = Factory.create(:car)
        @garage.cars << @car
      end
      @garages << @garage
    end

    time_before_native = Time.now.to_f
    @garages.each do |g|
      @output << g.as_json.to_json
    end
    time_after_native = Time.now.to_f

    time_before_optimized = Time.now.to_f
    @garages.each do |g|
      @output << g.from_materialized(:profile => :all)
    end
    time_after_optimized = Time.now.to_f

    optimized_time = (time_after_optimized - time_before_optimized)
    normal_time    = (time_after_native    - time_before_native)

    optimized_time.should < normal_time
  end

end
