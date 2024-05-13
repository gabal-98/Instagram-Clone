//
//  ProfileTabsCollectionReusableView.swift
//  Instagram
//
//  Created by robusta on 09/05/2024.
//

import UIKit

class ProfileTabsCollectionReusableView: UICollectionReusableView {
        
    static let identifier = "ProfileTabsCollectionReusableViewIdentifier"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .orange
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
