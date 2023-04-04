//
//  CarritoTableViewCell.swift
//  MRangelEcommerce
//
//  Created by MacBookMBA5 on 26/01/23.
//

import UIKit
import SwipeCellKit

class CarritoTableViewCell: SwipeTableViewCell {
    
    @IBOutlet weak var Nombrelbl: UILabel!
    @IBOutlet weak var Preciolbl: UILabel!
    @IBOutlet weak var Cantidadlbl: UILabel!
    @IBOutlet weak var ImagenProducto: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
