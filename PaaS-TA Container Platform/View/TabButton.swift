//
//  TabButton.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/09/29.
//

import SwiftUI

struct TabButton: View {
    var image: String
    var title: String
    
    // Selected Tab...
    @Binding var selectedTab: String
    @AppStorage("log_Status") var status = false
    @EnvironmentObject var userVM : UserVM
    // For Hero Animation Slide...
    var animation: Namespace.ID
    
    var body: some View {
        
        Button(action: {
            withAnimation(.spring()){
                selectedTab = title
                if title == "Log out" {
                    userVM.logout()
                    status.toggle()
                }
            }
        }, label: {
            
            HStack(spacing: 10){
                Image(systemName: image)
                    .font(.title2)
                    .frame(width: 30)
                
                Text(title)
                    .fontWeight(.semibold)
            }
            .foregroundColor(selectedTab == title ? Color("blue") : .white)
            .padding(.vertical,12)
            .padding(.horizontal,10)
            // Max Frame...
            .frame(maxWidth: getRect().width - 170, alignment: .leading)
            .background(
                
                ZStack{
                    
                    if selectedTab == title {
                        Color.white
                            .opacity(selectedTab == title ? 1 : 0)
                            .clipShape(CustomCorners(corners: [.topRight,.bottomRight], radius: 15))
                            .matchedGeometryEffect(id: "TAB", in: animation)
                    }
                }
                    
            )
        })
    }
}

struct TabButton_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
