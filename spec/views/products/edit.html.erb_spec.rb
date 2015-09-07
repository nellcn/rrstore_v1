require 'spec_helper'

describe "products/edit" do
  before(:each) do
    @product = assign(:product, stub_model(Product,
      :prod_id => 1,
      :prod_name => "MyString",
      :prod_price => "9.99",
      :prod_amount => 1,
      :prod_desc => "MyText"
    ))
  end

  it "renders the edit product form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => products_path(@product), :method => "post" do
      assert_select "input#product_prod_id", :name => "product[prod_id]"
      assert_select "input#product_prod_name", :name => "product[prod_name]"
      assert_select "input#product_prod_price", :name => "product[prod_price]"
      assert_select "input#product_prod_amount", :name => "product[prod_amount]"
      assert_select "textarea#product_prod_desc", :name => "product[prod_desc]"
    end
  end
end
