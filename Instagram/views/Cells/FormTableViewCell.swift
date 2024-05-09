//
//  FormTableViewCell.swift
//  Instagram
//
//  Created by robusta on 09/05/2024.
//

import UIKit

protocol FormTableViewCellDelegate: AnyObject {
    func formTableViewCell(_ cell: FormTableViewCell , updatedModel: EditProfileCellModel)
}

class FormTableViewCell: UITableViewCell , UITextFieldDelegate{

    static let identifier = "FormTableViewCellIdentifier"
    
    var delegate: FormTableViewCellDelegate?
    
    private let label: UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    private let txtField: UITextField = {
       let field = UITextField()
        field.returnKeyType = .done
        return field
    }()
    
    var model: EditProfileCellModel?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        clipsToBounds = true
        txtField.delegate = self
        contentView.addSubview(label)
        contentView.addSubview(txtField)
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        
        label.frame = CGRect(x: 5, y: 0, width: contentView.width / 3, height: contentView.height)
        txtField.frame = CGRect(x: label.width + 50, y: 0, width: contentView.width / 3, height: contentView.height)
    }
    
    func configure(with model: EditProfileCellModel){
        self.model = model
        label.text = model.label
        txtField.placeholder = model.placeholder
        txtField.text = model.value
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
        txtField.placeholder = nil
        txtField.text = nil
    }
    
    //MARK: - field
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        model?.value = txtField.text
        guard let model = model else {
            return true
        }
        delegate?.formTableViewCell(self, updatedModel: model)
        txtField.resignFirstResponder()
        return true
    }
}
