//
//  Repository.swift
//  DevDesk
//
//  Created by Shivam Chaudhary on 03/01/26.
//

import Foundation

struct Repository: Identifiable, Hashable {
    let id: Int
    let name: String
    let description: String?
    let language: String?
    let stars: Int
}

