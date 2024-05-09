//
//  SettingsViewController.swift
//  Instagram
//
//  Created by robusta on 05/05/2024.
//

import UIKit
import SafariServices

struct SettingCellModel {
    let title: String
    let handler: (() -> Void)
}

final class SettingsViewController: UIViewController {
    
    var data = [[SettingCellModel]]()
    
    private let tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .grouped)
        view.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        configureData()

        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        tableView.frame = view.bounds
    }
    
    func configureData(){
        
        data.append([
            SettingCellModel(title: "Edit Profile", handler: { [weak self] in
                self?.didTapEditProfile()
            }),
            SettingCellModel(title: "Invite Friends", handler: { [weak self] in
                self?.didTapInviteFriends()
            }),
            SettingCellModel(title: "Save Original Posts", handler: { [weak self] in
                self?.didTapSaveOriginalPosts()
            }),
        ])
        
        data.append([
            SettingCellModel(title: "Terms of Service", handler: { [weak self] in
                self?.openURL(type: .terms)
            }),
            SettingCellModel(title: "Privacy Policy", handler: { [weak self] in
                self?.openURL(type: .privacy)
            }),
            SettingCellModel(title: "Help / Feedback", handler: { [weak self] in
                self?.openURL(type: .help)
            }),
        ])

        data.append([
            SettingCellModel(title: "Logout", handler: { [weak self] in
                self?.didTapLogout()
            })
        ])
    }
    
    enum SettingsURLType {
        case terms , privacy , help
    }
    
    func didTapEditProfile(){
        let vc = EditProfileViewController()
        vc.title = "Edit Profile"
        let navVC = UINavigationController(rootViewController: vc)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
    }
    
    func didTapInviteFriends(){
        
    }
    
    func didTapSaveOriginalPosts(){
        
    }
    
    func openURL(type: SettingsURLType){
        var urlString: String?
        switch type {
          case .terms: urlString = "https://help.instagram.com/581066165581870"
          case .privacy: urlString = "https://help.instagram.com/196883487377501"
          case .help: urlString = "https://help.instagram.com/"
        }
        
        guard let url = URL(string: urlString!) else {
            return
        }
        
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    func didTapLogout(){
        
        let actionSheet = UIAlertController(title: "Logout", message: "Are you sure you want to logout ?", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Logout", style: .default , handler: { _ in
            AuthManager.shared.logout { success in
                if success {
                    let vc = LoginViewController()
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true) {
                        self.tabBarController?.selectedIndex = 0
                        self.navigationController?.popToRootViewController(animated: false)
                    }
                }else {
                    fatalError("can not logout")
                }
            }
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .destructive , handler: nil))
        present(actionSheet, animated: true)
    }
}

extension SettingsViewController: UITableViewDelegate , UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell" , for: indexPath)
        cell.textLabel?.text = data[indexPath.section][indexPath.row].title
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        data[indexPath.section][indexPath.row].handler()
    }
}
