//
//  UIViewControllerExtensions.swift
//  AE
//
//  Created by MAC_MINI_6 on 19/03/19.
//  Copyright © 2019 MAC_MINI_6. All rights reserved.
//

import UIKit

extension UINavigationController {
  
  func popToViewController(ofClass: AnyClass, animated: Bool = true) {
    if let vc = viewControllers.filter({$0.isKind(of: ofClass)}).last {
      popToViewController(vc, animated: animated)
    }
  }
  
}

extension UIViewController {
  func pushVC(_ vc: UIViewController, animated: Bool = true) {
    navigationController?.pushViewController(vc, animated: animated)
  }
  
  func popVC(animated: Bool = true) {
    navigationController?.popViewController(animated: animated)
  }
  
  func presentVC(_ vc: UIViewController) {
    navigationController?.present(vc, animated: true, completion: nil)
  }
  
  func dismissVC() {
    dismiss(animated: true, completion: nil)
  }
  
  func topMostVC() -> UIViewController {
    let vc = UIApplication.topVC()
    guard let topVC = vc else {
      return UIViewController()
    }
    return topVC
  }
  
  
  func popTo<T: UIViewController>(toControllerType: T.Type) {
    if var viewControllers: [UIViewController] = self.navigationController?.viewControllers {
      viewControllers = viewControllers.reversed()
      for currentViewController in viewControllers {
        if currentViewController .isKind(of: toControllerType) {
          self.navigationController?.popToViewController(currentViewController, animated: true)
          break
        }
      }
    }
  }
  
  func popVCs(viewsToPop: Int, animated: Bool = true) {
    if /navigationController?.viewControllers.count > viewsToPop {
      guard let vc = navigationController?.viewControllers[/navigationController?.viewControllers.count - viewsToPop - 1] else { return }
      navigationController?.popToViewController(vc, animated: animated)
    }
  }
  
  func actionSheet(for actions: [String], title: String?, message: String?, tapped: ((_ actionString: String?) -> Void)?) {
    let actionSheetController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
    
    actions.forEach {
      
      let action = UIAlertAction(title: $0, style: .default, handler: { (action) in
        tapped?(action.title)
      })
      action.setValue(Colors.TEXT_PRIMARY.uiColor, forKey: "titleTextColor")
      actionSheetController.addAction(action)
    }
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
      
    })
    cancelAction.setValue(Colors.RED_TINT.uiColor, forKey: "titleTextColor")
    actionSheetController.addAction(cancelAction)
    present(actionSheetController, animated: true, completion: nil)
  }
  
  func alertWithDesc(desc: String?) {
    let messageString = NSMutableAttributedString.init(string: /desc, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14, weight: .regular),
                                                                                   NSAttributedString.Key.foregroundColor: Colors.TEXT_PRIMARY.uiColor])
    
    let alert = UIAlertController(title: "", message: desc, preferredStyle: .alert)
    alert.addAction(UIAlertAction.init(title: "OK", style: .cancel, handler: { (_) in
    }))
    alert.setValue(messageString, forKey: "attributedMessage")
    present(alert, animated: true, completion: nil)
  }
  
  func alertBoxOKCancel(title: String?, message: String?, tapped: (() -> Void)?, cancelTapped: (() -> Void)?) {
    let messageString = NSMutableAttributedString.init(string: /message, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14, weight: .regular),
                                                                                      NSAttributedString.Key.foregroundColor: Colors.TEXT_PRIMARY.uiColor])
    
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: { (_) in
      cancelTapped?()
    }))
    alert.setValue(messageString, forKey: "attributedMessage")
    alert.addAction(UIAlertAction.init(title: "OK", style: .default, handler: { (_) in
      tapped?()
    }))
    present(alert, animated: true, completion: nil)
  }
  
  
  //MARK:- Present PopUp
  func presentPopUp(_ destVC: UIViewController) {
    addChild(destVC)
    destVC.view.frame = view.frame
    view.addSubview(destVC.view)
    destVC.didMove(toParent: self)
  }
  
  //MARK:- PopUps start
  func startPopUpWithAnimation() {
    view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
    view.alpha = 0.0
    UIView.animate(withDuration: 0.25, animations: {
      self.view.alpha = 1.0
      self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
    })
  }
  
  //MARK:- PopUp End
  func removePopUp() {
    UIView.animate(withDuration: 0.25, animations: {
      self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
      self.view.alpha = 0.0
    }, completion: {(finished: Bool) in
      if finished{
        self.view.removeFromSuperview()
      }
    })
  }
}
