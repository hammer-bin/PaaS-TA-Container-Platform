//
//  HomePage.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/09/29.
//

import SwiftUI

struct HomePage: View {
    @EnvironmentObject var k8sVM : K8sVM
    
    @State var name: String = ""
    @State var namespace: String = ""
    @State var uid: String = ""
    @State var status: String = ""
    @State var pvcdatas : [PVCData] = []
    @State var callList: Bool = false
    var body: some View{
        
        NavigationView{
            
            VStack(alignment: .leading, spacing: 20){
                Button(action: {
                    k8sVM.pvcList()
                    callList.toggle()
                }, label: {
                    Text("k8sVM.PVCList()")
                })
                
                if callList {
                    VStack{
                        ScrollView(.vertical, showsIndicators: false, content: {
                            ForEach(pvcdatas) {
                                pvcdatas in
                                ExpenseView(aCM: pvcdatas)
                            }
                        })
                    }
                    .padding(20)
                    .frame(maxWidth: .infinity, maxHeight: 400)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    .shadow(color: Color.primary.opacity(0.2), radius: 10, x: 0, y: 5)
                    .onReceive(k8sVM.$pvcs, perform: {self.pvcdatas = $0})
                }
                else {
                    Image("p1")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: getRect().width - 50, height: 400)
                        .cornerRadius(20)
                    
                    VStack(alignment: .leading, spacing: 5, content: {
                        
                        Text("Lee Ha Rin")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                        
                        Text("suslmk's baby, pretty")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(.gray)
                    })
                }
                
                
                // MARK: - PVCINFO
                VStack{
                    Button(action: {
                        k8sVM.pvcInfo()
                    }, label: {
                        Text("k8sVM.pvcInfo()")
                    })
                    
                    VStack{
                        Text("ResourceName: \(name)")
                        Text("NameSpace: \(namespace)")
                        Text("UID: \(uid)")
                        Text("Status: \(status)")
                    }
                }
                .onReceive(k8sVM.$pvcInfoData, perform: { value in
                    self.name = value?.detailPVC.name ?? "v1"
                    self.namespace = value?.detailPVC.namespace ?? "a"
                    self.uid = value?.detailPVC.uid ?? "a"
                    self.status = value?.resourcePVC.status ?? "a"
                    
                })
            }
            .padding(20)
            .navigationTitle("Home")
        }
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
                
                Text(aCM.status)
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
                
                Text(aCM.volume)
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
                
                Text(aCM.capacity)
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
                
                Text(aCM.createdTime)
                    .font(.callout)
                    .foregroundColor(.black)
                
                Spacer()
            }
            
            Divider()
            
        }
    }
}
