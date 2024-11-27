//
//  TabViewScrollPositionBug.swift
//  SwiftUI-Troubleshooter
//
//  Created by Pavel Kroupa on 27.11.2024.
//

import SwiftUI

// MARK: - TabView ScrollPosition ID Not Updated on Tab Selection
//
// Feedback Number: FB15964820
//
// Description:
// ---
// When using SwiftUI TabView with ScrollView at root level and scrollPosition(id:anchor:),
// tapping on a Tab item causes the ScrollView to scroll to the top, but the scroll
// position ID binding does not get updated to reflect this change. This makes it
// impossible to track the actual scroll position when users interact with Tab items.
//
// Steps to Reproduce:
// ---
// 1. Create a TabView with ScrollView using scrollPosition modifier
// 2. Scroll to any position in the list
// 3. Tap on the currently selected Tab item
// 4. Observe that while the view scrolls to top, the positionID remains unchanged
//
// Workaround:
// ---
// No known workaround available
//

struct TabViewScrollPositionBug: View {
    @State var positionID: Int?
    var body: some View {
        TabView {
            VStack {
                ScrollView(.vertical) {
                    LazyVStack(pinnedViews: [.sectionHeaders]) {
                        ForEach(0 ... 100, id: \.self) { index in
                            Text("\(index)")
                        }
                    }
                    .scrollTargetLayout()
                }

                .scrollPosition(id: $positionID, anchor: .top)

                // Breaks when you scroll to 10 and then press the TabItem. If you don't move/update the scroll position, it won't scroll back to 10
                Button {
                    positionID = 10
                } label: {
                    Text("Scroll to 10")
                }
            }
            .onChange(of: positionID) { _, newValue in
                print(newValue)
            }
            .tabItem { Label("Click Me", systemImage: "house") }
        }
    }
}

// MARK: - iOS 18 ScrollPosition API

@available(iOS 18.0, *)
struct TabViewScrollPositionBug18 {
    @State var position = ScrollPosition()
    var body: some View {
        TabView {
            Tab("Click Me", systemImage: "house") {
                VStack {
                    ScrollView(.vertical) {
                        LazyVStack(pinnedViews: [.sectionHeaders]) {
                            ForEach(0 ... 100, id: \.self) { index in
                                Text("\(index)")
                            }
                        }
                        .scrollTargetLayout()
                    }
                    .scrollPosition($position, anchor: .top)
                    .onChange(of: position) { _, newValue in
                        print(newValue)
                    }

                    // Breaks when you scroll to 10 and then press the TabItem. If you don't move/update the scroll position, it won't scroll back to 10
                    Button {
                        position.scrollTo(id: 10, anchor: .top)

                    } label: {
                        Text("Scroll to 10")
                    }
                }
            }
        }
    }
}

#Preview {
    TabViewScrollPositionBug()
}
