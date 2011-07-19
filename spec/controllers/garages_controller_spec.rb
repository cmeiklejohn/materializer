# encoding: UTF-8

require 'spec_helper'

describe GaragesController do 

  it "should return all formatted json" do
    @garages = []
    2.times do 
      @garage = Factory.create(:garage, :name => 'Chris')
      @garages << @garage
    end

    Garage.should_receive(:all).and_return(@garages)

    get 'index', :format => :json

    # Make sure whatever is returned from actionview to the client can
    # be parsed and is valid.
    #
    garages = JSON.parse(response.body) 
    garages.count.should == 2
    garages.first['name'].should == @garages.first.name
  end

  it "should return the formatted json" do
    @garage = Factory.create(:garage, :name => 'Chris')

    Garage.should_receive(:find).with("1").and_return(@garage)

    get 'show', :id => '1', :format => :json
    response.body.should == @garage.name_json

    # Make sure whatever is returned from actionview to the client can
    # be parsed and is valid.
    #
    garage = JSON.parse(response.body) 
    garage['name'].should == @garage.name
  end

end
