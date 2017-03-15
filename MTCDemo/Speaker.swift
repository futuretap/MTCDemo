//
//  Speaker.swift
//  MTCMessenger
//
//  Created by Ortwin Gentz on 10.03.17.
//  Copyright © 2017 FutureTap. All rights reserved.
//

import Foundation

struct Speaker {
	public let identifier: String
	let firstName: String
	let lastName: String
	let imageURL: URL
	let company: String
	
	init(fromDictionary dictionary: [String: AnyObject]) {
		identifier = dictionary["uniqueId"]! as! String
		firstName = dictionary["firstName"]! as! String
		lastName = dictionary["lastName"]! as! String
		company = dictionary["company"]! as! String
		imageURL = URL(string: dictionary["image"]! as! String)!
	}
}
