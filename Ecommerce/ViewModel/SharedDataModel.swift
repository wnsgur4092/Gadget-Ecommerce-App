//
//  SharedDataModel.swift
//  Ecommerce
//
//  Created by JunHyuk Lim on 9/10/2022.
//

import SwiftUI

class SharedDataModel : ObservableObject {
    @Published var detailProduct : Product?
    @Published var showDetailProduct : Bool = false
    
    //Matched Geometry Effect from search page
    @Published var fromSearchPage : Bool = false
    
    //Liked Product
    @Published var likedProduct : [Product] = []
    
    //Basket Products
    @Published var cartProduct : [Product] = []
    
    //Calculating total price
    func getTotalPrice()->String {
        var total: Int = 0
        
        cartProduct.forEach { product in
            let price = product.price.replacingOccurrences(of: "$", with: "") as NSString
            
            let quantity = product.quantity
            let priceTotal = quantity * price.integerValue
            
            total += priceTotal
        }
        
        return "$\(total)"
    }
}
