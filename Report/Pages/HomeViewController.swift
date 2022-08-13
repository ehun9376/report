//
//  HomeViewController.swift
//  Report
//
//  Created by yihuang on 2022/8/13.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupView()
    }
    
    func setupView(){
        let insideView = UIView()
        insideView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(insideView)
        insideView.heightAnchor.constraint(equalToConstant: 210).isActive = true
        insideView.leadingAnchor .constraint(equalTo: self.view.leadingAnchor,constant: 20).isActive = true
        insideView.trailingAnchor .constraint(equalTo: self.view.trailingAnchor,constant: -20).isActive = true
        insideView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor) .isActive = true
//        insideView.backgroundColor = .yellow
        
        let customButton = UIButton()
        customButton.translatesAutoresizingMaskIntoConstraints = false
        customButton.setTitle("我是顧客", for: .normal)
        customButton.setTitleColor(.white, for: .normal)
        customButton.backgroundColor = .darkGray
        customButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        insideView.addSubview(customButton)
        customButton.topAnchor.constraint(equalTo: insideView.topAnchor).isActive = true
        customButton.leadingAnchor.constraint(equalTo: insideView.leadingAnchor).isActive = true
        customButton.trailingAnchor.constraint(equalTo: insideView.trailingAnchor).isActive = true
        customButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
        customButton.layer.cornerRadius = 15
        customButton.clipsToBounds = true
        
        let managerButton = UIButton()
        managerButton.translatesAutoresizingMaskIntoConstraints = false
        managerButton.setTitle("我是管理員", for: .normal)
        managerButton.setTitleColor(.black, for: .normal)
        managerButton.backgroundColor = .systemGray
        managerButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        managerButton.layer.cornerRadius = 15
        managerButton.clipsToBounds = true

        insideView.addSubview(managerButton)
        
        managerButton.topAnchor.constraint(equalTo: customButton.bottomAnchor,constant: 10).isActive = true
        managerButton.leadingAnchor.constraint(equalTo: insideView.leadingAnchor).isActive = true
        managerButton.trailingAnchor.constraint(equalTo: insideView.trailingAnchor).isActive = true
        managerButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
    }
    @objc func buttonAction(_ button:UIButton){
        var member: UserMember = .custom
        switch button.titleLabel?.text {
        case "我是顧客":
            member = .custom
        case "我是管理員":
            member = .manager
        default:
            return
        }
        let vc = JobListViewController()
        vc.userMember = member
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.modalPresentationStyle = .fullScreen
        self.present(navigationController, animated: true)
        
        
    }
    
}
