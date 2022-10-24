//
//  Workload.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/09/30.
//

import SwiftUI

struct Workload: View {
    var body: some View {
        WorkloadContent()
    }
}

struct Workload_Previews: PreviewProvider {
    static var previews: some View {
        Workload()
    }
}

struct WorkloadContent : View {
    
    //var edges = UIApplication.shared.windows.first?.safeAreaInsets
    @State var selectedTab = "Deployment"
    
    var body: some View {
        VStack(spacing:0){
            
            VStack(spacing:0) {
                ZStack {
                    HStack{
                        
                        Spacer(minLength: 0)
                        
                        Button(action: {}, label: {
                            
                            Image(systemName: "magnifyingglass")
                                .font(.system(size:22))
                        })
                    }
                    
                    Text("Workload")
                        .font(.title2)
                        .fontWeight(.semibold)
                }
                .padding()
                .padding(.top)
                .foregroundColor(.white)
                
                HStack(spacing:20){
                    
                    ForEach(tabs, id: \.self){ title in
                        WorkLoadTabButton(selectedTab: $selectedTab, title: title)
                    }
                }
                .padding()
                .background(Color.white.opacity(0.08))
                .cornerRadius(15)
                .padding(.vertical)
            }
            .padding(.top,20)
            .padding(.bottom)
            .background(Color("Purple"))
            //.clipShape(WorkLoadCustomCorner(corner: .bottomLeft, size: 65))
            
            switch selectedTab {
            case "Deployment":
                DeploymentListView()
            case "Pod":
                PodListView()
            case "ReplicaSet":
                ReplicaSetListView()
            default:
                DeploymentListView()
            }
            
//            VStack{
//                Spacer()
//            }.frame(height: .infinity)
            
        }
        .background(Color(.white).ignoresSafeArea(.all, edges: .all))
        .ignoresSafeArea(.all, edges: .top)
    }
}

var tabs = ["Deployment", "Pod", "ReplicaSet"]

struct WorkLoadTabButton : View {
    @Binding var selectedTab : String
    var title : String
    @Namespace var animation
    
    var body: some View{
        
        Button(action: {
            
            withAnimation{
                
                selectedTab = title
                
            }
            
        }, label: {
            
            Text(title)
                .foregroundColor(.white)
                .padding(.vertical, 10)
                .padding(.horizontal)
                .background(
                    ZStack{
                        if selectedTab == title {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color("Purple"))
                                .matchedGeometryEffect(id: "Tab", in: animation)
                        }
                    }
                )
        })
    }
}

struct WorkLoadCustomCorner : Shape {
    
    var corner : UIRectCorner
    var size : CGFloat
    
    func path(in rect: CGRect) -> Path {
        
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corner, cornerRadii: CGSize(width: size, height: size))
        
        return Path(path.cgPath)
    }
}

struct ListView : View {
    var deployInfo : DeployData
    var body: some View {
        HStack(spacing: 10){
            Image(systemName: "chevron.right.square")
                .aspectRatio(contentMode: .fill)
                .frame(width: 30, height:30)
            
            VStack(alignment: .leading, spacing: 8){
                Text(deployInfo.name)
                    .fontWeight(.bold)
                
                Text(deployInfo.namespace)
                    .font(.caption)
                    .lineLimit(1)
                
            }
            Spacer()
            
            Text(deployInfo.createdTime)
                .font(.system(size: 15))
                .fontWeight(.bold)
        }
        .padding(.horizontal)
    }
}
