
import SwiftUI

struct SmartHomeDashboard: View {
    
    @StateObject private var viewModel = SmartHomeViewModel()
    @StateObject private var viewModel2 = ThermostatViewModel()
    
    
    @State private var isSmartLampOn: Bool = false
    @State private var isDoorOn: Bool = false
    @State private var isAirOn: Bool = false
    @State private var selectedMode: String?
    
    
    @State var isOpenThermostat: Bool = false
    
    var body: some View {
        VStack{
            
            // First Part
            HStack{
                VStack(alignment: .leading){
                    Text("Good Morning, Ömer")
                        .font(.title)
                        .fontWeight(.medium)
                    Text("Welcome to Home Assistant")
                        .foregroundStyle(.secondary)
                        .fontWeight(.light)
                        .font(.subheadline)
                }
                Spacer()
                
                CustomButtonView(title: "",imageName: "repeat" ,action: {
                    isSmartLampOn = false
                    isDoorOn = false
                    isAirOn = false
                    selectedMode = nil
                }, titleColor: .black, backgroundColor: .white, width: 15, height: 10, strokeColor: .black)
                .fontWeight(.bold)
                
                
            }
            .padding(.bottom, 20)
            
            // Weather
            VStack{
                WeatherView()
            }
            .padding(.bottom, 20)
            
            
            HStack(){
                Text("Devices")
                    .foregroundStyle(.secondary)
                    .fontWeight(.light)
                    .font(.subheadline)
                Spacer()
            }
            
            ScrollView{
                // Devices
                VStack{
                    HStack(spacing: 10){
                        VStack(spacing: 10){
                            CustomDeviceCard(
                                title: "Smart Lamp",
                                subtitle: viewModel.isSmartLampOn ? "On" : "Off",
                                color: viewModel.isSmartLampOn ? Color("color1") : .gray ,
                                height: 100,
                                image: viewModel.isSmartLampOn ? "lampOn" : "lampOff",
                                isOn: $viewModel.isSmartLampOn
                            )
                            CustomDeviceCard(
                                title: "Door",
                                subtitle: viewModel.isDoorOn ? "On" : "Off",
                                color: viewModel.isDoorOn ? Color("color2") : .gray,
                                height: 100,
                                image: viewModel.isDoorOn ? "doorOn" : "doorOff" ,
                                isOn: $viewModel.isDoorOn
                            )
                        }
                        CustomDeviceCard(
                            title: "Heater",
                            subtitle: isAirOn ? "On" : "Off",
                            color: isAirOn ? Color("color3") : .gray,
                            height: 255,
                            image: isAirOn ? "fireOn" : "fireOff" ,
                            isOn: $isAirOn
                        )
                        .onChange(of: isAirOn){ _, newV in
                            if newV{
                                isOpenThermostat = true
                            }else{
                                isOpenThermostat = false
                                    // Termometre sıcaklığını sıfırla
                                    viewModel2.resetTemperature()
                            }
                        }
                    }
                    
                }
                
                
                
                
            }
            HStack{
                Text("Modes")
                    .foregroundStyle(.secondary)
                    .fontWeight(.light)
                    .font(.subheadline)
                Spacer()
            }
            
            HStack{
                VStack{
                    CustomButtonView(title: "Morning", imageName: "sunrise.fill",isSystemImage: true, action: {
                        
                        viewModel.isSmartLampOn = true
                        isAirOn = true
                        viewModel.isDoorOn = false
                        selectedMode = "Morning"
                        
                        
                    }, titleColor: .black, backgroundColor: selectedMode == "Morning" ? Color("color1") : .gray.opacity(0.2), width: 140, height: 10, strokeColor: .black)
                    
                    CustomButtonView(title: "Leave Home", imageName: "house.slash",isSystemImage: true,action: {
                        
                        viewModel.isSmartLampOn = false
                        viewModel.isDoorOn = true
                        isAirOn = false
                        selectedMode = "Leave Home"
                                                  
                    }, titleColor: .black, backgroundColor: selectedMode == "Leave Home" ? Color("color2") : .gray.opacity(0.2), width: 140, height: 10, strokeColor: .black)
                }
                VStack{
                    CustomButtonView(title: "Arrive Home", imageName: "house",isSystemImage: true, action: {
                        
                        viewModel.isSmartLampOn = true
                        isAirOn = true
                        viewModel.isDoorOn = false
                        selectedMode = "Arrive Home"
                        
                    }, titleColor: .black, backgroundColor: selectedMode == "Arrive Home" ? Color("color3") : .gray.opacity(0.2), width: 140, height: 10, strokeColor: .black)
                    CustomButtonView(title: "Night", imageName: "moon.zzz",isSystemImage: true, action: {
                        
                        viewModel.isSmartLampOn = false
                        isAirOn = false
                        viewModel.isDoorOn = false
                        selectedMode = "Night"
                        
                    }, titleColor: .black, backgroundColor: selectedMode == "Night" ? Color("color4") : .gray.opacity(0.2), width: 140, height: 10, strokeColor: .black)
                }
                
            }
            
            
            
            
            
        }
        .padding()
        .sheet(isPresented: $isOpenThermostat){
            ThermostatView()
        }
    }
}

#Preview {
    SmartHomeDashboard()
}
