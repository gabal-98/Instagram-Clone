//
//  EditProfileViewController.swift
//  Instagram
//
//  Created by robusta on 05/05/2024.
//

import UIKit

struct EditProfileCellModel {
    var label: String
    var placeholder: String
    var value: String?
}

class EditProfileViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    private let tableView: UITableView = {
        let view = UITableView()
        view.register(FormTableViewCell.self, forCellReuseIdentifier: FormTableViewCell.identifier)
        return view
    }()
    
    var models = [[EditProfileCellModel]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureModels()
        view.backgroundColor = .systemBackground
        // Do any additional setup after loading the view.
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSaveButton))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(didTapCancelButton))
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableHeaderView = createTableViewHeader()
        
        view.addSubview(tableView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    func configureModels(){
        
        let section1Labels = ["Name" , "Username" , "Bio"]
        var section1 = [EditProfileCellModel]()
        for label in section1Labels {
            let sectionItem = EditProfileCellModel(label: label, placeholder: "Enter \(label)...", value: nil)
            section1.append(sectionItem)
        }
        models.append(section1)
        
        let section2Labels = ["Email" , "Phone" , "Gender"]
        var section2 = [EditProfileCellModel]()
        for label in section2Labels {
            let sectionItem = EditProfileCellModel(label: label, placeholder: "Enter \(label)...", value: nil)
            section2.append(sectionItem)
        }
        models.append(section2)
    }
    
    //MARK: - TableView Functions
    
    func createTableViewHeader() -> UIView {
        let header = UIView()
        header.frame = CGRect(x: 0, y: 0, width: view.width, height: view.height / 4).integral
        
        let size = header.height / 1.5
        let profilePhotoButton = UIButton(frame: CGRect(x: (view.width - size) / 2, y: (header.height - size) / 2, width: size, height: size))
        profilePhotoButton.setBackgroundImage(UIImage(systemName: "person.fill"), for: .normal)
        profilePhotoButton.tintColor = .label
        profilePhotoButton.layer.masksToBounds = true
        profilePhotoButton.layer.cornerRadius = size / 2.0
        profilePhotoButton.layer.borderWidth = 1
        profilePhotoButton.layer.borderColor = UIColor.secondarySystemBackground.cgColor
        profilePhotoButton.addTarget(self, action: #selector(didTapEditProfilePicture), for: .touchUpInside)
        
        header.addSubview(profilePhotoButton)
        
        return header
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.section][indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: FormTableViewCell.identifier, for: indexPath) as! FormTableViewCell
        cell.delegate = self
        cell.configure(with: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard section == 1 else {
            return nil
        }
        
        return "Private Information"
    }
    
    //MARK: - End of tableview functions
    
    @objc func didTapSaveButton(){
        dismiss(animated: true)
    }
    
    @objc func didTapCancelButton(){
        dismiss(animated: true)
    }
    
    @objc func didTapEditProfilePicture(){
        
        let actionSheet = UIAlertController(title: "Profile Picture", message: "Change Profile Picture", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Take Photo", style: .default , handler: { _ in
            //
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Choose from Library", style: .default , handler: { _ in
            //
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .destructive , handler: nil))
        
        actionSheet.popoverPresentationController?.sourceView = view
        actionSheet.popoverPresentationController?.sourceRect = view.bounds
        
        present(actionSheet, animated: true)
    }

}

extension EditProfileViewController: FormTableViewCellDelegate {
    
    func formTableViewCell(_ cell: FormTableViewCell, updatedModel: EditProfileCellModel) {
        print(updatedModel.value!)
        print(updatedModel.label)
    }
}
