//
//  PickerAnimation.swift
//  SwiftUI-Troubleshooter
//
//  Created by Pavel Kroupa on 28.11.2024.
//

import SwiftUI

// MARK: - Picker Animation Jump on Value Change
//
//
// Description:
// ---
// When you have Picker with MenuPickerStyle the picker sometimes jumps
// when changing the value. This behavior does not always happen, but
// it's noticeable when it happens. It is possible that this is also
// happening with other picker styles, but I have not tested it.
//
// Workaround:
// ---
// Add an .id modifier to the Picker, passing the currently selected value
//

struct PickerAnimation: View {
    @State private var selectedWithoutID = SimpleEnum.one
    @State private var selectedWithID = SimpleEnum.one

    var body: some View {
        List {
            Section {
                Picker("Picker without id", selection: $selectedWithoutID) {
                    ForEach(SimpleEnum.allCases) { item in
                        Text(item.rawValue)
                            .tag(item)
                    }
                }
                .pickerStyle(.menu)
            }
            Section {
                Picker("Picker with id", selection: $selectedWithID) {
                    ForEach(SimpleEnum.allCases) { item in
                        Text(item.rawValue)
                            .tag(item)
                    }
                }
                .pickerStyle(.menu)
                .id(selectedWithID)
            }
        }
    }
}

private enum SimpleEnum: String, Identifiable, CaseIterable {
    case one = "One"
    case two = "Two"
    case three = "Three"
    case four = "Four"

    var id: String {
        rawValue
    }
}

#Preview {
    PickerAnimation()
}
