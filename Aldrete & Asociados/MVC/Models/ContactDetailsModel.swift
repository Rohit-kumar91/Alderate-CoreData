//
//  ContactModel.swift
//  Aldrete & Asociados
//
//  Created by NewMacMini1 on 03/07/19.
//  Copyright © 2019 Code-Brew Labs. All rights reserved.
//

import UIKit


class ContactDetailModel: HeaderFooterDataProvider {
    
    var items: [Any]?
    
    var property: HeaderFooterValues?
    var other: OtherHeaderFooterProperty?
    var sectionId: String?
    var sectionHeight: CGFloat?
    var contact: Any?
    
    required init(_property: HeaderFooterValues?, _items: [Any]?, _other: OtherHeaderFooterProperty?) {
        
    }
    
    init(_ _sectionHeight: CGFloat?, _ _contact: Any?, _ _items: [DetailItem]?) {
        sectionId = _sectionId
        sectionHeight = _sectionHeight
        contact = _contact
        items = _items
    }
}

extension DetailSectionModel {
    
    class func getSectionalData() -> [DetailSectionModel] {
        
        let sampleCells = [ContactItem(ContactCell.identfier, Height.ContactCell, nil),
                           ContactItem(StatusAndMeetingCell.identfier, Height.StatusAndMeetingCell, nil)]
        
        let sections = [ContactDetailModel.init(ContactHeader.identfier, Height.ContactHeader, nil, sampleCells)]
        
        return sections
    }
    
}

class ContactItem {
    var cellId: String?
    var cellHeight: CGFloat?
    
    var item: Any?
    
    init(_ _cellId: String?, _ _cellHeight: CGFloat?, _ _item: Any?) {
        cellId = _cellId
        cellHeight = _cellHeight
        item = _item
    }
    
}
