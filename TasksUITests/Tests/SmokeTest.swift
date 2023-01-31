import Foundation
import XCTest

class SmokeTest: BaseTestCase {
    
    override func setUp() {
        app.launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testSmoke() {
        loginFormScreen.loginFlow(login: validLogin, pass: validPassword)
        tasksScreen.checkNoTasksAreDoneInTasks()
        XCTExpectFailure("During flow we can catch one of these tasks: BUG-3, BUG-4 or BUG-5") {
            for i in 2...4 {
                compositeElements.tapCompleteTask(pos: i, title: tasksArray[i], state: selectedState)
            }
            for i in 0...1 {
                compositeElements.assertCellIsSelected(pos: i, title: tasksArray[i], state: notSelectedState)
            }
            compositeElements.assertDefaultSorting()
            compositeElements.tapSortByNameButton()
            compositeElements.assertSortedSorting()
            tasksScreen.tapOnMoreInfoSleepButton()
            compositeElements.tapCompleteAllButton()
        }
        sleepTasksScreen.tapOnBackButton()
        compositeElements.tapConfirmLogoutButton()
    }
}
