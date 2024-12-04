//
//  ScrollViewTextJitter.swift
//  SwiftUI-Troubleshooter
//
//  Created by Pavel Kroupa on 30.11.2024.
//

import SwiftUI

// MARK: - ScrollView Section causes performance degradation and jittering
//
// Feedback Number: FB16039045
//
// Description:
// ---
// When implementing a ScrollView with multiple Section views within LazyVStack,
// severe performance degradation and visual jittering occurs, particularly near
// the end of the scroll content. The issue becomes noticeable with as few as
// 200 items and becomes more severe with larger datasets.
//
// Notes:
// ---
// - Problem is related to the number of section headers being managed
// - Performance impact increases as user scrolls toward the bottom
//
// Workaround:
// ---
// - Reduce the number of sections
// - Use plain LazyVStack without sections
//

struct ScrollViewTextJitter: View {
    let array = Array(1 ... 30000)

    var body: some View {
        ScrollView {
            LazyVStack(pinnedViews: [.sectionHeaders]) {
                ForEach(array, id: \.self) { index in
                    Section {
                        Text("Scroll view test \(index)")
                            .frame(height: 100, alignment: .center)
                            .padding(.horizontal)
                    } header: {
                        Text("Header")
                    }
                }
            }
        }
    }
}

#Preview {
    ScrollViewTextJitter()
}
