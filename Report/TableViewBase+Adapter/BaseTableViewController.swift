//
//  ViewController.swift
//  Pet
//
//  Created by Kai on 2022/7/10.
//

import UIKit

class BaseTableViewController: UIViewController {
    
    let defaultTableView = UITableView()
            
    var adapter: TableViewAdapter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.adapter = .init(self.defaultTableView)
        self.setDefaultTableView()
        self.setBottomBar()
        self.view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setDefaultApp()
        KeyboardHelper.shared.registFor(viewController: self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        KeyboardHelper.shared.unregist()
    }
    
    func setDefaultApp(){
        if #available(iOS 13.0, *) {
            let barAppearance = UINavigationBarAppearance()
            barAppearance.backgroundColor = .red
            barAppearance.shadowColor = .clear
            barAppearance.titleTextAttributes = [.foregroundColor:UIColor.white,.font: UIFont.systemFont(ofSize: 21)]
            navigationItem.standardAppearance = barAppearance
            navigationItem.scrollEdgeAppearance = barAppearance
        }

        if #available(iOS 15.0, *){
            UITableView.appearance().sectionHeaderTopPadding = 0
        }
    }
    
    func regisCell<celltype>(cellIDs: celltype){
        if let cellIDs = cellIDs as? [String]{
            for cellID in cellIDs {
                self.defaultTableView.register(UINib(nibName: cellID, bundle: nil), forCellReuseIdentifier: cellID)
            }
        }
        
        if let cellIDs = cellIDs as? [UITableViewCell.Type] {
            for cellID in cellIDs {
                self.defaultTableView.register(cellID, forCellReuseIdentifier: "\(cellID.self)")
            }
        }
        
    }
    
    func setDefaultTableView() {
        self.defaultTableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.defaultTableView)
        self.defaultTableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.defaultTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.defaultTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.defaultTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor,constant: -80.0).isActive = true
        self.defaultTableView.backgroundColor = .white
    }
    
    func creatBottomBarButton() -> [BottomBarButton] {
        return []
    }
    
    func setBottomBar() {
        
        guard self.creatBottomBarButton().count > 0 else {return}
        
        let bottomBarStackView = StackBottomBarView(buttons: self.creatBottomBarButton())
        bottomBarStackView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(bottomBarStackView)
        bottomBarStackView.topAnchor.constraint(equalTo: self.defaultTableView.bottomAnchor).isActive = true
        bottomBarStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        bottomBarStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        bottomBarStackView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        
    }
    
    func showAlert(title:String = "",message: String = "",confirmTitle: String = "",cancelTitle: String,confirmAction: (()->())? = nil,cancelAction:(()->())? = nil){
        let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: confirmTitle, style: .default) { _ in
            if let confirmAction = confirmAction {
                confirmAction()
            }
        }
        controller.addAction(okAction)
        
        let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel) { _ in
            if let cancelAction = cancelAction {
                cancelAction()
            }
        }
        controller.addAction(cancelAction)
        
        self.present(controller, animated: true, completion: nil)
    }
    
    func showSingleAlert(title:String = "",message: String = "",confirmTitle: String = "",confirmAction: (()->())? = nil){
        let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: confirmTitle, style: .default) { _ in
            if let confirmAction = confirmAction {
                confirmAction()
            }
        }
        controller.addAction(okAction)
        
        self.present(controller, animated: true, completion: nil)
    }

    
    
}

