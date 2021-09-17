//
//  MultiCell.swift
//  MultiSelectView
//
//  Created by jqrios on 2021/9/17.
//

import UIKit
import Reusable
import SnapKit
class MultiCell: UICollectionViewCell, Reusable {

    var model: MultiItem? {
        didSet {
            timeLabel.text = model?.title
            if model?.isSel ?? true {
                bgImageView.image = .init(named: "itemBgSel")
            } else {
                bgImageView.image = .init(named: "itemBgNor")
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize.init(width: 110, height: 66))
        }
        
        contentView.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(10)
            make.centerX.equalToSuperview()
        }
        
        contentView.addSubview(dayOfDateLabel)
        dayOfDateLabel.snp.makeConstraints { make in
            make.bottom.equalTo(0)
            make.centerX.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var bgImageView = UIImageView()
    
    private lazy var timeLabel: UILabel = {
        let lab = UILabel()
        lab.textColor = .color51 // rgba(85, 85, 85, 1)
        lab.font = .systemFont(ofSize: 14, weight: .regular)
        return lab
    }()
    
    private lazy var dayOfDateLabel: UILabel = {
        let lab = UILabel()
        lab.textColor = .color1682247// rgba(136, 136, 136, 1)
        lab.font = .systemFont(ofSize: 10, weight: .regular)
        return lab
    }()
}


extension UIColor {
    
    convenience init(r: UInt32 ,g: UInt32, b: UInt32 ,alpha: CGFloat = 1.0){
        self.init(red: CGFloat(r) / 255,
                  green: CGFloat(g) / 255.0,
                  blue: CGFloat(b) / 255.0,
                  alpha: alpha)
    }
    
    class var color51: UIColor {
        return UIColor(r: 51, g: 51, b: 51)
    }
    
    class var color1682247: UIColor {
        return UIColor(r: 16, g: 82, b: 247, alpha: 1)
    }
    
    class var yx_color136136136: UIColor {
        return UIColor(r: 136, g: 136, b: 136, alpha: 1)
    }
    
    class var yx_color085085085: UIColor {
        return UIColor(r: 85, g: 85, b: 85, alpha: 1)
    }
}
