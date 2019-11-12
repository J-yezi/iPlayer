//
//  Storage.swift
//  iPlayer
//
//  Created by 叶浩 on 2019/11/11.
//  Copyright © 2019 叶浩. All rights reserved.
//

protocol DataTransformable {
    func toData() throws -> Data
    static func fromData(_ data: Data) throws -> Self
    static var empty: Self { get }
}
