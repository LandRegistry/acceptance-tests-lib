Given(/^I am unblocked$/) do
  unblock_user("Walter White")
  set_user_view_count($userdetails['email'], 0)

end

Then(/^I become blocked$/) do
  find(".//*[@id='email']")
  step "I am prompted to login as a private citizen"
  step "I login to the service frontend with correct credentials"
  assert_match('Sign in', page.body, 'blocked error expected')
  #unblock and reset the user again
  unblock_user("Walter White")
  set_user_view_count($userdetails['email'], 0)
end

def set_user_view_count(email, count)
  visit("#{$LR_FIXTURES_URL}")
  select(email, :from => 'user_view_email')
  fill_in('view_count', :with => count)
  click_button('Set view count')
end

def unblock_user(name)
  visit("#{$LR_FIXTURES_URL}")
  select(name, :from => 'Account_lock_email')
  click_button('Toggle')
end
