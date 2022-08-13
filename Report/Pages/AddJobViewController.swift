//
//  AddJobViewController.swift
//  Report
//
//  Created by yihuang on 2022/8/12.
//

import Foundation

class AddJobViewController: BaseTableViewController {
    
    var jobModel: JobModel? = .init(json: [:])
    
    var disApperAction: (()->())?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "新增申請"
        self.regisCell(cellIDs: [
            "TitleTextFieldCell"
        ])
        self.defaultTableView.separatorStyle = .none
        self.setupRowModel()
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let disApperAction = disApperAction {
            disApperAction()
        }
    }
    
    func setupRowModel(){
        var rowModels: [CellRowModel] = []
        
        rowModels.append(TitleTextFieldCellRowModel(title: "標題",
                                                    textFieldEditAction: { str in
            self.jobModel?.title = str
        }))

        rowModels.append(TitleTextFieldCellRowModel(title: "報修設備",
                                                    textFieldEditAction: { str in
            self.jobModel?.device = str
        }))
        
        rowModels.append(TitleTextFieldCellRowModel(title: "問題描述",
                                                    textFieldEditAction: { str in
            self.jobModel?.errorMessage = str
        }))
        
        rowModels.append(TitleTextFieldCellRowModel(title: "單位",
                                                    textFieldEditAction: { str in
            self.jobModel?.unit = str
        }))
        
        rowModels.append(TitleTextFieldCellRowModel(title: "申請人",
                                                    textFieldEditAction: { str in
            self.jobModel?.name = str
        }))

        
        rowModels.append(TitleTextFieldCellRowModel(title: "聯絡電話",
                                                    textFieldEditAction: { str in
            self.jobModel?.phoneNumber = str
        }))
        
        
        self.adapter?.updateTableViewData(rowModels: rowModels)
    }
    override func creatBottomBarButton() -> [BottomBarButton] {
        return [
            .apply(action: {
                self.view.endEditing(true)
                FirebaseManager.shared.updateJobModel(child: .jobList, model: self.jobModel ?? nil) { error, applyID in
                    if let error = error {
                        self.showAlert(title: "出錯囉",
                                       message: error.localizedDescription,
                                       confirmTitle: "確定",
                                       cancelTitle: "取消",
                                       confirmAction: {
                            self.navigationController?.popViewController(animated: true)
                        },
                                       cancelAction: nil)
                    } else {
                        self.showSingleAlert(title: "提示",
                                             message: "申請完成",
                                             confirmTitle: "確定",
                                             confirmAction: {
                            self.navigationController?.popViewController(animated: true)
                        })
                    }
                }
            })
        ]
    }


}
