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
    // 하트이미지 삽입 로우 계산
    var heartIndex: Int?
    
    // countDays의 날짜를 연인이 된 날짜에 더한 날짜 date
    var dateDate: [Date] = []
    // 2. countDays의 날짜를 연인이 된 날짜에 더한 날짜 텍스트
    var strDate: [String] = []
    
    // 3. D-Day 현재날짜로 부터 몇일 남았는지 계산한 값
    var strDday: [String] = []
    
    var dDay: [Int] = []
    var dDayPlus: [Int] = []
    
    // ---------------------------- //
    //  "기념일" 탭2                   //
    // ---------------------------- //
    
    // 1. 기념일 이름 ex) 발렌타인 데이, 생일
//    var nameOfAnniversaryDay: [String] =
//        [
//            "본인생일",
//            "내꺼생일",
//            "다이어리데이",
//            "발렌타인데이",
//            "화이트데이",
//            "블랙데이",
//            "로즈데이",
//            "키스데이",
//            "실버데이",
//            "그린데이",
//            "포토데이",
//            "와인데이",
//            "무비데이",
//            "허그데이",
//            "크리스마스"
//
//        ]
    
    var nameOfAnniversaryDay: [String] =
        [
            "Your Birthday",
            "Lover Birthday",
            "Diary Day",
            "Valentine's Day",
            "White Day",
            "Black Day",
            "Rose Day",
            "Kiss Day",
            "Silver Day",
            "Green Day",
            "Photo Day",
            "Wine Day",
            "Movie Day",
            "Hug Day",
            "Christmas"    
    ]
    
    // 2. 기념일 날짜 ex) 2019년(올해) 3월 14일
    var dateOfAnniversaryDay: [String] = []
    
    // 3. 현재 날짜로 부터 기념일까지 남은 기간 D-day 계산 값
    var dDayOfAnniversaryDay: [String] = []
    
    var aDday: [Int] = []
    var aDdayPlus: [Int] = []
    var aHeartIndex: Int?
    
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
//                strCountDays.append("\(i)일")
                strCountDays.append("\(i) Days")
                countDays.append(i)
            }else if i % 365 == 0 {
                strCountDays.append("\(i/365) Year 💝")
                countDays.append(i)
            }
        }
    }
    
    /// "커플" 탭 함수
    /// 100일,200일 계산된 날짜 + 현재날짜로 부터 해당 기념일이 얼마나 남았는지 계산
    func dateCal(){
        
        let date = Date()
        var strOfselectedDate = ""
        var strOfselectedDateForYear = ""
        var year = 0
        
        let dateFormatter = DateFormatter()
        let dateFormatterForYear = DateFormatter()
        let dateFormatterAll = DateFormatter()
        
//        dateFormatter.dateFormat = "MM월 dd일"
//        dateFormatterForYear.dateFormat = "YYYY년"
//        dateFormatterAll.dateFormat = "YYYY년 MM월 dd일"
        dateFormatter.dateFormat = "M ▪︎ d"
        dateFormatterForYear.dateFormat = "YYYY"
        dateFormatterAll.dateFormat = "YYYY ▪︎ M ▪︎ d"

        
        if let selectedDate = UserDefaults.standard.value(forKey: "selDate") as? Date {
            strOfselectedDate = dateFormatter.string(from: selectedDate)
            strOfselectedDateForYear = dateFormatterForYear.string(from: selectedDate)
            
//            year = Int(strOfselectedDateForYear.dropLast())!
            year = Int(strOfselectedDateForYear)!
        }
        
        for i in countDays {
            
            // 1주년 단위 계산된 날짜 텍스트
            if i % 365 == 0 {
                
//                let strDate = "\(year+1)년 "+strOfselectedDate
                let strDate = "\(year+1) ▪︎ "+strOfselectedDate
                self.strDate.append(strDate)
                year += 1
                // 계산된 날짜 Date 타입 (아래 현재날짜로부터 얼마나 남았는지 계산하기 위한 값)   
                if let dateYealy = dateFormatterAll.date(from: strDate) {
                    
                    let dateY = dateYealy.getDateAfterForYealyDateCount(days: 1, yealyDate: dateYealy)
                    self.dateDate.append(dateY)
                }
                
            // 100,200,... 계산된 날짜 텍스트
            }else{
                let strDate = date.changeDaysBy(days: i)
                self.strDate.append(strDate)
                
                // 계산된 날짜 Date 타입 (아래 현재날짜로부터 얼마나 남았는지 계산하기 위한 값)
                let calculatedDay = date.getDateAfter(days: i)
                self.dateDate.append(calculatedDay)
            }
            
            
        }
        
        // 현재 날짜부터 100일로 계산된 날짜까지 얼마나 남았는지 계산하고 값
        for date in dateDate {
            
            // 현재 날짜
            let currentDate = Date()
            let calendar = Calendar.current
            let date1 = calendar.startOfDay(for: date)
            let date2 = calendar.startOfDay(for: currentDate)
            let components = calendar.dateComponents([.day], from: date2, to: date1)
            
            guard let days = components.day else {return}
            
            // 오늘 날짜보다 미래인 경우
            if days > 0 {
                let days1 = days - 1
                if days1 == 0 {
                    strDday.append("D-Day!")
                    dDay.append(days1)
                }else{
                    strDday.append("D-\(days - 1)")
                    dDay.append(days - 1)
                }
            // 오늘 날짜와 동일한 경우
            }else if days == 0 {
                strDday.append("D-Day")
                dDay.append(days)
            // 오늘 날짜보다 과거인 경우
            }else{
                let days1 = days - 1
                strDday.append("D+\(-days1)")
                dDay.append(days1)
            }
        }
    
        // 날짜 중에서 0과 양수 값만 남긴다
        for (index, d) in dDay.enumerated(){
           print("원석", index, d)
            if d >= 0 {
                dDayPlus.append(d)
            }
        }
        
        // 0과 양수 값 중에서 가장 작은 최소값을 구해서 index를 저장한다
        if let minNum = dDayPlus.min(){
            print("최소값", minNum)
            let str = "D-\(minNum)"
            if strDday.contains(str){
                let index = strDday.firstIndex(of: str)
                heartIndex = index
            }else{
                let index = strDday.firstIndex(of: "D-Day!")
                heartIndex = index
            }
        }
    }
    
    /// "기념일" 탭 함수
    /// 기념일 날짜 계산하는 함수
    /// 기념일 날짜 D-Day 계산하는 로직 추가
    func dateCalForAnniversaryDay() {
        
        // 1. 본인생일과 내꺼생일을 UserDefault에서 가져와서 String 값으로 넣어준다
        let dateFormatter1 = DateFormatter()
//        dateFormatter1.dateFormat = "MM월 dd일"
        dateFormatter1.dateFormat = "M ▪︎ d"
        
        let curDate = Date()
        let dateFormatter2 = DateFormatter()
//        dateFormatter2.dateFormat = "yyyy년"
        dateFormatter2.dateFormat = "yyyy ▪︎ "
        let strCurYear = dateFormatter2.string(from: curDate)
        
        if let myBirthDay = UserDefaults.standard.value(forKey: "myBirthDay") as? Date {
            let strMyBirthDay = dateFormatter1.string(from: myBirthDay)
//            dateOfAnniversaryDay.append(strCurYear+" "+strMyBirthDay)
            dateOfAnniversaryDay.append(strCurYear+strMyBirthDay)
        
        }
        
        if let loveBirthDay = UserDefaults.standard.value(forKey: "LoveBirthDay") as? Date {
            let strloveBirthDay = dateFormatter1.string(from: loveBirthDay)
//            dateOfAnniversaryDay.append(strCurYear+" "+strloveBirthDay)
            dateOfAnniversaryDay.append(strCurYear+strloveBirthDay)
        }
        
        // 2. 나머지 기념일들은 현재 연도를 year에 넣어주고 나머지 날짜들을 넣어준다
        for i in 1..<13 {
            dateOfAnniversaryDay.append("\(strCurYear)\(i) ▪︎ 14")
        }
        // 3. 크리스마스 12월 25일 추가
        dateOfAnniversaryDay.append("\(strCurYear)12 ▪︎ 25")
        
        // 기념일 푸쉬 알람을 위한 저장
        UserDefaults.standard.set(dateOfAnniversaryDay, forKey: "dateOfAnniversaryDay")
        
        // 4. 현재로 부터 기념일까지 D-Day 계산 로직
        let dateFormatter3 = DateFormatter()
//        dateFormatter3.dateFormat = "yyyy년 MM월 dd일"
        dateFormatter3.dateFormat = "yyyy ▪︎ M ▪︎ d"
        
        for date in dateOfAnniversaryDay{
            if let anniversaryDate = dateFormatter3.date(from: date) {
                
                let currentDate = Date()
                
                let calendar = Calendar.current
                let date1 = calendar.startOfDay(for: anniversaryDate)
                let date2 = calendar.startOfDay(for: currentDate)
                let components = calendar.dateComponents([.day], from: date2, to: date1)
                
                guard let days = components.day else {return}
                
                // 현재 날짜보다 과거인 경우
                if days > 0 {
                    dDayOfAnniversaryDay.append("D-\(days - 1)")
                    aDday.append(days - 1)
                // 현재 날짜와 동일한 경우
                }else if days == 0 {
                    dDayOfAnniversaryDay.append("D-Day")
                    aDday.append(days)
                // 현재 날짜보다 미래인 경우
                }else{
                    let days1 = days - 1
                    dDayOfAnniversaryDay.append("D+\(-days1)")
                    aDday.append(days1)
                }
            }
        }
        
        // 날짜 중에서 0과 양수 값만 남긴다
        for (index, d) in aDday.enumerated(){
            print("원석", index, d)
            if d >= 0 {
                aDdayPlus.append(d)
            }
        }
        
        // 0과 양수 값 중에서 가장 작은 최소값을 구해서 index를 저장한다
        if let minNum = aDdayPlus.min(){
            print("최소값", minNum)
            let str = "D-\(minNum)"
            if dDayOfAnniversaryDay.contains(str){
                let index = dDayOfAnniversaryDay.firstIndex(of: str)
                aHeartIndex = index
            }else{
                let index = dDayOfAnniversaryDay.firstIndex(of: "D-Day")
                aHeartIndex = index
            }
        }
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
//            dateComponents.day = days
            let resultDate = Calendar.current.date(byAdding: dateComponents, to: selectedDate)!
            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "yyyy년 MM월 dd일"
            dateFormatter.dateFormat = "yyyy ▪︎ M ▪︎ d"
            let strResultDay = dateFormatter.string(from: resultDate)
            
            return strResultDay
        }else{
            let currentDate = Date()
            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "yyyy년 MM월 dd일"
            dateFormatter.dateFormat = "yyyy ▪︎ M ▪︎ d"
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
    
    /// 연인이된 날짜로부터 1주년 단위 날짜 만들기 함수
    ///
    /// - Parameter days: N일
    /// - Returns: 결과 날짜 Date 타입
    func getDateAfterForYealyDateCount(days : Int, yealyDate: Date) -> Date {
            var dateComponents = DateComponents()
            dateComponents.day = days
            let resultDate = Calendar.current.date(byAdding: dateComponents, to: yealyDate)!
            return resultDate
    }
}
