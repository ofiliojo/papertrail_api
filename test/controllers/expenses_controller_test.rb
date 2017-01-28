require 'test_helper'
require 'json'

class ExpensesControllerTest < ActionController::TestCase

  test "Should get valid list of expenses" do
    get :index, params: { page: { number: 2 } }
    assert_response :success
    jdata = JSON.parse response.body
    assert_equal Expense.per_page, jdata['data'].length
    assert_equal jdata['data'][0]['type'], 'expenses'
    l = jdata['links']
    assert_equal l['first'], l['prev']
    assert_equal l['last'], l['next']
    assert_equal Expense.count, jdata['meta']['total-count']
  end

  test "Should get JSON:API error block when requesting post data with invalid ID" do
    get :show, params: { id: "z" }
    assert_response 404
    jdata = JSON.parse response.body
    assert_equal "Wrong ID provided", jdata['errors'][0]['detail']
    assert_equal '/data/attributes/id', jdata['errors'][0]['source']['pointer']
  end


  test "Should delete expense" do
    user = users('user_1')
    ecount = Expense.count - 1
    @request.headers["X-Api-Key"] = user.token
    delete :destroy, params: { id: expenses('article_5_24').id }
    assert_response 204
    assert_equal ecount, Expense.count
  end
end
