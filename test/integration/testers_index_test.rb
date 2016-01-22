require 'test_helper'

class TestersIndexTest < ActionDispatch::IntegrationTest
  def setup
    @admin     = testers(:caroline)
    @non_admin = testers(:david)
  end

  test "index as admin including pagination and delete links" do
    log_in_as(@admin)
    get testers_path
    assert_template 'testers/index'
    assert_select 'div.pagination'
    first_page_of_testers = Tester.paginate(page: 1)
    first_page_of_testers.each do |tester|
      assert_select 'a[href=?]', tester_path(tester), text: tester.name
      unless tester == @admin
        assert_select 'a[href=?]', tester_path(tester), text: 'delete'
      end
    end
    assert_difference 'Tester.count', -1 do
      delete tester_path(@non_admin)
    end
  end

  test "index as non_admin" do
    log_in_as(@non_admin)
    get testers_path
    assert_select 'a', text: 'delete', count: 0
  end
end
