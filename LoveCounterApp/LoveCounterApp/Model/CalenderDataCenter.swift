//
//  CalenderViewDataCenter.swift
//  LoveCounterApp
//
//  Created by richard oh on 15/03/2019.
//  Copyright © 2019 richard oh. All rights reserved.
//

import Foundation

class CalenderDataCenter {
    
    // ---------------------------- //
    //  "커플" 탭1                    //
    // ---------------------------- //
    
    // Int Value for Calcuation
    var countDays: [Int] = []
    // 1. String Value 100일,200일.. + 1주년, 2주년 ..
    var strCountDays: [String] = []
    
    // countDays의 날짜를 연인이 된 날짜에 더한 날짜 date
    var dateDate: [Date] = []
    // 2. countDays의 날짜를 연인이 된 날짜에 더한 날짜 텍스트
    var strDate: [String] = []
    
    // 3. D-Day 현재날짜로 부터 몇일 남았는지 계산한 값
    var strDday: [String] = []
    
    // ---------------------------- //
    //  "기념일" 탭2                   //
    // ---------------------------- //
    
    // 1. 기념일 이름 ex) 발렌타인 데이, 생일
    var nameOfAnniversaryDay: [String] =
        [
            "본인생일",
            "내꺼생일",
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
    
    // 2. 기념일 날짜 ex) 2019년(올해) 3월 14일
    var dateOfAnniversaryDay: [String] = []
    
    // 3. 현재 날짜로 부터 기념일까지 남은 기간 D-day 계산 값
    var dDayOfAnniversaryDay: [String] = []
    
    init() {
        
        calCountDays()
        dateCal()
        
        dateCalForAnniversaryDay()
        
    }
    
    /// "커플" 탭 함수
    /// 30주년까지 100일 단위, 1주년 단위 숫자와 텍스트 값을 배열에 담는다
    func calCountDays() {
        for i in 100..<11000{
            
            if i % 100 == 0 {
                strCountDays.append("\(i)일")
                countDays.append(i)
            }else if i % 365 == 0 {
                strCountDays.append("\(i/365)주년")
                countDays.append(i)
            }
        }
    }
    
    /// "커플" 탭 함수
    /// 100일,200일 계산된 날짜 + 현재날짜로 부터 해당 기념일이 얼마나 남았는지 계산
    func dateCal(){
        
        let date = Date()
        for i in countDays {
            
            // 계산된 날짜 텍스트
            let strDate = date.changeDaysBy(days: i)
            self.strDate.append(strDate)
            
            // 계산된 날짜 Date 타입 (아래 현재날짜로부터 얼마나 남았는지 계산하기 위한 값)
            let calculatedDay = date.getDateAfter(days: i)
            self.dateDate.append(calculatedDay)
        }
        
        // 현재 날짜부터 100일로 계산된 날짜까지 얼마나 남았는지 계산하고 값
        for date in dateDate {
            // 현재 날짜
            let currentDate = Date()
            // 현재날짜로 부터 해당 기념일까지 남은 날짜 계산
            let interval = date.timeIntervalSince(currentDate)
            let days = Int(interval / 86400)
            
            if days > 0 {
                strDday.append("D-\(days)")
            }else{
                strDday.append("D+\(-days)")
            }
        }
    }
    
    /// "기념일" 탭 함수
    /// 기념일 날짜 계산하는 함수
    func dateCalForAnniversaryDay() {
        
        // 1. 본인생일과 내꺼생일을 UserDefault에서 가져와서 String 값으로 넣어준다
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = "MM월 dd일"
        
        let curDate = Date()
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "yyyy년"
        let strCurYear = dateFormatter2.string(from: curDate)
        
        if let myBirthDay = UserDefaults.standard.value(forKey: "myBirthDay") as? Date {
            let strMyBirthDay = dateFormatter1.string(from: myBirthDay)
            dateOfAnniversaryDay.append(strCurYear+" "+strMyBirthDay)
            print("초기저장본인생일",myBirthDay)
        
        }
        
        if let loveBirthDay = UserDefaults.standard.value(forKey: "LoveBirthDay") as? Date {
            let strloveBirthDay = dateFormatter1.string(from: loveBirthDay)
            dateOfAnniversaryDay.append(strCurYear+" "+strloveBirthDay)
            print("초기저장내꺼생일",loveBirthDay)
        }
        
        // 2. 나머지 기념일들은 현재 연도를 year에 넣어주고 나머지 날짜들을 넣어준다
        for i in 1..<13 {
            dateOfAnniversaryDay.append("\(strCurYear) \(i)월 14일")
        }
        // 3. 크리스마스 12월 25일 추가
        dateOfAnniversaryDay.append("\(strCurYear) 12월 25일")
        
        print(dateOfAnniversaryDay.count)
    }
}
extension Date {
    
    /// 연인이된 날짜로 부터 N일 후 날짜 만들기 함수
    ///
    /// - Parameter days: N일
    /// - Returns: 결과 날짜 텍스트
    func changeDaysBy(days : Int) -> String {
        
        if let selectedDate = UserDefaults.standard.value(forKey: "selDate") as? Date{
            var dateComponents = DateComponents()
            dateComponents.day = days - 1
            let resultDate = Calendar.current.date(byAdding: dateComponents, to: selectedDate)!
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy년 MM월 dd일"
            let strResultDay = dateFormatter.string(from: resultDate)
            
            return strResultDay
        }else{
            let currentDate = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy년 MM월 dd일"
            let strResultDay = dateFormatter.string(from: currentDate)
            
            return strResultDay
        }
    }
    
    /// 연인이된 날짜로부터 N일 후 날짜 만들기 함수
    ///
    /// - Parameter days: N일
    /// - Returns: 결과 날짜 Date 타입
    func getDateAfter(days : Int) -> Date {
        
        if let selectedDate = UserDefaults.standard.value(forKey: "selDate") as? Date{
            
            var dateComponents = DateComponents()
            dateComponents.day = days
            let resultDate = Calendar.current.date(byAdding: dateComponents, to: selectedDate)!
            
            return resultDate
        }else{
            let currentDate = Date()
            return currentDate
        }
    }
}