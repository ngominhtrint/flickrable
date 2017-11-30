//
//  Observable+Ext.swift
//  Flickrable
//
//  Created by TriNgo on 11/30/17.
//  Copyright © 2017 TriNgo. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

extension ObservableType {
    
    func asDriverOnErrorJustComplete() -> Driver<E> {
        return asDriver { error in
            assertionFailure("Error \(error)")
            return Driver.empty()
        }
    }
}
