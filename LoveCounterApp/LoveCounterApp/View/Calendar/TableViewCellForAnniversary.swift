//
//  TableViewCellForAnniversary.swift
//  LoveCounterApp
//
//  Created by richard oh on 17/03/2019.
//  Copyright © 2019 richard oh. All rights reserved.
//

import UIKit
import SnapKit

class TableViewCellForAnniversary: UITableViewCell {

    let stackViewForCellContainer: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        return stackView
    }()
    
    let bottomLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let view1 = UIView()
    let textLbForView1: UILabel = {
        let text = UILabel()
        text.textColor = .white
        text.textAlignment = .left
        text.font = UIFont.boldSystemFont(ofSize: 20)
        return text
    }()
    
    let view2 = UIView()
    
    let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fillEqually
        return view
    }()
    
    let textLb1ForStackView: UILabel = {
        let text = UILabel()
        text.textColor = .white
        text.textAlignment = .right
        text.font = UIFont.systemFont(ofSize: 17)
        return text
    }()
    
    let textLb2ForStackView: UILabel = {
        let text = UILabel()
        text.textColor = .white
        text.textAlignment = .right
        text.font = UIFont.systemFont(ofSize: 17)
        return text
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        
        self.view1.addSubview(textLbForView1)
        self.stackView.addArrangedSubview(textLb1ForStackView)
        self.stackView.addArrangedSubview(textLb2ForStackView)
        self.view2.addSubview(stackView)
        
        self.stackViewForCellContainer.addArrangedSubview(view1)
        self.stackViewForCellContainer.addArrangedSubview(view2)
    
        self.stackViewForCellContainer.addSubview(bottomLineView)
        self.contentView.addSubview(stackViewForCellContainer)
    
        updateAutoLayout()
    }
    
    func updateAutoLayout() {
        
        stackViewForCellContainer.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        bottomLineView.snp.makeConstraints { make in
            make.height.equalTo(0.5)
            make.width.equalToSuperview().offset(-20)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        textLbForView1.snp.makeConstraints { make in
            make.width.greaterThanOrEqualTo(100)
            make.height.greaterThanOrEqualTo(55)
            make.left.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
        }
        
        stackView.snp.makeConstraints { make in
            make.width.equalTo(150)
            make.height.equalTo(50)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-10)
        }
        
    }
}
