//
//  Photo.swift
//  Flickrable
//
//  Created by TriNgo on 11/30/17.
//  Copyright © 2017 TriNgo. All rights reserved.
//

import Foundation
import ObjectMapper

class Photo: Mappable {
    
    public var id: String?
    public var owner: String?
    public var secret: String?
    public var server: String?
    public var farm: Int?
    public var title: String?
    public var isPublic: Int?
    public var isFriend: Int?
    public var isFamily: Int?
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        id <- map["id"]
        owner <- map["owner"]
        secret <- map["secret"]
        server <- map["server"]
        farm <- map["farm"]
        title <- map["title"]
        isPublic <- map["ispublic"]
        isFriend <- map["isfriend"]
        isFamily <- map["isfamily"]
    }
}
