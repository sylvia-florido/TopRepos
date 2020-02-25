//
//  Date.swift
//  TopRepos
//
//  Created by Silvia Florido on 25/02/20.
//  Copyright © 2020 Silvia Florido. All rights reserved.
//

import Foundation

extension Date {
    
    static func utcToLocalDateString(_ utc: String) -> String? {
        let formatterUTC = DateFormatter()
        formatterUTC.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        guard let utcDate = formatterUTC.date(from: utc) else {
            return nil
        }
        
        let formatterLocal = DateFormatter()
        formatterLocal.calendar = .current
        formatterLocal.dateFormat = "dd-MM-yyyy"
        return formatterLocal.string(from: utcDate)
    }
    
}
