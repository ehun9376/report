//
//  DetailViewController.swift
//  Report
//
//  Created by yihuang on 2022/8/12.
//

import Foundation

class DetailViewController: BaseTableViewController {
    
    var jobModel: JobModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.regisCell(cellIDs: [
            "TitleDetailCell"
        ])
        self.setupRow()
        self.title = jobModel?.title == "" ? "申請單" : jobModel?.title
    }
    func setupRow(){
        guard let jobModel = jobModel else {
            return
        }
        var rowModels: [CellRowModel] = []
        rowModels.append(TitleDetailCellRowModel(title: "標題",
                                                 detail: jobModel.title))
        rowModels.append(TitleDetailCellRowModel(title: "報修設備",
                                                 detail: jobModel.device))
        rowModels.append(TitleDetailCellRowModel(title: "問題描述",
                                                 detail: jobModel.errorMessage))
        rowModels.append(TitleDetailCellRowModel(title: "單位",
                                                 detail: jobModel.unit))
        rowModels.append(TitleDetailCellRowModel(title: "申請人",
                                                 detail: jobModel.name))
        rowModels.append(TitleDetailCellRowModel(title: "聯絡電話",
                                                 detail: jobModel.phoneNumber))
        rowModels.append(TitleDetailCellRowModel(title: "是否完成",
                                                 detail: jobModel.done ? "已完成" : "維修中"))

        
        self.adapter?.updateTableViewData(rowModels: rowModels)

    }
    
}
