//
//  ViewController.swift
//  Report
//
//  Created by 陳逸煌 on 2022/8/12.
//

import UIKit

class JobListViewController: BaseTableViewController {
    
    var jobModels: [JobModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.regisCell(cellIDs: [
            "TitleImageSwitchCell"
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getJobListFromFirebase()
    }
    
    func getJobListFromFirebase(){
        self.jobModels.removeAll()
        FirebaseManager.shared.getJobList(child: .jobList) { jsonModels in
            for model in jsonModels {
                let jobModel = JobModel(json: model)
                self.jobModels.append(jobModel)
            }
            self.setupRowModel()
        }
    }
    
    func setupRowModel(){
        var rowModels: [CellRowModel] = []
        //TODO: - 
        self.adapter?.updateTableViewData(rowModels: rowModels)
    }


}

