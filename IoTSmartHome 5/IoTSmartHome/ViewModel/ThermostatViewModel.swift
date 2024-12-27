import SwiftUI
import Combine
import Alamofire

class ThermostatViewModel: ObservableObject {
    @Published var thermostat = ThermostatModel(currentTemperature: 22, targetTemperature: 22)
    @Published var degrees: CGFloat = 198
    @Published var showStatus: Bool = false
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let minTemperature: CGFloat = 0
    private let maxTemperature: CGFloat = 30
    private let ringMaxValue: CGFloat = 40
    private var temperatureUpdateSubject = PassthroughSubject<CGFloat, Never>()
    private var cancellables = Set<AnyCancellable>()

    private let baseURL = "http://127.0.0.1:8000/control/thermostat"

    var ringValue: CGFloat {
        thermostat.currentTemperature / ringMaxValue
    }

    init() {
        temperatureUpdateSubject
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .sink { [weak self] newTemperature in
                self?.sendTemperatureToServer(newTemperature: newTemperature)
            }
            .store(in: &cancellables)
    }

    func startTemperatureUpdates() {
        Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }

                switch self.thermostat.status {
                case .heating:
                    self.showStatus = true
                    self.thermostat.currentTemperature += 1
                case .cooling:
                    self.showStatus = true
                    self.thermostat.currentTemperature -= 1
                case .reaching:
                    self.showStatus = false
                }
            }
            .store(in: &cancellables)
    }
    func resetTemperature() {
        thermostat.currentTemperature = 0
        thermostat.targetTemperature = 0
        degrees = 0
        
        sendTemperatureToServer(newTemperature: 0)
    }


    func stopTemperatureUpdates() {
        cancellables.removeAll() // Abonelikleri temizler
    }

    func updateTargetTemperature(degrees: CGFloat) {
        let targetTemperature = min(max(degrees / 360 * ringMaxValue, minTemperature), maxTemperature)
        thermostat.targetTemperature = targetTemperature
        self.degrees = targetTemperature / ringMaxValue * 360
        temperatureUpdateSubject.send(targetTemperature)
    }

    private func sendTemperatureToServer(newTemperature: CGFloat) {
        let url = "\(baseURL)/1/1/\(Int(newTemperature))"

        isLoading = true
        errorMessage = nil

        AF.request(url, method: .put)
            .validate()
            .response { [weak self] response in
                DispatchQueue.main.async {
                    self?.isLoading = false
                    switch response.result {
                    case .success:
                        print("Temperature updated successfully!")
                    case .failure(let error):
                        self?.errorMessage = "Failed to update temperature: \(error.localizedDescription)"
                    }
                }
            }
    }
}
