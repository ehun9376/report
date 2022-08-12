//
//  BottomBar.swift
//  Pet
//
//  Created by 陳逸煌 on 2022/7/15.
//

import Foundation
import UIKit

class StackBottomBarView: UIView {
    
    convenience init(buttons: [BottomBarButton] = []) {
        self.init(frame: .zero)
        self.setupView(bottomBarButtons: buttons)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    func createStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        stackView.spacing = 20
        return stackView
    }
    
    func setupView(bottomBarButtons: [BottomBarButton] = []) {
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        
        
        let stackView = createStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(stackView)
        
        stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        stackView.leadingAnchor.constraint(greaterThanOrEqualTo: self.leadingAnchor, constant: 33).isActive = true
        stackView.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: -33.0).isActive = true
        
        let totalButtons = bottomBarButtons.count
        let spacing: CGFloat = 20
        let availableWidth = UIScreen.main.bounds.width - CGFloat(totalButtons - 1) * spacing - 66
        let minWidth = min(availableWidth / CGFloat(totalButtons), CGFloat(140))
        
        for button in bottomBarButtons {
            
            stackView.addArrangedSubview(button)
            button.widthAnchor.constraint(equalToConstant: minWidth).isActive = true
        }
        
        
    }
    
    
}
