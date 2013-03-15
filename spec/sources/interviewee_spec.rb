require File.join(File.dirname(__FILE__),'..','spec_helper')

describe "Interviewee" do
  it_should_behave_like "SpecHelper" do
    before(:each) do
      setup_test_for Interviewee,'testuser'
    end

    it "should process Interviewee query" do
      pending
    end

    it "should process Interviewee create" do
      pending
    end

    it "should process Interviewee update" do
      pending
    end

    it "should process Interviewee delete" do
      pending
    end
  end  
end