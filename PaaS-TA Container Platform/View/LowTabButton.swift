//
//  RowTabButton.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/10/10.
//

import SwiftUI

struct LowTabButton: View {
    var title: String
    var image: String
    @EnvironmentObject var k8sVM : K8sVM
    @Binding var selected : String
    
    var body: some View {
        
        Button(action: {
            withAnimation(.spring()){selected = title}
            k8sVM.currentView = title
        }) {
            
            HStack(spacing: 10){
                
                Image(image)
                    .resizable()
                    //.renderingMode(.template)
                    .frame(width: 25, height: 25)
                    .foregroundColor(.white)
                
                if selected == title{
                    
                    Text(title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
            }
            .padding(.vertical,10)
            .padding(.horizontal)
            .background(Color.white.opacity(selected == title ? 0.08 : 0))
            .clipShape(Capsule())
        }
    }
}
