import Foundation
import XCTest

class LogoutTests: BaseTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testConfirmLogoutFromTasksScreen() {
        compositeElements.tapConfirmLogoutButton() // log out from tasks screen
    }
    
    func testCancelLogoutFromTasksScreen() {
        compositeElements.tapCancelLogoutButton() // cancel log out from tasks screen
        tasksScreen.assertTasksScreen() // check the user left on tasks screen
    }
    
    func testConfirmLogoutFromSleepScreen() {
        tasksScreen.tapOnMoreInfoSleepButton() // tap on "More info" button to display sleep tasks screen
        compositeElements.tapConfirmLogoutButton() // log out from sleep tasks screen
    }
    
    func testCancelLogoutFromSleepScreen() {
        tasksScreen.tapOnMoreInfoSleepButton() // tap on "More info" button to display sleep tasks screen
        compositeElements.tapCancelLogoutButton() // // cancel log out from sleep tasks screen
        sleepTasksScreen.assertSleepTasksScreen() // check the user left on sleep tasks screen
    }
}
