//
//  ContextPreviewSizeBug.swift
//  SwiftUI-Troubleshooter
//
//  Created by Pavel Kroupa on 27.11.2024.
//

import SwiftUI

// MARK: - Context Menu Preview Animation Glitch without width and height
//
// Description:
// ---
// When you add context menu with preview and the view does not have
// specific height, the opening animation of the context menu will jump
// and not perform the smooth opening animation when opened for the
// first time.
//
// Workaround:
// ---
// Add a width and height to the view. It even works with height that is
// larger than screen size.
//

struct ContextPreviewSizeBug: View {
    let image = "https://image.tmdb.org/t/p/w780/ztkUQFLlC19CCMYHW9o1zWhJRNq.jpg"
    var body: some View {
        VStack {
            let image = AsyncImage(url: URL(string: image)) { image in
                image.resizable()
                    .scaledToFit()
            } placeholder: {
                Rectangle()
                    .fill(Color(.systemGray5))
                    .aspectRatio(2 / 3, contentMode: .fit)
                    .containerRelativeFrame(.horizontal, count: 3, span: 1, spacing: 0, alignment: .center)
            }
            .clipShape(.rect(cornerRadius: 8))
            VStack {
                Text("Image without width and height")
                    .font(.headline)

                image
                    .containerRelativeFrame(.horizontal, count: 3, span: 1, spacing: 0, alignment: .center)
                    .contextMenu {
                        Button {} label: {
                            Text("placeholder")
                        }
                    } preview: {
                        image
                    }
            }

            Divider()

            VStack {
                Text("Image with width and height set in preview")
                    .font(.headline)
                image
                    .containerRelativeFrame(.horizontal, count: 3, span: 1, spacing: 0, alignment: .center)
                    .contextMenu {
                        Button {} label: {
                            Text("placeholder")
                        }
                    } preview: {
                        image
                            .frame(width: 500, height: 750)
                    }
            }
        }
    }
}

#Preview {
    ContextPreviewSizeBug()
}
