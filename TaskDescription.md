#YOUR TASK STARTS HERE: 


# TEST PLAN: 

Environment: "Tasks" build
Devices: 
 - iPhone 8
 - iPhone 12 mini
 - iPhone 13 Pro Max
What parts of app will be tested:
 - Сheck the existence of all necessary elements on Login, Tasks, Sleep screens
 - Check active/non-active checkboxes with different methods on Tasks and Sleep screens
 - Check input of valid and invalid data in Login Form
 - Check logout flow from Tasks and Sleep screens
 - Check if checkbox cindition is saved or not saved with different methods
 - Check "Complete all" and "Sort by name" filters in Tasks and Sleep screens
 - create list of test cases
 - create Smoke test case: 
 1. Log in with valid credentials
 2. Check several tasks states
 3. Sort tasks by name
 4. Tap on 'More info' button
 5. Tap on Complete all button
 6. Tap back button
 7. Confirm log out

# LIST OF TEST CASES: 
Login Tests:
 - Log in with valid credentials
 - Check empty email and password fields
 - Log in with invalid credentials
 - Check invalid credentials for email field
 - Log in via great deal of characters
Logout Tests:
 - Confirm log out from Tasks screen
 - Cancel log out from Tasks screen
 - Confirm log out from Sleep screen
 - Cancel log out from Sleep screen
Tasks Tests:
 - Check Complete All and Cancel All in Tasks screen 
 - Check Complete All and Cancel All in Sleep screen
 - Check each task in Tasks screen
 - Check each task in Sleep screen
 - Sort by name in Tasks screen
 - Sort by name in Sleep screen
Data Condition Tests:
 - Check data by re-logging with the same account
 - Check every screen data after putting app in background and reopen
 - Check every screen data after killing and launching app
 - Check data by swiping up and down on each screen
 - Check data transfers between screens


# LIST OF DISCOVERED ISSUES:
 1. Re-login does not save the set condition of the tasks with same account.
 2. After kill app, the set condition of the tasks is not saved.
 3. "Sort by name" does not work correctly (sometimes it can set the tasks as "Done").
 4. "Complete all", "Cancel all" do not work correctly (sometimes the color of text of tasks is getting as in "Done" state, but checkboxes are empty; sometimes the button is not changed into another).
 5. Single set task as "Done" does not work correctly (sometimes it marks another task, not the tasked i chose, as "Done").
 6. Retry pop-up error during login via valid credentials. No logical reproductions were found, everything is random.
 7. There is no safe range for entering characters into "Email" and "Password" fields. Current minimum - 1 character, maximum - unlimited. For example, valid range in Gmail is 6 - 30 characters for email field and 8 - 100 for password field. In Yahoo, valid range is 4 - 32 characters for email field and 9 - 128 for password field.
 8. Improvement, not a bug. Structure the pop-up window in the app. Make one form, text size, same font, buttons. In the login form screen two pop-ups look like system ones and differ from the Logout pop-up.
