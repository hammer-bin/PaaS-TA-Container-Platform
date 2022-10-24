//
//  ContentView.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/09/27.
//

import SwiftUI

struct ContentView: View {
    
    @State var animate = false
    
    @AppStorage("log_Status") var status = false
    var body: some View {
        
        ZStack {
            
            if status {
                MainView()
                    .onAppear(perform: animateSpalsh)
            }
            else {
                LoginPage()
            }
                
            
            
        }
        
        
        
    }
    
    func animateSpalsh() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            
            withAnimation(Animation.easeOut(duration: 5)) {
                animate.toggle()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
