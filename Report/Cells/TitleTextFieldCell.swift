//
//  TitleTextFieldCell.swift
//  Report
//
//  Created by yihuang on 2022/8/12.
//

import Foundation
import UIKit

class TitleTextFieldCellRowModel: CellRowModel {
    
    override func cellReUseID() -> String {
        return "TitleTextFieldCell"
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
class TitleTextFieldCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var textFiled: UITextField!
    
    var rowModel: TitleTextFieldCellRowModel?
    
    override func awakeFromNib() {
        self.titleLabel.font = .systemFont(ofSize: 16)
        self.textFiled.font = .systemFont(ofSize: 14)
    }
    
}
extension TitleTextFieldCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let rowModel = rowModel, let action = rowModel.textFieldEditAction {
            action(textField.text ?? "")
        }
    }
}
extension TitleTextFieldCell: CellViewBase {
    func setupCellView(rowModel: CellRowModel) {
        guard let rowModel = rowModel as? TitleTextFieldCellRowModel else { return }
        self.rowModel = rowModel
        self.titleLabel.text = rowModel.title
    }
}
