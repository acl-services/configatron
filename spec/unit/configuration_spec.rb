require 'pathname'
require Pathname(__FILE__).dirname.expand_path.parent + 'spec_helper'

describe Configatron::Configuration do
  
  before :each do
    configatron.reset!
  end
  
  it "should be a Singleton" do
    lambda{Configatron::Configuration.new}.should raise_error(NoMethodError)
    Configatron::Configuration.instance.should == Configatron::Configuration.instance
  end
  
  it "reset should remove all added methods" do
    configatron.should_not respond_to(:rst1)
    configatron.should_not respond_to(:rst2)
    
    configatron.nil_for_missing.should == false
    
    configatron do |config|
      config.rst1 = "RST1"
      config.rst2 = "RST2"
    end
    
    configatron.should respond_to(:rst1)
    configatron.should respond_to(:rst2)
    
    configatron.nil_for_missing = true
    configatron.nil_for_missing.should == true
    
    configatron.reset
    
    configatron.nil_for_missing.should == true
    
    configatron.should_not respond_to(:rst1)
    configatron.should_not respond_to(:rst2)
    
  end
  
  it "reset! should remove all added methods and revert the nil_for_missing setting" do
    configatron.should_not respond_to(:rst1)
    configatron.should_not respond_to(:rst2)
    
    configatron.nil_for_missing.should == false
    
    configatron do |config|
      config.rst1 = "RST1"
      config.rst2 = "RST2"
    end
    
    configatron.should respond_to(:rst1)
    configatron.should respond_to(:rst2)
    
    configatron.nil_for_missing = true
    configatron.nil_for_missing.should == true
    
    configatron.reset!
    
    configatron.nil_for_missing.should == false
    
    configatron.should_not respond_to(:rst1)
    configatron.should_not respond_to(:rst2)
  end
  
end