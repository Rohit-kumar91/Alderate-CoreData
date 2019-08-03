//
//  MasterContactsModel.swift
//  Aldrete & Asociados
//
//  Created by MAC_MINI_6 on 25/06/19.
//  Copyright © 2019 Code-Brew Labs. All rights reserved.
//

import UIKit

class MasterContactsModel: HeaderFooterDataProvider {
  
  var property: HeaderFooterValues?
  
  var items: [Any]?
  
  var other: OtherHeaderFooterProperty?
  
  required init(_property: HeaderFooterValues?, _items: [Any]?, _other: OtherHeaderFooterProperty?) {
    property = _property
    items = _items
    other = _other
  }
}


extension MasterContactsModel {
  
  class func getSectionalData() -> [MasterContactsModel] {
    
    let filters = [Filter(_image: #imageLiteral(resourceName: "ic_status"), _name: "Status"),
                   Filter(_image: #imageLiteral(resourceName: "ic_date"), _name: "Date")]
    
    let section1 = MasterContactsModel(_property:HeaderFooterValues(headerIdentifier: MasterSection.identfier, headerHeight: Height.MasterSection, cellIdentifier: FilterCell.identfier, cellHeight: Height.FilterCell, footerIdentifier: "", footerHeight: 0.0001)
      , _items: filters,
        _other: OtherHeaderFooterProperty.init(title: VCLiteral.FILTER.localized, subTitle: "", isBtnVisible: false, image: UIImage(), btnName: ""))
    
    let section2 = MasterContactsModel(_property:HeaderFooterValues(headerIdentifier: MasterSection.identfier, headerHeight: Height.MasterSection, cellIdentifier: ContactCell.identfier, cellHeight: Height.ContactCell, footerIdentifier: "", footerHeight: 0.0001)
      , _items: [],
        _other: OtherHeaderFooterProperty.init(title: VCLiteral.ALL_CONTACTS.localized, subTitle: "", isBtnVisible: false, image: UIImage(), btnName: ""))
    return [section1, section2]
  }
  
    //"Neelam Panwar", "Sandeep Kumar", "Abhijeet Choudhary", "Tanu Aggarwal", "Oliver Queen", "Thea Queen", "Hannah Baker"
}

class Filter {
  var name: String?
  var image: UIImage?
  
  init(_image: UIImage?, _name: String?) {
    name = _name
    image = _image
  }
}


struct Section {
    let letter : String
    let names : [String]
}
