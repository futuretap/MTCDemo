//
//  MessageView.swift
//  MTCDemo
//
//  Created by Ortwin Gentz on 14.03.17.
//  Copyright © 2017 FutureTap. All rights reserved.
//

import UIKit

class MessageView: UIView {
	@IBOutlet weak var speakerImageView: UIImageView!
	@IBOutlet weak var contentLabel: UILabel!
	@IBOutlet weak var detailLabel: UILabel!
	
	public var talk: Talk? {
		didSet(newValue) {
			if let talk = talk {
				speakerImageView.sd_setImage(with: talk.speakers.first!.imageURL)
				
				// Styles
				let talkAttributes = [NSFontAttributeName: UIFont.boldSystemFont(ofSize: contentLabel.font.pointSize),
				                      NSForegroundColorAttributeName: UIColor.black]
				let subtitleFontSize = round(contentLabel.font.pointSize * 0.8)
				let speakerAttributes = [NSFontAttributeName: UIFont.boldSystemFont(ofSize: subtitleFontSize),
				                         NSForegroundColorAttributeName: UIColor.gray]
				let companyAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: subtitleFontSize),
				                         NSForegroundColorAttributeName: UIColor.gray]
				
				let hyphenated = NSMutableParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
				hyphenated.hyphenationFactor = 1
				
				// build top label string
				let text = NSMutableAttributedString(string: talk.name, attributes: talkAttributes)
				
				for speaker in talk.speakers {
					let name = "\n\(speaker.firstName) \(speaker.lastName)\n"
					text.append(NSMutableAttributedString(string: name, attributes: speakerAttributes))
					text.append(NSAttributedString(string: speaker.company, attributes: companyAttributes))
				}
				
				text.addAttribute(NSParagraphStyleAttributeName, value: hyphenated, range: NSMakeRange(0, text.length))
				
				contentLabel.attributedText = text
				
				// Build bottom label string
				let details = NSMutableAttributedString(string: talk.details, attributes: [NSParagraphStyleAttributeName: hyphenated])
				detailLabel.attributedText = details
			}
		}
	}

}
