//
//  Product.swift
//  Ecommerce
//
//  Created by JunHyuk Lim on 5/10/2022.
//

import SwiftUI
//MARK: - PRODUCT TYPE
enum ProductType : String, CaseIterable {
    case Wearable = "Wearable"
    case Laptops = "Laptops"
    case Phones = "Phones"
    case Tablets = "Tablets"
}

//MARK: - PRODUCTS
struct Product : Identifiable, Hashable {
    var id = UUID().uuidString
    var type : ProductType
    var title : String
    var subtitle : String
    var description : String = ""
    var price : String
    var productImage : String = ""
    var quantity : Int = 1
}


