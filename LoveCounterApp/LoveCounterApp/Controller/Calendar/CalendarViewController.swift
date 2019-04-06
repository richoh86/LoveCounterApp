//
//  CalendarViewController.swift
//  LoveCounterApp
//
//  Created by richard oh on 15/03/2019.
//  Copyright © 2019 richard oh. All rights reserved.
//

import UIKit
import SnapKit

class CalendarViewController: UIViewController {
    
    let calendarView = CalendarView()
    let tableViewForCouple = UITableView()
    let tableViewForAnniversary = UITableView()
    let cDataCenter = CalenderDataCenter()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.clear
        self.view.isOpaque = false
        
        createUI()
        
        // Default Tab만 bottomLine 보여줄 것
        self.calendarView.bottomLineView2.isHidden = true
        self.calendarView.textForTab2.alpha = 0.2
        self.tableViewForAnniversary.isHidden = true
        
        createTableViewForCouple()
        createTableViewForAnniversary()
        
        updateAutoLayout()
    }
    
    // status bar -> white color
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func createUI(){
        
        calendarView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        calendarView.backgroundColor = .black
        calendarView.alpha = 0.9
        calendarView.btnForArrowDown.addTarget(self, action: #selector(arrowDownBtnAction), for: .touchUpInside)
        calendarView.btnForTab1.addTarget(self, action: #selector(btnActionForTab1), for: .touchUpInside)
        calendarView.btnForTab2.addTarget(self, action: #selector(btnActionForTab2), for: .touchUpInside)
        
        self.view.addSubview(calendarView)
    }
    
    @objc func btnActionForTab1(){
        
        calendarView.textForTab1.alpha = 1.0
        calendarView.textForTab2.alpha = 0.2
        
        calendarView.bottomLineView1.isHidden = false
        calendarView.bottomLineView2.isHidden = true
        
        self.tableViewForCouple.isHidden = false
        self.tableViewForAnniversary.isHidden = true
    }
    
    @objc func btnActionForTab2(){
        
        calendarView.textForTab2.alpha = 1.0
        calendarView.textForTab1.alpha = 0.2
        
        calendarView.bottomLineView1.isHidden = true
        calendarView.bottomLineView2.isHidden = false
        
        self.tableViewForCouple.isHidden = true
        self.tableViewForAnniversary.isHidden = false
    }
    
    func createTableViewForCouple() {
        
        // TableView 생성 시작
        self.tableViewForCouple.dataSource = self
        self.tableViewForCouple.delegate = self
        
        self.tableViewForCouple.register(TableViewCellForCalendar.self, forCellReuseIdentifier: "CellForCouple")
        self.tableViewForCouple.backgroundColor = UIColor.clear
        
        self.tableViewForCouple.tag = 1 // 커플 탭 태그는 1로 지정
        
        self.tableViewForCouple.separatorColor = .white
        self.tableViewForCouple.separatorStyle = .singleLine
        
        self.view.addSubview(self.tableViewForCouple)
        
//        self.tableViewForCouple.scrollToRow(at: tableViewForCouple.indexPath(for:), at: UITableView.ScrollPosition(rawValue: 10), animated: true)
    }
    
    func createTableViewForAnniversary() {

        // TableView 생성 시작
        self.tableViewForAnniversary.dataSource = self
        self.tableViewForAnniversary.delegate = self
        
        self.tableViewForAnniversary.register(TableViewCellForAnniversary.self, forCellReuseIdentifier: "CellForAnniversary")
        self.tableViewForAnniversary.backgroundColor = UIColor.clear
        
        self.tableViewForAnniversary.tag = 2 // 기념일 탭 태그는 2로 지정
        
        self.tableViewForAnniversary.separatorColor = .white
        self.tableViewForAnniversary.separatorStyle = .singleLine
        
        self.view.addSubview(self.tableViewForAnniversary)
        
    }

    func updateAutoLayout() {
        
            tableViewForCouple.snp.makeConstraints { make in
                make.top.equalTo(calendarView.stackViewForTabs.snp.bottom).offset(5)
                make.left.right.equalToSuperview()
                make.bottom.equalTo(calendarView.btnForArrowDown.snp.top)
            }
        
            tableViewForAnniversary.snp.makeConstraints { make in
                make.top.equalTo(calendarView.stackViewForTabs.snp.bottom).offset(5)
                make.left.right.equalToSuperview()
                make.bottom.equalTo(calendarView.btnForArrowDown.snp.top)
            }
    }
    
    @objc func arrowDownBtnAction(){
        self.dismiss(animated: true, completion: nil)
    }

}

// MARK: - UITableView DataSoucre
extension CalendarViewController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView.tag == 1 {
            return cDataCenter.strCountDays.count
        }else if tableView.tag == 2{
            return cDataCenter.nameOfAnniversaryDay.count
        }else {
            return 10
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if tableView.tag == 1 {
            let cellForCoupleTable = TableViewCellForCalendar(style: .default, reuseIdentifier: "CellForCouple")
            
            cellForCoupleTable.countDay.text = cDataCenter.strCountDays[indexPath.row]
            cellForCoupleTable.countedDate.text = cDataCenter.strDate[indexPath.row]
            
            cellForCoupleTable.countedDday.text = cDataCenter.strDday[indexPath.row]
            if cDataCenter.strDday[indexPath.row].contains("+"){
                cellForCoupleTable.countDay.alpha = 0.2
                cellForCoupleTable.countedDate.alpha = 0.2
                cellForCoupleTable.countedDday.alpha = 0.2
                cellForCoupleTable.bottomLineView.alpha = 0.2
            }
            
            cellForCoupleTable.backgroundColor = UIColor.clear
            
            return cellForCoupleTable
            
        } else if tableView.tag == 2{
            
            let cellForAnniversaryTable = TableViewCellForAnniversary(style: .default, reuseIdentifier: "CellForAnniversary")
            
            cellForAnniversaryTable.textLbForView1.text = cDataCenter.nameOfAnniversaryDay[indexPath.row]
            cellForAnniversaryTable.textLb1ForStackView.text = cDataCenter.dateOfAnniversaryDay[indexPath.row]
            cellForAnniversaryTable.textLb2ForStackView.text = cDataCenter.dDayOfAnniversaryDay[indexPath.row]
            if cDataCenter.dDayOfAnniversaryDay[indexPath.row].contains("+"){
                cellForAnniversaryTable.textLbForView1.alpha = 0.2
                cellForAnniversaryTable.textLb1ForStackView.alpha = 0.2
                cellForAnniversaryTable.textLb2ForStackView.alpha = 0.2
                cellForAnniversaryTable.bottomLineView.alpha = 0.2
            }
            
            cellForAnniversaryTable.backgroundColor = UIColor.clear
            
            return cellForAnniversaryTable
            
        } else {
            
            return UITableViewCell()
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
}


// MARK: - UITableView Delegate
extension CalendarViewController: UITableViewDelegate{
    
    // table cell 선택시 선택된 상태로 남아 있지 않도록 설정
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
