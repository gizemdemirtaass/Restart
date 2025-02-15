//
//  OnboardingView.swift
//  Restart
//
//  Created by gizem demirtas on 9.08.2024.
//

import SwiftUI

struct OnboardingView: View {
    // MARK: - PROPERTY
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = true
    
    @State private var buttonWidth: Double = UIScreen.main.bounds.width - 80
    @State private var buttonOffset: CGFloat = 0
    @State private var isAnimating : Bool = false
    //@State private var imageOffset : CGSize = CGSize(width: 0, height: 0)
    @State private var imageOffset : CGSize = .zero //Yukarıdaki ile aynı koddur!!
    @State private var indicatorOpacity : Double = 1.0
    @State private var textTitle : String = "Share."
    
    let hapticFeedback = UINotificationFeedbackGenerator()
    // MARK: - BODY
    
    
    var body: some View {
        ZStack {
            Color("ColorBlue")
                .ignoresSafeArea(.all, edges: .all)
            VStack (spacing:20){
                //Text("Onboarding")
                //    .font(.largeTitle)
                //    .fontWeight(.bold)
                
                //Button (action: {
                    //Some action
                //    isOnboardingViewActive = false
                //}){
                //    Text("Start")
                //}
                
                // MARK: HEADER
                Spacer()
                VStack (spacing:0){
                    Text(textTitle)
                        .font(.system(size: 60))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .transition(.opacity) //Bu değiştirici, ekleme sırasında saydamdan opağa ve çıkarma sırasında opaktan saydamlığa animasyonlu bir geçiş sağlamalıdır!!
                        .id(textTitle) //OPAKLIK GEÇİŞİNİ GÖRMEYİNCE ID verdik!
                        
                       
                    Text("""
                It's not how much we give but
                how much love we put into giving.
                """)
                    .font(.title3)
                    .fontWeight(.light)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 10)
                    
                }//: HEADER
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 1 : -40) //konum
                .animation(.easeOut(duration: 1), value: isAnimating)
                
                
                // MARK: CENTER
                ZStack{
                    CircleGroupView(ShapeColor: .white, ShapeOpacity: 0.2)
                        .offset(x:imageOffset.width * -1)
                        .blur(radius: abs(imageOffset.width / 5))
                        .animation(.easeOut(duration: 1), value: imageOffset)
                    
                    Image("character-1")
                        .resizable()
                        .scaledToFit()
                        .opacity(isAnimating ? 1 : 0)
                        .animation(.easeOut(duration: 0.5), value: isAnimating)
                        .offset(x: imageOffset.width*1.2, y: 0) // YENİ KONUM YAZILDI!
                        .rotationEffect(.degrees(Double(imageOffset.width / 20))) //DÖNDÜRME EFEKTİ!!
                    //DRAG GESTURE YAPISI
                        .gesture(  //HAREKET
                        DragGesture() //SÜRÜKLEME HAREKETİ
                            .onChanged {
                                gesture in // SÜRÜKLEME SIRASINDAKİ OLAYLAR
                                if abs(imageOffset.width) <= 150{ //'abs' mutlak değeri döndürür!!
                                    imageOffset = gesture.translation //Başlangıç noktasına göre ne kadar mesafe kat edildiğini belirler
                                    withAnimation(.linear(duration:0.25)) { //OK sembolünü doğrusal animasyon ile sakladık
                                        indicatorOpacity = 0
                                        textTitle = "Give." //Bunu animasyonun içine yazdık.
                                    
                                    }
                                    
                                }
                            }
                            .onEnded { _ in
                                imageOffset = .zero
                                withAnimation(.linear(duration:0.25)){ //OK Sembolünü doğrulsal animasyon ile geri görünür hale getirdik!
                                    indicatorOpacity = 1.0
                                    textTitle = "Share." //Bunu animasyonun içine yazdık.
                                }
                                
                            }
                        ) //: GESTURE
                        .animation(.easeOut(duration: 1), value: imageOffset)
                        
            }//: CENTER
                .overlay(
                Image(systemName: "arrow.left.and.right.circle")
                    .font(.system(size: 44, weight: .ultraLight))
                    .foregroundColor(.white)
                    .offset(y:20)
                    .opacity(indicatorOpacity)
                    .animation(.easeOut(duration: 1).delay(2), value: isAnimating)
                , alignment: .bottom
                
                )
                
                
                
                Spacer()
                
                // MARK: FOOTER
                ZStack{
                    //PARTS OF THE CUSTOM BUTTON
                    // 1. BACKGROUND (STATIC)
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                    
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                        .padding(8)
                    // 2. CALL-TO-ACTION (STATIC)
                    
                    Text("Get Started")
                        .font(.system(.title3, design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .offset(x:20)
                    
                    // 3. CAPSULE (DYNAMIC WIDTH)
                    
                    HStack {
                        Capsule()
                            .fill(Color("ColorRed"))
                            .frame(width: buttonOffset + 80)
                            
                        Spacer()
                        
                    }
                        
                    
                    // 4. CIRCLE (DRAGGABLE)
                    
                    HStack {
                        ZStack{
                            Circle()
                                .fill(Color("ColorRed"))
                            Circle()
                                .fill(.black.opacity(0.15))
                            Image(systemName: "chevron.right.2")
                                .font(.system(size: 24,weight: .bold))
                        }
                    .foregroundColor(.white)
                    .frame(width: 80, height: 80, alignment: .center)
                    .offset(x: buttonOffset)
                    //.onTapGesture {  -> DOKUNMA HAREKETİ
                    //    isOnboardingViewActive = false
                    //}
                    .gesture(
                    DragGesture()
                        .onChanged { gesture in
                            if gesture.translation.width > 0 && buttonOffset <= buttonWidth - 80{
                                buttonOffset = gesture.translation.width
                            }
                        }
                        .onEnded { _ in
                            withAnimation(Animation.easeOut(duration: 0.4)) { //Button Animasyonu
                                if buttonOffset > buttonWidth / 2 {
                                    hapticFeedback.notificationOccurred(.success)
                                    playSound(sound: "chimeup", type: "mp3")
                                    buttonOffset = buttonWidth - 80
                                    isOnboardingViewActive = false
                                 }
                                 else {
                                    buttonOffset = 0
                                     hapticFeedback.notificationOccurred(.warning)
                                }
                                
                             }
                            }
                    
                    ) //:GESTURE
                    
                        Spacer()
                        
                    }//: HSTACK
                    
                    
                    
                    
                }//: FOOTER
                .frame(width: buttonWidth, height: 80, alignment: .center)
                .padding(10)
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 1 : 40)
                .animation(.easeOut(duration: 1), value: isAnimating)
            } //: VSTACK
        } //: ZSTACK
        .onAppear(perform: {
            isAnimating = true
        })
    }
}

#Preview {
    OnboardingView()
}
