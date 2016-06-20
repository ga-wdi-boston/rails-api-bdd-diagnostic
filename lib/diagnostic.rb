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

# TDD differs from BDD in that the tests written for TDD could be all at once
# for the feature. BDD increments from feature to unit while TDD focuses all
# tests then code and does not go into finer detail.

#
# Question 2
#
# Create a request spec for our Examples API that ensures 'GET /examples'
# responds successfully and lists all examples.

RSpec.describe 'Examples API' do
  #   describe 'GET /examples' do
  #   it 'lists all examples' do
  #     get '/examples'
  #examples
  #     expect(response).to be_success
  #
  #     examples_response = JSON.parse(response.body)
  #     expect(examples_response.length).to eq(examples.count)
  #     expect(examples_response.first['title']).to eq(examples['title'])
  #   end
  # end

end

#
# Question 3
#
# Create a routing spec for our `Examples` resource that ensures
# GET /examples/:id routes to the examples#show action.

RSpec.describe 'routes for examples' do
# it 'routes GET /examples/:id to the examples#show action' do
#     expect(get '/examples/1').to route_to(
#       controller: 'examples',
#       action: 'show',
#       id: '1'
#     )
#   end
# end

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

  # describe 'POST create' do
  #   it 'is successful' do
  #     get :show, id: article.id
  #
  #     expect(response.status).to eq(200)
  #   end
  #
  #   it 'renders a JSON response' do
  #     get :show, id: examples.id
  #     examples_response = JSON.parse(response.body)
  #     expect(examples_response).not_to be_nil
  #     expect(examples_response['id']).not_to be_nil
  #   end
  # end

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
    # describe 'GET show' do
    def article_diff
      { title: 'Two Stupid Tricks' }
    end

    before(:each) do
      patch :update, id: example.id, article: example_diff, format: :json
    end
    it 'is successful' do

      expect(response.status).to be_successful
    end

    it 'renders a JSON response' do
      get :show,
      examples_response = JSON.parse(response.body)
      expect(examples_response).not_to be_nil
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

#   describe 'DELETE destroy' do
#  it 'is successful and returns an empty response' do
#    delete :destroy, id: article.id, format: :json
#
#    expect(response).to be_successful
#    expect(response.body).to be_empty
#  end
# end
