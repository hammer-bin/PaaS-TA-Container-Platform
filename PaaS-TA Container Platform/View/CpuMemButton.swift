//
//  CpuMemButton.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/10/31.
//

import SwiftUI

struct CpuMemButton: View {
    var title: String
    var image: String
    @Binding var selected : String
    
    var body: some View {
        
        Button(action: {
            withAnimation(.spring()){selected = title}
        }) {
            
            HStack(spacing: 10){
                
                Image(image)
                    .resizable()
                    .frame(width: 35, height: 35)
                    .foregroundColor(.white)
                
                if selected == title{
                    
                    Text(title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
            }
            .padding(.vertical,10)
            .padding(.horizontal)
            .frame(width: selected == title ? 160 : 80)
            .background(Color.white.opacity(selected == title ? 0.08 : 0))
            .clipShape(Capsule())
        }
    }
}
