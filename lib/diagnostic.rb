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

# Test Driven Development is used with the expectation that your code may or may not work.
# You run the code, without tests, and see what errors it throws and then you diagnose. With BDD,
# you write tests with the expectation that your tests will fail, and you'll be able to immediately pinpoint why the
# test failed and write code to satisfy the test. BDD is helpful in
# that it kind of guides you through your feature and unit testing because you
# test methodically and validate the tests in order. This also provides peace of mind when
# mkaing updates to your code in the future.

#
# Question 2
#
# Create a request spec for our Examples API that ensures 'GET /examples'
# responds successfully and lists all examples.

RSpec.describe 'Examples API' do
  describe 'GET /examples' do
    it 'lists all examples' do
      get '/examples'

      expect(response).to be_success

      examples_response = JSON.parse(response.body)
      expect(examples_response.length).to eq(examples.count)
      expect(examples_response.first['title']).to eq(example['title'])
    end
  end
end

#
# Question 3
#
# Create a routing spec for our `Examples` resource that ensures
# GET /examples/:id routes to the examples#show action.

RSpec.describe 'routes for examples' do
  it 'routes GET /examples/:id to the examples#show action' do
    expect(get('/examples/1')).to route_to(
      controller: 'examples',
      action: 'show',
      id: '1'
    )
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
    before(:each) do
      post :create, example: example_params, format: :json
    end

    it 'is successful' do
      expect(response.status).to eq(201)
    end

    it 'renders a JSON response' do
      example_response = JSON.parse(response.body)
      expect(example_response).not_to be_nil
    end
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
    patch :update, id: example.id, example: example_diff, format: :json
  end

  it 'is successful' do
    expect(response.status).to eq(200)
  end

  it 'renders a JSON response' do
    example_response = JSON.parse(response.body)
    expect(example_response).not_to be_nil
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
    it 'is successful and returns an empty response' do
    delete :destroy, id: example.id

    expect(response.status).to eq(204)
    expect(response.body).to be_empty
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
    def valid_params
      { title: 'test', content: 'blahblah' }
    end

    it 'validates the presence of an example\'s title and content' do
      expect(Example.create(valid_params)).to be_valid
    end

    describe 'title' do
      it 'is invalid without content' do
        invalid_params = valid_params.select { |key, _| key == :title }
        expect(Example.create(invalid_params)).to be_invalid
      end
    end
    describe 'content' do
      it 'is invalid without title' do
        invalid_params = valid_params.select { |key, _| key == :content }
        expect(Example.create(invalid_params)).to be_invalid
      end

    # test association with `other` here
    describe 'other association' do
    def others_association
      described_class.reflect_on_association(:others)
    end

    it 'has the name others' do
      expect(others_association).to_not be_nil
      expect(others_association.name).to eq(:others)
    end

    it 'has a set inverse of record' do
      expect(others_association.options[:inverse_of]).to_not be_nil
      expect(others_association.options[:inverse_of]).to eq(:example)
    end

    it 'deletes associated comments when destroyed' do
      expect(others_association.options[:dependent]).to eq(:destroy)
    end
  end
end
