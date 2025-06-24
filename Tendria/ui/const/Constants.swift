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
typealias Icons = Constants.Icons
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
typealias Padding = Constants.Padding
typealias Threshold = Constants.Threshold
typealias ZIndex = Constants.ZIndex
typealias Scale = Constants.Scale
typealias OffsetValue = Constants.OffsetValue
typealias FontValue = Constants.FontValues
typealias Tables = Constants.Tables

struct Constants {
    struct Gradients {
        static let mediumOrangeRed: [Color] = [Color.orange700, Color.red300]
    }
    struct Threshold {
        static let swipeImageRight = CGFloat(50)
        static let swipeImageLeft = CGFloat(-50)
    }
    struct Radius{
        static let xLargeRadius = CGFloat(UIScreen.main.bounds.height * 0.1)
        static let largeRadius = CGFloat(UIScreen.main.bounds.height * 0.05)
        static let mediumRadius = CGFloat(UIScreen.main.bounds.height * 0.03)
        static let borderRadius = CGFloat(16)
        static let shadowRadius = CGFloat(2)
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
    
    struct Spacing {
        static let normalSpacing = UIScreen.main.bounds.height * 0.02
        static let small = UIScreen.main.bounds.width * 0.01
    }
    struct ZIndex {
        static let top: Double = 2.0
        static let below: Double = 1.0
    }
    
    struct Scale {
        static let main: Double = 1.0
        static let sub: Double = 0.9
    }
    struct OffsetValue {
        static let deleteImageX = CGFloat(7)
        static let deleteImageY = CGFloat(4)
        static let leftIcon = CGFloat(14)
        static let rightIcon = CGFloat(-14)
    }

    struct Padding {
        static let constantMinusMediumPadding = CGFloat(-16)
        static let constantMinusLargePadding = CGFloat(-64)
        static let constantMinusXLargePadding = CGFloat(-100)
        static let customButtonPadding = CGFloat(36)
        static let constantLargePadding = CGFloat(32)
        static let constantMediumPadding = CGFloat(22)
        static let constantLightPadding = CGFloat(18)
        static let constantNormalPadding = CGFloat(16)
        static let leadingMediumPadding = CGFloat(12)
        static let e = CGFloat(8)
        static let constantXSmallPadding = CGFloat(4)
        static let constantXLargePadding = CGFloat(280)
        static let horizontalXLargePadding = UIScreen.main.bounds.width * 0.4
        static let horizontalLargePadding = UIScreen.main.bounds.width * 0.2
        static let horizontalNormalPlusPadding = UIScreen.main.bounds.width * 0.15
        static let horizontalNormalPadding = UIScreen.main.bounds.width * 0.1
        static let horizontalMediumPadding = UIScreen.main.bounds.width * 0.075
        static let horizontalSmallPadding = UIScreen.main.bounds.width * 0.03
        static let horizontalXSmallPadding = UIScreen.main.bounds.width * 0.005
        static let rowPadding = CGFloat(30)
        static let rowPaddingSmall = CGFloat(12)

        static let largePadding = UIScreen.main.bounds.height * 0.05
        static let mediumPadding = UIScreen.main.bounds.height * 0.02
        static let smallPadding = UIScreen.main.bounds.height * 0.01
    }
    
    struct Width{
        static let buttonWidth = UIScreen.main.bounds.width * 0.6
        static let buttonConstantMediumWidth = 12
        static let screenEightyWidth = UIScreen.main.bounds.width * 0.8
        static let screenSeventyWidth = UIScreen.main.bounds.width * 0.7
        static let screenSixtyWidth = UIScreen.main.bounds.width * 0.6
        static let screenHalfWidth = UIScreen.main.bounds.width * 0.5
        static let screenFourtyWidth = UIScreen.main.bounds.width * 0.4
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
        static let bottomSheetHeight = CGFloat(300)
        static let ultraLargeHeight = UIScreen.main.bounds.height * 0.6
        static let xxxLargeHeight = UIScreen.main.bounds.height * 0.30
        static let uploadHighHeight = UIScreen.main.bounds.height * 0.25
        static let xxLargePlusHeight = UIScreen.main.bounds.height * 0.20
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
        
