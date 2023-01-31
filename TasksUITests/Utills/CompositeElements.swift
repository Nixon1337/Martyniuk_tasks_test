import Foundation
import XCTest

class CompositeElements: BaseTestCase {
    // Logout
    lazy var logoutButton = app.windows.otherElements.navigationBars.buttons["Logout"].firstMatch
    lazy var popupWindow = app.windows.otherElements.alerts.firstMatch
    private lazy var cancelButton = app.windows.otherElements.alerts.buttons["Cancel"].firstMatch
    private lazy var confirmLogoutButton = app.windows.otherElements.alerts.buttons["Logout"].firstMatch
    // Cell elements
    private lazy var checkbox = app.windows.otherElements.tables.cells.images
    // Bottom bar
    lazy var completeAllButton = app.windows.otherElements.toolbars.buttons["Complete All"].firstMatch
    private lazy var cancellAllButton = app.windows.otherElements.toolbars.buttons["cancel-tasks-bar-button-item"].firstMatch
    lazy var sortByNameButton = app.windows.otherElements.toolbars.buttons["sort-tasks-bar-button-item"].firstMatch
    
    func tapConfirmLogoutButton() {
        if logoutButton.exists {
            logoutButton.tap()
            tapAlertPopUpButton(title: logoutTitle, button: logout)
            loginFormScreen.assertLoginPage()
        }
    }
    
    func tapCancelLogoutButton() {
        logoutButton.tap()
        tapAlertPopUpButton(title: logoutTitle, button: cancel)
    }
    
    func tapCompleteTask(pos: Int, title : String, state: String) {
        let navigatorCell = app.windows.otherElements.tables.cells.element(boundBy: pos)
        let navigatorTitle = navigatorCell.children(matching: .staticText).element(matching: .staticText, identifier: title)
        let checkBox = navigatorCell.children(matching: .image).element(matching: .image, identifier: "cell_image_view")
        XCTAssertTrue(navigatorCell.waitForExistence(timeout: 5), "\(navigatorCell) exists in the table")
        XCTAssertTrue(navigatorTitle.waitForExistence(timeout: 5), "\(navigatorTitle) exists in the table")
        navigatorTitle.tap()
        XCTAssertEqual(checkBox.value as! String, state, "\(checkBox) with specific state exists")
    }
    
    func tapCompleteAllButton() {
        XCTAssertTrue(completeAllButton.isEnabled, "\(completeAllButton) is visible before tapping on it")
        if sleepTasksScreen.backButton.exists {
            for i in 0...3 {
                compositeElements.assertCellIsSelected(pos: i, title: sleepArray[i], state: notSelectedState)
            }
            completeAllButton.tap()
            for i in 0...3 {
                compositeElements.assertCellIsSelected(pos: i, title: sleepArray[i], state: selectedState)
            }
        }
        else {
            for i in 0...4 {
                compositeElements.assertCellIsSelected(pos: i, title: tasksArray[i], state: notSelectedState)
            }
            completeAllButton.tap()
            for i in 0...4 {
                compositeElements.assertCellIsSelected(pos: i, title: tasksArray[i], state: selectedState)
            }
        }
        XCTAssertTrue(cancelButton.isEnabled, "\(cancelButton) is visible after tapping on \(completeAllButton)")
    }
    
    func tapCancelAllButton() {
        XCTAssertTrue(cancelButton.isEnabled, "\(cancelButton) is visible before tapping on it")
        if sleepTasksScreen.backButton.exists {
            for i in 0...3 {
                compositeElements.assertCellIsSelected(pos: i, title: sleepArray[i], state: selectedState)
            }
            cancellAllButton.tap()
            for i in 0...3 {
                compositeElements.assertCellIsSelected(pos: i, title: sleepArray[i], state: notSelectedState)
            }
        }
        else {
            for i in 0...4 {
                compositeElements.assertCellIsSelected(pos: i, title: tasksArray[i], state: selectedState)
            }
            cancellAllButton.tap()
            for i in 0...4 {
                compositeElements.assertCellIsSelected(pos: i, title: tasksArray[i], state: notSelectedState)
            }
        }
        XCTAssertTrue(completeAllButton.isEnabled, "\(completeAllButton) is visible after tapping on \(cancelButton)")
    }
    
    func tapSortByNameButton(state: String = notSelectedState) {
        sortByNameButton.tap()
    }
    
    func tapAlertPopUpButton(title: String, button: String) {
        let alertButton = popupWindow.buttons[button]
        assertAlert(title: title)
        alertButton.tap()
    }
    
    func assertDefaultSorting() {
        if sleepTasksScreen.backButton.exists {
            for i in 0...3 {
                compositeElements.assertCellIsSelected(pos: i, title: sleepArray[i], state: notSelectedState)
            }
        }
        else {
            for i in 0...4 {
                compositeElements.assertCellIsSelected(pos: i, title: tasksArray[i], state: notSelectedState)
            }
        }
    }
    
    func assertSortedSorting(state: String = notSelectedState) {
        let tasksSorted = tasksArray.sorted()
        let sleepSorted = sleepArray.sorted()
        if sleepTasksScreen.backButton.exists {
            for i in 0...3 {
                compositeElements.assertCellIsSelected(pos: i, title: sleepSorted[i], state: state)
            }
        }
        else {
            for i in 0...4 {
                compositeElements.assertCellIsSelected(pos: i, title: tasksSorted[i], state: state)
            }
        }
        
    }
    
    func assertToolbarTitle(title: String) {
        let navigationBarName = app.windows.otherElements.navigationBars.staticTexts[title]
        XCTAssertTrue(navigationBarName.waitForExistence(timeout: 5), "\(navigationBarName) exists on screen's navigation bar")
    }
    
    func assertAlert(title: String) {
        let alertTitle = popupWindow.staticTexts[title]
        XCTAssertTrue(popupWindow.waitForExistence(timeout: 5), "\(popupWindow) exits")
        XCTAssertTrue(alertTitle.exists, "\(alertTitle) of \(popupWindow) exists")
    }
    
    func assertCellIsSelected(pos: Int, title: String, state: String) {
        let navigatorCell = app.windows.otherElements.tables.cells.element(boundBy: pos)
        let navigatorTitle = navigatorCell.children(matching: .staticText).element(matching: .staticText, identifier: title)
        let checkBox = navigatorCell.children(matching: .image).element(matching: .image, identifier: "cell_image_view")
        XCTAssertTrue(navigatorCell.waitForExistence(timeout: 5), "\(navigatorCell) exists in the table")
        XCTAssertTrue(navigatorTitle.waitForExistence(timeout: 5), "\(navigatorTitle) exists in the table")
        XCTAssertEqual(checkBox.value as! String, state, "\(checkBox) with specific state exists")
    }
}
