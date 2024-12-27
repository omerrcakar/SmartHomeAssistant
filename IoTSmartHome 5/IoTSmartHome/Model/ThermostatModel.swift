import Foundation

struct ThermostatModel {
    var currentTemperature: CGFloat
    var targetTemperature: CGFloat
    var status: ThermostatStatus {
        if currentTemperature < targetTemperature {
            return .heating
        } else if currentTemperature > targetTemperature {
            return .cooling
        } else {
            return .reaching
        }
    }
}

enum ThermostatStatus: String {
    case heating = "HEATING"
    case cooling = "COOLING"
    case reaching = "REACHING"
}
