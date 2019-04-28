//
//  TableViewCellForCalendar.swift
//  LoveCounterApp
//
//  Created by richard oh on 16/03/2019.
//  Copyright © 2019 richard oh. All rights reserved.
//

import UIKit
import SnapKit

class TableViewCellForCalendar: UITableViewCell {
    
    let stackView = UIStackView()
    
    let bottomLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let view1 = UIView()
    
    // 100일, 200일, 1주년 ...
    var countDay: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.textAlignment = .justified
        return label
    }()
    
    // 하트이미지 셀에 삽입 2019.4.26 OHWS
    let heartImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "icons8-love-filled-100.png")
        return image
    }()
    
    let stackViewForview2: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        return stackView
    }()
    
    let view2 = UIView()
    
    // 연인이 된 날짜로 부터 100,200일.. 1,2주년 뒤 날짜
    var countedDate: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .white
        label.textAlignment = .right
        return label
    }()
    
    // D-Day
    var countedDday: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .white
        label.textAlignment = .right
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        
        self.stackView.distribution = .fillEqually
        self.stackView.axis = .horizontal
        
        view1.addSubview(countDay)
        // 하트이미지 셀에 삽입 2019.4.26 OHWS
        view1.addSubview(heartImage)
        
        stackViewForview2.addArrangedSubview(countedDate)
        stackViewForview2.addArrangedSubview(countedDday)
        
        view2.addSubview(stackViewForview2)
        
        self.stackView.addArrangedSubview(view1)
        self.stackView.addArrangedSubview(view2)
        
        self.stackView.addSubview(bottomLineView)
        self.contentView.addSubview(stackView)
       
        updateAutoLayout()
    }
    
    
    func updateAutoLayout(){
        
        // 하트이미지 셀에 삽입 2019.4.26 OHWS
        heartImage.snp.makeConstraints {
            $0.left.equalTo(countDay.snp.right)
            $0.width.equalTo(25)
            $0.height.equalTo(25)
            $0.centerY.equalTo(countDay.snp.centerY)
        }
        
        bottomLineView.snp.makeConstraints { make in
            make.height.equalTo(0.5)
            make.width.equalToSuperview().offset(-20)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        countDay.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(55)
            make.left.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
        }
        
        stackViewForview2.snp.makeConstraints { make in
            make.width.equalTo(150)
            make.height.equalTo(50)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-10)
        }
        
    }
    
}
