//
//  SplitVC.swift
//  Aldrete & Asociados
//
//  Created by Sandeep Kumar on 23/06/19.
//  Copyright © 2019 Code-Brew Labs. All rights reserved.
//

import UIKit

class SplitVC: UISplitViewController {
  
  private var detailVC: DetailVC?
  private var navVC: UINavigationController?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    preferredPrimaryColumnWidthFraction = 0.5
    view.backgroundColor = UIColor.clear
    // Do any additional setup after loading the view.
    
    navVC = viewControllers.last as? UINavigationController
    detailVC = navVC?.viewControllers.first as? DetailVC
    
    (viewControllers.first as? MasterContactsVC)?.didTapContact = { [weak self] (item) in
        
      if let contactVCOpened = self?.navVC?.viewControllers.first(where: {$0.isKind(of: ContactInfoVC.self)}) as? ContactInfoVC {
        //contactVCOpened
        contactVCOpened.profileData = item
        // Reload table
      } else {
        // Open New
        let destVC = StoryboardScene.Main.ContactInfoVC.instantiate()
        destVC.profileData = item
        
        self?.detailVC?.pushVC(destVC)
      }
    }
  }

  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
  
}
