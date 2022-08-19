//
//  TitleImageSwitchCell.swift
//  Report
//
//  Created by yihuang on 2022/8/12.
//

import Foundation
import UIKit
class TitleImageSwitchCellRowModel: CellRowModel {
    
    override func cellReUseID() -> String {
        return "TitleImageSwitchCell"
    }
    
    var title: String? = ""
    
    var doneMessage: String = ""
    
    var doneTextColor: UIColor = .black
    
    var isWho: UserMember = .custom
    
    var switchAction: ((Bool)->())?
    
    var errorID: String?
    
    init(
        title: String? = "",
        doneMessage: String = "",
        doneTextColor: UIColor = .black,
        isWho: UserMember = .custom,
        errorID: String?,
//        switchAction: ((Bool)->())?,
        cellDidSelect:((CellRowModel)->())?
    ){
        super.init()
        self.title = title
        self.doneMessage = doneMessage
        self.doneTextColor = doneTextColor
        self.isWho = isWho
        self.errorID = errorID
//        self.switchAction = switchAction
        self.cellDidSelect = cellDidSelect
    }
    
}
class TitleImageSwitchCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var statusLabel: UILabel!
    
    var rowModel: TitleImageSwitchCellRowModel?
    
    override func awakeFromNib() {
        self.selectionStyle = .none
        self.titleLabel.font = .systemFont(ofSize: 22)
        self.statusLabel.font = .systemFont(ofSize: 16)
    }
    
//    @objc func switchAction(_ swich:UISwitch) {
//        if let rowModel = rowModel, let switchAction = rowModel.switchAction{
//            switchAction(swich.isOn)
//        }
//    }
    
}

extension TitleImageSwitchCell: CellViewBase {
    func setupCellView(rowModel: CellRowModel) {
        guard let rowModel = rowModel as? TitleImageSwitchCellRowModel else { return }
        self.rowModel = rowModel
        self.titleLabel.text = rowModel.title
        self.statusLabel.text = rowModel.doneMessage
        self.statusLabel.textColor = rowModel.doneTextColor
//        self.workingimageView.isHidden = rowModel.isWho == .manager
//        self.doneSwitch.isHidden = rowModel.isWho == .custom
//        self.doneSwitch.setOn(rowModel.done, animated: false)
//        self.workingimageView.image = UIImage(named: rowModel.done ? "check" : "working")?.resizeImage(targetSize: CGSize(width: 50, height: 50))
    }
    
}
