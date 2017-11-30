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
        return RxAlamofire
            .request(.get, absolutePath, parameters: parameters)
            .debug()
            .map { json -> T in
                return try Mapper<T>().map(JSONObject: json)
        }
    }
    
}
