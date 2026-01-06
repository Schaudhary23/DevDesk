//
//  WindowAccessor.swift
//  DevDesk
//
//  Created by Shivam Chaudhary on 04/01/26.
//

import SwiftUI
import AppKit

struct WindowAccessor: NSViewRepresentable {

    let onWindowAvailable: (NSWindow) -> Void

    func makeNSView(context: Context) -> NSView {
        let view = NSView()
        DispatchQueue.main.async {
            if let window = view.window {
                onWindowAvailable(window)
            }
        }
        return view
    }

    func updateNSView(_ nsView: NSView, context: Context) {
        DispatchQueue.main.async {
            if let window = nsView.window {
                onWindowAvailable(window)
            }
        }
    }
}
