//
//  QiitaPostTableViewCell.swift
//  ReSwiftTest
//
//  Created by oyuk on 2/14/16.
//  Copyright © 2016 okysoft. All rights reserved.
//

import UIKit
import Kingfisher

class QiitaPostTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        profileImageView.clipsToBounds = false
  
    }
    
    var post:Post? {
        didSet {
            titleLabel.text = post?.title
            if let imageURL = post?.user?.profileImageUrl,let url = NSURL(string: imageURL) {
                profileImageView.kf_showIndicatorWhenLoading = true
                profileImageView.kf_setImageWithURL(url)
            }
        }    
    }
}