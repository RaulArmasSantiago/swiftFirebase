//
//  Extension.swift
//  Mi Tipo de Cambio
//
//  Created by Juan Meza on 9/14/19.
//  Copyright © 2019 Juan Meza. All rights reserved.
//

import Foundation
import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
    func loadImageUsingCacheUsingUrlString(urlString: String) {
        
        self.image = nil
        
        if let cachedImage = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = cachedImage
            return
        }
        
        let url = NSURL(string: urlString)
        URLSession.shared.dataTask(with: url! as URL, completionHandler: {
            (data, response, error) in
            
            if error != nil{
                print(error)
                return
            }
            
            DispatchQueue.main.async {
                
                if let downloadedImage = UIImage(data: data!) {
                    imageCache.setObject(downloadedImage, forKey: urlString as AnyObject)
                    
                    self.image = downloadedImage
                }
            }
        }).resume()
    }
}


extension UIImage {
    
    func getCropRatio() -> CGFloat {
        
        let widthRatio = CGFloat(self.size.width / self.size.height)
        return widthRatio
    }
}

