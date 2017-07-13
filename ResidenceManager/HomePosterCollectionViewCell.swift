//
//  HomePosterCollectionViewCell.swift
//  ResidenceManager
//
//  Created by Ginpei on 2017-07-13.
//  Copyright © 2017 Ginpei. All rights reserved.
//

import UIKit

class HomePosterCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleTextView: UITextView!
    
    static let identifier = "HomePosterCollectionViewCell"
    static let detailSegueIdentifier = "showPosterDetail"
    
    private var _poster: Poster?
    var poster: Poster? {
        get {
            return _poster
        }
        set(v) {
            _poster = v
            if titleTextView != nil {
                titleTextView.text = v?.title
            }
        }
    }
}
