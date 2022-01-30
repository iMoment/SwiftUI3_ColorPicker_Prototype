//
//  HomeView.swift
//  ColorPicker
//
//  Created by Stanley Pan on 2022/01/30.
//

import SwiftUI

struct HomeView: View {
    // MARK: Image Color Picker Values
    @State var showPicker: Bool = false
    @State var selectedColor: Color = Color.white
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(selectedColor)
                .ignoresSafeArea()
            
            // MARK: Picker Button
            Button {
                showPicker.toggle()
            } label:  {
                Text("Show Image Color Picker ")
                    .foregroundColor(selectedColor.isDarkColor ? .white : .black)
            }
        }
        // MARK: Calling Modifier
        .imageColorPicker(showPicker: $showPicker, color: $selectedColor)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
