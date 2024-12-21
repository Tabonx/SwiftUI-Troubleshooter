//
//  ListItemContextMenu.swift
//  SwiftUI-Troubleshooter
//
//  Created by Pavel Kroupa on 19.12.2024.
//

import SwiftUI

// MARK: - List will open context menu on whole cell when multiple in a single row
//
// Feedback Number: N/A
//
// Description:
// ---
// When you try to add multiple context menus to List in single row it will open
// context menu on whole cell instead regardless on what item you try to press.
//
// Notes:
// ---
// - Affects all items in the row regardless of tap location
//
// Workaround:
// ---
// - Use a `Menu` component instead with primary action
// - See example implementation below
//

struct ListItemContextMenu: View {
    var body: some View {
        List {
            Section {
                HStack {
                    ForEach(0 ... 10, id: \.self) { index in
                        Text("\(index)")
                            .contextMenu {
                                Button("\(index)") {}
                            }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } header: {
                Text("Unexpected behavior")
            }

            Section {
                HStack {
                    ForEach(0 ... 10, id: \.self) { index in
                        Menu {
                            Button("\(index)") {}
                        } label: {
                            Text("\(index)")
                        } primaryAction: {
                            print("\(index)")
                        }
                        // If you want it to behave like Text
                        .buttonStyle(.plain)
                        .accessibilityRemoveTraits(.isButton)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } header: {
                Text("Workaround")
            }
        }
    }
}
