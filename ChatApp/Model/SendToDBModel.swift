//
//  SendToDBModel.swift
//  ChatApp
//
//  Created by HechiZan on 2021/08/23.
//

import Foundation
import FirebaseStorage

protocol SendProtocolOkDelegate {
    
    func sendProtocolOkDelegate(url:String)
    
    
    
}

//画像データをストレージサーバーへ送る

class SendToDBModel{

    
    var sendProfileOkDelegate:SendProtocolOkDelegate?
    
    
    init(){
        
        
    }
    
    func sendProfileImageData(data:Data){
        
        let image = UIImage(data: data)
        let profileImageData = image?.jpegData(compressionQuality: 0.1)
        
        let imageRef = Storage.storage().reference().child("profileImage").child("\(UUID().uuidString + String(Date().timeIntervalSince1970)).jpg")
        
        imageRef.putData(profileImageData!, metadata: nil) { (metaData,error) in
            
            if error != nil{
                
                print(error.debugDescription)
                return
            }
            
            imageRef.downloadURL { (url, error) in
                
                if error != nil{
                    
                    print(error.debugDescription)
                    return
            }
                
                UserDefaults.standard.setValue(url?.absoluteString, forKey: "userImage")
                self.sendProfileOkDelegate?.sendProtocolOkDelegate(url: url!.absoluteString)
        }
    }
    
}
}
