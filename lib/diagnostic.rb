require 'rails_helper'

# Instructions:
# The tests you build for this diagnostic are not expected to pass.
# Merely provide a test for each given scenario.

def examples
  Example.all
end

def example
  Example.first
end


#
# Question 1
#
# In a Ruby comment, explain Behavior Driven Development, how it is meant to be
# used, and how it differs from Test Driven Development.

# BDD is for the most part for everyone to use and check code with. While TDD is
#mostly for engineers working on the code

#
# Question 2
#
# Create a request spec for our Examples API that ensures 'GET /examples'
# responds successfully and lists all examples.

RSpec.describe 'Examples API' do
  it 'routes GET /examples to the examples#index action' do
    expect(get '/examples').to route_to('examples#index')

end

#
# Question 3
#
# Create a routing spec for our `Examples` resource that ensures
# GET /examples/:id routes to the examples#show action.

RSpec.describe 'routes for examples' do
  it 'routes GET /examples/:id to the examples#show action' do
    expect(get '/examples/1').to route_to(
    controller: 'examples',
    action: 'show',
    id: '1'
    )
end

#
# Question 4
#
# Test that a POST action from our ExamplesController is both successful
# and renders a JSON response.

RSpec.describe ExamplesController do
  def example_params
    {
      name: 'Example name',
      body: 'What a fantastic example this is...'
    }
  end

  describe 'POST create' do
    before(:each) do
      post :create, article: article_params, format: :json
    end

    it 'is successful' do
      expect(response.status).not_to be_nil
    end

    it 'renders a JSON response' do
      article_response = JSON.parse(response.body)
      expect(article_response['title']).to eq(article_params[:title])
  end
end

#
# Question 5
#
# Test that a PATCH action from our ExamplesController is both successful
# and renders a JSON response.

RSpec.describe ExamplesController do
  def example_diff
    {
      body: 'This actually isn\'t that fantastic of an example...'
    }
  end

  describe 'PATCH update' do
    it "should update email" do
  @user = subject.example
  expect {
    patch :update, id: @user, user: {:examples => "doe@example1.com"}
    @user.reload
  }.to change(@user, :examples).to("john.doe@example1.com")
  end
end

#
# Question 6
#
# Test that a DELETE action from our ExamplesController is both successful
# and renders an empty response.

RSpec.describe ExamplesController do
  def example
    Example.first
  end

at  describe 'DELETE destroy' do
  it 'deletes an example' do
     example = Fabricate(:category)

     get "example"
     expect(response.status).to eq 200
     expect(JSON.parse(response.body)).to eq([YAML.load(category.to_json),YAML.load(category2.to_json),])

     delete "/examples/#{example.id}"
     expect(response.status).to eq 200

     get "/examples"
     expect(JSON.parse(response.body)).to eq([YAML.load(category2.to_json)])
   end
end
