//
//  Poster.swift
//  ResidenceManager
//
//  Created by Ginpei on 2017-07-13.
//  Copyright © 2017 Ginpei. All rights reserved.
//

import Foundation


class Poster {
    var title = ""
    
    init(title: String) {
        self.title = title
    }
}

enum PosterResult {
    case success([Poster])
    case failure(Error?)
}

class PosterStore {
    func fetchAll(completionHandler: @escaping (PosterResult) -> Void) {
        // dummy
        
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { timer in
            let result = PosterResult.success([
                Poster(title: "Ski items wanted"),
                Poster(title: "Yoshi's B-Day Party"),
                Poster(title: "I might lose both room and house key. Did anybody see it?"),
                ])
            completionHandler(result)
        }
    }
}
