//
//  WidgetTintRemovedBackgroundBug.swift
//  SwiftUI-Troubleshooter
//
//  Created by Pavel Kroupa on 27.11.2024.
//

import SwiftUI
import WidgetKit

// MARK: - containerBackgroundRemovable(false) breaks tinting for the whole widget
//
// Feedback Number: FB15835453
//
// Description:
// ---
// When using .containerBackgroundRemovable(false) on a widget
// containing a background image, the tinting system malfunctions.
// The background image remains permanently tinted and ignores
// widgetAccentedRenderingMode configurations. Text elements within
// the widget also retain tinting even when explicitly disabled
// using .widgetAccentable(false).
//
// Steps to Reproduce:
// ---
// 1. Add both widgets to the homescreen
// 2. Apply tinting to the widgets
//
// Workaround:
// ---
// Use ZStack with widget margins as padding. You can pass the Widget
// display size through the entry. Note: You still need to use the
// containerBackground API.
//

struct WidgetTintRemovedBackgroundBug: Widget {
    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: "com.tabonx.containerBackgroundRemovableBug",
            provider: Provider()
        ) { entry in
            SimpleWidgetView(simpleEntry: entry)
                .containerBackground(for: .widget) {
                    Image(.background)
                        .resizable()
                        // Indicates that it should be black and white
                        .widgetAccentedRenderingMode(.desaturated)
                        .scaledToFill()
                }
        }
        .supportedFamilies([.systemSmall])
        .configurationDisplayName("containerBackgroundRemovable Bug")
        .containerBackgroundRemovable(false)
    }
}

private struct SimpleWidgetView: View {
    let simpleEntry: SimpleEntry
    var body: some View {
        Text(simpleEntry.date, format: .dateTime)
    }
}

#Preview(as: .systemSmall) {
    WidgetTintRemovedBackgroundBug()
} timeline: {
    SimpleEntry(date: .now, emoji: "😀", widgetSize: .init(width: 170, height: 170))
}

// MARK: - Workaround Implementation

struct WidgetTintRemovedBackgroundWorkaround: Widget {
    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: "com.tabonx.containerBackgroundRemovableWorkaround",
            provider: Provider()
        ) { entry in
            SimpleWidgetWorkaroundView(simpleEntry: entry)
        }
        .contentMarginsDisabled()
        .supportedFamilies([.systemSmall])
        .configurationDisplayName("containerBackgroundRemovable Workaround")
    }
}

private struct SimpleWidgetWorkaroundView: View {
    @Environment(\.widgetContentMargins) var margins
    let simpleEntry: SimpleEntry
    var body: some View {
        ZStack {
            Image(.background)
                .resizable()
                // Indicates that it should be black and white
                .widgetAccentedRenderingMode(.desaturated)
                .scaledToFill()
                .frame(width: simpleEntry.widgetSize.width, height: simpleEntry.widgetSize.height)

            Text(simpleEntry.date, format: .dateTime)
                .padding(margins)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .containerBackground(for: .widget) {
            Rectangle()
                .foregroundStyle(.fill.tertiary)
        }
    }
}

#Preview(as: .systemSmall) {
    WidgetTintRemovedBackgroundWorkaround()
} timeline: {
    SimpleEntry(date: .now, emoji: "😀", widgetSize: .init(width: 170, height: 170))
}
