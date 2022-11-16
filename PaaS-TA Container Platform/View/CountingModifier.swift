//
//  CountingModifier.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/11/15.
//

import SwiftUI

struct CountingModifier: AnimatableModifier {
    
    var number : CGFloat = 0
    
    var animatableData: CGFloat {
        get { number }
        set { number = newValue }
    }
    
    func body(content: Content) -> some View {
        content.overlay(NumberLabelView(number: number))
    }
    
    // 숫자 라벨 뷰
    struct NumberLabelView : View {
        let number : CGFloat
        
        var body: some View {
            Text("\(String(format:"%.2f", number))%")
                .font(.largeTitle)
                .fontWeight(.black)
                .foregroundColor(.white)
        }
    }
}
