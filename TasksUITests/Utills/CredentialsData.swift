import Foundation

let validLogin = "nikolay192003@gmail.com"
let validLogin1 = "nikolay@yahoo.com"
let validLogin2 = "nikolay@proton.me"
let validLogin3 = "nikolay@ukr.net"
let validLogin4 = "nikolay@seznam.cz"
let validLogin5 = "nikolay@gmx.com"
let validLogin6 = "nikolay@yandex.ru"
let validLogin7 = "nikolay@outlook.com"
let validLogin8 = "nikolay@microsoft.com"
let validLogin9 = "nikolay@mailfence.com"
let validLogin10 = "nikolay@zoho.com"
let validLogin11 = "nikolay@tempmail.plus"
let validLogin12 = "nikolay@10minutemail.org"

let validPassword = "qwerty12345"

let emptyLogin = "Email"
let emptyPassword = "Password"

let invalidLogin = "nikolay192003"
let invalidPassword = "h"

let cyrillic = "николай@gmail.com"
let withoutAtSign = "nikolay192003gmail.com"
let withoutDot = "nikolay192003@gmailcom"
let withSpecialSymbol = "nikolay192003#@gmail.com"
let withSpace = "nikolay 192003@gmail.com"
let mailDomain = "@gmail.com"

var invalidEmails = [cyrillic, withoutAtSign, withoutDot, withSpecialSymbol, withSpace]
var validEmails = [validLogin, validLogin1, validLogin2, validLogin3, validLogin4, validLogin5, validLogin6, validLogin7, validLogin8, validLogin9, validLogin10, validLogin11, validLogin12]
