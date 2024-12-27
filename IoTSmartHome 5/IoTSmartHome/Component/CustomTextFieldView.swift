//
//  CustomButtonView.swift
//  IoTSmartHome
//
//  Created by ÖMER  on 4.12.2024.
//

import SwiftUI

struct CustomTextFieldView: View {
    
    @Binding private var text: String
    private var title: String
    
    
    init(_ title: String, text: Binding<String>) {
        self.title = title
        self._text = text
        
    }
    
    var body: some View {
        TextField(title,text: $text)
            .padding()
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(.black,lineWidth: 1)
            )
            .frame(width: 260)
        
    }
}

#Preview {
    CustomTextFieldView("City", text: .constant(""))
}
