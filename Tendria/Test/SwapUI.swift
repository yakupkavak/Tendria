import SwiftUI

struct TestVi: View {
    var body: some View {
            ZStack {
                // Arka plan resmi
                Image("pikachu")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .clipped()
                
                VStack {
                    
                    // BLUR VE YAZILAR BİRLEŞİYOR
                    ZStack {
                        // BLUR kısmı
                        VisualEffectBlur(blurStyle: .systemUltraThinMaterialDark)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                        
                        // İÇERİK kısmı
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                HStack(spacing: 2) {
                                    Text("Mount Fuji,")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                    Text("Tokyo")
                                        .font(.subheadline)
                                        .foregroundColor(.white.opacity(0.8))
                                }
                                HStack(spacing: 4) {
                                    Image(systemName: "location")
                                        .font(.caption)
                                    Text("Tokyo, Japan")
                                        .font(.caption)
                                }
                                .foregroundColor(.white.opacity(0.7))
                            }
                            Spacer()
                            VStack(spacing: 4) {
                                Text("4.8")
                                    .font(.headline)
                                Image(systemName: "star.fill")
                                    .font(.caption)
                            }
                            .foregroundColor(.white.opacity(0.9))
                        }
                        .padding(.horizontal, 24)
                        .padding(.vertical, 12)
                    }
                    .frame(height: 80)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 24)
                }
            }
            .ignoresSafeArea()
        }
    }


// VisualEffectBlur View (SwiftUI destekli)
struct VisualEffectBlur: UIViewRepresentable {
    var blurStyle: UIBlurEffect.Style

    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: blurStyle))
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
}

#Preview {

    TestVi()
     
}
