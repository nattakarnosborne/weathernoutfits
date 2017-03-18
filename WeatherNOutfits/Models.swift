//
//  Models.swift
//  WeatherNow
//
//  Created by Nattakarn Osborne on 1/9/17.
//  Copyright © 2017 Nattakarn Osborne. All rights reserved.
//

import UIKit

class Apparel{
    
    var title: String
    let cloths: [Cloth]
    
    init(title: String, cloths: [Cloth]){
        
        self.title = title
        self.cloths = cloths
        
    }
}


class Cloth{

    var clothLabel: String
    let clothImage: UIImage
    
    init(clothLabel: String, clothImage: UIImage){
    
        self.clothLabel = clothLabel
        self.clothImage = clothImage
        
    }

}
