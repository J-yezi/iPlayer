//
//  Error.swift
//  iPlayer
//
//  Created by 叶浩 on 2019/11/11.
//  Copyright © 2019 叶浩. All rights reserved.
//

import UIKit

enum FFmpegError: Error {
    enum CacheErrorReason {
        case cannotCreateDirectory
        case cannotConvertToData
        case cannotLoadDataFromDisk
    }
    
    case cacheError(CacheErrorReason)
}
