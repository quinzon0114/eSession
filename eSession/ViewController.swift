//
//  ViewController.swift
//  eSession
//
//  Created by Marietta  on 27/08/2019.
//  Copyright © 2019 Marietta . All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKUIDelegate, WKNavigationDelegate, UIGestureRecognizerDelegate {
    @IBOutlet weak var webView: WKWebView!
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var backLabel: UIButton!
    
    @IBOutlet weak var views: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.webView.uiDelegate = self
        self.webView.scrollView.delegate = self as? UIScrollViewDelegate
        let swipeGesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(backNavigationFunction(_:)))
        swipeGesture.edges = .left
        swipeGesture.delegate = self
        webView.addGestureRecognizer(swipeGesture)
        print("working")
    }
    
    @objc func backNavigationFunction(_ sender: UIScreenEdgePanGestureRecognizer) {
        let dX = sender.translation(in: webView).x
        if sender.state == .ended {
            let fraction = abs(dX / webView.bounds.width)
            if fraction >= 0.03 {
                //back navigation code here
                let currURL = webView.url
                if currURL?.absoluteString.contains("esession.html") == false{
                    clickedButton()
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if(CheckInternet.Connection()){
            let url = URL(string:"https://esanggunian.mandaluyong.gov.ph/cgi-bin/cgiip.exe/WService=MandaluyongSPLMS/esession.html");
            let request = URLRequest(url: url!)
            webView.load(request);
            
        }else{
            self.Alert()
        }
    }
    
    func viewForZooming(in: UIScrollView) -> UIView? {
        return nil;
    }
    
    func Alert(){
        let alert = UIAlertController(title: "No Internet Connection!", message: "Please Connect To a WIFI or use Data!", preferredStyle: .alert)
        let yesButton = UIAlertAction(title: "Ok", style: .default, handler: {(_ action: UIAlertAction) -> Void in
           exit(0)
        })
        alert.addAction(yesButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    func webView(_ webView: WKWebView!, createWebViewWith configuration: WKWebViewConfiguration!, for navigationAction: WKNavigationAction!, windowFeatures: WKWindowFeatures!) -> WKWebView! {
        if navigationAction.targetFrame == nil {
            webView.load(navigationAction.request)
            views.isHidden = false
        }
        return nil
    }
    
    func webView(webView: WKWebView!, didFinishNavigation navigation: WKNavigation!) {
        print("WebView content loaded.")
    }
    
    @IBAction func onClick(_ sender: UIButton, forEvent event: UIEvent){
        clickedButton()
    }
    
    @IBAction func clickLabel(_ sender: UIButton, forEvent event: UIEvent){
        clickedButton()
    }
    
    func clickedButton(){
        webView.goBack()
        views.isHidden = true
    }
}

