//
//  HomeView.swift
//  Restart
//
//  Created by gizem demirtas on 9.08.2024.
//

import SwiftUI

struct HomeView: View {
    // MARK: - PROPERTIES
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = false
    @State private var isAnimating : Bool = false
    
    // MARK: - BODY
    
    var body: some View {
        VStack (spacing: 20){
            //Text("Home")
            //    .font(.largeTitle)
            //.fontWeight(.bold)
            
            // MARK: - HEADER
            Spacer()
            ZStack {
                CircleGroupView(ShapeColor: .gray, ShapeOpacity: 0.1)
                Image("character-2")
                    .resizable()
                    .scaledToFit()
                .padding()
                .offset(y: isAnimating ? 35 : -35)//ANİMASYON BAŞLANGICI
                .animation(
                    Animation
                        .easeInOut(duration: 4)
                        .repeatForever(),
                    value: isAnimating
                )   // ANİMASYON BİTİŞİ
                
            }
            
            
            
            // MARK: - CENTER
            Text("The time that leads to mastery is dependent on the intensity of our focus.")
                .font(.title3)
                .fontWeight(.light)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding()
           
            
            // MARK: - FOOTER
            
            Spacer()
            
            
                Button (action:{
                    //Some action
                    withAnimation(Animation.easeOut(duration: 0.4)){
                        playSound(sound: "success", type: "m4a")
                        isOnboardingViewActive = true//Button Animasyonu
                    }
                    
                    
                   
                }) {
                    Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                        .imageScale(.large)
                    
                    Text("Restart")
                        .font(.system(.title3, design: .rounded))
                    //.font(.system(size: 55, design: .rounded))
                        .fontWeight(.bold)
                
            }
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.capsule)
                .controlSize(.large)
            
            
            
        } //: VSTACK
        .onAppear(perform: {  // ANİMASYONUN 3 SANİYE GECİKMESİNİ SAĞLAR
            DispatchQueue.main.asyncAfter(deadline: .now() + 3,
            execute:{
                isAnimating = true
            })
        })
        
    }
}

#Preview {
    HomeView()
}
