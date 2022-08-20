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
    
    var rowModels: [CellRowModel] = []
    
    let refreschControll = UIRefreshControl()
    
    var userMember: UserMember = .manager
    
    var jobModels: [JobModel] = []

    override func viewDidLoad() {

        super.viewDidLoad()
        
        switch self.userMember {
        case .custom:
            self.title = "申請清單"
        case .manager:
            self.title = "報修清單"
        }
        
        self.regisCell(cellIDs: [
            "TitleImageSwitchCell"
        ])
        self.getJobListFromFirebase()

        self.setupNavigationBar()
        
       
        self.addRefresh()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func addRefresh(){
        
        refreschControll.addTarget(self, action: #selector(reloadData), for: .valueChanged)
        self.defaultTableView.addSubview(refreschControll)
    }
    
    @objc func reloadData(){
        self.getJobListFromFirebase()
        
    }
    
    func setupNavigationBar(){

        if self.userMember == .custom {
            let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action:#selector(rightBarItemActionAdd))
            add.tintColor = .white
            self.navigationItem.rightBarButtonItems = [add]
        } else {
            let compose = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action:#selector(rightBarItemActionCompose))
            compose.tintColor = .white
            self.navigationItem.rightBarButtonItems = [compose]
        }
        
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationItem.backButtonTitle = ""
    }
    
    @objc func rightBarItemActionAdd() {
        let vc = AddJobViewController()
        vc.disApperAction = {
            self.getJobListFromFirebase()
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func rightBarItemActionCompose() {
        let controller = UIAlertController(title: "", message: "動作選單", preferredStyle: .actionSheet)
        
        let clearAll = UIAlertAction(title: "清除所有資料", style: .default) { _ in
            
            self.showAlert(title: "警告",
                           message: "確定要清除所有資料嗎",
                           confirmTitle: "確定",
                           cancelTitle: "取消",
                           confirmAction: {
                FirebaseManager.shared.clearChildAll(child: .jobList) { error, message in
                    if let error = error {
                        self.showSingleAlert(title: "出錯囉", message: error.localizedDescription, confirmTitle: "關閉", confirmAction: nil)
                    } else {
                        self.showSingleAlert(title: "提示", message: message, confirmTitle: "確定", confirmAction: {
                            self.getJobListFromFirebase()
                        })
                    }
                }
                
            },
                           cancelAction: nil)

        }
        let cancel = UIAlertAction(title: "取消", style: .cancel)
        controller.addAction(clearAll)
        controller.addAction(cancel)
        
        self.present(controller, animated: true, completion: nil)
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
        
        self.rowModels.removeAll()
        
        let sortModels = self.jobModels.sorted { lModel, rModel in
            return lModel.date ?? "" > rModel.date ?? ""
        }
        for model in sortModels {
            var doneStr = "待處理"
            var doneColor: UIColor = .black
            switch model.done {
            case 0 :
                doneStr = "待處理"
//                doneColor = .red
            case 1:
                doneStr = "處理中"
//                doneColor = .red
            case 2:
                doneStr = "已完成"
//                doneColor = .green
            default:
                doneStr = "待處理"
            }
            rowModels.append(TitleImageSwitchCellRowModel(title: model.title,
                                                          doneMessage: doneStr,
                                                          doneTextColor: doneColor,
                                                          isWho: self.userMember,
                                                          errorID: model.jobModelID,
//                                                          switchAction: { [weak self] isDone in
//            //TODO: - 抓到那個ID的事件然後更新
//                let model: JobModel = model
//                model.done = isDone
//                FirebaseManager.shared.updateJobStatus(child: .jobList, model: model, handler: {
//                    [weak self] (error,message) in
//                    if let error = error {
//                        self?.showSingleAlert(title: "出錯囉", message: error.localizedDescription, confirmTitle: "確定", confirmAction: nil)
//                    } else {
//                        self?.showSingleAlert(title: "提示", message: message, confirmTitle: "確定", confirmAction: nil)
//                    }
//
//                })
//            },
                                                          cellDidSelect: { [weak self] _  in
                self?.view.endEditing(true)
                let vc = DetailViewController()
                vc.disApperAction = {
                    self?.getJobListFromFirebase()
                }
                vc.jobModel = model
                vc.fromWho = self?.userMember ?? .custom
                self?.navigationController?.pushViewController(vc, animated: true)
            }))

        }
        //TODO: - 
        self.adapter?.updateTableViewData(rowModels: rowModels)
    }


}

