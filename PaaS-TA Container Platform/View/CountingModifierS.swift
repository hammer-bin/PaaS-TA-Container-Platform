//
//  CountingModifierS.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/11/17.
//

import SwiftUI

struct CountingModifierS: AnimatableModifier {
    
    var number : CGFloat = 0
    var unit : String = ""
    var format: String = ""
    
    var animatableData: CGFloat {
        get { number }
        set { number = newValue }
    }
    
    func body(content: Content) -> some View {
        content.overlay(NumberLabelView(number: number, unit: unit, format: format))
    }
    
    // 숫자 라벨 뷰
    struct NumberLabelView : View {
        let number : CGFloat
        let unit : String
        let format: String
        //"%.1f"
        var body: some View {
            Text("\(String(format:format, number))\(unit)")
                .font(.system(size: 22)).bold()
                .fontWeight(.black)
                .foregroundColor(Color("blue"))
        }
    }
}
