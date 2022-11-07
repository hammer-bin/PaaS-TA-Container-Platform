//
//  PodCardView.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/11/05.
//

import SwiftUI

struct PodCardView: View {
    var podInfo : PodData
    var body: some View {
        HStack(spacing: 10){
            Image(systemName: "chevron.right.square")
                .aspectRatio(contentMode: .fill)
                .frame(width: 30, height:30)
            
            VStack(content: {
                Text(podInfo.name)
                    .fontWeight(.bold)
                
                Divider()
                
                VStack(alignment: .leading, spacing: 8){

                    HStack{
                        Text("NameSpace : ")
                            .font(.caption)
                            .lineLimit(1)
                        
                        Text(podInfo.namespace)
                            .font(.caption)
                            .lineLimit(1)
                    }
                    
                    
                    HStack{
                        Text("node : ")
                            .font(.caption)
                            .lineLimit(1)
                        
                        Text(podInfo.node ?? "")
                            .font(.caption)
                            .lineLimit(1)
                    }
                    
                    HStack{
                        Text("status : ")
                            .font(.caption)
                            .lineLimit(1)
                        
                        Text(podInfo.status ?? "")
                            .font(.caption)
                            .lineLimit(1)
                    }
                    
                    HStack{
                        Text("restarts : ")
                            .font(.caption)
                            .lineLimit(1)
                        
                        Text("\(podInfo.restarts)")
                            .font(.caption)
                            .lineLimit(1)
                    }
                    
                    HStack{
                        Text("CreateTime : ")
                            .font(.caption)
                            .lineLimit(1)
                        
                        Text(podInfo.createdTime ?? "")
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

struct PodCardView_Previews: PreviewProvider {
    static var previews: some View {
        PodView()
    }
}
