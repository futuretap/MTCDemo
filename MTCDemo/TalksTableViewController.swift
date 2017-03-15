//
//  TalksTableViewController.swift
//  MTCMessenger
//
//  Created by Ortwin Gentz on 09.03.17.
//  Copyright © 2017 FutureTap. All rights reserved.
//

import UIKit

protocol TalkPickerDelegate : class {
	func talksTableViewController(_ controller: UIViewController, didSelect talk: Talk)
}

class TalksTableViewController: UITableViewController {
	
	weak var pickerDelegate : TalkPickerDelegate?
	
	public static var allSpeakers : [Speaker]?

	lazy var talks : [Talk] = {
		if let url = Bundle.main.url(forResource: "data", withExtension: "json"),
			let data = NSData(contentsOf: url) {
			do {
				if let dictionary = try JSONSerialization.jsonObject(with: data as Data, options: .allowFragments) as? NSDictionary {
					let speakersDict = dictionary["speakers"] as! [[String: AnyObject]]
					allSpeakers = speakersDict.map({Speaker(fromDictionary: $0)})
					
					let talksArray = dictionary["sessions"] as! [[String: AnyObject]]
					return talksArray.flatMap({Talk(fromDictionary: $0)}).sorted {
						return $0.startDate < $1.startDate
					}
				}
			} catch {
			}
		}
		return []
	}()

    // MARK: - Table view data source, delegate

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return talks.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "talk", for: indexPath) as! TalkTableViewCell
		cell.talk = talks[indexPath.row]
        return cell
    }

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)

		let talk = talks[indexPath.row]
		pickerDelegate?.talksTableViewController(self, didSelect: talk)
	}
}
