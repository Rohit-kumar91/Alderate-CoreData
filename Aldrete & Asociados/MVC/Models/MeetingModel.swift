//
//  MeetingModel.swift
//  Aldrete & Asociados
//
//  Created by MAC_MINI_6 on 25/06/19.
//  Copyright © 2019 Code-Brew Labs. All rights reserved.
//

import UIKit

class DetailSectionModel: HeaderFooterDataProvider {
  var items: [Any]?
  
  var property: HeaderFooterValues?
  
  var other: OtherHeaderFooterProperty?
  
  required init(_property: HeaderFooterValues?, _items: [Any]?, _other: OtherHeaderFooterProperty?) {
    
  }
  
  var sectionId: String?
  var sectionHeight: CGFloat?
  
  var contact: Any?
  
  init(_ _sectionId: String?, _ _sectionHeight: CGFloat?, _ _contact: Any?, _ _items: [DetailItem]?) {
    sectionId = _sectionId
    sectionHeight = _sectionHeight
    contact = _contact
    items = _items
  }
}

extension DetailSectionModel {
  
  class func getSectionalData() -> [DetailSectionModel] {
    
    let sampleCells = [DetailItem(MeetingLocationCell.identfier, Height.MeetingLocationCell, nil),
                       DetailItem(MeetingDateTimeCell.identfier, Height.MeetingDateTimeCell, nil),
                       DetailItem(MeetingCalendarCell.identfier, Height.MeetingCalendarCell, nil),
                       DetailItem(MeetingPPTCell.identfier, Height.MeetingPPTCell, nil)]
    
    let sections = [DetailSectionModel.init(DetailSection.identfier, Height.DetailSection, nil, sampleCells),
                    DetailSectionModel.init(DetailSection.identfier, Height.DetailSection, nil, sampleCells),
                    DetailSectionModel.init(DetailSection.identfier, Height.DetailSection, nil, sampleCells),
                    DetailSectionModel.init(DetailSection.identfier, Height.DetailSection, nil, sampleCells),
                    DetailSectionModel.init(DetailSection.identfier, Height.DetailSection, nil, sampleCells)]
    
    return sections
  }
  
}


class DetailItem {
  var cellId: String?
  var cellHeight: CGFloat?
  
  var item: Any?
  
  init(_ _cellId: String?, _ _cellHeight: CGFloat?, _ _item: Any?) {
    cellId = _cellId
    cellHeight = _cellHeight
    item = _item
  }
  
}
