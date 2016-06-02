require_relative 'spec_helper'

describe Robot do
  before :each do
    @robot = Robot.new
  end

  describe "#heal!" do
    it "increases health" do
      @robot.wound(40)
      @robot.heal!(20)
      expect(@robot.health).to eq(80)
    end

    it "raise excpetion if the robot is already at 0 health or less" do
      expect(@robot).to receive(:health).and_return(-10)
      expect { @robot.heal!(20) }.to raise_error(Exceptions::RobotAlreadyDeadError)
    end
  end

  describe "#attack!" do
    it "wounds other robot with weak default attack (5 hitpoints)" do
      foe_robot = Robot.new
      expect(foe_robot).to receive(:wound).with(5)
      @robot.attack!(foe_robot)
    end

    it "raise exception if the target being attack is not a robot" do
      foe = Object.new
      expect { @robot.attack!(foe) }.to raise_error(Exceptions::UnattackableEnemy)
    end
  end

end