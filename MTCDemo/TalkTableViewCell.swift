//
//  TalkTableViewCell.swift
//  MTCMessenger
//
//  Created by Ortwin Gentz on 09.03.17.
//  Copyright © 2017 FutureTap. All rights reserved.
//

import UIKit
import SDWebImage

class TalkTableViewCell: UITableViewCell {

	@IBOutlet weak var speakerImageView: UIImageView!
	@IBOutlet weak var talkNameLabel: UILabel!
	@IBOutlet weak var speakerLabel: UILabel!
	
	public var talk: Talk? {
		didSet(newValue) {
			if let talk = talk {
				speakerImageView.sd_setImage(with: talk.speakers.first!.imageURL, completed: { (image, error, cacheType, url) in
					if let error = error {
						print("\(String(describing: url)): \(error)")
					}
				})
				talkNameLabel.text = talk.name
				
				
				for speaker in talk.speakers {
					let name = "\(speaker.firstName) \(speaker.lastName)"
					let subtitle = NSMutableAttributedString(string: name, attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 12)])
					subtitle.append(NSAttributedString(string: " · "))
					subtitle.append(NSAttributedString(string: speaker.company, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 12)]))
					speakerLabel.attributedText = subtitle
				}
			}
		}
	}
}
