//
//  AuthViewController.swift
//  ImageFeed
//
//  Created by Kirill Gontsov on 27.07.2023.
//

import UIKit

protocol AuthViewControllerDelegate: AnyObject {
    func acceptToken(code: String)
}

final class AuthViewController: UIViewController {
    let showWebViewIdentifier = "ShowWebView"
    weak var delegate: AuthViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "ShowWebView" {
            let authView = segue.destination as? WebViewViewController
            if let unwrappedView = authView {
                unwrappedView.delegate = self
            }
        }
    }
}

extension AuthViewController: WebViewViewControllerDelegate {
    func webViewViewController(_ vc: WebViewViewController, didAuthenticateWithCode code: String) {
        delegate?.acceptToken(code: code)
    }
    
    func webViewViewControllerDidCancel(_ vc: WebViewViewController) {
        dismiss(animated: true)
    }
}
