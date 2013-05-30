require 'spec_helper'

describe Skab::Models::Base do

  describe '#factorial' do
    before do
      class << subject
        public :factorial
      end
    end
  
    it "should return the factorial correctly" do
      subject.factorial(1).should == 1
      subject.factorial(10).should == (1..10).reduce(1, :*)
      subject.factorial(100).should == (1..100).reduce(1, :*)
      subject.factorial(1000).should == (1..1000).reduce(1, :*)
      subject.factorial(10000).should == (1..10000).reduce(1, :*)
    end
  end

end
