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
    
    var done: Bool = false
    
    var isWho: UserMember = .custom
    
    var switchAction: ((Bool)->())?
    
    init(
        title: String? = "",
        done: Bool = false,
        isWho: UserMember = .custom,
        switchAction: ((Bool)->())?,
        cellDidSelect:((CellRowModel)->())?
    ){
        super.init()
        self.title = title
        self.done = done
        self.isWho = isWho
        self.switchAction = switchAction
        self.cellDidSelect = cellDidSelect
    }
    
}
class TitleImageSwitchCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var workingimageView: UIImageView!
    
    @IBOutlet weak var doneSwitch: UISwitch!
    
    var rowModel: TitleImageSwitchCellRowModel?
    
    override func awakeFromNib() {
        self.selectionStyle = .none
        self.titleLabel.font = .systemFont(ofSize: 18)
        self.doneSwitch.addTarget(self, action: #selector(switchAction), for: .valueChanged)
        self.workingimageView.contentMode = .scaleAspectFit
    }
    
    @objc func switchAction(_ swich:UISwitch) {
        if let rowModel = rowModel, let switchAction = rowModel.switchAction{
            switchAction(swich.isOn)
        }
    }
    
}

extension TitleImageSwitchCell: CellViewBase {
    func setupCellView(rowModel: CellRowModel) {
        guard let rowModel = rowModel as? TitleImageSwitchCellRowModel else { return }
        self.rowModel = rowModel
        self.titleLabel.text = rowModel.title
        self.workingimageView.isHidden = rowModel.isWho == .manager
        self.doneSwitch.isHidden = rowModel.isWho == .custom
        self.doneSwitch.setOn(rowModel.done, animated: false)
        self.workingimageView.image = UIImage(named: rowModel.done ? "check" : "working")?.resizeImage(targetSize: CGSize(width: 50, height: 50))
    }
    
}
