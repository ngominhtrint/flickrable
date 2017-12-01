//
//  PhotoViewModel.swift
//  Flickrable
//
//  Created by TriNgo on 11/30/17.
//  Copyright © 2017 TriNgo. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

final class PhotoViewModel: ViewModelType {
    struct Input {
        let trigger: Driver<Void>
    }
    
    struct Output {
        let photos: Driver<PhotoResponse>
        let error: Driver<Error>
    }
    
    init() { }
    
    func transform(input: PhotoViewModel.Input) -> PhotoViewModel.Output {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        
        let params: [String: Any] = ["method": "flickr.photos.getRecent", "api_key": flickr_api_key, "format": "json", "nojsoncallback": 1]
        
        let photos = input.trigger.flatMapLatest { _ in
            return PhotoApi<PhotoResponse>.getRecent(parameters: params)
                .trackActivity(activityIndicator)
                .trackError(errorTracker)
                .asDriverOnErrorJustComplete()
        }
        
        return Output(photos: photos, error: errorTracker.asDriver())
    }
}
