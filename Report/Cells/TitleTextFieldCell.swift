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
    
    var textFieldText: String?
    
    var textFieldCanEdit: Bool = true
    
    var textFieldTouchAction: ((CellRowModel)->())? = nil
    
    var textFieldEditAction: ((String)->())? = nil
    
    init(
        title: String? = "",
        textFieldText: String? = nil,
        textFieldCanEdit: Bool = true,
        textFieldTouchAction: ((CellRowModel)->())? = nil,
        textFieldEditAction: ((String)->())? = nil
    ){
        super.init()
        self.title = title
        self.textFieldText = textFieldText
        self.textFieldCanEdit = textFieldCanEdit
        self.cellDidSelect = textFieldTouchAction
        self.textFieldEditAction = textFieldEditAction
    }
    
}
class TitleTextFieldCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var textFiled: UITextField!
    
    var rowModel: TitleTextFieldCellRowModel?
    
    override func awakeFromNib() {
        self.selectionStyle = .none
        self.textFiled.delegate = self
        self.titleLabel.font = .systemFont(ofSize: 18)
        self.textFiled.font = .systemFont(ofSize: 16)
        self.textFiled.layer.borderColor = UIColor.black.cgColor
        self.textFiled.layer.borderWidth = 1
        self.textFiled.layer.cornerRadius = 6
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
        self.textFiled.isEnabled = rowModel.textFieldCanEdit
        if let text = rowModel.textFieldText {
            self.textFiled.text = text
        } else {
            self.textFiled.text = nil
        }
    }
}
