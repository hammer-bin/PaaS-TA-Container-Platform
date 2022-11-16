//
//  ConfigmapCardView.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/11/16.
//

import SwiftUI

struct ConfigmapCardView: View {
    var configmapInfo : ConfigmapData
    var body: some View {
        HStack(spacing: 10){
            Image(systemName: "chevron.right.square")
                .aspectRatio(contentMode: .fill)
                .frame(width: 30, height:30)
            
            VStack(content: {
                Text(configmapInfo.name)
                    .fontWeight(.bold)
                
                Divider()
                
                VStack(alignment: .leading, spacing: 8){

                    HStack{
                        Text("NameSpace : ")
                            .font(.caption)
                            .lineLimit(1)
                        
                        Text(configmapInfo.namespace)
                            .font(.caption)
                            .lineLimit(1)
                    }
                    
                    HStack{
                        Text("CreateTime : ")
                            .font(.caption)
                            .lineLimit(1)
                        
                        Text(configmapInfo.createdTime ?? "")
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
    }
}

struct ConfigmapCardView_Previews: PreviewProvider {
    static var previews: some View {
        ConfigmapView()
    }
}
