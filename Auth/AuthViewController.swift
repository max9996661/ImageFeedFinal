//
//  AuthViewController.swift
//  ImageFeedFinal
//
//  Created by Максим Казанцев on 20.08.2023.
//

import UIKit

protocol AuthViewControllerDelegate: AnyObject {
    func authViewController(_ vc: AuthViewController, didAuthenticateWithCode code: String)
}

final class AuthViewController: UIViewController {
    
//    private weak var delegateAuth: OAuth2ServiceProtocol?
//    private weak var delegateWBViewController: WebViewControllerDelegate?
    weak var delegate: AuthViewControllerDelegate?
    
//    init(delegateAuth: OAuth2ServiceProtocol, delegateWBViewController: WebViewControllerDelegate) {
//        self.delegateAuth = delegateAuth
//        self.delegateWBViewController = delegateWBViewController
//
//        super.init(nibName: nil, bundle: nil)
//    }
    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
            return .lightContent
        }
    
    func settingAuthIImageView() {
        
        let authImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.tintColor = UIColor(named: "YP Black")
            imageView.image = UIImage(named: "Logo_of_Unsplash")
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        } ()
        view.addSubview(authImageView)
        
        NSLayoutConstraint.activate([
            authImageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            authImageView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            authImageView.widthAnchor.constraint(equalToConstant: 60),
            authImageView.heightAnchor.constraint(equalToConstant: 60)
        
        ])
        
    }
    
    func settingAuthButton() {
        let authButton: UIButton = {
            let button = UIButton()
            button.addTarget(
                self,
                action: #selector(showWebViewVC),
                for: .touchUpInside)
            button.backgroundColor = UIColor(named: "YP White")
            button.setTitle("Войти", for: .normal)
            button.setTitleColor(UIColor(named: "YP Black"), for: .normal)
            button.titleLabel?.font = UIFont(name: "SF Pro", size: 17)
            button.titleLabel?.textAlignment = .center
            button.layer.cornerRadius = 16
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
        
        view.addSubview(authButton)
        
        NSLayoutConstraint.activate([
            authButton.widthAnchor.constraint(equalToConstant: 343),
            authButton.heightAnchor.constraint(equalToConstant: 48),
            authButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            authButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -90)
        
        ])
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "YP Black")
        settingAuthIImageView()
        settingAuthButton()
        
    }
    
    @objc func showWebViewVC() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "WebViewViewController") as! WebViewViewController
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        viewController.delegate = self
        
        self.show(viewController, sender: nil)
        
    }
    
}

extension AuthViewController: WebViewControllerDelegate {
    
    func webViewViewController(_vc: WebViewViewController, didAuthenticateWithCode code: String) {
        delegate?.authViewController(self, didAuthenticateWithCode: code)
        
    }
    
    
    func webViewViewControllerDidCancel(_vc: WebViewViewController) {
        dismiss(animated: true)
    }
    
    
}
