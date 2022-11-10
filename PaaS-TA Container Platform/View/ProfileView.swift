//
//  ProfileView.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/11/09.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var userVM : UserVM
    var body: some View {
        
        NavigationView {
            
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack{
                    
                    Text("My Profile")
                        .font(.title)
                        .fontWeight(.heavy)
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    VStack(spacing: 15) {
                        
                        Image("lhr_profile")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 60, height: 60)
                            .clipShape(Circle())
                            .offset(y: -30)
                            .padding(.bottom, -30)
                        
                        Text(userVM.loggedInUser?.userID ?? "-")
                            .font(.system(size: 16, design: .rounded))
                            .fontWeight(.semibold)
                        Text(userVM.loggedInUser?.k8sToken ?? "-")
                            .font(.system(size: 16, design: .rounded))
                            .fontWeight(.semibold)
                        Text(userVM.loggedInUser?.apiUrl ?? "-")
                            .font(.system(size: 16, design: .rounded))
                            .fontWeight(.semibold)
                        
                        HStack(alignment: .top, spacing: 10) {
                            
                            Image(systemName: "location.north.circle.fill")
                                .foregroundColor(.gray)
                                .rotationEffect(.init(degrees: 180))
                            
                            Text("Address: 43 Oxford Road\nM13 4GR\nManchester, UK")
                                .font(.system(size: 15, design: .rounded))
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding([.horizontal,.bottom])
                    .background(
                        Color("blue").opacity(0.1)
                        .cornerRadius(15))
                    
                    
                    .padding()
                    .padding(.top, 40)
                }
                .padding(.horizontal,22)
                .padding(.vertical,20)
                
                // Custom Navigation Link...
                
                CustomNavigationLimk(title: "Edit Profile") {
                    
                    Text("")
                        .navigationTitle("Edit Profile")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color("HomeBG").ignoresSafeArea())
                }
                
                CustomNavigationLimk(title: "Shopping address") {
                    
                    Text("")
                        .navigationTitle("Shopping address")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color("HomeBG").ignoresSafeArea())
                }
                
                CustomNavigationLimk(title: "Order History") {
                    
                    Text("")
                        .navigationTitle("Order History")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color("HomeBG").ignoresSafeArea())
                }
                
                CustomNavigationLimk(title: "Card") {
                    
                    Text("")
                        .navigationTitle("Card")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color("HomeBG").ignoresSafeArea())
                }
                
                CustomNavigationLimk(title: "Notifications") {
                    
                    Text("")
                        .navigationTitle("Notifications")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color("HomeBG").ignoresSafeArea())
                }
            }
            .navigationBarHidden(true)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Color("")
                    .ignoresSafeArea()
            )
        }
    }
    
    // Avoiding new Structs...
    @ViewBuilder
    func CustomNavigationLimk<Detail: View>(title: String, @ViewBuilder content: @escaping () -> Detail)->some View {
        
        NavigationLink {
            content()
        } label : {
            
            HStack{
                
                Text(title)
                    .font(.system(size: 17, design: .rounded))
                    .fontWeight(.semibold)
                
                Spacer()
                
                Image(systemName: "chevron.right")
            }
            .foregroundColor(.black)
            .padding()
            .background(
                Color("blue").opacity(0.1)
                .cornerRadius(15)
            )
            .padding(.horizontal)
            .padding(.top, 10)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
