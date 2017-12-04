//
//  PhotoViewModel.swift
//  Flickrable
//
//  Created by TriNgo on 11/30/17.
//  Copyright © 2017 TriNgo. All rights reserved.
//

import UIKit
import Foundation
import RxCocoa
import RxSwift

final class PhotoViewModel: ViewModelType {
    struct Input {
        let trigger: Driver<Void>
        let selection: Driver<IndexPath>
    }
    
    struct Output {
        let fetching: Driver<Bool>
        let photos: Driver<[Photo]>
        let selectedPhoto: Driver<Photo>
        let error: Driver<Error>
    }
    
    init() { }
    
    func transform(input: PhotoViewModel.Input) -> PhotoViewModel.Output {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        
        let params: [String: Any] = ["method": "flickr.photos.getRecent",
                                     "api_key": flickr_api_key,
                                     "format": "json",
                                     "nojsoncallback": 1]
        
        let photos = input.trigger.flatMapLatest { _ in
            return PhotoApi<PhotoResponse>.getRecent(parameters: params)
                .trackActivity(activityIndicator)
                .trackError(errorTracker)
                .asDriverOnErrorJustComplete()
                .map { $0.photos! }
        }
        
        let fetching = activityIndicator.asDriver()
        let selectedPhoto = input.selection.withLatestFrom(photos) { (indexPath, photos) -> Photo in
            return photos[indexPath.row]
        }
        
        return Output(fetching: fetching,
                      photos: photos,
                      selectedPhoto: selectedPhoto,
                      error: errorTracker.asDriver())
    }
}
