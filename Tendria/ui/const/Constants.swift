//
//  Constants.swift
//  Tendria
//
//  Created by Yakup Kavak on 19.01.2025.
//

import Foundation
import SwiftUI
typealias Height = Constants.Height
typealias Radius = Constants.Radius
typealias StringKey = Constants.StringKeys
typealias IconWidth = Constants.Icon
typealias IconName = Constants.Icons

struct Constants {
    struct Gradients {
        static let mediumOrangeRed: [Color] = [Color.orange700, Color.red300]
    }
    struct Radius{
        static let largeRadius = CGFloat(UIScreen.main.bounds.height * 0.1)
        static let mediumRadius = CGFloat(UIScreen.main.bounds.height * 0.05)
        static let normalRadius = CGFloat(UIScreen.main.bounds.height * 0.01)
    }
    struct Width{
        static let xLargeWidth = CGFloat(50)
        static let largeWidth = UIScreen.main.bounds.width * 0.1
        static let mediumWidth = UIScreen.main.bounds.width * 0.05
        static let xMediumWidth = UIScreen.main.bounds.width * 0.04
        static let normalWidth = UIScreen.main.bounds.width * 0.035
        static let smallWidth = UIScreen.main.bounds.width * 0.02
        static let xSmallWidth = UIScreen.main.bounds.width * 0.015
        static let xxSmallWidth = UIScreen.main.bounds.width * 0.01
        static let smalIconWidth = UIScreen.main.bounds.width * 0.01
    }
    struct Height{
        static let xLargeHeight = UIScreen.main.bounds.height * 0.18
        static let largeHeight = UIScreen.main.bounds.height * 0.1
        static let mediumHeight = UIScreen.main.bounds.height * 0.05
        static let xMediumHeight = UIScreen.main.bounds.height * 0.04
        static let normalHeight = UIScreen.main.bounds.height * 0.035
        static let smallHeight = UIScreen.main.bounds.height * 0.02
        static let xSmallHeight = UIScreen.main.bounds.height * 0.015
        static let xxSmallHeight = UIScreen.main.bounds.height * 0.01
        static let smallIconHeight = UIScreen.main.bounds.height * 0.025
    }
    struct Icon{
        static let normalHeight = UIScreen.main.bounds.height * 0.08
        static let mediumHeight = UIScreen.main.bounds.height * 0.04
        static let smallHeight = UIScreen.main.bounds.height * 0.01
    }
    struct StringKeys {
        static let welcome = LocalizedStringKey("welcome")
        static let signAccount = LocalizedStringKey("sign_account")
        static let username = LocalizedStringKey("username")
        static let password = LocalizedStringKey("password")
        static let forgotPassword = LocalizedStringKey("forgot_password")
        static let create = LocalizedStringKey("create")
        static let dont_account = LocalizedStringKey("dont_account")
        static let signIn = LocalizedStringKey("sign_in")
        static let create_account = LocalizedStringKey("create_account")
        static let email = LocalizedStringKey("email")
        static let already_account = LocalizedStringKey("already_account")
        static let reset_password = LocalizedStringKey("reset_password")
        static let reset = LocalizedStringKey("reset")
        static let full_name = LocalizedStringKey("full_name")
        static let unknown_error = LocalizedStringKey("unknown_error")
        static let error = LocalizedStringKey("error")
        static let success = LocalizedStringKey("success")
        static let email_empty_error = LocalizedStringKey("email_empty_error")
        static let username_empty_error = LocalizedStringKey("username_empty_error")
        static let password_empty_error = LocalizedStringKey("password_empty_error")
        static let full_name_empty_error = LocalizedStringKey("full_name_empty_error")
        static let password_reset_success = LocalizedStringKey("password_reset_success")
        static let user_not_found = LocalizedStringKey("user_not_found")
    }
    

    struct Padding {
        static let largePadding = UIScreen.main.bounds.height * 0.05
        static let mediumPadding = UIScreen.main.bounds.height * 0.02
        static let smallPadding = UIScreen.main.bounds.height * 0.01
    }
    
    struct Icons {
        static let googleIcon = "googleIcon"
        static let appleIcon = "appleIcon"
        static let envelope = "envelope.fill"
        static let lock = "lock.fill"
        static let person = "person.fill"
        static let right_arrow = "arrow.right"
    }
    
}
