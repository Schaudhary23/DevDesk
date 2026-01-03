//
//  DevDeskCommands.swift
//  DevDesk
//
//  Created by Shivam Chaudhary on 03/01/26.
//

import Foundation
import SwiftUI

struct DevDeskCommands: Commands {
    @FocusedObject
    private var viewModel: RepositoryListViewModel?
    
    var body: some Commands {
        CommandGroup(after: .newItem) {
            Button("Refesh") {
                viewModel?.refresh()
            }
            .keyboardShortcut("r", modifiers: [.command])
            
            Button("Clear Data") {
                viewModel?.clearCache()
            }
            .keyboardShortcut(.delete, modifiers: [.command])
            
            Button("Debug Focus") {
                print("Focused VM:", viewModel != nil)
            }
        }
    }
}
