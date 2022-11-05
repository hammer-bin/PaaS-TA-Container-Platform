//
//  ServiceCardView.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/10/09.
//

import SwiftUI

struct ServiceCardView: View {
    var serviceInfo : ServiceData
    var body: some View {
        HStack(spacing: 10){
            Image(systemName: "chevron.right.square")
                .aspectRatio(contentMode: .fill)
                .frame(width: 30, height:30)
            
            VStack(content: {
                Text(serviceInfo.name)
                    .fontWeight(.bold)
                
                Divider()
                
                VStack(alignment: .leading, spacing: 8){

                    HStack{
                        Text("NameSpace : ")
                            .font(.caption)
                            .lineLimit(1)
                        
                        Text(serviceInfo.namespace)
                            .font(.caption)
                            .lineLimit(1)
                    }
                    
                    
                    HStack{
                        Text("Type : ")
                            .font(.caption)
                            .lineLimit(1)
                        
                        Text(serviceInfo.type)
                            .font(.caption)
                            .lineLimit(1)
                    }
                    
                    HStack{
                        Text("ClusterIP : ")
                            .font(.caption)
                            .lineLimit(1)
                        
                        Text(serviceInfo.clusterIP)
                            .font(.caption)
                            .lineLimit(1)
                    }
                    
                    HStack{
                        Text("CreateTime : ")
                            .font(.caption)
                            .lineLimit(1)
                        
                        Text(serviceInfo.createdTime)
                            .font(.caption)
                            .lineLimit(1)
                    }
                    
                }
                Spacer()
            })
        }
        .padding(.horizontal)
        .padding(.vertical)
        .background(Color("blue").opacity(0.1))
        .cornerRadius(20)
//        .shadow(color: Color.black.opacity(0.08), radius: 5, x: 5, y: 5)
//        .shadow(color: Color.black.opacity(0.08), radius: 5, x: -5, y: -5)
    }
}

struct ServiceCardView_Previews: PreviewProvider {
    static var previews: some View {
        ServiceView()
    }
}
