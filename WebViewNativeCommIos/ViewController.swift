//
//  ViewController.swift
//  WebViewNativeCommIos
//
//  Created by Hari on 01/02/20.
//  Copyright © 2020 Hari. All rights reserved.
//

import UIKit
import WebKit


class ViewController: UIViewController , WKScriptMessageHandler{
    
    @IBOutlet weak var mWebKitView: WKWebView!
    
    @IBOutlet weak var mEdtTxt: UITextField!
    
    
    var mNativeToWebHandler : String = "jsMessageHandler"
    
    var mWebPageName : String = "sampleweb"
    
    var mWebPageExtension : String = "html"
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if let url = Bundle.main.url(forResource: mWebPageName, withExtension: mWebPageExtension) {
            
            mWebKitView.configuration.preferences.javaScriptEnabled = true
            
            mWebKitView.loadFileURL(url, allowingReadAccessTo: url.deletingLastPathComponent())
        }
        
        let contentController = WKUserContentController()
        
        mWebKitView.configuration.userContentController = contentController
        
        mWebKitView.configuration.userContentController.add(self, name: mNativeToWebHandler)
        
    }
    
    @IBAction func sendButtonPressed(_ sender: UIButton) {
        
        let data = String(mEdtTxt.text ?? "")
        
        self.mWebKitView.evaluateJavaScript("document.getElementById('inputField').value='\(data)'")
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
        if message.name == mNativeToWebHandler {
            mEdtTxt.text = message.body as? String
        }
    }
}

