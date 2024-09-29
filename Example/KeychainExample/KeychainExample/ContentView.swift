import SwiftUI

struct ContentView: View {
    @State private var rememberMe = false
    @State private var secret = ""
    @State private var outputText = Self.initialOutput
    
    private static let initialOutput = "Enter your desired values to be stored in Keychain and tap 'Store Value' button."
    
    private let keychain = MyAppKeychain.shared
    
    var body: some View {
        VStack(spacing: 20) {
            Text(outputText)
                .multilineTextAlignment(.center)
                .padding()
            
            Toggle("Remember Me", isOn: $rememberMe)
                .padding()
            
            TextField("Enter secret", text: $secret)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button(action: onTouchStoreValues) {
                Text("Store Values")
                    .fontWeight(.bold)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            Button(action: clearValues) {
                Text("Clear Values")
                    .fontWeight(.bold)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .padding()
        .onAppear {
            readValues()
        }
    }
    
    private func onTouchStoreValues() {
        guard !secret.isEmpty else { return }
        
        keychain.rememberMe = rememberMe
        keychain.secret = secret
        
        outputText = "Reading values from Keychain\n"
        outputText += "Remember me: \(keychain.rememberMe == true)\n"
        outputText += "Secret: \(keychain.secret ?? "-")"
    }
    
    private func readValues() {
        guard let rememberMe = keychain.rememberMe,
              let secret = keychain.secret else {
            return
        }
        
        outputText = "Reading values from Keychain\n"
        outputText += "Remember me: \(rememberMe)\n"
        outputText += "Secret: \(secret)"
    }
    
    private func clearValues() {
        keychain.rememberMe = nil
        keychain.secret = nil
        outputText = Self.initialOutput
    }
}
