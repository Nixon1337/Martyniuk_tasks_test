import Foundation
import XCTest

class LoginTests: BaseTestCase {
    
    override func setUp() {
        app.launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testCheckValidCredentials() {
        for email in validEmails {
            loginFormScreen.typeInEmailField(email: email) // type array valid emails in Email field
            loginFormScreen.typeInPasswordField(password: validPassword) // type valid "qwerty12345" password in Password field
            loginFormScreen.assertLoginButton(isEnabled: true) // check if login button is enabled after filling the login form
            loginFormScreen.tapLoginButton()
            XCTExpectFailure("Retry pop-up error during login via valid credentials. BUG-6") {
                tasksScreen.assertTasksScreen() // check if task screen elements are displayed after successful login
                XCTFail("Retry pop-up error is displayed")
            }
            compositeElements.tapConfirmLogoutButton() // log out from tasks screen and assert Login screen is displayed
        }
    }
    
    func testEmptyFields() {
        loginFormScreen.assertEmailField() // check if default email field had default "Email" title
        loginFormScreen.assertPasswordField() // check if default password field had default "Password" title
        loginFormScreen.assertLoginButton(isEnabled: false) // check if Login button is not enabled
        loginFormScreen.typeInEmailField(email: validLogin) // enter valid login in email text field
        loginFormScreen.assertLoginButton(isEnabled: false) // check if Login button is not enabled after entering valid login
        loginFormScreen.tapLoginFailedButton() // tap Login button that is not enabled
        loginFormScreen.assertLoginPage() // check that the user left on login screen
        loginFormScreen.clearTextInEmailField() // clear the email field
        loginFormScreen.typeInPasswordField(password: validPassword) // type valid password in password field
        loginFormScreen.assertLoginButton(isEnabled: false) // check if Login button is not enabled after entering valid password
        loginFormScreen.tapLoginFailedButton() // tap Login button that is not enabled
        loginFormScreen.assertLoginPage() // check that the user left on login screen
    }
    
    func testLoginWithInvalidCredentials() {
        loginFormScreen.typeInEmailField(email: invalidLogin) // type invalid login in email field
        loginFormScreen.typeInPasswordField(password: invalidPassword) // type invalid password in password field
        loginFormScreen.assertLoginButton(isEnabled: true) // check if login button is enabled after filling the login form
        loginFormScreen.tapLoginFailedButton() // tap on Login button and check for error pop-up appeared
        loginFormScreen.assertLoginPage() // check that the user left on login screen
    }
    
    func testInvalidCredentialsInEmailField() {
        loginFormScreen.typeInPasswordField(password: validPassword) // type valid password in password field
        for email in invalidEmails {
            loginFormScreen.typeInEmailField(email: email) // type invalid login from array of invalid emails
            loginFormScreen.assertLoginButton(isEnabled: true) // check if login button is enabled after filling the login form
            loginFormScreen.tapLoginFailedButton() // tap on Login button and check for error pop-up appeared
            loginFormScreen.assertLoginPage() // check that the user left on login screen
            loginFormScreen.clearTextInEmailField() // clear the email field
        }
    }
    
    func testLoginGreatDealOfCharactares() {
        loginFormScreen.typeInEmailField(email: helperMethods.randomText(length: 500) + mailDomain) // type 500 characters in email field
        loginFormScreen.typeInPasswordField(password: helperMethods.randomText(length: 500)) // type 500 characters inpassword field
        loginFormScreen.assertLoginButton(isEnabled: true) // check if login button is enabled after filling the login form
        XCTExpectFailure("User is logged with enormous amount of characters in login field and password field. BUG-7") { // set the expected failure due to test not behaving properly
            loginFormScreen.tapLoginFailedButton() // tap on Login button and check for error pop-up appeared
            loginFormScreen.assertLoginPage() // check that the user left on login screen
        }
    }
}
