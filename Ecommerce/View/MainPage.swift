//
//  MainPage.swift
//  Ecommerce
//
//  Created by JunHyuk Lim on 5/10/2022.
//

import SwiftUI

struct MainPage: View {
    //MARK: - PROPERTIES
    
    @State var currentTab :  Tab = .Home
    
    //Hiding Tab bar
    init(){
        UITabBar.appearance().isHidden = true
    }
    
    
    
    enum Tab : String, CaseIterable {
        case Home = "Home"
        case Liked = "Liked"
        case Profile = "Profile"
        case Cart = "Cart"
    }
    
    //MARK: - BODY
    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $currentTab) {
                Home()
                    .tag(Tab.Home)
                
                Text("Liked")
                    .tag(Tab.Liked)
                
                Text("Profile")
                    .tag(Tab.Profile)
                
                Text("Cart")
                    .tag(Tab.Cart)

            } //: TAB VIEW
            //MARK: - TAB BUTTON
            HStack(spacing: 0) {
                ForEach(Tab.allCases, id :\.self){ tab in
                    Button {
                        currentTab = tab
                    } label: {
                        Image(tab.rawValue)
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio( contentMode: .fit)
                            .frame(width: 22, height: 22)
                            .background(
                                Color("Purple")
                                    .opacity(0.1)
                                    .cornerRadius(5)
                                    .blur(radius: 5)
                                    .padding(-7)
                                    .opacity(currentTab == tab ? 1 : 0)
                            )
                            .frame(maxWidth: .infinity)
                            .foregroundColor(currentTab == tab ? Color("Purple") : Color.black.opacity(0.3))
                    } //: BUTTON
                } //: LOOP
            } //: HSTACK
            .padding([.horizontal,.top])
            .padding(.bottom, 10)
        } //: VSTACK
        .background(Color("HomeBackground").ignoresSafeArea())

    }
}


    
    
//MARK: - PREVIEW
struct MainPage_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}
