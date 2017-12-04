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
import ObjectMapper

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
    
    func test_transform_triggerInvoked_mapResponseToPhotos() {
        let trigger = PublishSubject<Void>()
        let input = createInput(trigger: trigger)
        
        let drivePhotos: Driver<[Photo]> = input.trigger.flatMapLatest { [unowned self] _ in
            return Observable.just(self.createPhotos()).asDriverOnErrorJustComplete()
        }
        
        drivePhotos.drive().disposed(by: disposeBag)
        trigger.onNext(())

        let photos = try! drivePhotos.toBlocking().first()!
        
        XCTAssertEqual(photos.count, 1)
    }
    
    private func createInput(trigger: Observable<Void> = Observable.never()) -> PhotoViewModel.Input {
        let selection: Observable<IndexPath> = Observable.never()
        return PhotoViewModel.Input(trigger: trigger.asDriverOnErrorJustComplete(), selection: selection.asDriverOnErrorJustComplete())
    }
    
    private func createPhotos() -> [Photo] {
        let photoFirst = StubResponse.fromJSONFile("photo")
        
        if let photoJSON = try! JSONSerialization.jsonObject(with: photoFirst, options: []) as? [String: Any] {
            guard let photo = Mapper<Photo>().map(JSON: photoJSON) else { return [] }
            return [photo]
        } else {
            return []
        }
    }
}
