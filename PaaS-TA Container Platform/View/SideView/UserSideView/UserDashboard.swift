//
//  UserDashboard.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/11/06.
//

import SwiftUI

struct UserDashboard: View {
    @EnvironmentObject var k8sVM : K8sVM
    
    @State var podCnt: CGFloat = 0
    @State var podTCnt: CGFloat = 0
    @State var deployCnt: CGFloat = 0
    @State var deployTCnt: CGFloat = 0
    @State var ReplicasetCnt: CGFloat = 0
    @State var ReplicasetTCnt: CGFloat = 0
    @State var pvcCnt: CGFloat = 0
    @State var pvcTCnt: CGFloat = 0
    
    @State var moreInfo: Bool = false
    
    var columns = Array(repeating: GridItem(.flexible(), spacing: 20), count:2)
    
    let timer = Timer.publish(every: 10.0, on: .current, in: .common).autoconnect()
    
    var body: some View {
        NavigationView {
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
                    
                    // MARK: - Version
                    VStack{
                        VStack(spacing: 8){
                            HStack{
                                Image(systemName: "chevron.right.circle.fill")
                                Text("Namespace")
                                    .font(.system(size:15))
                                    .fontWeight(.bold)
                                    .foregroundColor(.gray)
                                    .frame(width: 120, alignment: .leading)
                                
                                Text(UserDefaultManager.shared.getNamespace())
                                    .font(.system(size: 15, design: .rounded))
                                    .lineLimit(moreInfo ? 4 : 1)
                                    .foregroundColor(.black)
                                
                                Spacer()
                                
                                Button(action: {
                                    withAnimation{
                                        moreInfo.toggle()
                                    }
                                }, label: {
                                    Image(systemName: moreInfo ? "arrowtriangle.up.square" : "arrowtriangle.down.square")
                                        .foregroundColor(.black)
                                        .opacity(0.8)
                                })
                                
                                    
                            }
                            if moreInfo {
                                HStack{
                                    Image(systemName: "chevron.right.circle.fill")
                                    Text("API URL")
                                        .font(.system(size:15))
                                        .fontWeight(.bold)
                                        .foregroundColor(.gray)
                                        .frame(width: 120, alignment: .leading)
                                    
                                    Text(UserDefaultManager.shared.getK8sToken().apiUrl)
                                        .font(.callout)
                                        .foregroundColor(.black)
                                    
                                    Spacer()
                                    
                                }
                            }
                        }
                    }
                    .padding(20)
                    .frame(maxWidth: .infinity, maxHeight: 400)
                    //.background(Color.white)
                    .background(Color("blue").opacity(0.06))
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    .shadow(color: Color.primary.opacity(0.2), radius: 10, x: 0, y: 5)
                    
                    LazyVGrid(columns: columns, spacing: 10) {
                        
                        VStack(spacing: 32) {
                            getCircleGraph(title: "Deploy", useCnt: deployCnt, totalCnt: deployTCnt)
                        }
                        .padding()
                        .background(Color("blue").opacity(0.06))
                        .cornerRadius(15)
                        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 0)
                        
                        VStack(spacing: 32) {
                            getCircleGraph(title: "Pod", useCnt: podCnt, totalCnt: podTCnt)
                        }
                        .padding()
                        .background(Color("blue").opacity(0.06))
                        .cornerRadius(15)
                        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 0)
                        
                        VStack(spacing: 32) {
                            getCircleGraph(title: "Replicaset", useCnt: ReplicasetCnt, totalCnt: ReplicasetTCnt)
                        }
                        .padding()
                        .background(Color("blue").opacity(0.06))
                        .cornerRadius(15)
                        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 0)
                        
                        VStack(spacing: 32) {
                            getCircleGraph(title: "PVC", useCnt: pvcCnt, totalCnt: pvcTCnt)
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
                //일반사용자일경우 첫번째 화면에 namespace를 지정해준다.
                k8sVM.currentNS = UserDefaultManager.shared.getNamespace()
                k8sVM.namespaceMetricInfo()
            }
            .onReceive(k8sVM.$namespaceMetricsData, perform: { value in
                withAnimation(.easeInOut(duration: 2)) {
                    self.podCnt = value?.podCnt ?? 0
                    self.podTCnt = value?.podTCnt ?? 0
                    self.deployCnt = value?.deployCnt ?? 0
                    self.deployTCnt = value?.deployTCnt ?? 0
                    self.ReplicasetCnt = value?.replicaSetCnt ?? 0
                    self.ReplicasetTCnt = value?.replicaSetTCnt ?? 0
                    self.pvcCnt = value?.pvcCnt ?? 0
                    self.pvcTCnt = value?.pvcTCnt ?? 0
                }
            })
            .onReceive(timer, perform: { value in
                k8sVM.namespaceMetricInfo()
            })
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
