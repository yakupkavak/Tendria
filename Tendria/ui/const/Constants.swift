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
typealias Width = Constants.Width
typealias FireStorage = Constants.FirestorageConst
typealias FireDatabase = Constants.FirestoreConst
typealias Numbers = Constants.Numbers
typealias TextWith = Constants.TextWidth
typealias ImageSet = Constants.Images
typealias LottieSet = Constants.Lotties
typealias ImageWidth = Constants.ImageWidth
typealias StringValues = Constants.StringValues
typealias FunctionName = Constants.FunctionName
typealias Spacing = Constants.Spacing
typealias GradientSet = Constants.Gradients
typealias KeychainKeys = Constants.KeychainKeys
typealias NotificationKey = Constants.NotificationConst
typealias MaliFont = Constants.MaliFont

struct Constants {
    struct Gradients {
        static let mediumOrangeRed: [Color] = [Color.orange700, Color.red300]
    }
    struct Radius{
        static let xLargeRadius = CGFloat(UIScreen.main.bounds.height * 0.1)
        static let largeRadius = CGFloat(UIScreen.main.bounds.height * 0.05)
        static let mediumRadius = CGFloat(UIScreen.main.bounds.height * 0.03)
        static let shadowRadius = CGFloat(UIScreen.main.bounds.height * 0.005)
        static let shadowConstantRadiud = CGFloat(4)
        static let shadowSmallRadius = CGFloat(UIScreen.main.bounds.height * 0.0025)

    }
    struct TextWidth {
        static let tfNormalWidth = UIScreen.main.bounds.width * 0.75
        static let titleWidth = UIScreen.main.bounds.width * 0.5
    }
    
    struct ImageWidth {
        static let largeWidth = UIScreen.main.bounds.width * 0.65
        static let halfWidth = UIScreen.main.bounds.width * 0.5
    }
    
    struct Width{
        static let buttonWidth = UIScreen.main.bounds.width * 0.6
        static let buttonConstantMediumWidth = 12
        static let screenEightyWidth = UIScreen.main.bounds.width * 0.8
        static let screenSeventyWidth = UIScreen.main.bounds.width * 0.7
        static let screenHalfWidth = UIScreen.main.bounds.width * 0.5
        static let buttonMediumWidth = UIScreen.main.bounds.width * 0.36
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
        static let xxLargePlusHeight = UIScreen.main.bounds.height * 0.30
        static let xxLargeHeight = UIScreen.main.bounds.height * 0.18
        static let xLargeHeight = UIScreen.main.bounds.height * 0.13
        static let largeHeight = UIScreen.main.bounds.height * 0.1
        static let mediumPlusHeight = UIScreen.main.bounds.height * 0.075
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
    struct StringValues{
        static let RELATION_CODE_PLACEHOLDER = "XXXXXX"
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
        
        /* Task Screen*/
        static let collection_name = LocalizedStringKey("collection_name")
        static let collection_comment = LocalizedStringKey("collection_comment")
        static let task_name = LocalizedStringKey("task_name")
        static let note = LocalizedStringKey("note")
        static let title = LocalizedStringKey("title")
        static let add_collection = LocalizedStringKey("add_collection")
        static let add_task = LocalizedStringKey("add_task")
        static let add = LocalizedStringKey("add")
        
        /* User Information Screen*/
        static let personal_info = LocalizedStringKey("personal_info")
        static let make_relation = LocalizedStringKey("make_relation")
        static let exist_relation = LocalizedStringKey("exist_relation")
        static let change_password = LocalizedStringKey("change_password")
        static let notifications = LocalizedStringKey("notifications")
        static let settings = LocalizedStringKey("settings")
        static let log_out = LocalizedStringKey("log_out")
        
        /* Create Relation*/
        static let create_relation_title = LocalizedStringKey("create_relation_title")
        static let generate_code = LocalizedStringKey("generate_code")
        static let enter_code = LocalizedStringKey("enter_code")
        static let choose_one = LocalizedStringKey("choose_one")
        
        /* Alert*/
        static let notification = LocalizedStringKey("notification")
        static let notification_subtext = LocalizedStringKey("notification_subtext")
        static let turn_on = LocalizedStringKey("turn_on")
        static let skip_for_now = LocalizedStringKey("skip_for_now")
        static let cancel = LocalizedStringKey("cancel")
        static let ok = LocalizedStringKey("ok")
        
        /* Crop View */
        static let save = LocalizedStringKey("save")
        static let crop_title = LocalizedStringKey("crop_text")
        
        /*New relation Alert*/
        static let new_relation_title = LocalizedStringKey("new_relation_title")
        static let new_relation_subtext = LocalizedStringKey("new_relation_subtext")
        static let new_relation_subtext_string = "new_relation_subtext"
        static let continue_text = LocalizedStringKey("continue")
        
