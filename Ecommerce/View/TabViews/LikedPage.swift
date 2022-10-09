//
//  LikedPage.swift
//  Ecommerce
//
//  Created by JunHyuk Lim on 9/10/2022.
//

import SwiftUI

struct LikedPage: View {
    //MARK: - PROPERTIES
 
    @EnvironmentObject var sharedData : SharedDataModel
    
    @State var showDeleteOption : Bool = false
    
    let customFont = "Raleway-Regular"
    //MARK: - BODY
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack{
                    HStack{
                        Text("Favourites")
                            .font(.custom(customFont, size: 28).bold())
                        
                        Spacer()
                        
                        Button {
                            withAnimation {
                                showDeleteOption.toggle()
                            }
                        } label: {
                            Image("Delete")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                        }
                        .opacity(sharedData.likedProduct.isEmpty ? 0 : 1)
                    } //: HSTACK
                    
                    //Check if liked products are empty
                    if sharedData.likedProduct.isEmpty {
                        Group{
                            Image("NoLiked")
                                .resizable()
                                .scaledToFit()
                                .padding()
                            
                            Text("No favorites yet")
                                .font(.custom(customFont, size: 25))
                                .fontWeight(.semibold)
                            
                            Text("Hit the like button on each product page to save favorite ones.")
                                .font(.custom(customFont, size: 18))
                                .foregroundColor(.gray)
                                .padding(.horizontal)
                                .padding(.top, 10)
                                .multilineTextAlignment(.center)
                        }
                    } else {
                        VStack(spacing: 15) {
                            ForEach(sharedData.likedProduct) { product in
                                HStack(spacing: 0) {
                                    
                                    if showDeleteOption{
                                        Button {
                                            deleteProduct(product: product)
                                        } label: {
                                            Image(systemName: "minus.circle.fill")
                                                .font(.title2)
                                                .foregroundColor(.red)
                                        }
                                        .padding(.trailing)

                                    }
                                    
                                    CardView(product: product)
                                } //: HSTACK
                            } //: LOOP
                        } //: VSTACK
                        .padding(.top, 25)
                        .padding(.horizontal)
                    }
                } //: VSTACK
                .padding()

                
            } //: SCROLLVIEW
            .toolbar(.hidden)
            .frame(maxWidth:. infinity, maxHeight: .infinity)
            .background(
                Color("HomeBackground")
                    .ignoresSafeArea()
                )
        } //: NAVIGATION VIEW
    }
    
    //MARK: - View Builder
    @ViewBuilder
    func CardView(product: Product)->some View{
        HStack(spacing: 15) {
            Image(product.productImage)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(product.title)
                    .font(.custom(customFont, size: 18).bold())
                    .lineLimit(1)
                
                Text(product.subtitle)
                    .font(.custom(customFont, size: 18))
                    .fontWeight(.semibold)
                    .foregroundColor(Color("Purple"))
                
                Text("Type :\(product.type.rawValue)")
                    .font(.custom(customFont, size: 13))
                    .foregroundColor(.gray)
            } //: VSTACK
        } //: HSTACK
        .padding(.horizontal, 10)
        .padding(.vertical, 10)
        .frame(maxWidth:. infinity, alignment: .leading)
        .background(
            Color.white
                .cornerRadius(10)
        )
    }
    
    //MARK: - FUNCTION
    func deleteProduct(product: Product) {
        if let index = sharedData.likedProduct.firstIndex(where: { currentProduct in
            return product.id == currentProduct.id
        }) {
            let _ = withAnimation {
                sharedData.likedProduct.remove(at: index)
            }
        }
    }
}

//MARK: - PREVIEW
struct LikedPage_Previews: PreviewProvider {
    static var previews: some View {
        LikedPage()
            .environmentObject(SharedDataModel())
    }
}
