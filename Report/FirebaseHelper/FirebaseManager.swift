//
//  FirebaseManager.swift
//  Report
//
//  Created by yihuang on 2022/8/12.
//
//https://report-cd21b-default-rtdb.firebaseio.com/
import Foundation
import FirebaseDatabase

enum FirebaseChild{
    case jobList
    var description: String {
        switch self {
        case .jobList:
            return "jobList"
        }
    }
}

class FirebaseManager: NSObject {
    
    static let shared = FirebaseManager()
    
    var url = "https://report-cd21b-default-rtdb.firebaseio.com/"
    
    var ref: DatabaseReference?
    
    convenience init(url:String?) {
        self.init()
        if let url = url {
            self.url = url
        }
        
    }
    
    override init() {
        super.init()
    }
    
    func getJobList(child: FirebaseChild = .jobList,handler:(([[String:Any]])->())?){
        self.ref = Database.database().reference(fromURL: self.url)
        self.ref?.child(child.description).observeSingleEvent(of: .value, with: { snapShot in
            if let jsonModelWhthID = snapShot.value as? NSDictionary {
                var jsonModels:[[String:Any]] = []
                for model in jsonModelWhthID.allValues {
                    if let model = model as? [String:Any] {
                        jsonModels.append(model)
                    }
                }
                if let handler = handler{
                    handler(jsonModels)
                }
            } else {
                if let handler = handler{
                    handler([])
                }
            }
        })
    }
    
    func updateJobModel(child: FirebaseChild = .jobList,model: JobModel?,handler:((Error?,String)->())?){
        self.ref = Database.database().reference(fromURL: self.url)
        let autoID: String = self.ref?.child(child.description).childByAutoId().key ?? ""
        let model: JobModel? = model
        model?.jobModelID = autoID
        self.ref?.child(child.description).child(autoID).setValue(model?.getParam(),
                                                                  withCompletionBlock: { error, re in

            if let handler = handler {
                if let error = error {
                    handler(error,"")
                } else {
                    handler(nil, autoID)
                }
            }
        })
        
    }
    
    func updateJobStatus(child: FirebaseChild = .jobList,model: JobModel?,handler:((Error?,String)->())?){
        self.ref = Database.database().reference(fromURL: self.url)
        self.ref?.child(child.description).child(model?.jobModelID ?? "").setValue(model?.getParam(),
                                                                 withCompletionBlock: { error, re in
            
            if let handler = handler {
                if let error = error {
                    handler(error,"")
                } else {
                    handler(nil, "更新完成")
                }
            }
        })
    }
    
    func addFireBaseObserver(child: FirebaseChild = .jobList,handler:(([String:Any])->())?){
        self.ref = Database.database().reference(fromURL: self.url)
        self.ref?.child(child.description).observe(.childChanged, with: { snapShot in
            if let jsonModel = snapShot.value as? [String:Any] {
                if let handler = handler{
                    handler(jsonModel)
                }
            }
        })
    }
    func clearChildAll(child: FirebaseChild = .jobList,handler:((Error?,String)->())?){
        self.ref = Database.database().reference(fromURL: self.url)
        self.ref?.child(child.description).setValue([:],
                                                    withCompletionBlock: { error, re in
            
            if let handler = handler {
                if let error = error {
                    handler(error,"")
                } else {
                    handler(nil, "刪除完成")
                }
            }
        })
    }
    
    
    
}
