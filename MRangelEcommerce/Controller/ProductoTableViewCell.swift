//
//  ProductoTableViewCell.swift
//  MRangelEcommerce
//
//  Created by MacBookMBA5 on 30/12/22.
//

import UIKit
import SwipeCellKit

class ProductoTableViewCell: SwipeTableViewCell {
    
    @IBOutlet weak var ImageProduct: UIImageView!
    @IBOutlet weak var Nombrelbl: UILabel!
    
    @IBOutlet weak var PrecioUnitariolbl: UILabel!
    
    @IBOutlet weak var Stocklbl: UILabel!
    
    @IBOutlet weak var IdProveedor: UILabel!
    
    @IBOutlet weak var IdDepartamentolbl: UILabel!
    
    @IBOutlet weak var Descripcionlbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
