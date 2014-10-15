Given(/^I am unblocked$/) do
  unblock_user($userdetails['email'])
  set_user_view_count($userdetails['email'], 0)

end

Then(/^I become blocked$/) do
  find(".//*[@id='email']")
  step "I am prompted to login as a private citizen"
  step "I login to the service frontend with correct credentials"
  assert_match('Sign in', page.body, 'blocked error expected')
  #unblock and reset the user again
  unblock_user($userdetails['email'])
  set_user_view_count($userdetails['email'], 0)
end
