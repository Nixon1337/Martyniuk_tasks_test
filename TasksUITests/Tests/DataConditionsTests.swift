import Foundation
import XCTest

class DataConditionsTests: BaseTestCase {
    
    override func setUp() {
        app.launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testReloginViaSameAccount() {
        loginFormScreen.loginFlow(login: validLogin, pass: validPassword) // login flow with valid login and valid password. Assert Tasks elements exist
        compositeElements.tapCompleteTask(pos: 1, title: tasksArray[1], state: selectedState) // tap on second cell and check if it is selected
        compositeElements.tapConfirmLogoutButton() // confirm log out
        loginFormScreen.loginFlow(login: validLogin, pass: validPassword) // login flow with valid login and valid password
        XCTExpectFailure("The state of the tasks is not saved after the relogin. BUG-1") { // set the expected failure due to test not behaving properly
            compositeElements.assertCellIsSelected(pos: 1, title: tasksArray[1], state: selectedState) // check second cell is selected
        }
    }
    
    func testBackgroundForegroundEveryScreen() {
        loginFormScreen.typeInPasswordField(password: validPassword) // type valid password in password field
        loginFormScreen.typeInEmailField(email: validLogin) // type valid login in email field
        helperMethods.putAppInBackgroundAndReopen() // put the app in background and open it
        loginFormScreen.assertEmailField(email: validLogin) // check the valid login in email field
        loginFormScreen.assertPasswordFieldIsNotEmpty() // check password field has no standard value
        loginFormScreen.tapLoginSuccessButton() // tap login button
        tasksScreen.assertTasksScreen() // check if elements exist on tasks screen
        compositeElements.tapCompleteTask(pos: 1, title: tasksArray[1], state: selectedState) // tap on second cell and check if it is selected
        helperMethods.putAppInBackgroundAndReopen()
        compositeElements.assertCellIsSelected(pos: 1, title: tasksArray[1], state: selectedState) // check second cell is selected
        tasksScreen.tapOnMoreInfoSleepButton() // tap on "More info" button to display sleep tasks screen
        compositeElements.tapCompleteTask(pos: 2, title: sleepArray[2], state: selectedState) // tap on third cell and check if it is selected
        helperMethods.putAppInBackgroundAndReopen()
        compositeElements.assertCellIsSelected(pos: 2, title: sleepArray[2], state: selectedState) // check third cell is selected
    }
    
    func testKillAppAndReopenEveryScreen() {
        loginFormScreen.typeInEmailField(email: validLogin) // type valid login in email field
        loginFormScreen.typeInPasswordField(password: validPassword) // type valid password in password field
        helperMethods.killAppAndReopen() // kill app and relaunch it
        loginFormScreen.assertEmailField() // check the email field with "Email" standard value
        loginFormScreen.assertPasswordField() // check the password field with "Password" standard value
        loginFormScreen.loginFlow(login: validLogin, pass: validPassword) // login flow with valid credentials
        compositeElements.tapCompleteTask(pos: 1, title: tasksArray[1], state: selectedState) // tap on second cell and check if it is selected
        helperMethods.killAppAndReopen() // kill app and relaunch it
        XCTExpectFailure("The state of the tasks is not saved after killing and reopening app. BUG-2") { // set the expected failure due to test not behaving properly
            compositeElements.assertCellIsSelected(pos: 1, title: tasksArray[1], state: selectedState) // check the second cell is selected
        }
        tasksScreen.tapOnMoreInfoSleepButton() // tap on "More info" button to display sleep tasks screen
        compositeElements.tapCompleteTask(pos: 2, title: sleepArray[2], state: selectedState) // tap on third cell and check if it is selected
        helperMethods.killAppAndReopen()
        tasksScreen.tapOnMoreInfoSleepButton()
        XCTExpectFailure("The state of the tasks is not saved after killing and reopening app. BUG-2") { // set the expected failure due to test not behaving properly
        compositeElements.assertCellIsSelected(pos: 2, title: sleepArray[2], state: selectedState) // check third cell is selected
        }
    }
    
    func testCheckSwipeUpAndSwipeDown() {
        loginFormScreen.loginFlow(login: validLogin, pass: validPassword) // login flow with valid credentials
        compositeElements.tapCompleteTask(pos: 1, title: tasksArray[1], state: selectedState) // tap second cell and check if it is selected
        helperMethods.swipeTheScreenUp() // swipe up
        compositeElements.assertCellIsSelected(pos: 1, title: tasksArray[1], state: selectedState) // check second cell is selected
        helperMethods.swipeTheScreenDown() // swipe down
        compositeElements.assertCellIsSelected(pos: 1, title: tasksArray[1], state: selectedState) // check second cell is selected
        tasksScreen.tapOnMoreInfoSleepButton() // tap on "More info" button to display sleep tasks screen
        compositeElements.tapCompleteTask(pos: 2, title: sleepArray[2], state: selectedState) // tap on third cell and check if it is selected
        helperMethods.swipeTheScreenUp() // swipe up
        compositeElements.assertCellIsSelected(pos: 2, title: sleepArray[2], state: selectedState) // check third cell is selected
        helperMethods.swipeTheScreenDown() // swipe down
        compositeElements.assertCellIsSelected(pos: 2, title: sleepArray[2], state: selectedState) // check third cell is selected
    }
    
    func testTransfersBeetwenScreens() {
        loginFormScreen.loginFlow(login: validLogin, pass: validPassword) // login flow with valid credentials
        tasksScreen.checkNoTasksAreDoneInTasks() // check that all tasks are not "Done" on tasks screen
        tasksScreen.tapOnMoreInfoSleepButton() // tap on "More info" button to display sleep tasks screen
        sleepTasksScreen.assertSleepTasksScreen() // check the elements on sleep tasks screen
        sleepTasksScreen.checkNoTasksAreDoneInSleep() // check that all tasks are not "Done" on sleep tasks screen
        XCTExpectFailure("Sometimes different tasks are marked as Done, not the tasks were tapped. BUG-5") { // set the expected failure due to test not behaving properly
            for i in 2...3 {
                compositeElements.tapCompleteTask(pos: i, title: sleepArray[i], state: selectedState) // tap on cell and check if it is selected
            }
            for i in 0...1 {
                compositeElements.assertCellIsSelected(pos: i, title: sleepArray[i], state: notSelectedState) // check the cells are not selected
            }
            sleepTasksScreen.tapOnBackButton() // tap on back button to return on tasks screen
            tasksScreen.assertTasksScreen() // check if task screen elements are displayed after successful login
            tasksScreen.checkNoTasksAreDoneInTasks() // check that all tasks are not "Done" on tasks screen
            for i in 3...4 {
                compositeElements.tapCompleteTask(pos: i, title: tasksArray[i], state: selectedState) // tap on cell and check if it is selected
            }
            for i in 0...2 {
                compositeElements.assertCellIsSelected(pos: i, title: tasksArray[i], state: notSelectedState) // check the cells are not selected
            }
            tasksScreen.tapOnMoreInfoSleepButton() // tap on "More info" button to display sleep tasks screen
            sleepTasksScreen.assertSleepTasksScreen() // check the sleep tasks screen elements exist
            for i in 2...3 {
                compositeElements.assertCellIsSelected(pos: i, title: sleepArray[i], state: selectedState) // check the cells are selected
            }
            for i in 0...1 {
            compositeElements.assertCellIsSelected(pos: i, title: sleepArray[i], state: notSelectedState) // check the cells are not selected
            }
            sleepTasksScreen.tapOnBackButton() // tap on back button to return on tasks screen
            tasksScreen.assertTasksScreen() // checl the elements on tasks screen
            for i in 3...4 {
                compositeElements.assertCellIsSelected(pos: i, title: tasksArray[i], state: selectedState) // check the cells are selected
            }
            for i in 0...2 {
                compositeElements.assertCellIsSelected(pos: i, title: tasksArray[i], state: notSelectedState) // check the cells are not selected
            }
        }
    }
}
