//
//  WebViewController.swift
//  Task-vajro
//
//  Created by Nabbel on 08/11/24.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    let webView = WKWebView()
    
    var htmlContents = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if htmlContents.isEmpty {
            print("Error: HTML content is empty!")
            return
        }
        
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        print("HTML Content: \(htmlContents)")
        
        webView.loadHTMLString(htmlContents, baseURL: nil)
    }


}


extension WebViewController : WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
           print("Page loaded successfully.")
       }
       
       func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
           print("Page failed to load with error: \(error.localizedDescription)")
       }
    
}
