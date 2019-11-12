//
//  Data+Ex.swift
//  iPlayer
//
//  Created by 叶浩 on 2019/11/11.
//  Copyright © 2019 叶浩. All rights reserved.
//

import UIKit

extension Data: DataTransformable {
    public func toData() throws -> Data {
        return self
    }

    public static func fromData(_ data: Data) throws -> Data {
        return data
    }

    public static let empty = Data()
}
