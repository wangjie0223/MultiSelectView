//
//  ViewController.swift
//  MultiSelectView
//
//  Created by jqrios on 2021/9/17.
//

import UIKit
let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height

class ViewController: UIViewController {

    var dataArray = [MultiModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let m1 = MultiModel()
        m1.title = "2021-09-17  星期五"
        let i1 = MultiItem()
        i1.title = "08:00-09:00"
        let i2 = MultiItem()
        i2.title = "09:00-10:00"
        m1.items = [i1,i2]
        
        let m2 = MultiModel()
        m2.title = "2021-09-18  星期六"
        let m3 = MultiModel()
        m3.title = "2021-09-19  星期日"
        let m4 = MultiModel()
        m4.title = "2021-09-20  星期一"

        dataArray.append(m1)
        dataArray.append(m2)
        dataArray.append(m3)
        dataArray.append(m4)
        
        let customView = MultiSelectView.init(frame: .init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 34))
        view.addSubview(customView)
        customView.dataArray = dataArray
//        customView.actionArrayBlock = { [unowned self] array in
//            print(array)
//        }
        customView.buttonBlock = { [unowned self] array in
//            print(array)
            guard let list = array else { return }
            showAlert(list)
        }
    }
    
    func showAlert(_ list: [String]) {
        let customViewHeight = (CGFloat(list.count*28)) + 38
        
        let customV = CustomAlertView.init(frame: .init(x: 0, y: 0, width: 298, height: customViewHeight))
        customV.showList(list)
        let alert = LEEAlert.alert()
        _ = alert.config
            .leeClickBackgroundClose(true)
            .leeMaxWidth(298)
            .leeAddCustomView { cus in cus.view = customV }
            .leeAddAction { action in
                action.title = "取消"
                action.titleColor = .yx_color136136136
                action.font = .systemFont(ofSize: 16, weight:.semibold)
                action.height = 55
            }
            .leeAddAction { action in
                action.title = "确定"
                action.titleColor = .color1682247
                action.font = .systemFont(ofSize: 16, weight:.semibold)
                action.height = 55
//                action.clickBlock = { [weak self] in
//                    guard let scoreStr = customV.score else { return }
//                    guard let int_score = Int(scoreStr) else { return }
//                    self?.changeScore(at: indexPath, score: int_score)
//                };
            }
            .leeShow()
    }

}

