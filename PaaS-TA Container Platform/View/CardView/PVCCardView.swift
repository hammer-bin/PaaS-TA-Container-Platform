//
//  PVCCardView.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/10/10.
//

import SwiftUI

struct PVCCardView: View {
    var pvcInfo : PVCData
    var body: some View {
        HStack(spacing: 10){
            Image(systemName: "chevron.right.square")
                .aspectRatio(contentMode: .fill)
                .frame(width: 30, height:30)
            
            VStack(content: {
                Text(pvcInfo.name)
                    .fontWeight(.bold)
                
                Divider()
                
                VStack(alignment: .leading, spacing: 8){

                    HStack{
                        Text("NameSpace : ")
                            .font(.caption)
                            .lineLimit(1)
                        
                        Text(pvcInfo.namespace)
                            .font(.caption)
                            .lineLimit(1)
                    }
                    
                    
                    HStack{
                        Text("Status : ")
                            .font(.caption)
                            .lineLimit(1)
                        
                        Text(pvcInfo.status ?? "")
                            .font(.caption)
                            .lineLimit(1)
                    }
                    
                    HStack{
                        Text("Capacity : ")
                            .font(.caption)
                            .lineLimit(1)
                        
                        Text(pvcInfo.capacity ?? "")
                            .font(.caption)
                            .lineLimit(1)
                    }
                    
                    HStack{
                        Text("Volume : ")
                            .font(.caption)
                            .lineLimit(1)
                        
                        Text(pvcInfo.volume ?? "")
                            .font(.caption)
                            .lineLimit(1)
                    }
                    
                    HStack{
                        Text("CreateTime : ")
                            .font(.caption)
                            .lineLimit(1)
                        
                        Text(pvcInfo.createdTime ?? "")
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
        .shadow(color: Color.black.opacity(0.08), radius: 5, x: 5, y: 5)
        .shadow(color: Color.black.opacity(0.08), radius: 5, x: -5, y: -5)
    }
}

struct PVCCardView_Previews: PreviewProvider {
    static var previews: some View {
        PVCView()
    }
}
