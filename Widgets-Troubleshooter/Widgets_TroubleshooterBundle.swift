//
//  Widgets_TroubleshooterBundle.swift
//  Widgets-Troubleshooter
//
//  Created by Pavel Kroupa on 27.11.2024.
//

import SwiftUI
import WidgetKit

@main
struct Widgets_TroubleshooterBundle: WidgetBundle {
    var body: some Widget {
        WidgetTintRemovedBackgroundBug()
        WidgetTintRemovedBackgroundWorkaround()
    }
}
