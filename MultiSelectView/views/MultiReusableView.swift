//
//  MultiReusableView.swift
//  MultiSelectView
//
//  Created by jqrios on 2021/9/17.
//

import UIKit
import Reusable

class MultiReusableView: UICollectionReusableView, Reusable {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        addSubview(titleL)
        titleL.snp.makeConstraints { (make) in
            make.left.equalTo(16)
            make.bottom.equalTo(-10)
            make.height.equalTo(26)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var titleL: UILabel = {
        let label = UILabel.init()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .yx_color085085085
        return label
    }()
}
