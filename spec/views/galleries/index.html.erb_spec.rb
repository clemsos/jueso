require 'spec_helper'

describe "galleries/index.html.erb" do
  before(:each) do
    assign(:galleries, [
      stub_model(Gallery),
      stub_model(Gallery)
    ])
  end

  it "renders a list of galleries" do
    render
  end
end
