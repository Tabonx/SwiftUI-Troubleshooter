//
//  ContextPreviewBug.swift
//  SwiftUI-Troubleshooter
//
//  Created by Pavel Kroupa on 27.11.2024.
//

import SwiftUI

// MARK: - Context Menu Preview Animation Glitch During Scroll Interaction
//
// Feedback Number: FB15975095
//
// Description:
// ---
// When initiating a context menu with preview by long-pressing a view,
// if the user scrolls to a different position before the context menu
// fully opens, the view being animated remains stuck in its original position
// for approximately one second. During this time, it overlaps with other
// views that are moving with the scroll.
//
// Steps to Reproduce:
// ---
// 1. Long press to initiate context menu with preview
// 2. Before menu fully opens, scroll the view
// 3. Observe preview animation stuck in original position
//
// Notes:
// ---
// - This behavior is also present in native iOS apps like Photos
//
// Workaround:
// ---
// No known workaround available
//

struct ContextPreviewBug: View {
    var body: some View {
        ScrollView(.vertical) {
            ForEach(0 ... 10, id: \.self) { _ in
                let color = Color(
                    red: .random(in: 0 ... 1),
                    green: .random(in: 0 ... 1),
                    blue: .random(in: 0 ... 1)
                )
                Rectangle()
                    .fill(color)
                    .frame(height: 100)
                    .padding(.horizontal)
                    .contextMenu {
                        Button {} label: {
                            Label("View Details", systemImage: "info.circle")
                        }
                    } preview: {}
            }
        }
    }
}

#Preview {
    ContextPreviewBug()
}
