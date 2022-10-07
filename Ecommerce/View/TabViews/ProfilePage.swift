//
//  ProfilePage.swift
//  Ecommerce
//
//  Created by JunHyuk Lim on 7/10/2022.
//

import SwiftUI

struct ProfilePage: View {
    //MARK: - PROPERTIES
    
    let customFont = "Raleway-Regular"
    //MARK: - BODY
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack{
                    Text("My Profile")
                        .font(.custom(customFont, size: 28).bold())
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                    
                    VStack(spacing: 15) {
                        Image("ProfileImage")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 60, height: 60)
                            .clipShape(Circle())
                            .offset(y: -30)
                            .padding(.bottom, -30)
                        
                        Text("JunHyuk Lim")
                            .font(.custom(customFont, size: 16))
                            .fontWeight(.semibold)
                        
                        HStack(alignment: .top, spacing: 10) {
                            Image(systemName: "location.north.circle.fill")
                                .foregroundColor(.gray)
                                .rotationEffect(.init(degrees: 180))
                            
                            Text("7 Australia Ave, Sydney Olympic Park, NSW, 2127")
                                .font(.custom(customFont, size: 15))
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding([.horizontal, .bottom])
                    .background(Color.white.cornerRadius(12))
                    .padding()
                    .padding(.top, 40)
                    
                    //Custom Navigation Links
                    customNavigationLink(title: "Edit Profile") {
                        Text("")
                            .navigationTitle("Edit Profile")
                            .navigationBarTitleDisplayMode(.large)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color("HomeBackground").ignoresSafeArea())
                    }
                    
                    customNavigationLink(title: "Shopping address") {
                        Text("")
                            .navigationTitle("Shopping address")
                            .navigationBarTitleDisplayMode(.large)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color("HomeBackground").ignoresSafeArea())
                    }
                    
                    customNavigationLink(title: "Order history") {
                        Text("")
                            .navigationTitle("Order history")
                            .navigationBarTitleDisplayMode(.large)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color("HomeBackground").ignoresSafeArea())
                    }
                    
                    customNavigationLink(title: "Cards") {
                        Text("")
                            .navigationTitle("Cards")
                            .navigationBarTitleDisplayMode(.large)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color("HomeBackground").ignoresSafeArea())
                    }
                    
                    customNavigationLink(title: "Notifications") {
                        Text("")
                            .navigationTitle("Notifications")
                            .navigationBarTitleDisplayMode(.large)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color("HomeBackground").ignoresSafeArea())
                    }
                    
                } //: VSTACK
                .padding(.horizontal, 22)
                .padding(.vertical, 20)
            } //: SCROLLVIEW
            .toolbar(.hidden)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("HomeBackground").ignoresSafeArea())


        }
    }
    //MARK: - VIEW BUILDER
    @ViewBuilder
    func customNavigationLink<Detail: View>(title: String, @ViewBuilder content : @escaping()->Detail)-> some View{
        
        NavigationLink {
            content()
        } label: {
            HStack{
                Text(title)
                    .font(.custom(customFont, size: 17))
                    .fontWeight(.semibold)
                
                Spacer()
                
                Image(systemName: "chevron.right")
            }
            .foregroundColor(.black)
            .padding()
            .background(Color.white.cornerRadius(12))
            .padding(.horizontal)
            .padding(.top,10)
        }

        
    }
}

struct ProfilePage_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePage()
    }
}
