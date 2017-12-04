//
//  PhotoDetailViewController.swift
//  Flickrable
//
//  Created by TriNgo on 12/4/17.
//  Copyright © 2017 TriNgo. All rights reserved.
//

import UIKit

class PhotoDetailViewController: UIViewController {

    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var postTitle: UILabel!
    
    var photo: PhotoItemViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func setupView() {
        if let photoItem = photo, let imageUrl = URL(string: photoItem.imageUrl) {
            postImageView.af_setImage(withURL: imageUrl, placeholderImage: UIImage(named: "placeholder"), filter: nil, progress: nil, progressQueue: DispatchQueue.main, imageTransition: .crossDissolve(0.2), runImageTransitionIfCached: true, completion: nil)
            postTitle.text = photoItem.title
        }
    }
}
