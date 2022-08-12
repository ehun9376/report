//
//  JobModel.swift
//  Report
//
//  Created by yihuang on 2022/8/12.
//

import Foundation

class JobModel {
    ///事件ID
    var jobModelID: String?
    ///
    var title:String?
    ///單位
    var unit: String?
    ///裝備名稱
    var device: String?
    ///故障原因
    var errorMessage: String?
    ///申請人員
    var name: String?
    ///電話
    var phoneNumber: String?
    ///是否完成
    var done: Bool = false
    
    var date: String? = ""
    
    init(
        jobModelID: String? = nil,
        title: String?,
        unit: String?,
        device: String?,
        errorMessage: String?,
        name: String?,
        phoneNumber: String?,
        done: Bool = false,
        date: String? = ""
    ){
        self.jobModelID = jobModelID
        self.title = title
        self.unit = unit
        self.device = device
        self.errorMessage = errorMessage
        self.name = name
        self.phoneNumber = phoneNumber
        self.done = done
        self.date = date
    }
    convenience init(json:[String:Any]) {
        self.init(jobModelID: json["jobModelID"] as? String,
                  title: json["title"] as? String,
                  unit:json["unit"] as? String,
                  device: json["device"] as? String,
                  errorMessage: json["errorMessage"] as? String,
                  name: json["name"] as? String,
                  phoneNumber: json["phoneNumber"] as? String,
                  done: json["done"] as? Bool ?? false,
                  date: json["date"] as? String)
    
    }
    
    
    func getParam()->[String:Any] {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyyMMdd HH:mm:ss"
        let dateStr = dateformatter.string(from: Date())
        return [
            "unit" : self.unit ?? "",
            "device" : self.device  ?? "",
            "errorMessage" : self.errorMessage ?? "",
            "name" : self.name ?? "",
            "phoneNumber" : self.phoneNumber ?? "",
            "done" : self.done,
            "jobModelID" : self.jobModelID ?? "",
            "title": self.title ?? "",
            "date" : dateStr
        ]
    }
}
