//
//  MainAnimator.swift
//  IceCream
//
//  Created by jesse on 16/11/9.
//  Copyright © 2016年 jesse. All rights reserved.
//

import UIKit

class MainAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    weak var fromControl: UIViewController!
    weak var toControl: UIViewController!
    var containerView: UIView!
    weak var transitionContext: UIViewControllerContextTransitioning!
    fileprivate var defaultTime = 0.35
    fileprivate var completion: ((Bool) -> Void)?

    deinit {
        logger.destory("\(self.classForCoder.description())销毁")
    }

    init(complete: ((Bool) -> Void)? = nil) {
        super.init()
        completion = complete
    }

    func animateTransitionEvent() {}

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return defaultTime
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        fromControl = transitionContext.viewController(forKey: .from)
        toControl = transitionContext.viewController(forKey: .to)
        containerView = transitionContext.containerView
        self.transitionContext = transitionContext

        animateTransitionEvent()
    }

    func completeTransition() {
        completion?(!transitionContext.transitionWasCancelled)
        transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
    }
}
