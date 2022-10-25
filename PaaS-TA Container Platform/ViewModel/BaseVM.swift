//
//  BaseVM.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/10/09.
//

import SwiftUI

class BaseVM: ObservableObject {
    
    // Detail View Properties...
    @Published var currentService: ServiceData?
    @Published var showDetail = false
    
}
