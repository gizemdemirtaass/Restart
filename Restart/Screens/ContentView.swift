//
//  ContentView.swift
//  Restart
//
//  Created by gizem demirtas on 9.08.2024.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = true
//property wrapper  - User Key   //Property Name               - Value
    var body: some View {
       
        ZStack{
            if isOnboardingViewActive {
                OnboardingView()
            }else{
                HomeView()
            }
        }
    }
}

#Preview {
    ContentView()
}
