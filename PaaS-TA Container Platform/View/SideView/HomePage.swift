//
//  HomePage.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/09/29.
//

import SwiftUI

struct HomePage: View {
    @EnvironmentObject var k8sVM : K8sVM
    @EnvironmentObject var userVM : UserVM
    
    @State var name: String = ""
    @State var namespace: String = ""
    @State var uid: String = ""
    @State var status: String = ""
    
    @State var kubeletVersion: String = ""
    @State var NodeCnt: CGFloat = 0
    @State var NodeTCnt: CGFloat = 0
    @State var NamespaceCnt: CGFloat = 0
    @State var NamespaceTCnt: CGFloat = 0
    @State var PvCnt: CGFloat = 0
    @State var PvTCnt: CGFloat = 0
    @State var PvcCnt: CGFloat = 0
    @State var PvcTCnt: CGFloat = 0
    @State var PodCnt: CGFloat = 0.0
    @State var PodTCnt: CGFloat = 0.0
    @State var CpuRatio: CGFloat = 0.0
    @State var MemRatio: CGFloat = 0.0
    @State var NodeRatio: CGFloat = 0.0
    @State var NSRatio: CGFloat = 0.0
    @State var PvRatio: CGFloat = 0.0
    @State var PvcRatio: CGFloat = 0.0
    @State var PodRatio: CGFloat = 0.0
    
    @State var APIUrl: String = UserDefaultManager.shared.getK8sToken().apiUrl
    @State var K8sName: String = UserDefaultManager.shared.getK8sName()
    
    @State var pvcdatas : [PVCData] = []
    @State var callList: Bool = false
    
    @State var progress: CGFloat = 0.1
    @State var current = "CPU"
    @State var moreInfo: Bool = false
    
    var columns = Array(repeating: GridItem(.flexible(), spacing: 20), count:2)
    
    let timer = Timer.publish(every: 10.0, on: .current, in: .common).autoconnect()
    
