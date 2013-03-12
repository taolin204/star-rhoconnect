require File.join(File.dirname(__FILE__),'..','spec_helper')

describe "Company" do
  it_should_behave_like "SpecHelper" do
    before(:each) do
      setup_test_for Company,'testuser'
    end

    it "should process Company query" do
      pending
    end

    it "should process Company create" do
      pending
    end

    it "should process Company update" do
      pending
    end

    it "should process Company delete" do
      pending
    end
  end  
end