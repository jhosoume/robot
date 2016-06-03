require_relative 'spec_helper'

describe Robot do
  before :each do
    @robot = Robot.new
  end

  it "has shields" do
    expect(@robot.shields).to eq(50)
  end

  it "receives damage in the shields" do
  end

  it "is damaged when shields are down" do
  end

end