    var body: some View{
        
        NavigationView{
            
            ScrollView(.vertical, showsIndicators: false){
                VStack(alignment: .leading, spacing: 20){
                    // MARK: - Version
                    VStack{
                        VStack(spacing: 8){
                            HStack{
                                Image(systemName: "chevron.right.circle.fill")
                                Text("K8s Name")
                                    .font(.system(size:15))
                                    .fontWeight(.bold)
                                    .foregroundColor(.gray)
                                    .frame(width: 120, alignment: .leading)
                                
                                Text(K8sName)
                                    .font(.system(size: 15, design: .rounded))
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
                                    Text("K8s Version")
                                        .font(.system(size:15))
                                        .fontWeight(.bold)
                                        .foregroundColor(.gray)
                                        .frame(width: 120, alignment: .leading)
                                    
                                    Text(kubeletVersion)
                                        .font(.system(size: 15, design: .rounded))
                                        .foregroundColor(.black)
                                    
                                    Spacer()
                                    
                                }
                                
                                HStack{
                                    Image(systemName: "chevron.right.circle.fill")
                                    Text("API URL")
                                        .font(.system(size:15))
                                        .fontWeight(.bold)
                                        .foregroundColor(.gray)
                                        .frame(width: 120, alignment: .leading)
                                    
                                    Text(APIUrl)
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
                    .onReceive(k8sVM.$pvcs, perform: {self.pvcdatas = $0})
                    
                    // MARK: - CPU / MEM
                    VStack{
                        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)){
                            HStack(spacing: 0){
                                
                                //TabButton...
                                CpuMemButton(title: "CPU", image: "cpu-100", selected: $current)
                                
                                Spacer(minLength: 0)
                                
                                CpuMemButton(title: "MEM", image: "memory-64", selected: $current)
                                
                            }
                            .padding(.vertical, 12)
                            .padding(.horizontal)
                            .background(Color("Ring1"))
                            //.opacity(0.7)
                            .clipShape(Capsule())
                            .padding(.horizontal,35)
                        }
                        RoundedRectangle(cornerRadius: 8).fill(Color.clear)
                            .frame(maxWidth: 150, maxHeight: 50)
                            .font(.system(size: 35, weight: .black))
                            .foregroundColor(Color("blue"))
                            //.padding(.top, 5)
                            .lineLimit(1)
                            .modifier(CountingModifier(number: current == "CPU" ? CpuRatio*100 : MemRatio*100))
                        
                        // MARK: - SpeedMeter
                        SpeedoMeter(progress: current == "CPU" ? $CpuRatio : $MemRatio)
                    }
                    .padding(.top, 10)
                    .frame(maxWidth: .infinity)
                    .frame(height: 360)
                    // MARK: - Custom Background
                    .background{
                        RoundedRectangle(cornerRadius: 15, style: .continuous)
                            .fill(
                                .linearGradient(colors: [
                                    Color("blue")
                                        .opacity(0.8),
                                    Color("blue")
                                        .opacity(0.4),
                                    Color("blue")
                                        .opacity(0.2)
                                ] + Array(repeating: Color.clear, count: 2)
                                                , startPoint: .top, endPoint: .bottom)
                            )
                    }
                    
                    // MARK: - METRICS INFO
                    
                    LazyVGrid(columns: columns, spacing: 10) {
                        
                        VStack(spacing: 32){
                            getCircleGraph(title: "Node", useCnt: NodeCnt, totalCnt: NodeTCnt, ratio: NodeRatio)
                        }
                        .padding()
                        .background(Color("blue").opacity(0.06))
                        .cornerRadius(15)
                        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 0)
                        
                        VStack(spacing: 32){
                            getCircleGraph(title: "Namespace", useCnt: NamespaceCnt, totalCnt: NamespaceTCnt, ratio: NSRatio)
                        }
                        .padding()
                        .background(Color("blue").opacity(0.06))
                        .cornerRadius(15)
                        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 0)
                        
                        VStack(spacing: 32){
                            getCircleGraph(title: "Pod", useCnt: PodCnt, totalCnt: PodTCnt, ratio: PodRatio)
                        }
                        .padding()
                        .background(Color("blue").opacity(0.06))
                        .cornerRadius(15)
                        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 0)
                        
                        VStack(spacing: 32){
                            getCircleGraph(title: "PVC", useCnt: PvcCnt, totalCnt: PvcTCnt, ratio: PvcRatio)
                        }
                        .padding()
                        .background(Color("blue").opacity(0.06))
                        .cornerRadius(15)
                        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 0)
                        
                        VStack(spacing: 32){
                            getCircleGraph(title: "PV", useCnt: PvCnt, totalCnt: PvTCnt, ratio: PvRatio)
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
                k8sVM.clusterMetricInfo()
                userVM.isClusterAdmin = true
            }
            .onReceive(k8sVM.$clusterMetricsData, perform: { value in
                self.kubeletVersion = value?.kubeletVersion ?? "-"
                withAnimation(.easeInOut(duration: 2)){
                    self.NodeCnt = value?.nodeCnt ?? 0
                    self.NamespaceCnt = value?.nameSpaceCnt ?? 0
                    self.PvCnt = value?.pvCnt ?? 0
                    self.PvcCnt = value?.pvcCnt ?? 0
                    self.PodCnt = value?.podCnt ?? 0
                    self.CpuRatio = value?.cpuRatio ?? 0.0
                    self.MemRatio = value?.memRatio ?? 0.0
                    self.NodeRatio = value?.nodeRatio ?? 0.0
                    self.NSRatio = value?.namespaceRatio ?? 0.0
                    self.PvcRatio = value?.pvcRatio ?? 0.0
                    self.PvRatio = value?.pvRatio ?? 0.0
                    self.PodRatio = value?.podRatio ?? 0.0
                }
                self.NodeTCnt = value?.nodeTCnt ?? 0
                self.NamespaceTCnt = value?.nameSpaceTCnt ?? 0
                self.PvTCnt = value?.pvTCnt ?? 0
                self.PvcTCnt = value?.pvcTCnt ?? 0
                self.PodTCnt = value?.podTCnt ?? 0
            })
            .onReceive(timer, perform: { value in
                //k8sVM.clusterMetricInfo()
            })
        }
    }
    
