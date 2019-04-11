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
        
        // 푸쉬 알람 설정이 켜져있는 경우만 등록
        guard let pushAlarm = UserDefaults.standard.value(forKey: "pushAlarm") as? Bool, pushAlarm == true else {return}
        
            // 알람설정 공통 로직
            // 현재 등록되어 있는 모든 알람을 모두 삭제하고
            // 마지막으로 설정된 날짜로 다시 알람 설정을 수행
            let center = UNUserNotificationCenter.current()
        
            center.removeAllDeliveredNotifications()
            center.removeAllPendingNotificationRequests()
        
//            center.removeDeliveredNotifications(withIdentifiers: ["content"])
//            center.removePendingNotificationRequests(withIdentifiers: ["content"])

        var requests: [UNNotificationRequest] = []
        
        if let selDate = UserDefaults.standard.value(forKey: "selDate") as? Date {
        
            // -------------------------------------------------//
            // 1,2,3... 주년 단위 푸쉬 알람 설정 (동일 날짜로 반복하면 가능) //
            // -------------------------------------------------//
            let dCpntsForSeldate = Calendar.current.dateComponents([.year], from: selDate)
            let dCpntsForCurDate = Calendar.current.dateComponents([.year], from: Date())
            var yearDifCnt = 0
            
            if let yearOfSelDate = dCpntsForSeldate.year,
                let yearOfCurDate = dCpntsForCurDate.year{
                yearDifCnt = yearOfCurDate - yearOfSelDate
            }
            
            // 0이 아니면 수행 0주년은 없음.
            if yearDifCnt != 0 {
            
            let body = "💝 \(yearDifCnt)주년"
            
            let content = makeUnmutableNotiContent(title: "LoveCounter", subtitle: nil, body: body, threadIdentifier: "\(yearDifCnt)YearlyAlarm")
            let dateComponents = makeDatecomponents(date: selDate)
            let request = makeTriggerAndRequestForLocalNotification(repeatsForTrigger: true, dateComponents: dateComponents,identifier: "\(yearDifCnt)YearlyAlarm" ,content: content)
            
            requests.append(request)
                
            }
            // -------------------------------------------------//
            // 100, 200 ... 일 단위 푸쉬 알람설정.                   //
            // -------------------------------------------------//
            var daysOf100: [Date] = []
            var daysOf100s: [Date] = []
            var daysInt: [Int] = []
            let curDate = Date()
            
            // 100일 단위 Int 배열에 담기
            for i in 100..<11000 {
                if i % 100 == 0 {
                    daysInt.append(i)
                }
            }
            
            // 선택한 날짜로 부터 100,200.. 후 날짜 배열에 담기
            for i in daysInt {
                var dateComponents = DateComponents()
                dateComponents.day = i - 1
                let resultDate = Calendar.current.date(byAdding: dateComponents, to: selDate)
                
                // 1. 우선 100, 200.. 단위의 날짜가 현재 날짜보다 미래인 경우만 등록
                if let date = resultDate, date > curDate {
                    daysOf100.append(date)
                }
            }
            
            // 2. 현재날짜로부터 100일 후 날짜보다 작은 100일 단위 날짜들만 등록 가능
            // => 2개씩만 등록
            var dateComp = DateComponents()
            dateComp.day = 100
            if let limitedDate = Calendar.current.date(byAdding: dateComp, to: curDate) {
                print("limitedDate 300일 후 날짜", limitedDate)
             daysOf100s = daysOf100.filter { $0 < limitedDate }
            }
            
            // request 만들어서 배열에 담기
            for date in daysOf100s {
                
                let calendar = Calendar.current
                let future = calendar.startOfDay(for: date)
                let past = calendar.startOfDay(for: selDate)
                let components = calendar.dateComponents([.day], from: past, to: future)
                
                guard let days = components.day else {return}
            
                let body100s = "❤️ \(days + 1)일"
                
                let content100s = makeUnmutableNotiContent(title: "LoveCounter", subtitle: nil, body: body100s, threadIdentifier: "\(days + 1)sAlarm")
                let dateComp100s = makeDatecomponents(date: date)
                let request100s = makeTriggerAndRequestForLocalNotification(repeatsForTrigger: false, dateComponents: dateComp100s, identifier: "\(days + 1)sAlarm", content: content100s)
                
                requests.append(request100s)
            }
        }
        
        // 생일 기념일 푸쉬 알람이 설정된 경우만 넣어줄 것
        let alarm = UserDefaults.standard.bool(forKey: "pushAlarmForBirthAndAnniBool")
        if alarm == true {
        
        // -------------------------------------------------//
        // 본인 생일 푸쉬 알람 설정                               //
        // -------------------------------------------------//
        if let myBirth = UserDefaults.standard.value(forKey: "myBirthDay") as? Date, let name1 = UserDefaults.standard.value(forKey: "name1") as? String{
            
            let dateCompMyBirth = makeDatecomponents(date: myBirth)
            var bodyMyBirth = ""
            if let month = dateCompMyBirth.month,
                let day = dateCompMyBirth.day{
                bodyMyBirth = " 🎁 \(name1)생일 \(month)월 \(day)일"
            }
            let contentMyBirth = makeUnmutableNotiContent(title: "LoveCounter", subtitle: nil, body: bodyMyBirth, threadIdentifier: "myBirthAlarm")
            let requestMyBirth = makeTriggerAndRequestForLocalNotification(repeatsForTrigger: true, dateComponents: dateCompMyBirth, identifier: "myBirthAlarm", content: contentMyBirth)
            
            requests.append(requestMyBirth)
            
        }
        
        // -------------------------------------------------//
        // 내꺼 생일 푸쉬 알람 설정                               //
        // -------------------------------------------------//
        if let yourBirth = UserDefaults.standard.value(forKey: "LoveBirthDay") as? Date,
            let name2 = UserDefaults.standard.value(forKey: "name2") as? String{
            
            let dateCompYourBirth = makeDatecomponents(date: yourBirth)
            var bodyYourBirth = ""
            if let month = dateCompYourBirth.month,
                let day = dateCompYourBirth.day{
                bodyYourBirth = "🎁 \(name2)생일 \(month)월 \(day)일"
            }
            let contentYourBirth = makeUnmutableNotiContent(title: "LoveCounter", subtitle: nil, body: bodyYourBirth, threadIdentifier: "yourBirthAlarm")
            let requestYourBirth = makeTriggerAndRequestForLocalNotification(repeatsForTrigger: true, dateComponents: dateCompYourBirth, identifier: "yourBirthAlarm", content: contentYourBirth)
            
            requests.append(requestYourBirth)
            
        }
          
          // 기념일은 일단 제외
        // -------------------------------------------------//
        // 기념일 푸쉬 알람 설정                                 //
        // -------------------------------------------------//
            if var dateOfAnniversaryDay = UserDefaults.standard.value(forKey: "dateOfAnniversaryDay") as? [String]{

                dateOfAnniversaryDay.remove(at: 0) // 본인생일 제거
                dateOfAnniversaryDay.remove(at: 0) // 내꺼생일 제거

                let nameOfAnniversaryDay: [String] = [
                    "다이어리데이",
                    "발렌타인데이",
                    "화이트데이",
                    "블랙데이",
                    "로즈데이",
                    "키스데이",
                    "실버데이",
                    "그린데이",
                    "포토데이",
                    "와인데이",
                    "무비데이",
                    "허그데이",
                    "크리스마스"
                ]

            // 두 배열의 총 카운트 숫자가 다르면 아래 코드 실행하지 않는다
            guard dateOfAnniversaryDay.count == nameOfAnniversaryDay.count else {return}

            for (index, dateStr) in dateOfAnniversaryDay.enumerated(){

                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "YYYY년 M월 d일"
                dateFormatter.locale = Locale(identifier: "ko_KR")
                if let date = dateFormatter.date(from: dateStr) {

                    let dateCompAnni = makeDatecomponents(date: date)

                    var body = ""
                    if let month = dateCompAnni.month,
                        let day = dateCompAnni.day{
                        body = "\(month)월 \(day)일 \(nameOfAnniversaryDay[index])"
                    }

                    let contentsAnni = makeUnmutableNotiContent(title: "LoveCounter", subtitle: nil, body: body, threadIdentifier: "\(index)AnniAlarm")
                    let requestAnni = makeTriggerAndRequestForLocalNotification(repeatsForTrigger: true, dateComponents: dateCompAnni, identifier: "\(index)AnniAlarm", content: contentsAnni)

                    requests.append(requestAnni)
                }
            }
        }
    }
        
        guard requests.count != 0 else {return}
        
        // 알림 등록 가능한 수량이 제한되어 있음...
        // 찾아보니 64개라고 나오는데...
        // 실제로 등록된 갯수는 12개 더 이상 등록 안되는 것 같음
        // 로직 추가해서 반영 완료
        
        for (index, r) in requests.enumerated() {
            center.add(r) { err in
                if let err = err{
                    print(err.localizedDescription)
                }
                else{
                    print("\(index)개 알람 설정 완료!")
                }
            }
        }
        
        // 등록된 Notifications 확인하기
        center.getDeliveredNotifications { (noti) in
            print("DeliveredNotifications",noti)
        }
        
        center.getPendingNotificationRequests { (noti) in
            print("PendingNotificationRequests", noti)
            print(noti.count)
        }
    }
    
    /// content 만드는 함수 "메세지 내용 및 구성"
    func makeUnmutableNotiContent(title: String, subtitle: String?, body: String, threadIdentifier: String) -> UNMutableNotificationContent{
        
        let content = UNMutableNotificationContent()
        content.title = title
        if let subtitle = subtitle {
        content.subtitle = subtitle
        }
        content.body = body
        content.sound = UNNotificationSound.default
        content.threadIdentifier = threadIdentifier

        return content
    }
    
    /// 선택 날짜 dateComponents 생산 함수
    ///
    /// - Parameter date: 입력 날짜
    /// - Returns: DateComponents
    func makeDatecomponents(date: Date) -> DateComponents{
        
        var dateComponents = Calendar.current.dateComponents([.month,.day], from: date)
        
        dateComponents.hour = 00
        dateComponents.minute = 00
        dateComponents.second = 00
        
        return dateComponents
    }
    
    /// 리퀘스트 만드는 함수
    ///
    /// - Parameters:
    ///   - repeats: 반복 여부 결정
    ///   - dateComponents: DateComponents
    ///   - content: UNMutableNotificationContent
    /// - Returns: UNNotificationRequest
    func makeTriggerAndRequestForLocalNotification(repeatsForTrigger: Bool ,dateComponents: DateComponents, identifier: String, content: UNMutableNotificationContent) -> UNNotificationRequest {
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: repeatsForTrigger)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        return request
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

