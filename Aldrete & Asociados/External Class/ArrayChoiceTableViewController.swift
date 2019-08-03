// Copyright 2018, Ralf Ebert
// License   https://opensource.org/licenses/MIT
// License   https://creativecommons.org/publicdomain/zero/1.0/
// Source    https://www.ralfebert.de/ios-examples/uikit/choicepopover/

import UIKit

class ArrayChoiceTableViewController<Element> : UITableViewController {
    
    typealias SelectionHandler = (Element) -> Void
    typealias LabelProvider = (Element) -> String
    
    private let values : [Element]
    private let labels : LabelProvider
    private let onSelect : SelectionHandler?
    

    
    init(_ values : [Element], labels : @escaping LabelProvider = String.init(describing:), onSelect : SelectionHandler? = nil) {
        self.values = values
        self.onSelect = onSelect
        self.labels = labels
        super.init(style: .plain)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return values.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        
        if VCLiteral.ADD_MEETING.rawValue == labels(values[indexPath.row]) || VCLiteral.EDIT_STATUS.rawValue == labels(values[indexPath.row]) || VCLiteral.EDIT_MAIN.rawValue == labels(values[indexPath.row]) || VCLiteral.DELETE_CONTACT.rawValue == labels(values[indexPath.row]) {
            if labels(values[indexPath.row]) ==  VCLiteral.ADD_MEETING.rawValue {
                cell.textLabel?.text = VCLiteral.ADD_MEETING.localized
                cell.textLabel?.textColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
            } else if labels(values[indexPath.row]) ==  VCLiteral.EDIT_STATUS.rawValue {
                cell.textLabel?.text = VCLiteral.EDIT_STATUS.localized
                cell.textLabel?.textColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
            } else if labels(values[indexPath.row]) == VCLiteral.EDIT_MAIN.rawValue {
                cell.textLabel?.text = VCLiteral.EDIT_MAIN.localized
                cell.textLabel?.textColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
            } else if labels(values[indexPath.row]) == VCLiteral.DELETE_CONTACT.rawValue {
                cell.textLabel?.text = VCLiteral.DELETE_CONTACT.localized
                cell.textLabel?.textColor = UIColor(displayP3Red: 1, green: 0.32, blue: 0.29, alpha: 1)
            }
        }
        else if labels(values[indexPath.row]) == VCLiteral.UPLOAD_PRESENTATION.rawValue || labels(values[indexPath.row]) == VCLiteral.RESCHEDULE.rawValue {
            if labels(values[indexPath.row]) ==  VCLiteral.UPLOAD_PRESENTATION.rawValue {
                cell.textLabel?.text = VCLiteral.UPLOAD_PRESENTATION.localized
                cell.textLabel?.textColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
            } else {
                cell.textLabel?.text = VCLiteral.RESCHEDULE.localized
                cell.textLabel?.textColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
            }
        }
        else {
            if labels(values[indexPath.row]) ==  VCLiteral.ALL.rawValue {
                cell.textLabel?.text = VCLiteral.ALL.localized
                cell.textLabel?.textColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
            } else if labels(values[indexPath.row]) ==  VCLiteral.WARM.rawValue {
                cell.textLabel?.text = VCLiteral.WARM.localized
                cell.textLabel?.textColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
            } else if labels(values[indexPath.row]) == VCLiteral.HOT.rawValue {
                cell.textLabel?.text = VCLiteral.HOT.localized
                cell.textLabel?.textColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
            } else if labels(values[indexPath.row]) == VCLiteral.COLD.rawValue {
                cell.textLabel?.text = VCLiteral.COLD.localized
                cell.textLabel?.textColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
            }
        }
       
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dismiss(animated: true)
        onSelect?(values[indexPath.row])
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}
