//
//  CustomColorPicker.swift
//  ColorPicker
//
//  Created by Stanley Pan on 2022/01/30.
//

import SwiftUI

// MARK: Extension to call Image Color Picker
extension View {
    func imageColorPicker(showPicker: Binding<Bool>, color: Binding<Color>) -> some View {
        return self
        // Full Sheet
            .fullScreenCover(isPresented: showPicker) {
                
            } content: {
                ColorPickerHelperView(showPicker: showPicker, color: color)
            }
    }
}

// MARK: Custom View for Color Picker
struct ColorPickerHelperView: View {
    @Binding var showPicker: Bool
    @Binding var color: Color
    
    var body: some View {
        NavigationView {
            
            VStack(spacing: 10) {
                // Only need live picker button, hack by setting height to clip content
                CustomColorPicker(color: $color)
                    .frame(width: 100, height: 50, alignment: .topLeading)
                    .clipped()
                    .offset(x: 20)
            }
            .navigationTitle("Image Color Picker")
            .navigationBarTitleDisplayMode(.inline)
            // MARK: Close Button
            .toolbar {
                Button("Close") {
                    showPicker.toggle()
                }
            }
        }
    }
}

// MARK: Custom Color Picker with help from UIColorPicker
struct CustomColorPicker: UIViewControllerRepresentable {
    // MARK: Picker Values
    @Binding var color: Color
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> UIColorPickerViewController {
        let picker = UIColorPickerViewController()
        picker.supportsAlpha = false
        picker.selectedColor = UIColor(color)
        
        // Connecting Delegate
        picker.delegate = context.coordinator
        picker.title = ""
        
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIColorPickerViewController, context: Context) {
        
    }
    
    // MARK: Delegate Methods
    class Coordinator: NSObject, UIColorPickerViewControllerDelegate {
        var parent: CustomColorPicker
        
        init(parent: CustomColorPicker) {
            self.parent = parent
        }
        
        func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
            // Updating Color
            parent.color = Color(viewController.selectedColor)
        }
        
        func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
            parent.color = Color(color)
        }
    }
}
