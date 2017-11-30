//
//  ViewModelType.swift
//  Flickrable
//
//  Created by TriNgo on 11/30/17.
//  Copyright © 2017 TriNgo. All rights reserved.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
