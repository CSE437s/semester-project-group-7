import SwiftUI
import HealthKit

struct HealthKitPermissions: View {
    @Environment(\.presentationMode) var presentationMode
    private let healthStore = HKHealthStore()

    var body: some View {
        ZStack {
            Color.gray.opacity(0.3).edgesIgnoringSafeArea(.all)
            VStack(spacing: 20) {
                Text("HealthKit Permissions")
                    .font(.title)
                    .padding()

                Text("This app requires access to your HealthKit data to provide personalized health information. Please grant permissions in the next screen.")
                    .multilineTextAlignment(.center)
                    .padding()

                Button("Continue") {
                    requestHealthKitAuthorization()
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(10)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(20)
            .padding()
        }
    }

    private func requestHealthKitAuthorization() {
        guard HKHealthStore.isHealthDataAvailable() else {
            print("Health data is not available on this device.")
            self.presentationMode.wrappedValue.dismiss()
            return
        }

        let bvp = HKObjectType.quantityType(forIdentifier: .heartRateVariabilitySDNN)
        let ecg = HKObjectType.electrocardiogramType()
        let eda = HKObjectType.quantityType(forIdentifier: .electrodermalActivity)
        let temp = HKObjectType.quantityType(forIdentifier: .bodyTemperature)
        let walkingSpeed = HKObjectType.quantityType(forIdentifier: .walkingSpeed)
        let height = HKObjectType.quantityType(forIdentifier: .height)

        let typesToRead: Set<HKObjectType> = [bvp!, ecg, eda!, temp!, walkingSpeed!, height!,]
        
        healthStore.requestAuthorization(toShare: [], read: typesToRead) { [self] success, error in
            DispatchQueue.main.async {
                if success {
                    print("Permissions are granted.")
                } else {
                    print("Failed to get permissions \(error?.localizedDescription ?? "Unknown error")")
                }
                self.presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

// For previewing the SwiftUI view within Xcode
struct HealthKitPermissions_Previews: PreviewProvider {
    static var previews: some View {
        HealthKitPermissions()
    }
}
