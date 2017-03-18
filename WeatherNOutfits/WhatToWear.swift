//
//  SettingCity.swift
//  WeatherNow
//
//  Created by Nattakarn Osborne on 1/3/17.
//  Copyright © 2017 Nattakarn Osborne. All rights reserved.
//

import UIKit

class WhatToWear : NSObject, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    let blackView = UIView()
    
    let collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsetsMake(30, 10, 10, 10)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        
        
        return cv
        
        
    }()
    
    
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        
        return view
    }()
    let label: UILabel = {
        
        let label = UILabel()
        label.text = "Search City"
        label.textColor = UIColor.rgb(108, g: 95, b: 95)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    
    
    
    
    func showWhatTowear(){
        
        getTemp()
        
        if let window = UIApplication.shared.keyWindow{
            
            
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            
            window.addSubview(blackView)
            window.addSubview(collectionView)
            
            
            
            let height: CGFloat = 450
            let yAxis = window.frame.height - height
            
            collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
            
            blackView.frame = window.frame
            blackView.alpha = 0
            
            
            
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                self.blackView.alpha = 1
                
                self.collectionView.frame = CGRect(x: 0, y: yAxis, width: self.collectionView.frame.width , height: self.collectionView.frame.height)
                
                
            }, completion: nil)
            
            
        }
        
        
    }
    
    
    func handleDismiss(){
        
        UIView.animate(withDuration: 0.5){
            
            self.blackView.alpha = 0
            
            if let window = UIApplication.shared.keyWindow {
                
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
                
            }
            
            
        }
        
    }
    
    let cellId = "cellId"
    
    
    let below20 = ["Winter Coat": #imageLiteral(resourceName: "Winter Coat") , "Pants": #imageLiteral(resourceName: "Pants")]
    let twentyTo29 = ["Pant": #imageLiteral(resourceName: "Pants"),"Winter Coat" : #imageLiteral(resourceName: "Winter Coat"), "Warm Hat" : #imageLiteral(resourceName: "Warm Hat"), "Gloves/Mittens" : #imageLiteral(resourceName: "Gloves"), "Sweatshirt" : #imageLiteral(resourceName: "Sweatshirt"), "Jacket" : #imageLiteral(resourceName: "Jacket"), "Sweater": #imageLiteral(resourceName: "Sweater")]
    let thirtyTo39 = ["Pant" : #imageLiteral(resourceName: "Pants"), "Winter Coat": #imageLiteral(resourceName: "Winter Coat"), "Warm Hat": #imageLiteral(resourceName: "Warm Hat"), "Gloves/Mittens": #imageLiteral(resourceName: "Gloves")]
    let fourtyTo49 = ["Pant" : #imageLiteral(resourceName: "Pants"), "Winter Coat": #imageLiteral(resourceName: "Winter Coat"), "Warm Hat": #imageLiteral(resourceName: "Warm Hat"), "Gloves/Mittens": #imageLiteral(resourceName: "Gloves"), "Sweatshirt": #imageLiteral(resourceName: "Sweatshirt"), "Jacket": #imageLiteral(resourceName: "Jacket"), "Sweater": #imageLiteral(resourceName: "Sweater")]
    let fiftyTo59 = ["Pant" : #imageLiteral(resourceName: "Pants"), "Sweatshirt": #imageLiteral(resourceName: "Sweatshirt"), "Jacket": #imageLiteral(resourceName: "Jacket"), "Sweater": #imageLiteral(resourceName: "Sweater")]
    let sixtyTo69 = ["Shorts": #imageLiteral(resourceName: "Shorts"), "Sweatshirt": #imageLiteral(resourceName: "Sweatshirt"), "Jacket": #imageLiteral(resourceName: "Jacket"), "Sweater": #imageLiteral(resourceName: "Sweater"), "Pants": #imageLiteral(resourceName: "Pants"), "Long Sleeved Shirt": #imageLiteral(resourceName: "Long Sleeved Shirt")]
    let seventyTo79 = ["Shorts": #imageLiteral(resourceName: "Shorts"), "T-Shirt": #imageLiteral(resourceName: "T-Shirt")]
    let above80 = ["You should be at the pool!": #imageLiteral(resourceName: "above80")]
    
    
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "What to wear"
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let currentTemp = temp
    var currentTempArrays : [String : AnyObject] = [:]
    
    
    func getTemp(){
        
        
        let myTemp = temp
        
        switch myTemp {
            
        case 21...29:
            
            currentTempArrays = self.below20
            collectionView.reloadData()
            
            
        case 30...39:
            
            currentTempArrays = self.twentyTo29
            collectionView.reloadData()
            
            
        case 40...49:
            
            currentTempArrays = self.fourtyTo49
            collectionView.reloadData()
            
            
        case 50...59:
            
            currentTempArrays = self.fiftyTo59
            collectionView.reloadData()
            
            
        case 60...69:
            
            currentTempArrays = self.sixtyTo69
            collectionView.reloadData()
            
        case 70...79:
            
            currentTempArrays = self.above80
            collectionView.reloadData()
            
        case 80...140:
            
            currentTempArrays = self.above80
            collectionView.reloadData()
            
        default:
            
            currentTempArrays = self.below20
            collectionView.reloadData()
            
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        
        let count = currentTempArrays.count
        
        return count
        
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ApparelsCell
        
        
        cell.nameLabel.text = Array(currentTempArrays.keys)[indexPath.item]
        cell.clothImageView.image = Array(currentTempArrays.values)[indexPath.row] as? UIImage
        
        
        return cell
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = UIScreen.main.bounds.width
        
        return CGSize(width: (width / 2) - 15 , height: (width / 2) - 15)
    }
    
    override init(){
        
        super.init()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ApparelsCell.self, forCellWithReuseIdentifier: cellId)
        
        
        collectionView.addSubview(nameLabel)
        
        collectionView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-14-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nameLabel]))
        
        
        //        var appCategory: AppCategory? {
        //            didSet {
        //
        //                if let name = appCategory?.name {
        //                    nameLabel.text = name
        //                }
        //                
        //                appsCollectionView.reloadData()
        //                
        //            }
        //        }
        
        
    }
    
}

