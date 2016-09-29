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

```rb
# Behavior Driven Development adds a layer on top of Test Driven Development where the thing being tested is a feature and exists at a higher level than the bare control flow/logic functions.  It tests for things the end-users are concerned with, rather than how the program got to that point.  A feature test however is still made up of smaller unit tests, and BDD combines both of them.  It guides development by putting the focus on the end-product and maps out the steps it takes to get there, one small feature at a time.
```

#
# Question 2
#
# Create a request spec for our Examples API that ensures 'GET /examples'
# responds successfully and lists all examples.

RSpec.describe 'Examples API' do
  describe 'GET /examples' do
    it 'is successful' do
      get '/examples', nil, headers
      
      expect(response).to be_success
      
      parsed_response = JSON.parse(response.body)
      expect(
        parsed_response['examples']
      ).not_to be_empty
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
      post :create, { name: example_params.name, body: example_params.body }, format: :json
    end
    
    it 'is successful' do
      expect(response).to be_successful
    end
    
    it 'renders a JSON response' do
      parsed_response = JSON.parse(response.body)
      expect(parsed_response).not_to be_nil
    end
  end
end

#
# Question 5
#
# Test that a PATCH action from our ExamplesController is both successful
# and renders a JSON response.

RSpec.describe ExamplesController do
  describe 'PATCH example_patch'
  def example_diff
    {
      body: 'This actually isn\'t that fantastic of an example...'
    }
  end

  describe 'PATCH example_patch' do
    before(:each) do
      patch :example_patch,
        { body: example_diff}
    end
    
    it 'is successful' do
      expect(response).to be_successful
    end
    
    it 'renders no response body' do
      expect(response.body).to be_empty
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
    # your test(s) here
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
