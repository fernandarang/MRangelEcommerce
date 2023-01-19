//
//  ProductoCollectionViewCell.swift
//  MRangelEcommerce
//
//  Created by MacBookMBA5 on 18/01/23.
//

import UIKit

class ProductoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var ImageProduct: UIImageView!
    
    @IBOutlet weak var Nombrelbl: UILabel!
    
    @IBOutlet weak var Descripcionlbl: UILabel!
    
    @IBOutlet weak var AgregarBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
