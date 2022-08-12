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
    
    var textFieldEditAction: ((String)->())?
    
    init(
        title: String? = "",
        textFieldEditAction: ((String)->())?
    ){
        super.init()
        self.title = title
        self.textFieldEditAction = textFieldEditAction
    }
    
}
class TitleImageSwitchCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var workingimageView: UIImageView!
    
    @IBOutlet weak var doneSwitch: UISwitch!
    
    var rowModel: TitleImageSwitchCellRowModel?
    
    override func awakeFromNib() {
        self.titleLabel.font = .systemFont(ofSize: 16)
    }
    
}

extension TitleImageSwitchCell: CellViewBase {
    func setupCellView(rowModel: CellRowModel) {
        guard let rowModel = rowModel as? TitleImageSwitchCellRowModel else { return }
        self.rowModel = rowModel
        self.titleLabel.text = rowModel.title
    }
}
