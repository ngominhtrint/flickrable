//
//  PhotoViewModelTests.swift
//  FlickrableTests
//
//  Created by TriNgo on 11/30/17.
//  Copyright © 2017 TriNgo. All rights reserved.
//

import XCTest
import RxCocoa
import RxSwift
import RxBlocking

@testable import Flickrable

class PhotoViewModelTests: XCTestCase {
    
    var photoVM: PhotoViewModel!
    
    let disposeBag = DisposeBag()
    
    override func setUp() {
        super.setUp()
        
        photoVM = PhotoViewModel()
    }
    
    func test_transform_triggerInvoked_getRecentEmitted() {
        let trigger = PublishSubject<Void>()
        let input = createInput(trigger: trigger)
        let output = photoVM.transform(input: input)
        
        output.photos.drive().disposed(by: disposeBag)
        trigger.onNext(())
        
        XCTAssertNotNil(output.photos.asObservable())
    }
    
    private func createInput(trigger: Observable<Void> = Observable.never()) -> PhotoViewModel.Input {
        return PhotoViewModel.Input(trigger: trigger.asDriverOnErrorJustComplete())
    }
}
