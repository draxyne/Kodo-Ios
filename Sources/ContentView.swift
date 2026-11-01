import SwiftUI

struct ContentView: View {
    @State private var isLoading = true
    @State private var hasError = false
    @State private var reloadTrigger = 0

    private let url = URL(string: "https://ia.zyranex.fr/app/")!
    private let bg = Color(red: 0x1c / 255.0, green: 0x1b / 255.0, blue: 0x1a / 255.0)

    var body: some View {
        ZStack {
            bg.ignoresSafeArea()

            WebView(url: url,
                    isLoading: $isLoading,
                    hasError: $hasError,
                    reloadTrigger: $reloadTrigger)

            if isLoading && !hasError {
                ProgressView()
                    .tint(.white)
                    .scaleEffect(1.3)
            }

            if hasError {
                VStack(spacing: 16) {
                    Image(systemName: "wifi.slash")
                        .font(.system(size: 44))
                        .foregroundStyle(.white.opacity(0.7))
                    Text("Connexion impossible")
                        .font(.headline)
                        .foregroundStyle(.white)
                    Text("Vérifie ta connexion puis réessaie.")
                        .font(.subheadline)
                        .foregroundStyle(.white.opacity(0.6))
                    Button {
                        hasError = false
                        isLoading = true
                        reloadTrigger += 1
                    } label: {
                        Text("Réessayer")
                            .fontWeight(.semibold)
                            .padding(.horizontal, 28)
                            .padding(.vertical, 12)
                            .background(.white)
                            .foregroundStyle(.black)
                            .clipShape(Capsule())
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(bg.ignoresSafeArea())
            }
        }
        .preferredColorScheme(.dark)
    }
}
