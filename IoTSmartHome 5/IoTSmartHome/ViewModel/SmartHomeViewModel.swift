
import SwiftUI

class SmartHomeViewModel: ObservableObject {
    @Published var isSmartLampOn: Bool = false {
        didSet {
            updateDevice(deviceType: "light", status: isSmartLampOn)
        }
    }
    @Published var isDoorOn: Bool = false {
        didSet {
            updateDevice(deviceType: "door", status: isDoorOn)
        }
    }
    
    private func updateDevice(deviceType: String, status: Bool) {
        DeviceService.shared.updateDeviceStatus(deviceType: deviceType, status: status) { result in
            switch result {
            case .success:
                print("\(deviceType) updated successfully to \(status ? "On" : "Off")")
            case .failure(let error):
                print("Failed to update \(deviceType): \(error.localizedDescription)")
            }
        }
    }
}
