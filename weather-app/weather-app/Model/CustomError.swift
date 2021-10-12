//
//  CustomError.swift
//  weather-app
//
//  Created by Agustin Errecalde on 12/10/2021.
//

import Foundation

enum CustomError: String {
    case unexpected = "Unexpected Error"
    case restricted = "Your locations is restricted"
    case denied = "You have denied this app location permission. Go into settings to change it"
    case serviceError = "Connection Error"
}
