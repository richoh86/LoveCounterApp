//
//  AppDelegate.swift
//  LoveCounterApp
//
//  Created by richard oh on 07/03/2019.
//  Copyright © 2019 richard oh. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
// UNUserNotificationCenterDelegate
    // UIWindow에서 모든 VC를 관리하고 있다 참고할 것.
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // LaunchScreen 2초간 보여줄 것
        Thread.sleep(forTimeInterval: 2)
        
        // 1. 앱 사용이 처음인 경우 false: 연인이된 날짜, 생일 정보를 입력하도록 3단계 뷰로 이동.
        // 2. 앱 사용이 처음이 아닌 경우 true: 이전에 입력된 정보를 기준으로 메인 뷰 이동.
        let firstUseBool = UserDefaults.standard.bool(forKey: "firstUseBool")
        if firstUseBool == true {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mainVC = storyboard.instantiateViewController(withIdentifier: "MainViewController")
            window?.rootViewController = mainVC
        }
        
//        // Push Alarm 권한 요청 및 설정
//        let center = UNUserNotificationCenter.current()
//        let options: UNAuthorizationOptions = [.sound, .alert]
//
//        center.requestAuthorization(options: options) { (granted, error) in
//            if let err = error {
//                print(err.localizedDescription)
//            }else{
//                print(granted)
//                UserDefaults.standard.set(granted, forKey: "pushAlarm")
//            }
//        }
//
//        center.delegate = selč
        
        return true
    }
    
//    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
//        completionHandler([.alert , .sound, .badge])
//    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

