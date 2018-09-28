//
//  DetailViewController.swift
//  scrollingHideNavbar
//
//  Created by hir-suzuki on 2018/09/28.
//  Copyright © 2018年 hir-suzuki. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    
    var detailItem: String? {
        didSet {
            configureView()
        }
    }

    func configureView() {
        if let detail = detailItem {
            if let label = detailDescriptionLabel {
                label.text = detail.description
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        
        /// 詳細遷移の際、NavigationBarが非表示になってしまうので、表示にする
        navigationController?.setNavigationBarHidden(false, animated: false)
    }

}

