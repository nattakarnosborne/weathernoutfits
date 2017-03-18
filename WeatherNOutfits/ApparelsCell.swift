//
//  CityGetter.swift
//  WeatherNow
//
//  Created by Nattakarn Osborne on 1/3/17.
//  Copyright © 2017 Nattakarn Osborne. All rights reserved.
//

import UIKit

class ApparelsCell: UICollectionViewCell {
    
    override init (frame: CGRect){
        
        super.init(frame: frame)
        setupViews()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder) has not been implemented")
    }
    
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Apparel"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let clothImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Jacket")
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 16
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    
    
    func setupViews(){
        
        addSubview(nameLabel)
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-14-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nameLabel]))
        
        
        addSubview(clothImageView)
        //width x width = square
        //clothImageView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.width)
        
        _ = clothImageView.anchor(nameLabel.bottomAnchor, left: leftAnchor ,bottom: nil, right: nil, topConstant: 5, leftConstant: 0 , bottomConstant: 0, rightConstant: 0, widthConstant: frame.width - 30, heightConstant: frame.height - 30)
    }
}

