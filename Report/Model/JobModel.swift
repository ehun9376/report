//
//  JobModel.swift
//  Report
//
//  Created by yihuang on 2022/8/12.
//

import Foundation

class JobModel {
    
//    報修人
//    聯絡電話
//    故障地點
//    故障類別
//    情況概述
//    報修日期
    
    ///事件ID
    var jobModelID: String?
    ///主旨
    var title:String?
    ///故障地點
    var place: String?
    ///故障類別
    var errorClass: String?
    ///情況概述
    var errorMessage: String?
    ///報修人
    var name: String?
    ///聯絡電話
    var phoneNumber: String?
    ///是否完成 0待處理 ，１處理中，２已完成
    var done: Int = 0
    ///日期
    var date: String? = ""
    
    ///處理的人
    var workingName: String?
    
    ///處理日期
    var workTime: String?
    
    
    init(
        jobModelID: String? = nil,
        title: String?,
        place: String?,
        errorClass: String?,
        errorMessage: String?,
        name: String?,
        phoneNumber: String?,
        done: Int = 0,
        date: String? = "",
        workingName: String?,
        workTime: String?
    ){
        self.jobModelID = jobModelID
        self.title = title
        self.place = place
        self.errorClass = errorClass
        self.errorMessage = errorMessage
        self.name = name
        self.phoneNumber = phoneNumber
        self.done = done
        self.date = date
        self.workingName = workingName
        self.workTime = workTime
    }
    
    convenience init(json:[String:Any]) {
        self.init(jobModelID: json["jobModelID"] as? String,
                  title: json["title"] as? String,
                  place:json["place"] as? String,
                  errorClass: json["errorClass"] as? String,
                  errorMessage: json["errorMessage"] as? String,
                  name: json["name"] as? String,
                  phoneNumber: json["phoneNumber"] as? String,
                  done: json["done"] as? Int ?? 0,
                  date: json["date"] as? String,
                  workingName: json["workingName"] as? String,
                  workTime: json["workTime"] as? String)
    
    }
    
    
    func getParam()->[String:Any] {

        return [
            "place" : self.place ?? "",
            "errorClass" : self.errorClass  ?? "",
            "errorMessage" : self.errorMessage ?? "",
            "name" : self.name ?? "",
            "phoneNumber" : self.phoneNumber ?? "",
            "done" : self.done,
            "jobModelID" : self.jobModelID ?? "",
            "title": self.title ?? "",
            "date" : self.date ?? "",
            "workingName" : self.workingName ?? "",
            "workTime" : self.workTime ?? ""
        ]
    }
}
