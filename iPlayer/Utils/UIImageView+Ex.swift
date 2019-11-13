//
//  UIImageView+Ex.swift
//  iPlayer
//
//  Created by 叶浩 on 2019/11/13.
//  Copyright © 2019 叶浩. All rights reserved.
//

import UIKit

extension UIImageView {
    func setImage(forKey key: String) {
        FFmpegManager.default.retrieveImage(forKey: key) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    self.image = image
                case .failure(_):
                    break
                }
            }
        }
    }
}
