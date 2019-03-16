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
    let cDataCenter = CalenderDataCenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.clear
        self.view.isOpaque = false
        
        createUI()
        
        // TableView 생성 시작
        self.tableViewForCouple.dataSource = self
        self.tableViewForCouple.delegate = self
        
        self.tableViewForCouple.register(TableViewCellForCalendar.self, forCellReuseIdentifier: "Cell")
        self.tableViewForCouple.backgroundColor = UIColor.clear
        
        self.tableViewForCouple.separatorColor = .white
        self.tableViewForCouple.separatorStyle = .singleLine
        
        self.view.addSubview(self.tableViewForCouple)
        
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
        
        self.view.addSubview(calendarView)
    }
    
    func updateAutoLayout() {
        
        tableViewForCouple.snp.makeConstraints { make in
            make.top.equalTo(calendarView.topTitleContainerView.snp.bottom).offset(5)
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
        return cDataCenter.strCountDays.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = TableViewCellForCalendar(style: .default, reuseIdentifier: "Cell")
        
        cell.countDay.text = cDataCenter.strCountDays[indexPath.row]
        cell.countedDate.text = cDataCenter.strDate[indexPath.row]
        cell.countedDday.text = cDataCenter.strDday[indexPath.row]
        
        cell.backgroundColor = UIColor.clear
        
        return cell
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
        print(cDataCenter.strCountDays[indexPath.row])
    }
}
