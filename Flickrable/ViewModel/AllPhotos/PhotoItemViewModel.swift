//
//  PhotoItemViewModel.swift
//  Flickrable
//
//  Created by TriNgo on 12/2/17.
//  Copyright © 2017 TriNgo. All rights reserved.
//

import Foundation

final class PhotoItemViewModel {
    var title: String = ""
    var imageUrl: String = ""
    
    init (with photo: Photo) {
        self.title = photo.title!
        self.imageUrl = "https://farm\(photo.farm!).staticflickr.com/\(photo.server!)/\(photo.id!)_\(photo.secret!).jpg"
    }
}
