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
    
    weak var delegate: AuthViewControllerDelegate?
    private let ShowWebViewSegueIdentifier = "ShowWebView"
    
    @IBOutlet weak var enterButton: UIButton!
    
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
            enterButton.backgroundColor = UIColor(named: "YP White")
            enterButton.setTitle("Войти", for: .normal)
            enterButton.setTitleColor(UIColor(named: "YP Black"), for: .normal)
            enterButton.titleLabel?.font = UIFont(name: "SF Pro", size: 17)
            enterButton.titleLabel?.textAlignment = .center
            enterButton.layer.cornerRadius = 16
            enterButton.translatesAutoresizingMaskIntoConstraints = false

        
        NSLayoutConstraint.activate([
            enterButton.widthAnchor.constraint(equalToConstant: 343),
            enterButton.heightAnchor.constraint(equalToConstant: 48),
            enterButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            enterButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -90)
        
        ])
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "YP Black")
        settingAuthIImageView()
        settingAuthButton()
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == ShowWebViewSegueIdentifier {
                guard let webViewViewController = segue.destination as? WebViewViewController else {
                    assertionFailure("Failed to prepare for \(ShowWebViewSegueIdentifier)")
                    return
                }
                webViewViewController.delegate = self
            } else {
                super.prepare(for: segue, sender: sender)
            }
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
