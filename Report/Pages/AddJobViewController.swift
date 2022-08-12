//
//  AddJobViewController.swift
//  Report
//
//  Created by yihuang on 2022/8/12.
//

import Foundation

class AddJobViewController: BaseTableViewController {
    
    var jobModel: JobModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.regisCell(cellIDs: [
            "TitleTextFieldCell"
        ])
        self.setupRowModel()
    }
    
    func setupRowModel(){
        var rowModels: [CellRowModel] = []
        //TODO: -
        self.adapter?.updateTableViewData(rowModels: rowModels)
    }
    override func creatBottomBarButton() -> [BottomBarButton] {
        return [
            .apply(action: {
                FirebaseManager.shared.updateJobModel(child: .jobList, model: self.jobModel ?? nil) { error, applyID in
                    if let error = error {
                        self.showAlert(title: "提示",
                                       message: error.localizedDescription,
                                       confirmTitle: "確定",
                                       cancelTitle: "取消",
                                       confirmAction: {
                            self.navigationController?.popViewController(animated: true)
                        },
                                       cancelAction: nil)
                    } else {
                        self.showSingleAlert(title: "提示", message: "申請完成", confirmTitle: "確定", confirmAction: nil)
                    }
                }
            })
        ]
    }


}
