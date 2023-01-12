//
//  UsuarioTableViewCell.swift
//  MRangelEcommerce
//
//  Created by MacBookMBA5 on 09/01/23.
//

import UIKit
import SwipeCellKit

class UsuarioTableViewCell: SwipeTableViewCell {
    
    
    @IBOutlet weak var UserNamelbl: UILabel!
    @IBOutlet weak var Nombrelbl: UILabel!
    @IBOutlet weak var ApellidoPaternolbl: UILabel!
    @IBOutlet weak var ApellidoMaterno: UILabel!
    @IBOutlet weak var Emaillbl: UILabel!
    @IBOutlet weak var Passwordlbl: UILabel!
    @IBOutlet weak var FechaNacimientolbl: UILabel!
    @IBOutlet weak var Sexolbl: UILabel!
    @IBOutlet weak var Telefonolbl: UILabel!
    @IBOutlet weak var Celularlbl: UILabel!
    @IBOutlet weak var Curplbl: UILabel!
    @IBOutlet weak var ImagenView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
