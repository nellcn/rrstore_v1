require 'spec_helper'

describe "Static pages" do

  describe "Home page" do

    it "should have the content 'RR STATIONERY'" do
      visit root_path
      page.should have_content('RR STATIONERY')
    end

  end
end
