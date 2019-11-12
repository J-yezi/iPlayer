//
//  ViewController.swift
//  iPlayer
//
//  Created by 叶浩 on 2019/11/4.
//  Copyright © 2019 叶浩. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let a = HTFFMpegPlayerView(frame: CGRect(x: 10, y: 100, width: view.bounds.width - 20, height: 200))
//        view.addSubview(a)
//
//        a.videoPath = Bundle.main.path(forResource: "b.flv", ofType: nil)
//        a.play()
        
        
        let imageView = UIImageView(frame: CGRect(x: 10, y: 350, width: view.bounds.width - 20, height: 200))
        imageView.backgroundColor = .cyan
        view.addSubview(imageView)
    }


}

