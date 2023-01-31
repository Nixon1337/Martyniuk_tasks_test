import Foundation
import XCTest

class SleepTasksScreen: BaseTestCase {
    
    lazy var backButton = app.windows.otherElements.navigationBars.buttons[tasksTitle].firstMatch

    func tapOnBackButton() {
        backButton.tap()
        compositeElements.assertToolbarTitle(title: tasksTitle)
    }
    
    func checkNoTasksAreDoneInSleep() {
        for i in 0...3 {
            compositeElements.assertCellIsSelected(pos: i, title: sleepArray[i], state: notSelectedState)
        }
    }
    
    func checkAllTasksAreDoneInSleep() {
        for i in 0...3 {
            compositeElements.assertCellIsSelected(pos: i, title: sleepArray[i], state: selectedState)
        }
    }
    
    func assertSleepTasksScreen() {
        XCTAssertTrue(backButton.waitForExistence(timeout: 3), "\(backButton) is visible on sleep tasks screen")
        compositeElements.assertToolbarTitle(title: sleepTitle)
        XCTAssertTrue(compositeElements.logoutButton.isEnabled , "\(compositeElements.logoutButton) is visible on sleep tasks screen")
        XCTAssertTrue(compositeElements.sortByNameButton.isEnabled, "\(compositeElements.sortByNameButton) is visible on sleep tasks screen")
    }
}
