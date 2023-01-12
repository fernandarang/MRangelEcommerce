//
//  DepartamentoTableViewCell.swift
//  MRangelEcommerce
//
//  Created by MacBookMBA5 on 05/01/23.
//

import UIKit
import SwipeCellKit

class DepartamentoTableViewCell: SwipeTableViewCell {

    
    @IBOutlet weak var Nombrelbl: UILabel!
    @IBOutlet weak var IdArealbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
