//
//  Setup.swift
//  GoGoGitHub
//
//  Created by Rick  on 6/28/16.
//  Copyright © 2016 Rick . All rights reserved.
//

import Foundation


protocol Setup {
    static var id: String { get }
    
    func setup()
    func setupAppearance()
}

extension Setup {
    static var id: String {
        return String(self)
    }
}