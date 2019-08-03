//
//  Storyboards.swift
//  Aldrete & Asociados
//
//  Created by Sandeep Kumar on 27/06/19.
//  Copyright © 2019 Code-Brew Labs. All rights reserved.
//

import UIKit

private final class BundleToken { }

protocol StoryboardType {
  static var storyboardName: String { get }
}

extension StoryboardType {
  static var storyboard: UIStoryboard {
    let name = storyboardName
    return UIStoryboard(name: name, bundle: Bundle(for: BundleToken.self) )
  }
}

struct SceneType<T: Any> {
  let storyboard: StoryboardType.Type
  let identifier: String
  
  func instantiate() -> T {
    let identifier = self.identifier
    guard let controller = storyboard.storyboard.instantiateViewController(withIdentifier: identifier) as? T else {
      fatalError("Viewcontroller with identifier: \(identifier) is not of expected class: \(T.self)")
    }
    return controller
  }
}

struct InitialSceneType<T: Any> {
  let storyboard: StoryboardType.Type
  
  func instantiate() -> T {
    guard let controller = storyboard.storyboard.instantiateInitialViewController() as? T else {
      fatalError("Viewcontroller is not of expected class: \(T.self)")
    }
    return controller
  }
}

protocol SegueType: RawRepresentable {
  
}

extension UIViewController {
  func perform<S: SegueType>(segue: S, sender: Any? = nil) where S.RawValue == String {
    let identifier = segue.rawValue
    performSegue(withIdentifier: identifier, sender: sender)
  }
}


enum StoryboardScene {
  
  enum Main: StoryboardType {
    
    static let storyboardName: String = "Main"
    
    static let initialScene = InitialSceneType<UINavigationController>.init(storyboard: Main.self)
    
    static let FormVC = SceneType<FormVC>.init(storyboard: Main.self, identifier: "FormVC")
    
    static let ContactInfoVC = SceneType<ContactInfoVC>.init(storyboard: Main.self, identifier: "ContactInfoVC")
    
  }
  
}
