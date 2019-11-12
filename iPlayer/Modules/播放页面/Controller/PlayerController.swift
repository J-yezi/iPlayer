//
//  PlayerController.swift
//  iPlayer
//
//  Created by 叶浩 on 2019/10/29.
//  Copyright © 2019 叶浩. All rights reserved.
//

import UIKit
import BaseKit
import IJKMediaFramework
import SnapKit

class PlayerController: BaseController {
    fileprivate var url: String!
    var player:IJKFFMoviePlayerController!
    
    init(url: String) {
        super.init(nibName: nil, bundle: nil)
        self.url = url
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(abc(noti:)), name: NSNotification.Name.IJKMPMoviePlayerFirstVideoFrameRendered, object: nil)

        let options = IJKFFOptions.byDefault()
        let u = URL(fileURLWithPath: url)
        player = IJKFFMoviePlayerController(contentURL: u, with: options)
        player.scalingMode = .aspectFit //缩放模式
        player.shouldAutoplay = true //开启自动播放
        view.addSubview(player.view)
        
        player.view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    @objc func abc(noti: Notification) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            let imageView = UIImageView(frame: self.view.bounds)
            let image = self.player.thumbnailImageAtCurrentTime()
            imageView.image = image
            imageView.backgroundColor = .red
            self.view.addSubview(imageView)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            //开始播放
            self.player.prepareToPlay()
            
        }
        
        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            //关闭播放器
//            self.player.shutdown()
        }
}
