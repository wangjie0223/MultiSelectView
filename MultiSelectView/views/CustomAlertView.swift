//
//  CustomAlertView.swift
//  MultiSelectView
//
//  Created by jqrios on 2021/9/17.
//

import UIKit

class CustomAlertView: UIView {

    override init(frame: CGRect) {
        super .init(frame: frame)
        
        let titleLabel = UILabel()
        addSubview(titleLabel)
        titleLabel.text = "确认补充课程"
        titleLabel.textColor = .black
        titleLabel.font = .systemFont(ofSize: 20, weight: .regular)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(0)
            make.centerX.equalToSuperview()
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showList(_ list: [String]) {

        for index in 0..<list.count {
            let lab = UILabel()
            addSubview(lab)
            lab.text = list[index]
            lab.textColor = .yx_color136136136
            lab.font = .systemFont(ofSize: 15, weight: .regular)
            let labPositionY = (28 * CGFloat(index)) + 38
            lab.frame = .init(x: 14, y: labPositionY, width: frame.width - 28, height: 28)
        }
    }

}
