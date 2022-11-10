//
//  UserDashboard.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/11/06.
//

import SwiftUI

struct UserDashboard: View {
    @EnvironmentObject var k8sVM : K8sVM
    var columns = Array(repeating: GridItem(.flexible(), spacing: 20), count:2)
    
    var body: some View {
        NavigationView {
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
                    
                    LazyVGrid(columns: columns, spacing: 10) {
                        
                        VStack(spacing: 32) {
                            Rectangle()
                        }
                        .padding()
                        .background(Color("blue").opacity(0.06))
                        .cornerRadius(15)
                        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 0)
                    }
                }
                .padding(20)
                .navigationTitle("Dashboard")
            }
            .onAppear{
                
            }
        }
    }
    
    @ViewBuilder
    func getCircleGraph(title: String, useCnt: CGFloat, totalCnt: CGFloat) -> some View {
        VStack{
            HStack{
                
                Text(title)
                    .font(.system(size: 22))
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                Spacer(minLength: 0)
            }
            ZStack{
                Circle()
                    .trim(from: 0, to: 1)
                    .stroke(Color("blue").opacity(0.05), lineWidth: 10)
                    .frame(width: (UIScreen.main.bounds.width - 150) / 2, height: (UIScreen.main.bounds.width - 150) / 2)
                
                Circle()
                    .trim(from: 0, to: (useCnt / totalCnt   ))
                    .stroke(Color("blue"), style: StrokeStyle(lineWidth: 10, lineCap: .round))
                    .frame(width: (UIScreen.main.bounds.width - 150) / 2, height: (UIScreen.main.bounds.width - 150) / 2)
                
                Text(getPercent(current: useCnt, Goal: totalCnt) + " %")
                    .font(.system(size: 22))
                    .fontWeight(.bold)
                    .foregroundColor(Color("blue"))
                    .rotationEffect(.init(degrees: 90))
            }
            .rotationEffect(.init(degrees: -90))
            
            Text(getDec(val: useCnt) + " / " + getDec(val: totalCnt))
                .font(.system(size: 22))
                .foregroundColor(Color("blue"))
                .fontWeight(.bold)
        }
        
    }
    
    func getPercent(current: CGFloat, Goal: CGFloat) -> String {
        let per = (current / Goal) * 100
        
        return String(format: "%.1f", per)
    }
    
    // converting Number to decimal...
    func getDec(val: CGFloat)->String{
        let format = NumberFormatter()
        format.numberStyle = .decimal
        
        return format.string(from: NSNumber.init(value: Float(val)))!
    }
}
