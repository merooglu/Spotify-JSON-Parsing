//
//  AudioVC.swift
//  Spotify
//
//  Created by Mehmet Eroğlu on 27.03.2017.
//  Copyright © 2017 Mehmet Eroğlu. All rights reserved.
//

import Foundation
import UIKit

class AudioVC : UIViewController{
    
    var image = UIImage()
    var mainSongTitle = String()
    
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var songTitle: UILabel!
    
    override func viewDidLoad() {
        
        songTitle.text = mainSongTitle
        background.image = image
        mainImageView.image = image
       
    }
}
