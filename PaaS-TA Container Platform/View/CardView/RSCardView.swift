//
//  RSCardView.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/11/08.
//

import SwiftUI

struct RSCardView: View {
    var rsInfo : RSData
    var body: some View {
        HStack(spacing: 10){
            Image(systemName: "chevron.right.square")
                .aspectRatio(contentMode: .fill)
                .frame(width: 30, height:30)
            
            VStack(content: {
                Text(rsInfo.name)
                    .fontWeight(.bold)
                
                Divider()
                
                VStack(alignment: .leading, spacing: 8){
                    
                    HStack{
                        Text("NameSpace : ")
                            .font(.caption)
                            .lineLimit(1)
                        
                        Text(rsInfo.namespace)
                            .font(.caption)
                            .lineLimit(1)
                    }
                    
                    
                    HStack{
                        Text("pods : ")
                            .font(.caption)
                            .lineLimit(1)
                        
                        Text(rsInfo.pods ?? "")
                            .font(.caption)
                            .lineLimit(1)
                    }
                    
                    HStack{
                        Text("image : ")
                            .font(.caption)
                            .lineLimit(1)
                        
                        ForEach(rsInfo.image ?? [], id: \.self) { p in
                            Text(p)
                                .font(.caption)
                                .lineLimit(1)
                        }
                    }
                    
                    HStack{
                        Text("CreateTime : ")
                            .font(.caption)
                            .lineLimit(1)
                        
                        Text(rsInfo.createdTime ?? "")
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

struct RSCardView_Previews: PreviewProvider {
    static var previews: some View {
        ReplicaSetListView()
    }
}
