//
//  LoadingScreen.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/11/06.
//

import SwiftUI

struct LoadingScreen: View {
    var body: some View {
        
        ZStack {
            Color.black.opacity(0.2).ignoresSafeArea(.all, edges: .all)
            
            ProgressView()
                .padding(20)
                .background(Color.white)
                .cornerRadius(10)
        }
    }
}

struct LoadingScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoadingScreen()
    }
}
