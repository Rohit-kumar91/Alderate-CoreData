//
//  PresentationViewVC.swift
//  Aldrete & Asociados
//
//  Created by NewMacMini1 on 05/07/19.
//  Copyright © 2019 Code-Brew Labs. All rights reserved.
//

import UIKit
import WebKit

class PresentationViewVC: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let pdf = Bundle.main.url(forResource: "App-Brewery", withExtension: "pdf", subdirectory: nil, localization: nil)  {
            let req = NSURLRequest(url: pdf)
            webView.loadRequest(req as URLRequest)
            self.view.addSubview(webView)
        }
    }
    

    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
