//
//  SearchView.swift
//  Ecommerce
//
//  Created by JunHyuk Lim on 7/10/2022.
//

import SwiftUI

struct SearchView: View {
    //MARK: - PROPERTIES
    var animation : Namespace.ID
    
    @EnvironmentObject var homeViewModel : HomeViewModel
    
    @FocusState var startTF : Bool
    
    let customFont = "Raleway-Regular"
    
    //MARK: - BODY
    var body: some View {
        VStack(spacing: 0) {
            
            //Search Bar
            HStack(spacing: 15) {
                
                //Close Button
                Button {
                    withAnimation {
                        homeViewModel.searchActivated = false
                    }
                    homeViewModel.searchText = ""
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.title2)
                        .foregroundColor(Color.black.opacity(0.7))
                } //: BUTTON
                
                //Search Bar
                HStack(spacing: 15) {
                    Image(systemName: "magnifyingglass")
                        .font(.title2)
                        .foregroundColor(.gray)
                    
                    TextField("Search", text: $homeViewModel.searchText)
                        .focused($startTF)
                        .textCase(.lowercase)
                        .autocorrectionDisabled(true)
                } //: HSTACK
                .padding(.vertical, 12)
                .padding(.horizontal)
                .background(Capsule().strokeBorder(Color("Purple"), lineWidth: 1.5))
                .matchedGeometryEffect(id: "SEARCHBAR", in: animation)
                .padding(.trailing, 20)
                
            } //: HSTACK
            .padding(.horizontal)
            .padding(.top)
            .padding(.bottom, 10)
            
            //Showing progress if searching
            if let products = homeViewModel.searchedProducts {
                if products.isEmpty {
                    VStack(spacing: 10) {
                        Image("NotFound")
                            .resizable()
                            .scaledToFit()
                            .padding(.top,60)
                        
                        Text("Item Not Found")
                            .font(.custom(customFont, size: 22).bold())
                        
                    }
                    .padding()
                } else{
                    //Filter Results
                    ScrollView(.vertical, showsIndicators: false) {
                        
                        VStack(spacing: 0){
                            
                            // Found Text...
                            Text("Found \(products.count) results")
                                .font(.custom(customFont, size: 24).bold())
                                .padding(.vertical)
                            
                            // Staggered Grid...
                            // See my Staggered Video..
                            // Link in Bio...
                            StaggeredGrid(columns: 2,spacing: 20, list: products) {product in
                                
                                // Card View....
                                ProductCardView(product: product)
                            }
                        }
                        .padding()
                    }
                }
                
            } else {
                ProgressView()
                    .padding(.top, 30)
                    .opacity(homeViewModel.searchText == "" ? 0 : 1)
            }

            
        }//: VSTACK
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color("HomeBackground"))
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                startTF = true
            }
        }
    }
    
    //MARK: - VIEW BUILDER
    @ViewBuilder
    func ProductCardView(product: Product)-> some View{
        
        VStack(spacing: 10) {
            Image(product.productImage)
                .resizable()
                .scaledToFit()
                .offset(y: -50)
                .padding(.bottom, -50)
            
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
        .padding(.top, 50)
    }
}



//MARK: - PREVIEW
struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
