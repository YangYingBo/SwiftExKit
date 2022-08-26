//
//  UITableView+Ex.swift
//  TBExKit
//
//  Created by yangyb on 2022/8/12.
//

import Foundation
import UIKit

public extension SwiftExKit where Base: UITableView {
    /// 占位UI在回调自行布局
    func emptyDataSetView(_ closure: @escaping (TBEmptyView) -> Void) {
        self.base.emptyDataSetView(closure)
    }
    
    
}

public extension SwiftExKit where Base: UICollectionView {
    /// 占位UI在回调自行布局
    func emptyDataSetView(_ closure: @escaping (TBEmptyView) -> Void) {
        self.base.emptyDataSetView(closure)
    }
    
    
}

private var TBConfigureEmptyDataSetView = false


extension UIScrollView {
    
    private var configureEmptyDataSetView: ((TBEmptyView) -> Void)? {
        get {
            return objc_getAssociatedObject(self, &TBConfigureEmptyDataSetView) as? (TBEmptyView) -> Void
        }
        set {
            objc_setAssociatedObject(self, &TBConfigureEmptyDataSetView, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            UIScrollView.swizzleReloadData
            if self is UITableView {
                UIScrollView.swizzleEndUpdates
            }
        }
    }
    
//    private func swizzleReloadData() {
//        if self is UITableView {
//            let tableViewOriginalSelector = #selector(UITableView.reloadData)
//            let tableViewSwizzledSelector = #selector(UIScrollView.scrollViewSwizzledReloadData)
//            swizzleMethod(for: UITableView.self, originalSelector: tableViewOriginalSelector, swizzledSelector: tableViewSwizzledSelector)
//        } else if self is UICollectionView {
//            let collectionViewOriginalSelector = #selector(UICollectionView.reloadData)
//            let collectionViewSwizzledSelector = #selector(UIScrollView.scrollViewSwizzledReloadData)
//
//            swizzleMethod(for: UICollectionView.self, originalSelector: collectionViewOriginalSelector, swizzledSelector: collectionViewSwizzledSelector)
//        }
//    }
//
//    private func swizzleEndUpdates() {
//        let originalSelector = #selector(UITableView.endUpdates)
//        let swizzledSelector = #selector(UIScrollView.tableViewSwizzledEndUpdates)
//
//        swizzleMethod(for: UITableView.self, originalSelector: originalSelector, swizzledSelector: swizzledSelector)
//    }
    
    private static let swizzleReloadData: () = {
        let tableViewOriginalSelector = #selector(UITableView.reloadData)
        let tableViewSwizzledSelector = #selector(UIScrollView.tableViewSwizzledReloadData)
        
        swizzleMethod(for: UITableView.self, originalSelector: tableViewOriginalSelector, swizzledSelector: tableViewSwizzledSelector)
        
        let collectionViewOriginalSelector = #selector(UICollectionView.reloadData)
        let collectionViewSwizzledSelector = #selector(UIScrollView.collectionViewSwizzledReloadData)
        
        swizzleMethod(for: UICollectionView.self, originalSelector: collectionViewOriginalSelector, swizzledSelector: collectionViewSwizzledSelector)
    }()
    
    private static let swizzleEndUpdates: () = {
        let originalSelector = #selector(UITableView.endUpdates)
        let swizzledSelector = #selector(UIScrollView.tableViewSwizzledEndUpdates)
        
        swizzleMethod(for: UITableView.self, originalSelector: originalSelector, swizzledSelector: swizzledSelector)
    }()
    
    @objc private func tableViewSwizzledEndUpdates() {
        tableViewSwizzledEndUpdates()
        reloadEmptyDataSet()
    }
    
    @objc private func tableViewSwizzledReloadData() {
        tableViewSwizzledReloadData()
        reloadEmptyDataSet()
    }
    
    @objc private func collectionViewSwizzledReloadData() {
        collectionViewSwizzledReloadData()
        reloadEmptyDataSet()
    }
    
    func emptyDataSetView(_ closure: @escaping (TBEmptyView) -> Void) {
        self.configureEmptyDataSetView = closure
    }
    
    private func reloadEmptyDataSet() {
        if itemsCount == 0, let block = self.configureEmptyDataSetView {
            let emptyView = TBEmptyView()
            block(emptyView)
            if let tableView = self as? UITableView  {
                tableView.backgroundView = emptyView
            } else if let collectionView = self as? UICollectionView {
                collectionView.backgroundView = emptyView
            }
            
        } else {
            if let tableView = self as? UITableView  {
                tableView.backgroundView = nil
            } else if let collectionView = self as? UICollectionView {
                collectionView.backgroundView = nil
            }
//            self.configureEmptyDataSetView = nil
        }
    }
    
    internal var itemsCount: Int {
        var items = 0
        
        // UITableView support
        if let tableView = self as? UITableView {
            var sections = 1
            
            if let dataSource = tableView.dataSource {
                if dataSource.responds(to: #selector(UITableViewDataSource.numberOfSections(in:))) {
                    sections = dataSource.numberOfSections!(in: tableView)
                }
                if dataSource.responds(to: #selector(UITableViewDataSource.tableView(_:numberOfRowsInSection:))) {
                    for i in 0 ..< sections {
                        items += dataSource.tableView(tableView, numberOfRowsInSection: i)
                    }
                }
            }
        } else if let collectionView = self as? UICollectionView {
            var sections = 1
            
            if let dataSource = collectionView.dataSource {
                if dataSource.responds(to: #selector(UICollectionViewDataSource.numberOfSections(in:))) {
                    sections = dataSource.numberOfSections!(in: collectionView)
                }
                if dataSource.responds(to: #selector(UICollectionViewDataSource.collectionView(_:numberOfItemsInSection:))) {
                    for i in 0 ..< sections {
                        items += dataSource.collectionView(collectionView, numberOfItemsInSection: i)
                    }
                }
            }
        }
        
        return items
    }
}

public class TBEmptyView: UIView {
    
    public let emptyImageView = UIImageView()
    
    public let titleLabel = UILabel.ex.label("", fontSize: 16, textColor: .black)
    
    public let detailLabel = UILabel.ex.label("", fontSize: 16, textColor: .black)
    
    public let emptyButton = UIButton(type: .custom)
    
    
    init() {
        super.init(frame: .zero)
        self.addSubview(emptyButton)
        self.addSubview(emptyImageView)
        self.addSubview(titleLabel)
        self.addSubview(detailLabel)
    }
    
    required init?(coder: NSCoder) { nil }
    
  
}


