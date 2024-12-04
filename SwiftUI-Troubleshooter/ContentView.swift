//
//  ContentView.swift
//  SwiftUI-Troubleshooter
//
//  Created by Pavel Kroupa on 27.11.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List {
                NavigationLink { ContextPreviewBug() } label: { Text("Context Preview Bug") }
                NavigationLink { TabViewScrollPositionBug() } label: { Text("TabView Position Bug") }
                NavigationLink { PickerAnimation() } label: { Text("Picker animation glitch") }
                NavigationLink { SheetIgnoresPresentation() } label: { Text("Sheet Ignores Presentation") }
                NavigationLink { MaterialOverlayLag() } label: { Text("Material Overlay Lag") }
                NavigationLink { ContextPreviewSizeBug() } label: { Text("Context Preview Size Bug") }
                NavigationLink { ScrollViewTextJitter() } label: { Text("Scroll text jitter") }
            }
        }
    }
}

#Preview {
    ContentView()
}
