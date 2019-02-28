//
//  CollectionViewCell.swift
//  MatchEmUpGameTest
//
//  Created by Денис Марков on 2/27/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setUpCell(imageReference: String) {
        let stringUrl = "\(Settings.photoDownloadServerUrl)maxwidth=\(Settings.maxPhotoWidth)&photoreference=\(imageReference)&key=\(Settings.googlePlacesAPIKey)"
        if let url = URL(string: stringUrl) {
            imageView.af_setImage(withURL: url)
            //debugPrint(url.absoluteString)
        }
    }
}
