//
//  MasterViewController.swift
//  scrollingHideNavbar
//
//  Created by hir-suzuki on 2018/09/28.
//  Copyright © 2018年 hir-suzuki. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    var detailViewController: DetailViewController? = nil
    var objects = Array(repeating: "cell", count: 100)
    
    
    ///  スクロール開始地点
    var scrollBeginPoint: CGFloat = 0.0
    
    /// navigationBarが隠れているかどうか(詳細から戻った一覧に戻った際の再描画に使用)
    var lastNavigationBarIsHidden = false

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if lastNavigationBarIsHidden {
            self.navigationController?.setNavigationBarHidden(true, animated: false)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    /// スクロール開始検知
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        scrollBeginPoint = scrollView.contentOffset.y
    }

    /// スクロール量検知
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollDiff = scrollBeginPoint - scrollView.contentOffset.y
        updateNavigationBarHiding(scrollDiff: scrollDiff)
    }
    
    /// navigationBarの表示/非表示を更新
    func updateNavigationBarHiding(scrollDiff: CGFloat) {
        /// スクロール量の閾値
        let boundaryValue: CGFloat = 0.0
        
        /// navigationBar表示
        if scrollDiff > boundaryValue {
            navigationController?.setNavigationBarHidden(false, animated: true)
            lastNavigationBarIsHidden = false
            return
        }
        
        /// navigationBar非表示
        if scrollDiff < -boundaryValue {
            navigationController?.setNavigationBarHidden(true, animated: true)
            lastNavigationBarIsHidden = true
            return
        }
    }
    
    // MARK: - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            guard let indexPath = sender as? IndexPath else {
                return
            }
            let object = objects[indexPath.row]
            
            let controller = segue.destination as? DetailViewController
            controller?.detailItem = object
        }
    }
}

extension MasterViewController: UITableViewDelegate,UITableViewDataSource {
    // MARK: - Table View
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let object = objects[indexPath.row]
        cell.textLabel!.text = object.description
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetail", sender: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
