//
//  OnBoardingPage.swift
//  Ecommerce
//
//  Created by JunHyuk Lim on 4/10/2022.
//

import SwiftUI

struct OnBoardingPage: View {
    //MARK: - PROPERTEIS
    let customFont = "Raleway-Regular"
    
    @State var showLoginPage : Bool = false
    
    //MARK: - BODY
    var body: some View {
        VStack(alignment: .leading) {
            Text("Find your\nGadget")
                .font(.custom(customFont, size: 55))
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            Image("OnBoard")
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            Button {
                withAnimation {
                    showLoginPage = true
                }
            } label: {
                Text("Get Started")
                    .font(.custom(customFont, size: 18))
                    .fontWeight(.semibold)
                    .padding(.vertical, 18)
                    .frame(maxWidth: .infinity)
                    .background(.white)
                    .cornerRadius(10)
                    .shadow(color: .black.opacity(0.1), radius: 5, x: 5, y: 5)
                    .foregroundColor(Color("Purple"))
            }
            .padding(.horizontal,30)
            .offset(y: 20)
            
            Spacer()

        } //: VSTACK
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("Purple"))
        .overlay(
            Group{
                if showLoginPage {
                    LoginPage()
                        .transition(.move(edge: .bottom))
                }
            }
        )
    }
}
 


//MARK: - PREVIEW
struct OnBoardingPage_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingPage()
    }
}
