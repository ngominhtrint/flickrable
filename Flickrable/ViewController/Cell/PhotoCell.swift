//
//  PhotoCell.swift
//  Flickrable
//
//  Created by TriNgo on 12/4/17.
//  Copyright © 2017 TriNgo. All rights reserved.
//

import UIKit
import AlamofireImage

class PhotoCell: UITableViewCell {

    @IBOutlet weak var postContentView: UIView!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var postTitle: UILabel!
    
    func bind(_ photoItem: PhotoItemViewModel) {
        if let imageUrl = URL(string: photoItem.imageUrl) {
            postImageView.af_setImage(withURL: imageUrl, placeholderImage: UIImage(named: "placeholder"), filter: nil, progress: nil, progressQueue: DispatchQueue.main, imageTransition: .crossDissolve(0.2), runImageTransitionIfCached: true, completion: nil)
        }
        
        postTitle.text = photoItem.title
    }
}
