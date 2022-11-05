//
//  SCCardView.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/11/02.
//

import SwiftUI

struct SCCardView: View {
    var scInfo : SCData
    var body: some View {
        HStack(spacing: 10){
            Image(systemName: "chevron.right.square")
                .aspectRatio(contentMode: .fill)
                .frame(width: 30, height:30)
            
            VStack(content: {
                Text(scInfo.name)
                    .fontWeight(.bold)
                
                Divider()
                
                VStack(alignment: .leading, spacing: 8){

                    HStack{
                        Text("Provider : ")
                            .font(.caption)
                            .lineLimit(1)
                        
                        Text(scInfo.provider)
                            .font(.caption)
                            .lineLimit(1)
                    }
                    
                    
                    HStack{
                        Text("Parameter : ")
                            .font(.caption)
                            .lineLimit(1)
                        
                        ForEach(scInfo.parameter, id: \.self) { p in
                            Text(p)
                                //.clipShape(Rectangle())
                                .font(.caption)
                                .lineLimit(1)
                        }
                    }
                    
                    HStack{
                        Text("CreateTime : ")
                            .font(.caption)
                            .lineLimit(1)
                        
                        Text(scInfo.createdTime)
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

struct SCCardView_Previews: PreviewProvider {
    static var previews: some View {
        SCView()
    }
}
