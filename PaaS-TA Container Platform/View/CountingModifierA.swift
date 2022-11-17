//
//  CountingModifierA.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/11/18.
//

import SwiftUI

struct CountingModifierA: AnimatableModifier {
    
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
            Text("\(String(format:"%.0f", number))")
                .font(.system(size: 18)).bold()
                .fontWeight(.black)
                .foregroundColor(Color("blue"))
        }
    }
}
