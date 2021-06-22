//
//  originalPage.swift
//  recipeResearcher
//
//  Created by 洞井僚太 on 2021/06/22.
//

import Foundation
import UIKit
import WebKit

class originalPageViewController:UIViewController,WKNavigationDelegate,WKUIDelegate{
    var targetUrl:String!
    var webView = WKWebView()
    override func viewDidLoad() {
        webView.uiDelegate = self
        webView.navigationDelegate = self
        setupWebview()
    }
    func setupWebview() {
            // WKWebViewを作成と設定
            webView = WKWebView(frame: .zero, configuration: WKWebViewConfiguration())
            webView.allowsBackForwardNavigationGestures = true
            webView.backgroundColor = .white
            webView.navigationDelegate = self
            webView.uiDelegate = self
            
            // WKWebViewを追加してし制約を付与する
            self.view.addSubview(webView)
            // コードによるAutoLayoutの制約をWKWebViewへ付与する
            webView.translatesAutoresizingMaskIntoConstraints = false
            if #available(iOS 11.0, *) {
                webView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
                webView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor).isActive = true
                webView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor).isActive = true
            } else {
                webView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
                webView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
                webView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
            }
            webView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
            // 取得したいURLページをセットする
            requestPageUrl()
        }
        private func requestPageUrl() {
            if let url = URL(string: targetUrl) {
                let urlRequest = URLRequest(url: url)
                webView.load(urlRequest)
            }
        }
}
