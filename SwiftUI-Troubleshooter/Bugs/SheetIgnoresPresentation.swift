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
// - Use https://github.com/nathantannar4/Transmission as alternative to sheet.
// - Add delay
//
// Notes:
// ---
// - Confirmed by Apple's DTS Engineer in https://developer.apple.com/forums/thread/768207
// - In my testing, it usually breaks when I use swipe to dismiss.
//

struct SheetIgnoresPresentation: View {
    @State private var showSheetOne = false
    @State private var showSheetTwo = false
    @State private var enableInfinityMode = false

    @State private var infinityModeDelay = 0.5

    var body: some View {
        VStack(spacing: 20) {
            Text("Sheet Presentation Bug Demo")
                .font(.headline)
                .padding(.top, 40)

            Button(action: { showSheetOne = true }) {
                Text("Open Sheet One")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue.opacity(0.2))
                    .cornerRadius(8)
            }

            Button(action: { showSheetTwo = true }) {
                Text("Open Sheet with interactive dismiss disabled  ")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green.opacity(0.2))
                    .cornerRadius(8)
            }

            DelaySlider(delay: $infinityModeDelay)
        }
        .padding()
        .frame(maxHeight: .infinity, alignment: .top)
        .sheet(isPresented: $showSheetOne) {
            SheetContent(
                title: "Sheet One",
                description: "Rapidly opening and closing may break presentation settings.",
                isInfinityMode: $enableInfinityMode,
                infinityModeDelay: $infinityModeDelay,
                dismissAction: { showSheetOne = false
                }
            )
            .presentationDetents([.medium, .large])
            .presentationCornerRadius(20)
        }
        .sheet(isPresented: $showSheetTwo) {
            SheetContent(
                title: "Sheet Two",
                description: "This sheet has interactiveDismissDisabled.",
                isInfinityMode: $enableInfinityMode,
                infinityModeDelay: $infinityModeDelay,
                dismissAction: { showSheetTwo = false
                }
            )
            .presentationDetents([.medium, .large])
            .presentationCornerRadius(20)
            .interactiveDismissDisabled()
            .presentationBackground(.ultraThinMaterial)
        }
        .onChange(of: showSheetOne) { _, isPresented in
            handleInfinityMode(isPresented: isPresented, toggle: { showSheetOne = true })
        }
        .onChange(of: showSheetTwo) { _, isPresented in
            handleInfinityMode(isPresented: isPresented, toggle: { showSheetTwo = true })
        }
    }

    private func handleInfinityMode(isPresented: Bool, toggle: @escaping () -> Void) {
        if !isPresented && enableInfinityMode {
            Task {
                try? await Task.sleep(for: .seconds(infinityModeDelay))
                toggle()
            }
        }
    }
}

private struct DelaySlider: View {
    @Binding var delay: Double

    var body: some View {
        VStack {
            Text("Delay: \(String(format: "%.2f", delay)) seconds")
                .font(.footnote)
                .foregroundColor(.gray)
            HStack {
                Button(action: {
                    delay = max(delay - 0.01, 0)
                }) {
                    Image(systemName: "minus.circle")
                        .font(.title2)
                        .foregroundColor(.blue)
                }
                .buttonStyle(.borderless)

                Slider(value: $delay, in: 0 ... 3) {
                    Text("Infinity mode delay")
                }

                Button(action: {
                    delay = min(delay + 0.01, 3)
                }) {
                    Image(systemName: "plus.circle")
                        .font(.title2)
                        .foregroundColor(.blue)
                }
                .buttonStyle(.borderless)
            }
        }
    }
}

private struct SheetContent: View {
    let title: String
    let description: String
    @Binding var isInfinityMode: Bool
    @Binding var infinityModeDelay: Double
    let dismissAction: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            Text(title)
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top)

            Text(description)
                .multilineTextAlignment(.center)
                .padding()

            Toggle("Enable Infinity Mode", isOn: $isInfinityMode)
                .padding()

            DelaySlider(delay: $infinityModeDelay)

            Button(action: dismissAction) {
                Text("Close")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .cornerRadius(8)
            }
            .padding(.bottom)
        }
        .padding()
    }
}

#Preview {
    SheetIgnoresPresentation()
}
