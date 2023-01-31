import Foundation
import XCTest

class LoginFormScreen: BaseTestCase {
    
    private lazy var emailField = app.windows.otherElements.textFields["password-text-field"]
    private lazy var passwordField = app.windows.otherElements.secureTextFields.firstMatch
    private lazy var loginButton = app.windows.otherElements.buttons["login-button"].firstMatch
    private lazy var loginLabel = app.windows.otherElements.staticTexts["login-label"].firstMatch
    
    func loginFlow(login: String, pass: String) {
        typeInEmailField(email: login)
        typeInPasswordField(password: pass)
        assertLoginButton(isEnabled: true)
        tapLoginSuccessButton()
        tasksScreen.assertTasksScreen()
    }
    
    func typeInEmailField(email: String) {
        emailField.tap()
        emailField.typeText(email)
        helperMethods.tapCloseKeyboardButton()
        XCTAssertEqual(emailField.value as! String, email, "\(emailField) has user-set value")
    }
    
    func clearTextInEmailField() {
        emailField.tap()
        emailField.clearText()
        helperMethods.tapCloseKeyboardButton()
        XCTAssertEqual(emailField.value as! String, emptyLogin, "\(emailField) has default value")
    }
    
    func typeInPasswordField(password: String) {
        passwordField.tap()
        passwordField.typeText(password)
        helperMethods.tapCloseKeyboardButton()
    }
    
    func tapLoginButton() {
        XCTAssertTrue(loginButton.waitForExistence(timeout: 5), "\(loginButton) exists before tapping on it")
        loginButton.tap()
    }
    
    func tapLoginSuccessButton() {
        tapLoginButton()
        XCTAssertTrue(loginLabel.exists, "\(loginButton) is present while logging in")
        if compositeElements.logoutButton.waitForExistence(timeout: 10) {
            tasksScreen.assertTasksScreen()
        }
        while (compositeElements.popupWindow.waitForExistence(timeout: 3)) { // handling Retry error
            compositeElements.tapAlertPopUpButton(title: errorTitle, button: retry)
        }
    }
    
    func tapLoginFailedButton() {
        tapLoginButton()
        if compositeElements.popupWindow.exists {
            compositeElements.tapAlertPopUpButton(title: errorTitle, button: ok)
        }
    }
    
    func assertLoginButton(isEnabled: Bool) {
        XCTAssertTrue(loginButton.isEnabled == isEnabled, "\(loginButton) is enabled or not after filling login form")
    }
    
    func assertLoginPage() {
        XCTAssertTrue(emailField.isEnabled, "\(emailField) exists on login form screen")
        XCTAssertTrue(passwordField.isEnabled, "\(passwordField) exists on login form screen")
        XCTAssertTrue(loginButton.exists, "\(loginFormScreen) exists on login form screen")
    }
    
    func assertEmailField(email: String = emptyLogin) {
        XCTAssertEqual(emailField.value as! String, email, "\(emailField) has standard value")
    }
    
    func assertPasswordField(password: String = emptyPassword) {
        XCTAssertEqual(passwordField.value as! String, password, "\(passwordField) has standard value")
    }
    
    func assertPasswordFieldIsNotEmpty() {
        XCTAssertNotEqual(passwordField.value as! String, emptyPassword, "\(passwordField) value is not standard")
    }
}
