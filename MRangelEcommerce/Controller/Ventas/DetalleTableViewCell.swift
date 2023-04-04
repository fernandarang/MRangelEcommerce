//
//  DetalleTableViewCell.swift
//  MRangelEcommerce
//
//  Created by MacBookMBA5 on 25/01/23.
//

import UIKit

class DetalleTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var Nombrelbl: UILabel!
    @IBOutlet weak var Preciolbl: UILabel!
    @IBOutlet weak var Descripcionlbl: UILabel!
    @IBOutlet weak var ImagenView: UIImageView!
    
    @IBOutlet weak var cantidadtxt: UITextField!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
