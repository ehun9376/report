//
//  BottomBarButton.swift
//  Pet
//
//  Created by 陳逸煌 on 2022/7/15.
//

import Foundation
import UIKit

class BottomBarButton: UIButton {
    
    var buttonTouchUpInsideAction: (()->())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    convenience init(
        touchUpInsideAction: (()->())?
    ) {
        self.init(frame: .zero)
        buttonTouchUpInsideAction = touchUpInsideAction
    }
    
    func setup(){
        self.addTarget(self, action: #selector(touchUpInsideAction), for: .touchUpInside)
    }
    
    @objc func touchUpInsideAction() {
        guard let buttonAction = buttonTouchUpInsideAction else {
            return
        }
        buttonAction()
    }
    
    func resetStatus(canClick: Bool = true) {
        DispatchQueue.main.async {
            self.backgroundColor = canClick ? UIColor.red : UIColor.gray
            self.isEnabled = canClick
        }
    }
    static func apply(action: (()->())?) -> BottomBarButton {
        let button = BottomBarButton(touchUpInsideAction: action)
        commonSet(button: button, action: action)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.red
        button.setTitle("申請", for: .normal)
        return button
    }
        
    class func commonSet(button: BottomBarButton, action: (()->())?) {
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .systemFont(ofSize: 18)
        button.clipsToBounds = true
        button.layer.cornerRadius = 9
    }
}
