//
//  UIViewControllerExtension.swift
//  IndexDemo
//
//  Created by jesse on 2017/6/27.
//  Copyright © 2017年 jesse. All rights reserved.
//

import UIKit

private var kTransitionKey: Void?

// MARK: - Methods
extension UIViewController {
    
    var transition: TransitionDelegate {
        get {
            return objc_getAssociatedObject(self, &kTransitionKey) as! TransitionDelegate
        }
        set {
            objc_setAssociatedObject(self, &kTransitionKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func present(_ control: UIViewController, in present: MainAnimator? = nil, out dismiss: MainAnimator? = nil) {
        let delegate = TransitionDelegate(in: present, out: dismiss)
        control.transition = delegate
        control.transitioningDelegate = delegate
        control.modalPresentationStyle = .custom
        self.present(control, animated: true, completion: nil)
    }
    
    func push(_ control: UIViewController, in push: MainAnimator? = nil, out pop: MainAnimator? = nil) {
        self.navigationController?.pushViewController(UIViewController(), animated: true)
        guard let naviControl = self.navigationController else { return }
        let delegate = TransitionDelegate(in: push, out: pop)
        naviControl.delegate = delegate
        naviControl.pushViewController(control, animated: true)
    }
}
