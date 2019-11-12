//
//  ViewModelProtocol.swift
//  OralCalculation
//
//  Created by 叶浩 on 2019/1/4.
//  Copyright © 2019 叶浩. All rights reserved.
//

public protocol ViewModelData {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
