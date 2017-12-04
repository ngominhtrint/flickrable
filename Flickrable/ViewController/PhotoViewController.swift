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

    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: PhotoViewModel!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureTableView()
        bindViewModel()
    }
    
    func configureTableView() {
        tableView.refreshControl = UIRefreshControl()
    }
    
    func bindViewModel() {
        viewModel = PhotoViewModel()
        let viewWillAppear = rx.sentMessage(#selector(UIViewController.viewWillAppear(_:)))
            .mapToVoid()
            .asDriverOnErrorJustComplete()
        
        let pull = tableView.refreshControl!.rx
            .controlEvent(.valueChanged)
            .asDriver()
        
        let input = PhotoViewModel.Input(trigger: Driver.merge(viewWillAppear, pull),
                                         selection: tableView.rx.itemSelected.asDriver())
        let output = viewModel.transform(input: input)
        
        output.photos.asObservable().bind(to:
            tableView.rx.items(cellIdentifier: PhotoCell.reuseID,
                               cellType: PhotoCell.self)) { (tv, photo, cell) in
            let photoItem = PhotoItemViewModel(with: photo)
            cell.bind(photoItem)
        }
        .disposed(by: disposeBag)
        
        output.fetching
            .drive(tableView.refreshControl!.rx.isRefreshing)
            .disposed(by: disposeBag)
        output.selectedPhoto
            .drive(onNext: { photo in
                performSegue(withIdentifier: <#T##String#>, sender: <#T##Any?#>)
            })
            .disposed(by: disposeBag)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        <#code#>
    }
}
