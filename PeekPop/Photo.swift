//
//  Photo.swift
//  PeekPop
//  PeekPop
//
//  Created by Akshit Verma
//

import UIKit

struct Photo {

    let caption:String
    let imageName:String
    let city:String
    
    init( caption:String, imageName:String, city:String ){
        
        self.caption = caption
        self.imageName = imageName
        self.city = city
        
    }
    
}
