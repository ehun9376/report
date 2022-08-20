//
//  DetailViewController.swift
//  Report
//
//  Created by yihuang on 2022/8/12.
//

import Foundation

class DetailViewController: BaseTableViewController {
    
    var fromWho: UserMember = .custom
    
    var jobModel: JobModel?
    
    var disApperAction: (()->())?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.regisCell(cellIDs: [
            "TitleDetailCell",
            "TitleTextFieldCell"
        ])
        if self.fromWho == .manager {
            self.read()
        }
        self.setupRow()
        self.title = "報修單"
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if let disApperAction = disApperAction {
            disApperAction()
        }
    }
    
    func read(){
        guard let jobModel = jobModel else {
            return
        }
        if jobModel.done == 0 {
            jobModel.done = 1
            FirebaseManager.shared.updateJobStatus(model: jobModel) { error, str in
                if let error = error {
                    
                    self.showSingleAlert(title: "出錯囉，請再試一次",
                                         message: error.localizedDescription,
                                         confirmTitle: "確定") {
                        self.navigationController?.popViewController(animated: true)
                    }
                }

            }
        }
    }
    func setupRow(){
        guard let jobModel = jobModel else {
            return
        }
        //    報修人
        //    聯絡電話
        //    故障地點
        //    故障類別
        //    情況概述
        //    報修日期
        var rowModels: [CellRowModel] = []
        rowModels.append(TitleDetailCellRowModel(title: "標題",
                                                 detail: jobModel.title,
                                                 cellAction: {
            [weak self] _ in
            self?.view.endEditing(true)
        }))
        rowModels.append(TitleDetailCellRowModel(title: "報修人",
                                                 detail: jobModel.name,
                                                 cellAction: {
            [weak self] _ in
            self?.view.endEditing(true)
        }))
        rowModels.append(TitleDetailCellRowModel(title: "聯絡電話",
                                                 detail: jobModel.phoneNumber,
                                                 cellAction: {
            [weak self] _ in
            self?.view.endEditing(true)
        }))
        rowModels.append(TitleDetailCellRowModel(title: "故障地點",
                                                 detail: jobModel.place,
                                                 cellAction: {
            [weak self] _ in
            self?.view.endEditing(true)
        }))
        rowModels.append(TitleDetailCellRowModel(title: "故障類別",
                                                 detail: jobModel.errorClass,
                                                 cellAction: {
            [weak self] _ in
            self?.view.endEditing(true)
        }))
        rowModels.append(TitleDetailCellRowModel(title: "問題描述",
                                                 detail: jobModel.errorMessage,
                                                 cellAction: {
            [weak self] _ in
            self?.view.endEditing(true)
        }))
        rowModels.append(TitleDetailCellRowModel(title: "報修日期",
                                                 detail: jobModel.date,
                                                 cellAction: {
            [weak self] _ in
            self?.view.endEditing(true)
        }))

        var doneStr = "待處理"
        switch jobModel.done {
        case 0 :
            doneStr = "待處理"
        case 1:
            doneStr = "處理中"
        case 2:
            doneStr = "已完成"
        default:
            doneStr = "待處理"
        }

        rowModels.append(TitleDetailCellRowModel(title: "維修進度",
                                                 detail: doneStr,
                                                 cellAction: {
            [weak self] _ in
            self?.view.endEditing(true)
        }))
        switch self.fromWho {
        case .custom:
            if jobModel.done == 2 {
                if let workName = jobModel.workingName {
                    rowModels.append(TitleDetailCellRowModel(title: "處理人",
                                                             detail: workName,
                                                             cellAction: {
                        [weak self] _ in
                        self?.view.endEditing(true)
                    }))
                }
                if let workTime = jobModel.workTime {
                    rowModels.append(TitleDetailCellRowModel(title: "處理時間",
                                                             detail: workTime,
                                                             cellAction: {
                        [weak self] _ in
                        self?.view.endEditing(true)
                    }))
                }
            }
        case .manager:
            rowModels.append(TitleTextFieldCellRowModel(title: "處理人",
                                                        textFieldText: jobModel.workingName ?? "",
                                                        textFieldEditAction: { str in
                self.jobModel?.workingName = str
            }))
            rowModels.append(TitleTextFieldCellRowModel(title: "處理時間",
                                                        textFieldText: jobModel.workTime ?? "",
                                                        textFieldCanEdit: false,
                                                        textFieldTouchAction: { [weak self] _ in
                guard let self = self else { return }
                self.view.endEditing(true)
                
                let pickerView = DatePickerView()
                pickerView.confirmAction = { returnDate in
                    self.jobModel?.workTime = returnDate
                    self.setupRow()
                }
                pickerView.translatesAutoresizingMaskIntoConstraints = false
                self.view.addSubview(pickerView)
                pickerView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
                pickerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
                pickerView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
                pickerView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
            }))
        }
        


        
        self.adapter?.updateTableViewData(rowModels: rowModels)

    }
    override func creatBottomBarButton() -> [BottomBarButton] {
        switch self.fromWho {
        case .custom:
            return []
        case .manager:
             return [

                .update(action: {
                    guard let _ = self.jobModel?.workTime , let _ = self.jobModel?.workingName else {
                        self.showSingleAlert(title: "提示",
                                             message: "姓名或日期沒有寫喔" ,
                                             confirmTitle: "確定",
                                             confirmAction: nil)
                        return
                    }
                    self.jobModel?.done = 2

                    FirebaseManager.shared.updateJobStatus(model: self.jobModel, handler: { error, message in
                        var messageStr: String = ""
                        if let error = error {
                            messageStr = error.localizedDescription
                        } else {
                            messageStr = message
                        }
                        self.showSingleAlert(title: "提示",
                                             message: messageStr,
                                             confirmTitle: "確定") {
                            self.navigationController?.popViewController(animated: true)
                        }
                    })

                })
             ]
        }
    }
    
}
