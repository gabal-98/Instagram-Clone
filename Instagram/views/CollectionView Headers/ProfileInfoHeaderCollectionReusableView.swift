//
//  ProfileInfoHeaderCollectionReusableView.swift
//  Instagram
//
//  Created by robusta on 09/05/2024.
//

import UIKit

class ProfileInfoHeaderCollectionReusableView: UICollectionReusableView {
        
    static let identifier = "ProfileInfoHeaderCollectionReusableViewIdentifier"
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBlue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
