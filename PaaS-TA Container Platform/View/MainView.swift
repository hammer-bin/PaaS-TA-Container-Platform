//
//  MainView.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/09/28.
//

import SwiftUI

struct MainView: View {
    // selected Tab...
    @State var selectedTab = "Dashboard"
    @State var showMenu = false
    @State var translation: CGSize = .zero
    @State var offsetX: CGFloat = -120
    @EnvironmentObject var k8sVM : K8sVM
    
    // Animation Namespace
    @Namespace var animation
    
    var body: some View {
        
        ZStack{
            Color("blue")
                .ignoresSafeArea()
            
            // Side Menu...
            ScrollView(getRect().height < 750 ? .vertical : .init(), showsIndicators: false, content: {
                SideMenu(selectedTab: $selectedTab)
            })
            
            
            ZStack{
                
                // two background Cards...
                
                Color.white
                    .opacity(0.5)
                    .cornerRadius(showMenu ? 15 : 0)
                    .shadow(color: Color.black.opacity(0.07), radius: 5, x: -5, y: 0)
                    .offset(x: showMenu ? -25 : 0)
                    .padding(.vertical, 30)
                
                Color.white
                    .opacity(0.5)
                    .cornerRadius(showMenu ? 15 : 0)
                    .shadow(color: Color.black.opacity(0.07), radius: 5, x: -5, y: 0)
                    .offset(x: showMenu ? -50 : 0)
                    .padding(.vertical, 60)
                
                Home(selectedTab: $selectedTab)
                    .cornerRadius(showMenu ? 15 : 0)
                    
            }
            // Scaling And Moving The View...
            .scaleEffect(showMenu ? 0.84 : 1)
            .offset(x: showMenu ? getRect().width - 120 : 0)
            .ignoresSafeArea()
            .overlay(
                VStack{
                    HStack(alignment: .top){                //Menu Button...
                        Button(action: {
                            withAnimation(.spring()){
                                showMenu.toggle()
                                k8sVM.showMenu.toggle()
                            }
                        }, label: {
                            
                            // Animated Drawer Button...
                            VStack(spacing: 5) {
                                Capsule()
                                    .fill(showMenu ? Color.white : Color.primary)
                                    .frame(width: 30, height: 3)
                                // Rotating...
                                    .rotationEffect(.init(degrees: showMenu ? -50 : 0))
                                    .offset(x: showMenu ? 2 : 0, y: showMenu ? 9 : 0)
                                VStack(spacing: 5) {
                                    Capsule()
                                        .fill(showMenu ? Color.white : Color.primary)
                                        .frame(width: 30, height: 3)
                                    // Moving Up when clicked...
                                    Capsule()
                                        .fill(showMenu ? Color.white : Color.primary)
                                        .frame(width: 30, height: 3)
                                        .offset(y: showMenu ? -8 : 0)
                                }
                                .rotationEffect(.init(degrees: showMenu ? 50 : 0))
                            }
                        })
                        .padding()
                        
                        Spacer()
                        
                        Button(action: {
                            withAnimation(.easeInOut){
                                k8sVM.searchActivated = true
                            }
                        }, label: {
                            Image(systemName: "magnifyingglass")
                                .padding([.top, .trailing], 15)
                                .font(.title2)
                                .frame(width: 36, height: 36)
                                .foregroundColor(.black)
                                .opacity(showMenu ? 0 : 1)
                            
                        })
                    }
                    Spacer()
                }
            )
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        translation = gesture.translation
                        
                        
                    }
                    .onEnded{_ in
                        withAnimation(.spring()){
                            let dragOffset = translation.width + offsetX
                            
                            if dragOffset > -100 && offsetX == -120 {
                                offsetX = 120
                                showMenu = true
                            } else if dragOffset < 100 && offsetX == 120 {
                                offsetX = -120
                                showMenu = false
                            }
                            //self.show.toggle()
                        }
                    }
                             
            )
            .overlay(
                ZStack{
                    if k8sVM.searchActivated{
                        SearchView(animation: animation)
                            
                    }
                }
            )
            //detailView overlay 고려
            
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
