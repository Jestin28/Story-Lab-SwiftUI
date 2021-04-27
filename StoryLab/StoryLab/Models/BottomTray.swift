//
//  BottomTray.swift
//  Biography
//
//  Created by jestin antony on 06/10/20.
//

import SwiftUI

struct BottomTray: View {
    let selectedperson: Person?
    var isScrollDisabled = true
    
    var body: some View {
        ZStack{
            if self.selectedperson != nil {
                VStack{
                    Rectangle().fill(Color.gray.opacity(0.4))
                        .frame(width:40, height:4)
                        .cornerRadius(4)
                    
                    Text(self.selectedperson?.name ?? "")
                        .font(.system(size: 30,weight:.semibold))
                        .padding(.vertical)
                    
                    Divider()
                    
                    ScrollView(.vertical,showsIndicators: false){
                        Text(self.selectedperson?.description ?? "")
                            .padding()
                            
                        
                       
                    }
                    .disabled(self.isScrollDisabled)
                }
                
            }
        }
      //  .background(BlurView(style: .systemThinMaterial))
        .foregroundColor(.black)
        .edgesIgnoringSafeArea(.all)
    }
}

struct BottomTray_Previews: PreviewProvider {
    static var previews: some View {
        BottomTray(selectedperson: Person.stubbed[0],isScrollDisabled: false)
    }
}