    @ViewBuilder
    func getCircleGraph(title: String, useCnt: CGFloat, totalCnt: CGFloat, ratio: CGFloat) -> some View {
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
                    .trim(from: 0, to: ratio)
                    .stroke(Color("blue"), style: StrokeStyle(lineWidth: 10, lineCap: .round))
                    .frame(width: (UIScreen.main.bounds.width - 150) / 2, height: (UIScreen.main.bounds.width - 150) / 2)
                    .animation(Animation.easeInOut(duration: 20), value: ratio)
                
                
                RoundedRectangle(cornerRadius: 8).fill(.clear)
                    .frame(maxWidth: 100, maxHeight: 30)
                    .foregroundColor(Color("blue"))
                    .modifier(CountingModifierS(number: ratio ,unit: "%", format: "%.1f"))
                    .rotationEffect(.init(degrees: 90))
                    
            }
            .rotationEffect(.init(degrees: -90))
            
            HStack(spacing: 2) {
                RoundedRectangle(cornerRadius: 8).fill(.clear)
                    .frame(maxWidth: 30, maxHeight: 30)
                    .foregroundColor(Color("blue"))
                    .modifier(CountingModifierS(number: useCnt ,unit: "", format: "%.0f"))
                Text("/  \(getDec(val: totalCnt))")
                    .font(.system(size: 22)).bold()
                    .fontWeight(.black)
                    .foregroundColor(Color("blue"))
            }
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

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}


struct ExpenseView: View {
    var aCM: PVCData
    var width: CGFloat = 120
    var body: some View {
        
        VStack{
            
            HStack{
                Image(systemName: "chevron.right.circle.fill")
                Text("ReourceName")
                    .font(.system(size:15))
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                    .frame(width: width, alignment: .leading)
                
                Text(aCM.name)
                    .font(.callout)
                    .foregroundColor(.black)
                
                Spacer()
                    
            }
            
            HStack{
                Image(systemName: "chevron.right.circle.fill")
                Text("NameSpace")
                    .font(.system(size:15))
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                    .frame(width: width, alignment: .leading)
                
                Text(aCM.namespace)
                    .font(.callout)
                    .foregroundColor(.black)
                
                Spacer()
            }
            
            HStack{
                Image(systemName: "chevron.right.circle.fill")
                Text("Status")
                    .font(.system(size:15))
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                    .frame(width: width, alignment: .leading)
                
                Text(aCM.status ?? "")
                    .font(.callout)
                    .foregroundColor(.black)
                
                Spacer()
            }
            
            HStack{
                Image(systemName: "chevron.right.circle")
                Text("Volume")
                    .font(.system(size:15))
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                    .frame(width: width, alignment: .leading)
                
                Text(aCM.volume ?? "")
                    .font(.callout)
                    .foregroundColor(.black)
                
                Spacer()
            }
            
            HStack{
                Image(systemName: "chevron.right.circle.fill")
                Text("Capacity")
                    .font(.system(size:15))
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                    .frame(width: width, alignment: .leading)
                
                Text(aCM.capacity ?? "")
                    .font(.callout)
                    .foregroundColor(.black)
                
                Spacer()
            }
            
            HStack{
                Image(systemName: "chevron.right.circle.fill")
                Text("Created Time")
                    .font(.system(size:15))
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                    .frame(width: width, alignment: .leading)
                
                Text(aCM.createdTime ?? "")
                    .font(.callout)
                    .foregroundColor(.black)
                
                Spacer()
            }
            
            Divider()
            
        }
    }
}
