//
//  PhotoResponse.swift
//  Flickrable
//
//  Created by TriNgo on 11/30/17.
//  Copyright © 2017 TriNgo. All rights reserved.
//

import Foundation
import ObjectMapper

class PhotoResponse: ImmutableMappable {
    
    public var photos: [Photo]?
    public var page: Int?
    public var pages: Int?
    public var perpage: Int?
    public var total: Int?
    
    required init(map: Map) throws { }
    
    func mapping(map: Map) {
        photos <- map["photos.photo"]
        page <- map["photos.page"]
        pages <- map["photos.pages"]
        perpage <- map["photos.perpage"]
        total <- map["photos.total"]
    }
}
