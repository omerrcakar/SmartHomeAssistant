
import Foundation
import Alamofire

class DeviceService {
    static let shared = DeviceService() // Singleton yapısı
    private let baseURL = "http://127.0.0.1:8000/control"
    
    /// Cihazın durumunu günceller
    func updateDeviceStatus(deviceType: String, status: Bool, completion: @escaping (Result<Void, Error>) -> Void) {
        // URL'yi oluştur
        let endpoint = "\(baseURL)/\(deviceType)/1/1/\(status ? 1 : 0)"
        
        // PUT isteği gönder
        AF.request(endpoint, method: .put)
            .validate()
            .response { response in
                switch response.result {
                case .success:
                    print("\(deviceType) updated successfully to \(status ? "On" : "Off")")
                    completion(.success(()))
                case .failure(let error):
                    print("Error:", error.localizedDescription)
                    if let data = response.data {
                        print("Response Data:", String(data: data, encoding: .utf8) ?? "No data")
                    }
                    completion(.failure(error))
                }
            }

    }
}
