//
//  MultiSelectView.swift
//  MultiSelectView
//
//  Created by jqrios on 2021/9/17.
//

import UIKit

class MultiModel {
    var title: String?
    var items: [MultiItem]?
}

class MultiItem {
    var title: String?
    var isSel = false
}

class MultiSelectView: UIView {
    var titles = [String]() {
        didSet {
            if titles.count == 0 {
                bottomBtn.backgroundColor = .lightGray
            } else {
                bottomBtn.backgroundColor = .color1682247
            }
        }
    }
    var actionArrayBlock: ((_ array: [String]?) -> ())?
    var buttonBlock: ((_ array: [String]?) -> ())?

    var dataArray: [MultiModel]? {
        didSet {
            myCollectionView.reloadData()
        }
    }
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        addSubview(myCollectionView)
        myCollectionView.frame = .init(x: 0, y: 0, width: frame.width, height: frame.height - 44)
        
        addSubview(bottomBtn)
        bottomBtn.backgroundColor = .lightGray
        bottomBtn.setTitle("确定", for: .normal)
        bottomBtn.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        bottomBtn.layer.masksToBounds = true
        bottomBtn.layer.cornerRadius = 22
        bottomBtn.addTarget(self, action: #selector(clickBottomBtn(button:)), for:.touchUpInside )
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var bottomBtn = UIButton.init(frame: .init(x: 16, y: frame.height - 44, width: frame.width - 32, height: 44))

    // MARK: - 方法
    @objc func clickBottomBtn(button: UIButton) {
        if titles.count == 0 {
            return
        }
        guard let blcok = buttonBlock else { return }
        blcok(titles)
    }
    
    // MARK: - 懒加载
    private lazy var myCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .vertical
        layout.sectionHeadersPinToVisibleBounds = true
        layout.itemSize = .init(width: 110, height: 66)
        let collection = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        layout.sectionInset = .init(top: 0, left: 16, bottom: 0, right: 16)
        collection.backgroundColor = .white
        collection.delegate = self
        collection.dataSource = self
        collection.isScrollEnabled = true
        collection.alwaysBounceVertical = true
        collection.register(cellType: MultiCell.self)
        collection.register(supplementaryViewType: MultiReusableView.self, ofKind: UICollectionView.elementKindSectionHeader)
        //        collection.register(supplementaryViewType: StudentClassTableDetailSectionHeader.self, ofKind: UICollectionView.elementKindSectionHeader)
        
        return collection
    }()
    
    
}

extension MultiSelectView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        dataArray?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataArray?[section].items?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: MultiCell.self)
        cell.model = dataArray?[indexPath.section].items?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        if indexPath.section == 0 {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, for: indexPath, viewType: MultiReusableView.self)
            header.titleL.text = dataArray?[indexPath.section].title
            return header
        } else {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, for: indexPath, viewType: MultiReusableView.self)
            header.titleL.text = dataArray?[indexPath.section].title
            return header
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
//            return .init(width: SCREEN_WIDTH, height: 250)
            return .init(width: SCREEN_WIDTH, height: 56)
        } else {
            return .init(width: SCREEN_WIDTH, height: 56)
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // print(dataArray?[indexPath.section].items?[indexPath.row].title)
        // 多选
        guard let model = dataArray?[indexPath.section].items?[indexPath.row] else { return }
        if model.isSel == true {
            dataArray?[indexPath.section].items?[indexPath.row].isSel = false
        } else {
            dataArray?[indexPath.section].items?[indexPath.row].isSel = true
        }
        collectionView.reloadItems(at: [indexPath])
        
        titles.removeAll()
        dataArray?[indexPath.section].items?.forEach({ item in
            if item.isSel {
                titles.append(item.title ?? "")
            }
        })
        print(titles)
        guard let arrayBlock = actionArrayBlock else { return }
        arrayBlock(titles)
        
    }

}

