import Foundation
import XCTest

class HelperMethods: BaseTestCase {
    
    private lazy var closeKeyboardButton = app.keyboards.buttons["return"].firstMatch
    
    func tapCloseKeyboardButton() {
        closeKeyboardButton.tap()
    }
    
    func putAppInBackgroundAndReopen() {
        XCUIDevice.shared.press(.home)
        sleep(1)
        app.activate()
    }
    
    func killAppAndReopen() {
        app.terminate()
        app.launch()
    }
    
    func swipeTheScreenUp() {
        app.swipeUp()
    }
    
    func swipeTheScreenDown() {
        app.swipeDown()
    }
    
    func randomText(length: Int) -> String {
        let allowedChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let allowedCharsCount = UInt32(allowedChars.count)
        var randomString = ""

        for _ in 0 ..< length {
            let randomNum = Int(arc4random_uniform(allowedCharsCount))
            let randomIndex = allowedChars.index(allowedChars.startIndex, offsetBy: randomNum)
            let newCharacter = allowedChars[randomIndex]
            randomString += String(newCharacter)
        }

        return randomString
    }
}

extension XCUIElement {
    func clearText() {
        guard let stringValue = self.value as? String else {
            return
        }
        if let placeholderString = self.placeholderValue, placeholderString == stringValue {
            return
        }
        var deleteString = String()
        for _ in stringValue {
            deleteString += XCUIKeyboardKey.delete.rawValue
        }
        self.typeText(deleteString)
    }
}
