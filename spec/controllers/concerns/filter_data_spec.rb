require 'spec_helper'
describe FilterData do  
  context "#filter_date" do
    it "from and to nil" do
      expect(filter_date("", "")).to {}
    end 
  end
end