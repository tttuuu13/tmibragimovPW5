//
//  WebVC.swift
//  tmibragimovPW5
//
//  Created by тимур on 26.12.2024.
//

import UIKit
import WebKit

class WebVC: UIViewController {
    // MARK: - Properties
    private let webView: WKWebView
    private let url: URL
    
    // MARK: - Initializers
    init(url: URL) {
        self.webView = WKWebView()
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func loadView() {
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.load(URLRequest(url: url))
    }
}
