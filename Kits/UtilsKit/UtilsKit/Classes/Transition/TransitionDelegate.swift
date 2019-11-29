//
//  TransitionDelegate.swift
//  PresentTransition
//
//  Created by jesse on 2017/7/11.
//  Copyright © 2017年 jesse. All rights reserved.
//

import UIKit

class TransitionDelegate: NSObject {

    fileprivate var inAnimator: MainAnimator?
    fileprivate var outAnimator: MainAnimator?
    public var isDismissEnabled = true

    init(in inAnimator: MainAnimator? = nil, out outAnimator: MainAnimator? = nil) {
        super.init()
        self.inAnimator = inAnimator
        self.outAnimator = outAnimator
    }

    deinit {
        logger.destory("\(self.classForCoder.description())销毁")
    }
}

extension TransitionDelegate: UIViewControllerTransitioningDelegate {
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return inAnimator
    }

    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return outAnimator
    }
}

extension TransitionDelegate: UINavigationControllerDelegate {
    public func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .push {
            return inAnimator
        } else if operation == .pop {
            return outAnimator
        }
        return nil
    }
}
