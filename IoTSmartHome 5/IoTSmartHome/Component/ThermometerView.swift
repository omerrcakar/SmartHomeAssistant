import SwiftUI
import Combine

struct ThermometerView: View {
    @StateObject private var viewModel = ThermostatViewModel()
    private let ringSize: CGFloat = 220
    private let outerDialSize: CGFloat = 200

    var body: some View {
        ZStack {
            ThermometerScaleView()
            ThermometerPlaceholderView()

            Circle()
                .inset(by: 5)
                .trim(from: 0.099, to: min(viewModel.ringValue, 0.75))
                .stroke(LinearGradient(colors: [Color.blue], startPoint: .top, endPoint: .bottom),
                        style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                .frame(width: ringSize, height: ringSize)
                .rotationEffect(.degrees(90))
                .animation(.linear(duration: 1), value: viewModel.ringValue)

            ThermometerDialView(degrees: viewModel.degrees)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            let x = min(max(value.location.x, 0), outerDialSize)
                            let y = min(max(value.location.y, 0), outerDialSize)

                            let angle = calculateAngle(centerPoint: CGPoint(x: outerDialSize / 2, y: outerDialSize / 2),
                                                       endPoint: CGPoint(x: x, y: y))

                            if angle >= 36 && angle <= 270 {
                                viewModel.updateTargetTemperature(degrees: angle - angle.remainder(dividingBy: 9))
                            }
                        }
                )

            ThermometerSummaryView(status: viewModel.thermostat.status,
                                   showStatus: viewModel.showStatus,
                                   temperature: viewModel.thermostat.currentTemperature)
            
            VStack {
                Spacer()

                Button(action: {
                    viewModel.resetTemperature()
                }) {
                    Text("Reset Temperature")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.red)
                        .cornerRadius(10)
                }
                .padding()
            }
        }
        .onAppear {
            viewModel.startTemperatureUpdates()
        }
        .onDisappear {
            viewModel.stopTemperatureUpdates()
        }
    }

    private func calculateAngle(centerPoint: CGPoint, endPoint: CGPoint) -> CGFloat {
        let radians = atan2(endPoint.x - centerPoint.x, centerPoint.y - endPoint.y)
        return 180 + (radians * 180 / .pi)
    }
}

#Preview {
    ThermometerView()
}
