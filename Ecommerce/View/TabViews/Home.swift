//
//  Home.swift
//  Ecommerce
//
//  Created by JunHyuk Lim on 5/10/2022.
//

import SwiftUI

struct Home: View {
    //MARK: - PROPERTIES
    @StateObject var homeViewModel : HomeViewModel = HomeViewModel()
    @Namespace var animation
    
    let customFont = "Raleway-Regular"
    
    var body: some View {
        //MARK: - BODY
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 15){
                
                //MARK: - SEARCH BAR
                HStack(spacing: 15) {
                    Image(systemName: "magnifyingglass")
                        .font(.title2)
                        .foregroundColor(.gray)
                    
                    TextField("Search", text: .constant(""))
                        .disabled(true)
                } //: HSTACK
                .padding(.vertical, 12)
                .padding(.horizontal)
                .background(Capsule().strokeBorder(Color.gray, lineWidth: 2))
                .frame(width: getRect().width / 1.6)
                .padding(.horizontal, 25)
                
                //MARK: - TITLE
                Text("Order online\ncollect in store")
                    .font(.custom(customFont, size: 28).bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top)
                    .padding(.horizontal,25)
                
                //MARK: - PRODUCTS TAB
                ScrollView(.horizontal,showsIndicators: false){
                    HStack(spacing: 18) {
                        ForEach(ProductType.allCases, id:\.self) { type in
                            ProductTypeView(type: type)
                            
                        } //: LOOP
                    }//: HSTACK
                    .padding(.horizontal,25)
                } //: SCROLLVIEW
                .padding(.top, 28)
                
                //MARK: - PRODUCT PAGE
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 25) {
                        ForEach(homeViewModel.filteredProducts) { product in
                            ProductCardView(product: product)
                        }
                    } //: HSTACK
                    .padding(.horizontal, 25)
                    .padding(.bottom)
                    .padding(.top, 80)
                } //: SCROLLVIEW
                .padding(.top, 30)
                
                //MARK: - SHOW MORE BUTTON
                Button {
                    homeViewModel.showMoreProductsOnType.toggle()
                } label: {
                    Label {
                        Image(systemName: "arrow.right")
                    } icon: {
                        Text("See More")
                    }
                    .font(.custom(customFont, size: 15).bold())
                    .foregroundColor(Color("Purple"))

                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.trailing)
                .padding(.top, 10)

            }//: VSTACK
            .padding(.vertical)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("HomeBackground"))
        .onChange(of: homeViewModel.productType) { newValue in
            homeViewModel.filterProductByType()
        }
        .sheet(isPresented: $homeViewModel.showMoreProductsOnType) {
            
        } content: {
            MoreProductsView()
        }

    }
    
    //MARK: - VIEW BUILDER
    @ViewBuilder
    func ProductTypeView(type: ProductType) -> some View{
        Button {
            withAnimation {
                homeViewModel.productType = type
            }
        } label: {
            Text(type.rawValue)
                .font(.custom(customFont, size: 15))
                .fontWeight(.semibold)
                .foregroundColor(homeViewModel.productType == type ? Color("Purple") : Color.gray)
                .padding(.bottom, 10)
                .overlay(
                    ZStack{
                        if homeViewModel.productType == type {
                            Capsule()
                                .fill(Color("Purple"))
                                .frame(height: 2)
                                .matchedGeometryEffect(id: "PRODUCTTAB", in: animation)
                        } else {
                            Capsule()
                                .fill(Color.clear)
                                .frame(height: 2)
                        }
                    }
                    .padding(.horizontal, -5)
                    , alignment: .bottom)
        } //: BUTTON
    } //: VIEWBUILDER
    
    @ViewBuilder
    func ProductCardView(product: Product)-> some View{
        
        VStack(spacing: 10) {
            Image(product.productImage)
                .resizable()
                .scaledToFit()
                .frame(width: getRect().width / 2.5, height: getRect().width / 2.5)
                .offset(y: -80)
                .padding(.bottom, -80)
            
            Text(product.title)
                .font(.custom(customFont, size: 18))
                .fontWeight(.semibold)
                .padding(.top)
            
            Text(product.subtitle)
                .font(.custom(customFont, size: 14))
                .foregroundColor(.gray)
            
            Text(product.price)
                .font(.custom(customFont, size: 16))
                .fontWeight(.bold)
                .foregroundColor(Color("Purple"))
                .padding(.top,5)
        } //: VSTACK
        .padding(.horizontal, 20)
        .padding(.bottom, 22)
        .background(
            Color.white
                .cornerRadius(25)
        )
    }
    
}
//MARK: - EXTENSION
extension View{
    func getRect() -> CGRect{
        return UIScreen.main.bounds
    }
}


//MARK: - PREVIEW
struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
