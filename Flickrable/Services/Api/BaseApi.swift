//
//  BaseApi.swift
//  Flickrable
//
//  Created by TriNgo on 11/30/17.
//  Copyright © 2017 TriNgo. All rights reserved.
//

import Foundation
import RxAlamofire
import AlamofireObjectMapper
import ObjectMapper

let flickr_base_url: String = "https://api.flickr.com/services/rest/"
let flickr_api_key: String = "70132be7596614d6bd46879d7c438031"

let ERROR_NORMAL_MESSAGE: String = "Error occured, please try again later."
let ERROR_TOKEN_EXPIRE_MESSAGE: String = "Session expired, Please login again!"

open class API {
    class func createCustomHeader() -> [String: String] {
        return ["Content-Type": "Application/json"]
    }
}

open class BaseApi {
    
}
