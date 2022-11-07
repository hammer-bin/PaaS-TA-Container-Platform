//
//  PVCardView.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/10/17.
//

import SwiftUI

struct PVCardView: View {
    var pvInfo : PVData
    var body: some View {
        HStack(spacing: 10){
            Image(systemName: "chevron.right.square")
                .aspectRatio(contentMode: .fill)
                .frame(width: 30, height:30)
            
            VStack(content: {
                Text(pvInfo.name)
                    .fontWeight(.bold)
                
                Divider()
                
                VStack(alignment: .leading, spacing: 8){
                    
                    
                    HStack{
                        Text("Status : ")
                            .font(.caption)
                            .lineLimit(1)
                        
                        Text(pvInfo.status ?? "")
                            .font(.caption)
                            .lineLimit(1)
                    }
                    
                    HStack{
                        Text("Capacity : ")
                            .font(.caption)
                            .lineLimit(1)
                        
                        Text(pvInfo.capacity ?? "")
                            .font(.caption)
                            .lineLimit(1)
                    }
                    

                    
                    HStack{
                        Text("CreateTime : ")
                            .font(.caption)
                            .lineLimit(1)
                        
                        Text(pvInfo.createdTime ?? "")
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

struct PVCardView_Previews: PreviewProvider {
    static var previews: some View {
        Storage()
    }
}
