import Foundation
import XCTest

public class BaseTestCase: XCTestCase {
    
    public let app = XCUIApplication()
    
    lazy var loginFormScreen = LoginFormScreen()
    lazy var tasksScreen = TasksScreen()
    lazy var sleepTasksScreen = SleepTasksScreen()
    lazy var compositeElements = CompositeElements()
    lazy var helperMethods = HelperMethods()
    
    open override func setUp() {
        app.launch()
        continueAfterFailure = false
        loginFormScreen.loginFlow(login: validLogin, pass: validPassword)
    }
    
    open override func tearDown() {
        compositeElements.tapConfirmLogoutButton()
        app.terminate()
    }
}
