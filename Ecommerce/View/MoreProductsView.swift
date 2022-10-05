//
//  MoreProductsView.swift
//  Ecommerce
//
//  Created by JunHyuk Lim on 5/10/2022.
//

import SwiftUI

struct MoreProductsView: View {
    //MARK: - PROPERTIES
    
    let customFont = "Raleway-Regular"
    
    //MARK: - BODY
    var body: some View {
        VStack{
            Text("More Products")
                .font(.custom(customFont, size: 24).bold())
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
        } //: VSTACK
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(Color("HomeBackground").ignoresSafeArea())
    }
}

struct MoreProductsView_Previews: PreviewProvider {
    static var previews: some View {
        MoreProductsView()
    }
}
