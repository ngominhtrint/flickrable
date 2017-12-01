//
//  PhotoApi.swift
//  Flickrable
//
//  Created by TriNgo on 11/30/17.
//  Copyright © 2017 TriNgo. All rights reserved.
//

import Foundation
import RxSwift
import RxAlamofire
import ObjectMapper

public final class PhotoApi<T: ImmutableMappable> {
    
    open class func getRecent(parameters: [String: Any]) -> Observable<T> {
        let absolutePath = flickr_base_url
        let scheduler = ConcurrentDispatchQueueScheduler(qos: DispatchQoS(qosClass: DispatchQoS.QoSClass.background, relativePriority: 1))
        return RxAlamofire
            .json(.get, absolutePath, parameters: parameters)
            .debug()
            .observeOn(scheduler)
            .map { json -> T in
                return try Mapper<T>().map(JSONObject: json)
        }
    }
    
}
