//
//  ProductDetailView.swift
//  Ecommerce
//
//  Created by JunHyuk Lim on 9/10/2022.
//

import SwiftUI

struct ProductDetailView: View {
    //MARK: - PROPETIES
    
    let customFont = "Raleway-Regular"
    
    var product : Product
    var animation: Namespace.ID
    
    @EnvironmentObject var sharedData : SharedDataModel
    @EnvironmentObject var homeViewModel : HomeViewModel
    
    //MARK: - BODY
    
    var body: some View {
        VStack {
            //Title Bar & Product Images
            VStack {
                
                //MARK: - TITLE BAR
                HStack{
                    Button {
                        withAnimation(.easeInOut){
                            sharedData.showDetailProduct = false
                        }
                    } label: {
                        Image(systemName: "arrow.left")
                            .font(.title2)
                            .foregroundColor(Color.black.opacity(0.7))
                    } //: BUTTON
                    
                    Spacer()

                    Button {
                        addToLiked()
                    } label: {
                        Image("Liked")
                            .renderingMode(.template )
                            .resizable()
                            .scaledToFit()
                            .frame(width:22, height: 22)
                            .foregroundColor(isLiked() ? .red :  Color.black.opacity(0.7))
                    }
                } //: HSTACK
                .padding()
                
                //MARK: - PRODUCT IMAGE
                Image(product.productImage)
                    .resizable()
                    .scaledToFit()
                    .matchedGeometryEffect(id: "\(product.id) \(sharedData.fromSearchPage ? "SEARCH"  : "IMAGE")", in: animation)
                    .padding(.horizontal)
                    .offset(y: -12)
                    .frame(maxHeight: .infinity)

            } //: VSTACK
            .frame(height: getRect().height / 2.7)
            
            //Product Details
            ScrollView(.vertical, showsIndicators: false) {
                //MARK: - Product Data
                VStack(alignment:.leading, spacing: 15){
                    Text(product.title)
                        .font(.custom(customFont, size: 20).bold())
                    
                    Text(product.subtitle)
                        .font(.custom(customFont, size: 18))
                        .foregroundColor(.gray)
                    
                    Text("Get Apple TV+ free for a year")
                        .font(.custom(customFont, size: 18))
                    
                    Button {
                        
                    } label: {
                        Label {
                            Image(systemName: "arrow.right")
                        } icon: {
                            Text("Full description")
                        }
                        .font(.custom(customFont, size: 15).bold())
                        .foregroundColor(Color("Purple"))
                    } //: BUTTON
                    
                    HStack{
                        Text("Total")
                            .font(.custom(customFont, size: 17))
                            .zIndex(1)
                        
                        Spacer()
                        
                        Text("\(product.price)")
                            .font(.custom(customFont, size: 20).bold())
                            .foregroundColor(Color("Purple"))
                    }
                    .padding(.vertical, 20)

                    Button {
                        addToCart()
                    } label: {
                        Text("\(isAddedToCart() ? "added" : "add" ) to basket")
                            .font(.custom(customFont, size: 20).bold())
                            .foregroundColor(.white)
                            .padding(.vertical, 20)
                            .frame(maxWidth: .infinity)
                            .background(
                                Color("Purple")
                                    .cornerRadius(15)
                                    .shadow(color: .black.opacity(0.07), radius: 5, x: 5, y: 5)
                            )
                    }

                    
                    
                }//: VSTACK
                .padding([.horizontal,.bottom], 25)
                .padding(.top, 25)
                .frame(maxWidth:.infinity, alignment: .leading)
            }
            .frame(maxWidth:.infinity, maxHeight: .infinity)
            .background(
                Color.white
                    .clipShape(CustomCorners(corners: [.topLeft,.topRight], radius: 25))
                    .ignoresSafeArea()
            )
            .zIndex(0)
        } //: VSTACK
        .animation(.easeInOut, value: sharedData.likedProduct)
        .animation(.easeInOut, value: sharedData.cartProduct)
        .background(Color("HomeBackground"))
    }
    
    //MARK: - FUNCTION
    func isLiked()->Bool{
        return sharedData.likedProduct.contains { product in
            return self.product.id == product.id
        }
        
    }
    
    func isAddedToCart()->Bool{
        return sharedData.cartProduct.contains { product in
            return self.product.id == product.id
        }
        
    }
    
    
    func addToLiked() {
        if let index = sharedData.likedProduct.firstIndex(where: { Product in
            return self.product.id == product.id
        }) {
            sharedData.likedProduct.remove(at: index)
        } else {
            sharedData.likedProduct.append(product)
        }
        
    }
    
    func addToCart() {
        if let index = sharedData.cartProduct.firstIndex(where: { Product in
            return self.product.id == product.id
        }) {
            sharedData.cartProduct.remove(at: index)
        } else {
            sharedData.cartProduct.append(product)
        }
    }
}

//MARK: - PREVIEW
struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
//        ProductDetailView(product: HomeViewModel().products[0]).environmentObject(SharedDataModel())
        MainPage()
    }
}
