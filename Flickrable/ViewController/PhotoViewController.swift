//
//  PhotoViewController.swift
//  Flickrable
//
//  Created by TriNgo on 11/30/17.
//  Copyright © 2017 TriNgo. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class PhotoViewController: UIViewController {

    var viewModel: PhotoViewModel!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        bindViewModel()
    }
    
    func bindViewModel() {
        viewModel = PhotoViewModel()
        let viewWillAppear = rx.sentMessage(#selector(UIViewController.viewWillAppear(_:)))
            .mapToVoid()
            .asDriverOnErrorJustComplete()
        
        let input = PhotoViewModel.Input(trigger: viewWillAppear)
        let output = viewModel.transform(input: input)
        
        output.photos.drive(onNext: { photoResponse in
            print(photoResponse.toJSON())
        })
        .disposed(by: disposeBag)
        
    }
}
