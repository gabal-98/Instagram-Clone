//
//  DatabaseManager.swift
//  Instagram
//
//  Created by robusta on 05/05/2024.
//

import Foundation
import FirebaseDatabase

public class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    let database = Database.database().reference()
    
    public func canCreateNewUser(username: String , email: String , completion: ((Bool) -> Void)) {
        completion(true)
    }
    
    public func insertNewUser(email: String , username: String , completion: @escaping ((Bool) -> Void)){
        
        database.child(email.selfDatabaseKey()).setValue(["username": username]){ error , _ in
            if error == nil {
                completion(true)
                return
            }else {
                completion(false)
                print(error as Any)
                return
            }
        }
    }
}
