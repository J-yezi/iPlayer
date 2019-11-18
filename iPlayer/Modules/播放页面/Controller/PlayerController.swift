//
//  PlayerController.swift
//  iPlayer
//
//  Created by 叶浩 on 2019/10/29.
//  Copyright © 2019 叶浩. All rights reserved.
//

import UIKit
import BaseKit
import SnapKit

class PlayerController: BaseController {
    var path: String!
    
    init(path: String) {
        super.init(nibName: nil, bundle: nil)
        self.path = path
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        button.backgroundColor = .red
        button.addTarget(self, action: #selector(click), for: UIControl.Event.touchUpInside)
        view.addSubview(button)
    }
    
    @objc
    fileprivate func click() {
        let controller = KxMovieViewController.movieViewController(withContentPath: path, parameters: nil)
        present(controller as! UIViewController, animated: true, completion: nil)
    }
}
