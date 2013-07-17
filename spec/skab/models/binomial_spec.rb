require 'spec_helper'
require 'rspec/expectations'

ITERS = 10000
MAX_N = 1000

describe Skab::Models::Binomial do

  describe '#binomial_coef' do
    before do
      class << subject
        public :binomial_coef
      end
      class << subject_no_optims
        public :binomial_coef
      end
    end
    let(:subject) { described_class.new([1, 2, 3, 4])}  
    let(:subject_no_optims) { described_class.new([1, 2, 3, 4, {}]) }

    it "should return the binomial coefficient correctly" do
      subject.binomial_coef(0, 0).should == 1
      subject.binomial_coef(1, 0).should == 1
      subject.binomial_coef(1, 1).should == 1
      subject.binomial_coef(2, 1).should == 2
      subject.binomial_coef(3, 1).should == 3
      subject.binomial_coef(4, 2).should == 6
      subject.binomial_coef(10, 4).should == 210
      subject.binomial_coef(10, 4).should == subject.binomial_coef(10, 6)
      subject.binomial_coef(456, 123).should == subject.binomial_coef(456, 333)
    end

    it "should be quickish" do
      t = Time.now.to_f
      ITERS.times do
        n = rand(MAX_N)
        k = rand(n + 1)
        subject.binomial_coef(n, k)
      end
      u = Time.now.to_f
      # puts "#{ITERS} binomial_coef calls took #{(u - t)/(1.0 * ITERS)}s per call"
    end

    it "should be match results with no optimisations" do
      ITERS.times do
        n = rand(MAX_N)
        k = rand(n + 1)
        subject.binomial_coef(n, k).should == subject_no_optims.binomial_coef(n, k)
      end
    end
  end

  RSpec::Matchers.define :match_array_with_NaNs do |expected|
    match do |actual|
      len_match = (expected.length == actual.length)
      puts "Expected length #{expected.length}; got actual length #{actual.length}" unless len_match
      element_match = true
      expected.each_with_index do |exp, i|
        act = actual[i]
        this_element_match = exp.each_with_index.all?{|e, j| (e == act[j]) or (e.nan? and act[j].nan?)}
        puts "element #{i}: #{exp.join(',')} != #{act.join(',')}" unless this_element_match
        element_match &= this_element_match
      end
      len_match && element_match
    end
  end

  def do_distrib_test(subject)
    t = Time.now.to_f
    result = nil
    iters.times do
      subject.reset
      result = subject.distribution
    end
    u = Time.now.to_f
    # puts "#{iters} distribution calls took #{(u - t)/(1.0 * iters)}s per call"
    result
  end

  describe '#distribution' do
    let(:iters) { 25 }
    let(:ta)    { 3000 }
    let(:sa)    { 250 }
    let(:tb)    { 2850 }
    let(:sb)    { 123 }
    let(:subject_no_optims) { described_class.new([ta, sa, tb, sb, {}]) }
    context 'no optimisations' do
      let(:subject) { described_class.new([ta, sa, tb, sb, {}]) }
      it "should be slowish" do
        do_distrib_test(subject).should match_array_with_NaNs(subject_no_optims.distribution)
      end
    end
    context 'with caching of binomial_coef calls' do
      let(:subject) { described_class.new([ta, sa, tb, sb, {:cache_binomial_coef => true}])}
      it "should be a bit quicker" do
        do_distrib_test(subject).should match_array_with_NaNs(subject_no_optims.distribution)
      end
    end
    context 'with caching of binomial calls' do
      let(:subject) { described_class.new([ta, sa, tb, sb, {:cache_binomial => true}])}
      it "should be a bit quicker" do
        do_distrib_test(subject).should match_array_with_NaNs(subject_no_optims.distribution)
      end
    end
    context 'with caching of binomial and binomial_coef calls' do
      let(:subject) { described_class.new([ta, sa, tb, sb, {:cache_binomial => true, :cache_binomial_coef => true}])}
      it "should be a bit quicker still" do
        do_distrib_test(subject).should match_array_with_NaNs(subject_no_optims.distribution)
      end
    end
  end
end
