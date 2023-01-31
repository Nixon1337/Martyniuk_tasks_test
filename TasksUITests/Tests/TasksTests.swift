import Foundation
import XCTest

class TasksTests: BaseTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testCompleteAllCancelAllTasks() {
        completeAllAndCancelAllFilter() // check the state of tasks after tapping on "Complete all" (all tasks are "Done") and "Cancel all" (All tasks are not "Done) buttons on tasks screen
    }
    
    func testCompleteAllCancelAllSleepTasks() {
        tasksScreen.tapOnMoreInfoSleepButton() // tap on "More info" button to display sleep tasks screen
        completeAllAndCancelAllFilter() // check the state of tasks after tapping on "Complete all" (all tasks are "Done") and "Cancel all" (All tasks are not "Done) buttons on sleep tasks screen
    }
    
    func testCheckEachTaskInTasks() {
        tasksScreen.checkNoTasksAreDoneInTasks() // check that all tasks are not "Done" on tasks screen
        XCTExpectFailure("Sometimes different tasks are marked as Done, not the tasks were tapped. BUG-5") { // set the expected failure due to test not behaving properly
            for i in (0...4).reversed() {
                compositeElements.tapCompleteTask(pos: i, title: tasksArray[i], state: selectedState) // tap on cell and check if it is selected
            }
            tasksScreen.checkAllTasksAreDoneInTasks() // check that all tasks are "Done" on tasks screen
            for i in 0...4 {
                compositeElements.tapCompleteTask(pos: i, title: tasksArray[i], state: notSelectedState) // check the cells are not selected
            }
        }
        tasksScreen.checkNoTasksAreDoneInTasks() // check that all tasks are not "Done" on tasks screen
    }
    
    func testCheckEachTaskInSleep() {
        tasksScreen.tapOnMoreInfoSleepButton() // tap on "More info" button to display sleep tasks screen
        sleepTasksScreen.checkNoTasksAreDoneInSleep() // check that all tasks are not "Done" on sleep tasks screen
        XCTExpectFailure("Sometimes different tasks are marked as Done, not the tasks were tapped. BUG-5") { // set the expected failure due to test not behaving properly
            for i in (0...3).reversed() {
                compositeElements.tapCompleteTask(pos: i, title: sleepArray[i], state: selectedState) // tap on cell and check if it is selected
            }
            sleepTasksScreen.checkAllTasksAreDoneInSleep() // check that all tasks are "Done" on sleep tasks screen
            for i in 0...3 {
                compositeElements.tapCompleteTask(pos: i, title: sleepArray[i], state: notSelectedState) // check the cells are not selected
            }
        }
        sleepTasksScreen.checkNoTasksAreDoneInSleep() // check that all tasks are not "Done" on sleep tasks screen
    }
    
    func testCheckSortByNameInTasks() {
        sortByNameFilter() // check the list by default and then sorted on tasks screen
    }
    
    func testCheckSortByNameInSleep() {
        tasksScreen.tapOnMoreInfoSleepButton() // tap on "More info" button to display sleep tasks screen
        sortByNameFilter() // check the list by default and then sorted on sleep tasks screen
    }
    
    // Common steps for several tests
    private func completeAllAndCancelAllFilter() {
        XCTExpectFailure("Sometimes different tasks are marked as Done, not the tasks were tapped. BUG-4") { // set the expected failure due to test not behaving properly
            compositeElements.tapCompleteAllButton() // tap on "Complete all" button
            compositeElements.tapCancelAllButton() // tap on "Cancel all" button
        }
    }
    
    private func sortByNameFilter() {
        compositeElements.assertDefaultSorting() // check the default sorting of list
        compositeElements.tapSortByNameButton() // tap on "Sort"
        XCTExpectFailure("Sort by name does not work correctly. Sometimes it can set the tasks as Done. Also it may not return the default sorting. BUG-3") { // set the expected failure due to test not behaving properly
            compositeElements.assertSortedSorting() // check the sorted list
            compositeElements.tapSortByNameButton() // tap on "Sort" and check the sorted list
            compositeElements.assertDefaultSorting() // check the default sorting of list
        }
    }
}
