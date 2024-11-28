//
//  SheetIgnoresPresentation.swift
//  SwiftUI-Troubleshooter
//
//  Created by Pavel Kroupa on 28.11.2024.
//

import SwiftUI

// MARK: - Sheet ignores presentation when rapidly opening and closing
//
// Feedback Number: FB15718814
//
// Description:
// ---
// When you rapidly open and close a sheet with presentation settings,
// it will eventually break and ignore all presentation configurations.
//
// Steps to Reproduce:
// ---
// 1. Present a sheet with custom presentation settings
// 2. Rapidly open and close the sheet multiple times
// 3. Observe that presentation settings are ignored
//
// Workaround:
// ---
// Use https://github.com/nathantannar4/Transmission as alternative to sheet
//
// Notes:
// ---
// Confirmed by Apple's DTS Engineer in https://developer.apple.com/forums/thread/768207
//

struct SheetIgnoresPresentation: View {
    @State private var showSheet = false

    var body: some View {
        Button("Show Sheet") {
            showSheet = true
        }
        .sheet(isPresented: $showSheet) {
            Text("Rapidly opening and closing the sheet may cause it to ignore the presentation setting.")
                .multilineTextAlignment(.center)
                .presentationDetents([.medium])
                .presentationCornerRadius(30)
        }
    }
}

#Preview {
    SheetIgnoresPresentation()
}
