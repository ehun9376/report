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
        //    報修人
        //    聯絡電話
        //    故障地點
        //    故障類別
        //    情況概述
        //    報修日期
        var rowModels: [CellRowModel] = []
        
        rowModels.append(TitleTextFieldCellRowModel(title: "標題",
                                                    textFieldText: self.jobModel?.title,
                                                    textFieldEditAction: { str in
            self.jobModel?.title = str
        }))
        rowModels.append(TitleTextFieldCellRowModel(title: "報修人",
                                                    textFieldText: self.jobModel?.name,
                                                    textFieldEditAction: { str in
            self.jobModel?.name = str
        }))
        
        
        rowModels.append(TitleTextFieldCellRowModel(title: "聯絡電話",
                                                    textFieldText: self.jobModel?.phoneNumber,
                                                    textFieldEditAction: { str in
            self.jobModel?.phoneNumber = str
        }))
        
        rowModels.append(TitleTextFieldCellRowModel(title: "故障地點",
                                                    textFieldText: self.jobModel?.place,
                                                    textFieldEditAction: { str in
            self.jobModel?.place = str
        }))

        rowModels.append(TitleTextFieldCellRowModel(title: "故障類別",
                                                    textFieldText: self.jobModel?.errorClass,
                                                    textFieldCanEdit: false,
                                                    textFieldTouchAction: { [weak self] _ in
            guard let self = self else { return }
            self.view.endEditing(true)
            
            let pickerView = ErrorTypePicker()
            pickerView.typeArray = ["1","2","3"]
            pickerView.confirmAction = { [weak self] returnType in
                guard let self = self else { return }
                self.jobModel?.errorClass = returnType
                self.setupRowModel()
            }
            pickerView.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(pickerView)
            pickerView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
            pickerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
            pickerView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
            pickerView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
            
            
        }))
        
        rowModels.append(TitleTextFieldCellRowModel(title: "情況概述",
                                                    textFieldText: self.jobModel?.errorMessage,
                                                    textFieldEditAction: { str in
            self.jobModel?.errorMessage = str
        }))
        
        //TODO: - 要不要做這個
        rowModels.append(TitleTextFieldCellRowModel(title: "報修日期",
                                                    textFieldText: self.jobModel?.date ?? "",
                                                    textFieldCanEdit: false,
                                                    textFieldTouchAction: {  _ in
            self.view.endEditing(true)
            let pickerView = DatePickerView()
            pickerView.confirmAction = { returnDate in
                self.jobModel?.date = returnDate
                self.setupRowModel()
            }
            pickerView.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(pickerView)
            pickerView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
            pickerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
            pickerView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
            pickerView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
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
