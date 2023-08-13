//
//  ProfileViewController.swift
//  ImageFeedFinal
//
//  Created by Максим Казанцев on 23.07.2023.
//

import UIKit

class ProfileViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
// MARK: - setting Image
        let avatarImage: UIImage! = {
            guard let image = UIImage(named: "personImage") else {return UIImage()}
            return image
        }()
        
        let imageView : UIImageView = {
            let imageV = UIImageView(image: avatarImage)
            imageV.tintColor = .black
            imageV.translatesAutoresizingMaskIntoConstraints = false
            return imageV
        }()
        
        view.addSubview(imageView)
        
// MARK: - setting Label name
        let nameLabel: UILabel = {
            let label = UILabel()
            label.text = "Екатерина Новикова"
            label.font = UIFont(descriptor: UIFontDescriptor(name: "SFPro-Bold", size: 23), size: 23)
            label.textColor = UIColor(named: "YP White")
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        view.addSubview(nameLabel)
// MARK: - setting loginLabel
        let loginNameLabel: UILabel = {
            let label = UILabel()
            label.text = "@ekaterina_nov"
            label.font = UIFont(descriptor: UIFontDescriptor(name: "SFPro-Regular", size: 13), size: 13)
            label.textColor = UIColor(named: "YP Gray")
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        view.addSubview(loginNameLabel)
// MARK: - descriptionLabel
        let descriptionLabel: UILabel = {
            let label = UILabel()
            label.text = "Hello, World!"
            label.font = UIFont(descriptor: UIFontDescriptor(name: "SFPro-Regular", size: 13), size: 13)
            label.textColor = UIColor(named: "YP White")
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        view.addSubview(descriptionLabel)
// MARK: - setting logoutButton
        let logoutButton: UIButton = UIButton.systemButton(with: UIImage(named: "ExitEmage")!, target: self, action: #selector(logoutButtonAction))
        logoutButton.tintColor = .red
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(logoutButton)
        
        
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 70),
            imageView.widthAnchor.constraint(equalToConstant: 70),
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            loginNameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            loginNameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            descriptionLabel.topAnchor.constraint(equalTo: loginNameLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            logoutButton.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            logoutButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
            
        ])
        
    }
    
    
    @objc func logoutButtonAction(_ sender: UIButton) {
        
    }
    
    

}