        /* Add Memory*/
        static let add_memory = LocalizedStringKey("add_memory")
        static let date = LocalizedStringKey("date")
        static let memory_name = LocalizedStringKey("memory_name")
        static let memory_comment = LocalizedStringKey("memory_comment")
        static let select_date = LocalizedStringKey("select_date")
        static let memory_added = LocalizedStringKey("memory_added")
        static let comment_title = LocalizedStringKey("comment_title")
        static let none_comment = LocalizedStringKey("none_comment")
        
        /*Days*/
        static let monday = LocalizedStringKey("monday")
        static let tuesday = LocalizedStringKey("tuesday")
        static let wednesday = LocalizedStringKey("wednesday")
        static let thursday = LocalizedStringKey("thursday")
        static let friday = LocalizedStringKey("friday")
        static let saturday = LocalizedStringKey("saturday")
        static let sunday = LocalizedStringKey("sunday")
        
        /* Months */
        static let january = LocalizedStringKey("january")
        static let february = LocalizedStringKey("february")
        static let march = LocalizedStringKey("march")
        static let april = LocalizedStringKey("april")
        static let may = LocalizedStringKey("may")
        static let june = LocalizedStringKey("june")
        static let july = LocalizedStringKey("july")
        static let august = LocalizedStringKey("august")
        static let september = LocalizedStringKey("september")
        static let october = LocalizedStringKey("october")
        static let november = LocalizedStringKey("november")
        static let december = LocalizedStringKey("december")
        
        /*Event Screen*/
        static let eventTitle = LocalizedStringKey("event_title")
        static let selectTime = LocalizedStringKey("select_time")
        static let selectDate = LocalizedStringKey("select_date")
        static let category = LocalizedStringKey("category")
        static let tenMinuteTimer = LocalizedStringKey("ten_minute_timer")
        static let repeatKey = LocalizedStringKey("repeat")
        static let other = LocalizedStringKey("other")
        static let from = LocalizedStringKey("from")
        static let to = LocalizedStringKey("to")
        static let accept = LocalizedStringKey("accept")
        static let sameTimeError = LocalizedStringKey("sameTimeError")
        static let startHour = LocalizedStringKey("startHour")
        static let endHour = LocalizedStringKey("endHour")
        static let addNewCategory = LocalizedStringKey("addNewCategory")
        static let categoryName = LocalizedStringKey("categoryName")
        static let categoryColor = LocalizedStringKey("categoryColor")
        
    }

    struct Images {
        static let MAKE_RELATION = "MakeRelation"
        static let PIKACHU = "pikachu"
        static let NOTIFICATION = "notification"
    }
    
    struct Tables {
        static let days = [
            StringKey.sunday,
            StringKey.monday,
            StringKey.tuesday,
            StringKey.wednesday,
            StringKey.thursday,
            StringKey.friday,
            StringKey.saturday
        ]
        
        static let months = [
            StringKey.january,
            StringKey.february,
            StringKey.march,
            StringKey.april,
            StringKey.may,
            StringKey.june,
            StringKey.july,
            StringKey.august,
            StringKey.september,
            StringKey.october,
            StringKey.november,
            StringKey.december
        ]
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
        static let left_direction = "chevron.left"
        static let right_direction = "chevron.right"
        static let heart = "heart.fill"
        static let close = "xmark"
    }
    
    struct FirestoreConst {
        static let COLLECTION_PATH = "Collection"
        static let RELATION_CODE_PATH = "RelationCode"
        static let RELATIONSHIP_PATH = "Relationship"
        static let MEMORY_PATH = "Memory"
        static let USERS_PATH = "Users"
        static let USER_ID_FIELD = "userId"
        static let RELATION_ID = "relationId"
        static let COLLECTION_ID = "collectionId"
        static let USER_IMAGE_FIELD = "profileImage"
        static let FCM_TOKEN_FIELD = "fcmToken"
        static let USER_LANGUAGE = "userLanguage"
    }
    struct FirestorageConst {
        static let COLLECTION_PATH = "collection"
        static let MEMORY_PATH = "memory"
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
    struct FontValues {
        static let bigIconSize = CGFloat(28)
    }
}
