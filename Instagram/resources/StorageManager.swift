//
//  StorageManager.swift
//  Instagram
//
//  Created by robusta on 05/05/2024.
//

import Foundation
import FirebaseStorage


public class StorageManager {
    
    static let shared = StorageManager()
    
    let bucket = Storage.storage().reference()
    
    public enum IGStorageManagerError: Error {
        case failedToDownload
    }
    
    func uploadUserPost(model: UserPost , completion: @escaping (Result<URL, Error>) -> Void) {
        
    }
    
    public func downLoadImage(with reference: String , completion: @escaping (Result<URL , IGStorageManagerError>) -> Void){
        bucket.child(reference).downloadURL { url, error in
            guard let url = url , error == nil else {
                completion(.failure(.failedToDownload))
                return
            }
            completion(.success(url))
        }
    }
    
    
}

enum UserPostType {
    case Photo , Video
}

struct UserPost {
    
}
