//
//  MaterialOverlayLag.swift
//  SwiftUI-Troubleshooter
//
//  Created by Pavel Kroupa on 28.11.2024.
//

import SwiftUI

// MARK: - Material causes performance lag
//
// Feedback Number: FB14685359
//
// Description:
// ---
// When you add a lot of material to a screen it will cause a lag. This is
// especially noticeable on ProMotion display where it can lag even with
// few on screen. I do not know if this is a SwiftUI issue or the Material
// is so heavy to compute that it will lag.
//
// Notes:
// ---
// - Drawing Group does not solve this issue
//
// Workaround:
// ---
// Do not use large number of material in views or use color if possible.
//

struct MaterialOverlayLag: View {
    @State var useMaterial = true
    @State var width: CGFloat = 100
    var body: some View {
        VStack {
            ScrollView(.vertical) {
                ForEach(0 ... 100, id: \.self) { _ in
                    HorizontalStack(useMaterial: useMaterial, width: width)
                }
            }

            Slider(value: $width, in: 20 ... 200)
        }

        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    useMaterial.toggle()
                } label: {
                    Text(useMaterial ? "Material" : "Gray color")
                }
            }
        }
    }
}

private struct HorizontalStack: View {
    var useMaterial: Bool = true
    var width: CGFloat = 100

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            ScrollView(.horizontal) {
                LazyHStack(spacing: 8.0) {
                    ForEach(images, id: \.self) { image in
                        AsyncImage(url: URL(string: image)) { image in
                            image.resizable()
                        } placeholder: {
                            Rectangle()
                                .fill(Color(.systemGray5))
                        }
                        .clipShape(.rect(cornerRadius: 8))
                        .overlay {
                            if useMaterial {
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(.ultraThinMaterial, lineWidth: 1)
                            } else {
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(.gray.opacity(0.2), lineWidth: 1)
                            }
                        }
                        .frame(width: width, height: width * 1.5)
                    }
                }
            }
        }
    }
}

private let images = [
    "https://image.tmdb.org/t/p/w780/vG7cmUDBvNQDa2pX3yRQSxmprab.jpg",
    "https://image.tmdb.org/t/p/w780/7QMsOTMUswlwxJP0rTTZfmz2tX2.jpg",
    "https://image.tmdb.org/t/p/w780/5X0SWyNJ5IjN9YSXlbHBOVMzh1G.jpg",
    "https://image.tmdb.org/t/p/w780/eONkvEahSQJan1HTzWJKjvaMe29.jpg",
    "https://image.tmdb.org/t/p/w780/95RVeMWMvk97PBW0msryIJC32XD.jpg",
    "https://image.tmdb.org/t/p/w780/ugYAGyxwajuplDUUYT8Bzbj8eNR.jpg",
    "https://image.tmdb.org/t/p/w780/dqZENchTd7lp5zht7BdlqM7RBhD.jpg",
    "https://image.tmdb.org/t/p/w780/fqldf2t8ztc9aiwn3k6mlX3tvRT.jpg",
    "https://image.tmdb.org/t/p/w780/ztkUQFLlC19CCMYHW9o1zWhJRNq.jpg",
    "https://image.tmdb.org/t/p/w780/rXojaQcxVUubPLSrFV8PD4xdjrs.jpg",
    "https://image.tmdb.org/t/p/w780/imuZQcnPNKNygPw28TESUq4tNsb.jpg",
    "https://image.tmdb.org/t/p/w780/2zmTngn1tYC1AvfnrFLhxeD82hz.jpg",
    "https://image.tmdb.org/t/p/w780/sgv6nwj1TlDDKqxbcUEuds8fqoz.jpg",
    "https://image.tmdb.org/t/p/w780/vEy7B1qw7XuML07tjG9kATMcVm2.jpg",
    "https://image.tmdb.org/t/p/w780/sDbpr5VoxlcQvzvWFECr7bXCAwg.jpg",
    "https://image.tmdb.org/t/p/w780/eCOoBMVFm5UgoKAZ35HdOC9cCwt.jpg",
    "https://image.tmdb.org/t/p/w780/unsnrlDQJVMT9FeR2auFcwpHLNY.jpg",
    "https://image.tmdb.org/t/p/w780/jrwVDaWgoScCFn8KMQM83kDyJyX.jpg",
    "https://image.tmdb.org/t/p/w780/ocpB3Z5vufQK4kv6uzJWs3KnzET.jpg",
    "https://image.tmdb.org/t/p/w780/mlMDbD8Nit9uS4OekWgLhkzWKDm.jpg",
    "https://image.tmdb.org/t/p/w780/enudCEaTaxn6mET58gnaUjCLncQ.jpg",
    "https://image.tmdb.org/t/p/w780/5a0z6F4npH4hiqDBKMoWcDk3CBT.jpg",
    "https://image.tmdb.org/t/p/w780/yeCS1uVGVIo7tF8dTGouNkqDV8V.jpg",
    "https://image.tmdb.org/t/p/w780/7hE6LffWtMccJjXxc20Xnh1JbRG.jpg",
    "https://image.tmdb.org/t/p/w780/xHNtl7bhElOMrtksYnC0z5GRnSO.jpg",
    "https://image.tmdb.org/t/p/w780/sUirfTzQklsUweibdqhRtJP71KM.jpg",
    "https://image.tmdb.org/t/p/w780/dxj8Y2PYnCr4mMv2hNRSDT4ESM9.jpg",
    "https://image.tmdb.org/t/p/w780/wS6xiUtot9Bktx5yWovxUXAadVK.jpg",
    "https://image.tmdb.org/t/p/w780/8xVQqNkEEgGOODkYIW9psU3SxzC.jpg",
    "https://image.tmdb.org/t/p/w780/e3NBGiAifW9Xt8xD5tpARskjccO.jpg",
]

#Preview {
    MaterialOverlayLag()
}
