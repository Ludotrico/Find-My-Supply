//
//  AppDelegate.swift
//  Find My Supply
//
//  Created by Ludovico Veniani on 5/1/20.
//  Copyright © 2020 Ludovico Veniani. All rights reserved.
//

import UIKit
import GoogleMobileAds

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        IQKeyboardManager.shared.enableAutoToolbar = true
        IQKeyboardManager.shared.overrideKeyboardAppearance = true
        IQKeyboardManager.shared.keyboardAppearance = .dark
        IQKeyboardManager.shared.shouldToolbarUsesTextFieldTintColor = true
        IQKeyboardManager.shared.keyboardDistanceFromTextField = 70
        
        
        
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        //GADMobileAds.sharedInstance.requestConfiguration.testDeviceIdentifiers = @[kGADSimulatorID]
        
        
        UIApplication.shared.applicationIconBadgeNumber = 0
        UserDefaults.standard.set(UserDefaults.standard.integer(forKey: "openCount")+1, forKey: "openCount")
        
//
//
//
//        for family in UIFont.familyNames.sorted() {
//            let names = UIFont.fontNames(forFamilyName: family)
//            //print("^^^^^Family: \(family) Font names: \(names)")
//        }
        
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        //print("@@@@@@@@@")
        let deviceTokenString = deviceToken.map { String(format: "%02x", $0) }.joined()
        
        DispatchQueue.global(qos: .userInitiated).async {
            UpdateUser.shared.registrationID = deviceTokenString
            UpdateUser.shared.addRegistrationID { (result) in
                switch result {
                case .success(_):
                    //print("@@@@@@success")
                    UserDefaults.standard.set(true, forKey: "hasRegisteredID")
                case .failure(let error):
                    print("DEBUG: Failed with error \(error)")
                    
                }
            }
        }
        
        
        
        //print("@@@@@@@: \(deviceTokenString)")
        
    }
    
    
}

