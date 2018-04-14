//
//  CustomCell.swift
//  InstaPhotoSave
//
//  Created by Waqas Karim on 21/02/2018.
//  Copyright © 2018 Waqas Karim. All rights reserved.
//

import UIKit

class CustomCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbnail: UIImageView!
    var instaUrl: URL?
    
    @IBOutlet weak var downloadBtn: UIButton!
    
    @IBOutlet weak var openUrlBtn: UIButton!
    
    @IBAction func downloadAction(_ sender: UIButton) {
        //download image into photo library
       
    }

    @IBAction func openUrlAction(_ sender: UIButton) {
        //open url on safari
    }
    
}
