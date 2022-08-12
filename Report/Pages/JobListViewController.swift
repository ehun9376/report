//
//  ViewController.swift
//  Report
//
//  Created by 陳逸煌 on 2022/8/12.
//

import UIKit
enum UserMember{
    case custom
    case manager
}

class JobListViewController: BaseTableViewController {
    
    let refreschControll = UIRefreshControl()
    
    var userMember: UserMember = .manager
    
    var jobModels: [JobModel] = []

    override func viewDidLoad() {

        super.viewDidLoad()
        self.title = "申請清單"
        self.regisCell(cellIDs: [
            "TitleImageSwitchCell"
        ])
        self.getJobListFromFirebase()
        self.setupNavigationBar()
        refreschControll.addTarget(self, action: #selector(reloadData), for: .valueChanged)
        self.defaultTableView.addSubview(refreschControll)
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @objc func reloadData(){
        self.getJobListFromFirebase()
        
    }
    
    func setupNavigationBar(){
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action:#selector(rightBarItemAction))
        add.tintColor = .white
        self.navigationItem.rightBarButtonItems = [add]
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationItem.backButtonTitle = ""
    }
    
    @objc func rightBarItemAction() {
        let vc = AddJobViewController()
        vc.disApperAction = {
            self.getJobListFromFirebase()
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func getJobListFromFirebase(){
        self.jobModels.removeAll()
        FirebaseManager.shared.getJobList(child: .jobList) { jsonModels in
            self.refreschControll.endRefreshing()
            for model in jsonModels {
                let jobModel = JobModel(json: model)
                self.jobModels.append(jobModel)
            }
            self.setupRowModel()
        }
    }
    
    func setupRowModel(){
        var rowModels: [CellRowModel] = []
        
        let sortModels = self.jobModels.sorted { lModel, rModel in
            return lModel.date ?? "" > rModel.date ?? ""
        }
        for model in sortModels {
            rowModels.append(TitleImageSwitchCellRowModel(title: model.title,
                                                          done: model.done,
                                                          isWho: self.userMember,
                                                          switchAction: { [weak self] isDone in
            //TODO: - 抓到那個ID的事件然後更新
            },
                                                          cellDidSelect: { [weak self] _  in
                self?.view.endEditing(true)
            }))

        }
        //TODO: - 
        self.adapter?.updateTableViewData(rowModels: rowModels)
    }


}

