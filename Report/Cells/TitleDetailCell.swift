//
//  TitleDetailCell.swift
//  Report
//
//  Created by yihuang on 2022/8/12.
//

import Foundation
import UIKit
class TitleDetailCellRowModel: CellRowModel {
    override func cellReUseID() -> String {
        return "TitleDetailCell"
    }
    var title: String?
    var detail: String?
    
    init(
        title: String?,
        detail: String?,
        cellAction: ((CellRowModel)->())? = nil
    ){
        super.init()
        self.title = title
        self.detail = detail
        self.cellDidSelect = cellAction
    }
}
class TitleDetailCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var detailLabel: UILabel!
    
    override func awakeFromNib() {
        self.selectionStyle = .none
        self.titleLabel.font = .systemFont(ofSize: 18)
        self.titleLabel.numberOfLines = 0
        self.titleLabel.lineBreakMode = .byWordWrapping
        
        self.detailLabel.font = .systemFont(ofSize: 16)
        self.detailLabel.numberOfLines = 0
        self.detailLabel.lineBreakMode = .byWordWrapping
    }
    
}
extension TitleDetailCell:CellViewBase {
    
    func setupCellView(rowModel: CellRowModel) {
        
        guard let rowModel = rowModel as? TitleDetailCellRowModel else { return }
        
        self.titleLabel.text = rowModel.title
        
        self.detailLabel.text = rowModel.detail
        
    }
}
