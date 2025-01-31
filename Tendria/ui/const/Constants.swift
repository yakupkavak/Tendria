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
typealias Strings = Constants.Strings
typealias IconWidth = Constants.Icon

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
        static let xLargeHeight = CGFloat(50)
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
        static let mediumHeight = UIScreen.main.bounds.height * 0.04
    }
    struct Strings {
        static let welcome = LocalizedStringKey("welcome")
        static let signAccount = LocalizedStringKey("sign_account")
        static let username = LocalizedStringKey("username")
        static let password = LocalizedStringKey("password")
        static let forgotPassword = LocalizedStringKey("forgot_password")
        static let create = LocalizedStringKey("create")
        static let dontAccount = LocalizedStringKey("dont_account")
        static let signIn = LocalizedStringKey("sign_in")
        static let createAccount = LocalizedStringKey("create_account")
        static let email = LocalizedStringKey("email")
        static let alreadyAccount = LocalizedStringKey("already_account")
        static let resetPassword = LocalizedStringKey("reset_password")
        static let reset = LocalizedStringKey("reset")
        static let full_name = LocalizedStringKey("full_name")
        static let unknown_error = LocalizedStringKey("unknown_error")
    }

    struct Padding {
        static let largePadding = UIScreen.main.bounds.height * 0.05
        static let mediumPadding = UIScreen.main.bounds.height * 0.02
        static let smallPadding = UIScreen.main.bounds.height * 0.01
    }
    
}
