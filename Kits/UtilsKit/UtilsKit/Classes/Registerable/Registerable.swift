//
//  Registerable.swift
//  demo
//
//  Created by 叶浩 on 2019/2/14.
//  Copyright © 2019 叶浩. All rights reserved.
//

import UIKit

public protocol Registerable: class {
    static var identifier: String { get }
}

extension Registerable {
    public static var identifier: String {
        let identifier = String(describing: self)
        if identifier.contains(".") {
            return identifier.components(separatedBy: ".").last!
        } else {
            return identifier
        }
    }
}

extension UINib: Registerable {}
extension UIView: Registerable {}

public protocol CollectionView {
    func register(cell: Registerable.Type)
    func register(header: Registerable.Type)
    func register(footer: Registerable.Type)
    func dequeueCell<T: Registerable>(at indexPath: IndexPath) -> T
}

extension CollectionView {
    func register(cells: Registerable.Type...) {
        cells.forEach(register(cell:))
    }

    func register(headers: Registerable.Type...) {
        headers.forEach(register(header:))
    }

    func register(footers: Registerable.Type...) {
        footers.forEach(register(footer:))
    }
}

extension UITableView: CollectionView {
    public func register(cell: Registerable.Type) {
        switch cell {
        case is UINib.Type:
            register(UINib(nibName: cell.identifier, bundle: nil), forCellReuseIdentifier: cell.identifier)
        case is UIView.Type:
            register(cell, forCellReuseIdentifier: cell.identifier)
        default:
            break
        }
    }
    
    public func register(header: Registerable.Type) {
        switch header {
        case is UINib.Type:
            register(UINib(nibName: header.identifier, bundle: nil), forHeaderFooterViewReuseIdentifier: header.identifier)
        case is UIView.Type:
            register(header, forHeaderFooterViewReuseIdentifier: header.identifier)
        default:
            break
        }
    }
    
    public func register(footer: Registerable.Type) {
        register(header: footer)
    }
    
    public func dequeueCell<T: Registerable>(at indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as! T
    }
    
    public func dequeueHeaderFooter<T: Registerable>() -> T {
        return dequeueReusableHeaderFooterView(withIdentifier: T.identifier) as! T
    }
}

extension UICollectionView: CollectionView {
    public func register(cell: Registerable.Type) {
        switch cell {
        case is UINib.Type:
            register(UINib(nibName: cell.identifier, bundle: nil), forCellWithReuseIdentifier: cell.identifier)
        case is UIView.Type:
            register(cell, forCellWithReuseIdentifier: cell.identifier)
        default:
            break
        }
    }

    public func register(header: Registerable.Type) {
        register(supplementaryView: header, kind: UICollectionView.elementKindSectionHeader)
    }
    
    public func register(footer: Registerable.Type) {
        register(supplementaryView: footer, kind: UICollectionView.elementKindSectionFooter)
    }

    public func register(supplementaryView view: Registerable.Type, kind: String) {
        switch view {
        case is UINib.Type:
            register(UINib(nibName: view.identifier, bundle: nil), forSupplementaryViewOfKind: kind, withReuseIdentifier: view.identifier)
        case is UIView.Type:
            register(view, forSupplementaryViewOfKind: kind, withReuseIdentifier: view.identifier)
        default:
            break
        }
    }

    public func dequeueCell<T: Registerable>(at indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as! T
    }

    public func dequeueHeader<T: Registerable>(for forIndexPath: IndexPath) -> T {
        return dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: T.identifier, for: forIndexPath) as! T
    }
    
    public func dequeueFooter<T: Registerable>(for forIndexPath: IndexPath) -> T {
        return dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: T.identifier, for: forIndexPath) as! T
    }
}
