//
//  ActionSheet.swift
//  iPlayer
//
//  Created by 叶浩 on 2019/11/18.
//  Copyright © 2019 叶浩. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import CcExtensions

class ActionSheet: UIView {
    fileprivate var observer: AnyObserver<Int>!
    
    fileprivate lazy var backView: UIView = {
        let backView: UIView = UIView(frame: UIScreen.main.bounds)
        backView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        backView.alpha = 0
        let tap = UITapGestureRecognizer(target: self, action: #selector(close))
        backView.addGestureRecognizer(tap)
        return backView
    }()
    fileprivate lazy var shareView: UIView = {
        let shareView: UIView = UIView(frame: CGRect(x: 0, y: UIScreen.main.bounds.height, width: UIScreen.main.bounds.width, height: 295 + (UIDevice.isXSeries ? 34 : 0)))
        shareView.layer.cornerRadius = 5
        shareView.backgroundColor = UIColor.white
        return shareView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(backView)
        addSubview(shareView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ActionSheet {
    @objc func close() {
        undisplay()
    }

    func display(_ view: UIView? = nil, _ completion: (() -> Void)? = nil) {
        if let view = view {
            view.addSubview(view)
        } else {
            UIApplication.shared.keyWindow?.addSubview(self)
        }
        UIView.animate(withDuration: 0.25, animations: {
            self.backView.alpha = 1
            self.shareView.bottom = UIScreen.main.bounds.height
        }) { _ in
            completion?()
        }
    }

    func undisplay(_ completeHandler: (() -> Void)? = nil) {
        UIView.animate(withDuration: 0.25, animations: {
            self.shareView.top = UIScreen.main.bounds.height
            self.backView.alpha = 0
        }) { _ in
            self.removeFromSuperview()
            completeHandler?()
        }
    }
}

extension Reactive where Base: ActionSheet {
    func display(_ view: UIView? = nil, _ completion: (() -> Void)? = nil) -> Observable<Int> {
        base.display(view, completion)
        return Observable.create { [weak base] in
            base?.observer = $0
            return Disposables.create()
        }
    }
}
