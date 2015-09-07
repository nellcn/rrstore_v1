require 'spec_helper'

describe "products/show" do
  before(:each) do
    @product = assign(:product, stub_model(Product,
      :prod_id => 1,
      :prod_name => "Prod Name",
      :prod_price => "9.99",
      :prod_amount => 2,
      :prod_desc => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/Prod Name/)
    rendered.should match(/9.99/)
    rendered.should match(/2/)
    rendered.should match(/MyText/)
  end
end
