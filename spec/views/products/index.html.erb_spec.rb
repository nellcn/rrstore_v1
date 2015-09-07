require 'spec_helper'

describe "products/index" do
  before(:each) do
    assign(:products, [
      stub_model(Product,
        :prod_id => 1,
        :prod_name => "Prod Name",
        :prod_price => "9.99",
        :prod_amount => 2,
        :prod_desc => "MyText"
      ),
      stub_model(Product,
        :prod_id => 1,
        :prod_name => "Prod Name",
        :prod_price => "9.99",
        :prod_amount => 2,
        :prod_desc => "MyText"
      )
    ])
  end

  it "renders a list of products" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Prod Name".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
