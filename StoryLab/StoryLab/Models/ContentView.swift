//
//  ContentView.swift
//  Biography
//
//  Created by jestin antony on 06/10/20.
//

import SwiftUI

let screen = UIScreen.main

struct ContentView: View {
    let people = Person.stubbed
    @State var selectedPerson: Person?
    @State var bottomDragState: CGSize = .zero
    @State var showFull = false
 
    let heightBanner = screen.bounds.height * 0.65
    
    var body: some View {

        GeometryReader { geo in
            ZStack {
       
                Ellipse().fill(Color(#colorLiteral(red: 0, green: 0.7110984921, blue: 0.7248441577, alpha: 1)))
                    .rotationEffect(Angle(degrees: 90))
                    .offset(y: -screen.bounds.width * 0.7 )
                    .edgesIgnoringSafeArea(.top)
                    .opacity(self.selectedPerson == nil ? 1 : 0)
                
                VStack(alignment: .leading, spacing: 24){
                    VStack(spacing: 20){
                        Text("Story Lab")
                            .font(.system(size: 36, weight: .bold))
                            
                        
                        Text("A selection of children's favorite short stories.Pick one and dive in.")
                            .font(.system(size: 17))
                    }
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .padding(.top)
                    
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack(spacing:10){
                            ForEach(self.people){ item in
                                GeometryReader{ geo in
                                    CardView(person: item)
                                        .rotation3DEffect(
                                            .degrees(Double(geo.frame(in: .global).minX) - 20 ) / -20, axis: (x: 0 , y: 1, z: 0) )
                                        .onTapGesture {
                                            withAnimation(Animation.spring()){
                                                self.selectedPerson = item
                                            }
                                    }
                                }
                                .frame(width: screen.bounds.width * 0.75, height: screen.bounds.height * 0.65)
                            }
                        }
                        .padding(.horizontal,32)
                        .padding(.vertical)
                    }
                }
                
                .blur(radius: self.selectedPerson == nil ? 0 : 50)
        
                ZStack{
                    Rectangle().fill(Color.clear)
                    if self.selectedPerson?.imageName != nil {
                        Image(self.selectedPerson!.imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            
                    }
                }
                .frame(width:screen.bounds.width)
                .frame(height:self.selectedPerson == nil ? nil : self.heightBanner)
                .offset(y: self.selectedPerson == nil ? -screen.bounds.height : (self.heightBanner / 2) - screen.bounds.height / 2)
                .opacity(self.selectedPerson == nil ? 0.5 : 1)
                .blur(radius: self.bottomDragState.height > 0 ? min(self.bottomDragState.height , 50) : 0)
                .animation(.easeInOut)
                
                BottomTray(selectedperson:  self.selectedPerson, isScrollDisabled: !self.showFull)
                    .frame(maxWidth: .infinity)
                    .frame(height:screen.bounds.height * 0.9)
                    .padding(.top)
                    .padding(.bottom,32)
                    .background(BlurView(style: .systemThinMaterial))
                    .cornerRadius(30)
                    .shadow(radius: 24)
                    .offset(y:self.selectedPerson == nil ? screen.bounds.height : screen.bounds.height * 0.6)
                    .offset(y:self.bottomDragState.height)
                    .gesture(DragGesture().onChanged({ (value) in
                        self.bottomDragState = value.translation
                        
                        if self.showFull {
                            self.bottomDragState.height += -300
                        }
                        
                        if self.bottomDragState.height < -450 {
                            self.bottomDragState.height = -300
                        }
                        
                    }).onEnded({ (value) in
                        withAnimation(Animation.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0)) {
                            if self.bottomDragState.height > 100 {
                                self.selectedPerson = nil
                                self.bottomDragState = .zero
                            }
                            
                            if self.bottomDragState.height < -200 || self.bottomDragState.height < -100 {
                                self.bottomDragState.height = -300
                                self.showFull = true
                            } else {
                                self.bottomDragState = .zero
                                self.showFull = false
                            }
                        }
                    }))
             }
          }
            .background(Color(#colorLiteral(red: 0.8623074889, green: 0.8571819663, blue: 0.8662477136, alpha: 1)))
            .frame( maxWidth: .infinity, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.top)
            .edgesIgnoringSafeArea(.bottom)
            
}
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


class HostingController: UIHostingController<ContentView> {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}


