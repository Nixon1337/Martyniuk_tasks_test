import Foundation
import XCTest

class TasksScreen: BaseTestCase {
    
    private lazy var moreInfoSleepButton = app.windows.otherElements.tables.cells.buttons["More Info"].firstMatch
    
    func tapOnMoreInfoSleepButton() {
        moreInfoSleepButton.tap()
        compositeElements.assertToolbarTitle(title: sleepTitle)
    }
    
    func checkNoTasksAreDoneInTasks() {
        for i in 0...4 {
            compositeElements.assertCellIsSelected(pos: i, title: tasksArray[i], state: notSelectedState)
        }
    }
    
    func checkAllTasksAreDoneInTasks() {
        for i in 0...4 {
            compositeElements.assertCellIsSelected(pos: i, title: tasksArray[i], state: selectedState)
        }
    }
    
    func assertTasksScreen() {
        XCTAssertTrue(moreInfoSleepButton.waitForExistence(timeout: 20), "\(moreInfoSleepButton) is visible on tasks screen")
        compositeElements.assertToolbarTitle(title: tasksTitle)
        XCTAssertTrue(compositeElements.logoutButton.isEnabled, "\(compositeElements.logoutButton) is visible on tasks screen")
        XCTAssertTrue(compositeElements.sortByNameButton.isEnabled, "\(compositeElements.sortByNameButton) is visible on tasks screen")
    }
}
