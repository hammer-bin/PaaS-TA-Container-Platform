//
//  DeploymentCardView.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/11/04.
//

import SwiftUI

struct DeploymentCardView: View {
    var deployInfo : DeployData
    var body: some View {
        HStack(spacing: 10){
            Image(systemName: "chevron.right.square")
                .aspectRatio(contentMode: .fill)
                .frame(width: 30, height:30)
            
            VStack(content: {
                Text(deployInfo.name)
                    .fontWeight(.bold)
                
                Divider()
                
                VStack(alignment: .leading, spacing: 8){

                    HStack{
                        Text("NameSpace : ")
                            .font(.caption)
                            .lineLimit(1)
                        
                        Text(deployInfo.namespace)
                            .font(.caption)
                            .lineLimit(1)
                    }
                    
                    
                    HStack{
                        Text("replicas : ")
                            .font(.caption)
                            .lineLimit(1)
                        
                        Text("\(deployInfo.availableReplicas) / \(deployInfo.replicas)")
                            .font(.caption)
                            .lineLimit(1)
                    }
                    
                    HStack{
                        Text("image: ")
                            .font(.caption)
                            .lineLimit(1)
                        
                        VStack(spacing: 3){
                            ForEach(deployInfo.image ?? [], id: \.self){ am in
                                Text(am)
                                    .font(.caption)
                                    .lineLimit(1)
                            }
                        }
                    }
                    
                    HStack{
                        Text("CreateTime : ")
                            .font(.caption)
                            .lineLimit(1)
                        
                        Text(deployInfo.createdTime ?? "")
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

struct DeploymentCardView_Previews: PreviewProvider {
    static var previews: some View {
        DeploymentView()
    }
}
