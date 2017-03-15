//
//  Talk.swift
//  MTCMessenger
//
//  Created by Ortwin Gentz on 09.03.17.
//  Copyright © 2017 FutureTap. All rights reserved.
//

import Foundation

struct Talk {
	let identifier: String
	let name: String
	let details: String
	let startDate: Date
	let time: String
	let room: String
	let speakerIds: [String]
	let speakers: [Speaker]
	
	init?(fromDictionary dictionary: [String: AnyObject]) {
		guard (dictionary["conferenceId"] as! Array).contains("57a4915434e04ea54d2c62f8_585a58373af8aac74ab58b24") else {return nil}
		
		identifier = dictionary["uniqueId"] as! String
		name = dictionary["name"] as! String
		if let details = dictionary["details"] as? String {
			self.details = details.truncate(length: 200, trailing: "…")
		} else {
			return nil
		}
		room = dictionary["roomName"] as! String? ?? ""

		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSz"
		
		startDate = dateFormatter.date(from: dictionary["startDate"] as! String)!
		let endDate = dateFormatter.date(from: dictionary["endDate"] as! String)!
		
		let timeFormatter = DateFormatter()
		timeFormatter.dateStyle = .none
		timeFormatter.timeStyle = .short
		time = "\(timeFormatter.string(from: startDate)) - \(timeFormatter.string(from: endDate))"
			
		let speakerIds = dictionary["speakersUniqueIds"] as! [String]
		speakers = TalksTableViewController.allSpeakers!.filter({(speaker: Speaker) in
			return speakerIds.contains(speaker.identifier)
		})
		self.speakerIds = speakerIds
	}
	
	public var talkURL : URL {
		return URL(string: "data:\(self.identifier)")!
	}
}

extension String {
	func truncate(length: Int, trailing: String = "…") -> String {
		if self.characters.count > length {
			return String(self.characters.prefix(length)) + trailing
		} else {
			return self
		}
	}
}