        /*Collection and Memory*/
        static let noneCollectionTitle = LocalizedStringKey("none_collection_title")
        static let noneCollectionText = LocalizedStringKey("none_collection_text")
        static let noneMemoryTitle = LocalizedStringKey("none_memory_title")
        static let noneMemoryText = LocalizedStringKey("none_memory_text")
        static let noneRelationTitle = LocalizedStringKey("none_relation_title")
        static let noneRelationText = LocalizedStringKey("none_relation_text")
    }
    struct Spacing {
        static let normalSpacing = UIScreen.main.bounds.height * 0.02
        static let small = UIScreen.main.bounds.width * 0.01
    }

    struct Padding {
        static let constantMinusMediumPadding = CGFloat(-16)
        static let constantMinusLargePadding = CGFloat(-64)
        static let constantLargePadding = CGFloat(32)
        static let constantMediumPadding = CGFloat(22)
        static let constantXLargePadding = CGFloat(280)
        static let constantXSmallPadding = CGFloat(4)
        static let horizontalXLargePadding = UIScreen.main.bounds.width * 0.4
        static let horizontalLargePadding = UIScreen.main.bounds.width * 0.2
        static let horizontalNormalPlusPadding = UIScreen.main.bounds.width * 0.15
        static let horizontalNormalPadding = UIScreen.main.bounds.width * 0.1
        static let horizontalMediumPadding = UIScreen.main.bounds.width * 0.075
        static let horizontalSmallPadding = UIScreen.main.bounds.width * 0.03
        static let horizontalXSmallPadding = UIScreen.main.bounds.width * 0.005

        static let largePadding = UIScreen.main.bounds.height * 0.05
        static let mediumPadding = UIScreen.main.bounds.height * 0.02
        static let smallPadding = UIScreen.main.bounds.height * 0.01
        static let leadingMediumPadding = CGFloat(12)
    }
    struct Images {
        static let MAKE_RELATION = "MakeRelation"
        static let PIKACHU = "pikachu"
        static let NOTIFICATION = "notification"
    }
    struct Lotties {
        static let BEAR_CAT_JSON = "bearandcat"
        static let BEAR_CAT_DJSON = "bearCatLottie"
        static let FIREWORK_JSON = "havaifişek"
        static let CONFETTI_JSON = "konfeti"
        static let LOADING_CIRCLE_JSON = "loadingcircle"
        static let NO_DATA_FOUND_JSON = "noDataFound"
        static let HEART_LOADING = "heartloading"
        static let GIVE_HEART = "giveHeart"
    }
    
    struct Icons {
        static let googleIcon = "googleIcon"
        static let appleIcon = "appleIcon"
        static let imageUploadIcon = "uploadImage"
        static let envelope = "envelope.fill"
        static let lock = "lock.fill"
        static let person = "person.fill"
        static let right_arrow = "arrow.right"
        static let heart = "heart.fill"
    }
    
    struct FirestoreConst {
        static let COLLECTION_PATH = "Collection"
        static let RELATION_CODE_PATH = "RelationCode"
        static let RELATIONSHIP_PATH = "Relationship"
        static let USERS_PATH = "Users"
        static let USER_ID_FIELD = "userId"
        static let USER_RELATION_ID = "relationId"
        static let USER_IMAGE_FIELD = "profileImage"
        static let FCM_TOKEN_FIELD = "fcmToken"
        static let USER_LANGUAGE = "userLanguage"
    }
    struct FirestorageConst {
        static let LIST_PATH = "list"
        static let TASK_PATH = "task"
    }
    struct Numbers{
        static let RANDOM_COUNT = 6
    }
    struct FunctionName{
        static let CHECK_RELATION = "checkRelationCode"
        static let CHECK_AND_ADD_RELATION = "checkAndAddRelation"
    }
    struct KeychainKeys{
        static let FCM_TOKEN = "fcmToken"
    }
    struct NotificationConst{
        static let TYPE = "alertType"
        static let NEW_RELATION = "NewRelationship"
        static let SHOW_NEW_REALTION = "ShowNewRelation"
    }
    struct MaliFont {
        static let Regular = "Mali-Regular"
        static let Italic = "Mali-Italic"
        static let ExtraLight = "Mali-ExtraLight"
        static let ExtraLightItalic = "Mali-ExtraLightItalic"
        static let Light = "Mali-Light"
        static let LightItalic = "Mali-LightItalic"
        static let Medium = "Mali-Medium"
        static let MediumItalic = "Mali-MediumItalic"
        static let SemiBold = "Mali-SemiBold"
        static let SemiBoldItalic = "Mali-SemiBoldItalic"
        static let Bold = "Mali-Bold"
        static let BoldItalic = "Mali-BoldItalic"
    }
}
