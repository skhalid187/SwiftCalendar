//
//  CalenderViewCell.swift
//  Catch App
//
//  Created by Salman Khalid on 05/09/2016.
//  Copyright © 2016 Salman Khalid. All rights reserved.
//



import UIKit

class CalenderViewCell: UICollectionViewCell {
    
    @IBOutlet weak var datelbl: UILabel!
    @IBOutlet weak var eventlbl: UILabel!
    @IBOutlet weak var static_event_image: UIImageView!
    
    @IBOutlet weak var thirdImageView: UIImageView!
    @IBOutlet weak var firstImageView: UIImageView!
    @IBOutlet weak var secondImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
}
