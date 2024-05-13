//
//  PhotoCollectionViewCell.swift
//  Instagram
//
//  Created by robusta on 09/05/2024.
//

import UIKit
import SDWebImage

class PhotoCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "PhotoCollectionViewCellIdentifier"
    
    private let photoImageView: UIImageView = {
       let view = UIImageView()
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        photoImageView.frame = contentView.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.image = nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(photoImageView)
        contentView.clipsToBounds = true
        accessibilityHint = "Double Tap to open post"
        accessibilityLabel = "User Post image"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with model: UserPost){
        let thumbnailURL = model.thumbnailImage
        photoImageView.sd_setImage(with: thumbnailURL)
    }
    
    public func configure(debug imageName: String){
        photoImageView.image = UIImage(named: imageName)
    }
}
