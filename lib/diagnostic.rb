# frozen_string_literal: true
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

# BDD is the process of testing the expected output of of your program. It involves
# running a feature test and many unit tests. The unit tests are for smaller, individual parts
# of the app, while the feature test tests the whole feature. TDD is when you write tests
# that will fail on the first attempt, and then wirte the code to get them to pass. Once they
# pass, you can refactor your code and run it again to ensure it still passes

#
# Question 2
#
# Create a request spec for our Examples API that ensures 'GET /examples'
# responds successfully and lists all examples.

RSpec.describe 'Examples API' do
  describe 'GET index' do
    before(:each) { get :index } # haven't written the code for this
  end

  it 'is successful' do
    expect(response.status).to eq(200)
  end

  it 'renders a JSON response' do
    expect(response.body).not_to be_empty

    articles_list = JSON.parse(response.body)
    expect(articles_list).to be_a(Array)
    expect(articles_list.first['something']).to eq(article_params[:something]) # this part only works if you set it up prior to the test running.
  end

end

#
# Question 3
#
# Create a routing spec for our `Examples` resource that ensures
# GET /examples/:id routes to the examples#show action.

RSpec.describe 'routes for examples' do

  it 'routes GET /examples/:id to the examples#show action' do
  expect(get('/examples/3')).to route_to(controller: 'examples',
                                         action: 'show',
                                         id: '3')
end
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
    # didn't cover in class. Will come back to it
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

    before(:each) do
      patch :update, params: { id: article.id, article: article_diff }
    end

    it 'is successful' do
      expect(response).to be_success
    end

    it 'renders a JSON response' do
      updated_article = JSON.parse(response.body)
      expect(updated_article['body']).to eq(article_diff[:body])
    end



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

  describe 'DELETE destroy' do
    before(:each) { delete :destroy, params: { id: example.id } }
      it 'is successful and returns an empty response' do
        expect(response.body).to be_empty
        expect(response).to be_success
      end
  end
end

#
# Question 7
#
# Test that the Example model has an association with an
# `other` model. You'll have to build an `association` model
# on your own.

RSpec.describe Example do
  describe 'associations' do
    # association method here

    # test association with `other` here
  end
end
