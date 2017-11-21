//
//  ViewController.swift
//  webAppX
//
//  Created by Andrea Ceroli on 21/11/17.
//  Copyright © 2017 Aesys. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    
    @IBOutlet weak var forewardBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet var myView: UIView!
    @IBOutlet var myProgressView: UIProgressView!
    
    var webView: WKWebView!
    
    @IBAction func Indietro(_ sender: Any) {
        webView.goBack()
    }
    
    @IBAction func Avanti(_ sender: Any) {
        webView.goForward()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.webView = WKWebView(frame: self.view.frame)
        self.myView.addSubview(self.webView)
        self.webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        self.loadURL("www.apple.it")
        webView.allowsBackForwardNavigationGestures = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func loadURL(_ fromString: String) {
        var url: URL?
        url = URL(string: "http://" + fromString) // creo un URL partendo dalla stringa
        let request = URLRequest(url: url!) // creo la richiesta da far effettuare alla webview
        self.webView.load(request) // performo la richiesta
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if (webView.canGoForward==true){
            forewardBtn.isHidden=false
        }
        else
        {
            forewardBtn.isHidden=true
        }
        
        if (webView.canGoBack==true){
            backBtn.isHidden=false
        }
        else
        {
            backBtn.isHidden=true
        }
        
        if (keyPath == "estimatedProgress") {
            myProgressView.isHidden = webView.estimatedProgress == 1
            myProgressView.setProgress(Float(webView.estimatedProgress), animated: true)
        }
    }
}
