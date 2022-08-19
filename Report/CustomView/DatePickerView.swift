//
//  PickerVIewCcontroller.swift
//  Report
//
//  Created by yihuang on 2022/8/20.
//

import Foundation
import UIKit
class DatePickerView: UIView {
    
    let yearPicker = UIDatePicker()
    
    let topBarView = UIView()
        
    var didSeletedYear: String = ""
    
    var typeArray: [String] = []
    
    var confirmAction: ((String) -> ())? = nil
    
    let formatter = DateFormatter()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewTap) ))
        self.configurePicker()
        self.pickerDataSource()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configurePicker()
        self.pickerDataSource()
    }
    
    @objc func viewTap(){
        if let confirmAction = confirmAction {
            confirmAction(self.didSeletedYear)
        }
        print("dsaddadssa")
        self.removeFromSuperview()
    }
    
    func pickerDataSource() {


        // 設置 UIDatePicker 格式
        yearPicker.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        yearPicker.datePickerMode = .dateAndTime
        yearPicker.preferredDatePickerStyle = .wheels        
        yearPicker.locale = .init(identifier: "zh_TW")

        // 設置 UIDatePicker 預設日期為現在日期
        yearPicker.date = Date()
        yearPicker.addTarget(self, action: #selector(datePickerChanged), for: .valueChanged)
        
        formatter.dateFormat = "yyyy年MM月dd日 HH:mm:ss"
        self.didSeletedYear = formatter.string(from: Date())
    }
    @objc func datePickerChanged(datePicker: UIDatePicker) {
        self.didSeletedYear = formatter.string(from: datePicker.date)
    }
    
    
    func configurePicker() {
        
        let backView = UIView()
        backView.translatesAutoresizingMaskIntoConstraints = false
        backView.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        self.addSubview(backView)
        let backViewConstraints = [
            backView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            backView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            backView.heightAnchor.constraint(equalToConstant: 246)
        ]
        
        NSLayoutConstraint.activate(backViewConstraints)
        
        
        backView.addSubview(yearPicker)
        
        yearPicker.translatesAutoresizingMaskIntoConstraints = false
        yearPicker.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        
        let constraints = [
            yearPicker.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            yearPicker.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            yearPicker.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
            yearPicker.heightAnchor.constraint(equalToConstant: 220)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        backView.addSubview(topBarView)
        
        topBarView.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        
        topBarView.translatesAutoresizingMaskIntoConstraints = false

        topBarView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        topBarView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        topBarView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        topBarView.bottomAnchor.constraint(equalTo: self.yearPicker.topAnchor).isActive  = true
        
//        topBarView.layer.borderWidth = 1
//        topBarView.layer.borderColor = UIColor.gray.cgColor
        
        let button = UIButton(type: .custom)
        if #available(iOS 15.0, *) {
            button.configuration = nil
        }
        button.setTitle("完成", for: .normal)
        
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.setTitleColor(.red, for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        topBarView.addSubview(button)
        
        button.trailingAnchor.constraint(equalTo: topBarView.trailingAnchor, constant: -16).isActive = true
        button.centerYAnchor.constraint(equalTo: topBarView.centerYAnchor).isActive = true
        
    }
    
    @objc func buttonAction() {
        if let confirmAction = confirmAction {
            confirmAction(self.didSeletedYear)
        }
        print("dsaddadssa")
        
        self.removeFromSuperview()
    }
    
    
}

//extension YearPickerView: UIPickerViewDataSource {
//
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        1
//    }
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return typeArray.count
//    }
//
//
//}
//extension YearPickerView: UIPickerViewDelegate {
//
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//       return String(typeArray[row])
//    }
//
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        self.didSeletedYear = typeArray[row]
//    }
//}
