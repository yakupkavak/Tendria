import SwiftUI

struct CustomWaveView: View {
    var gradient: Gradient
    var startPoint: UnitPoint
    var endPoint: UnitPoint
    
    var body: some View {
        CustomWaveShape()
            .fill(
                LinearGradient(
                    gradient: gradient,
                    startPoint: startPoint,
                    endPoint: endPoint
                )
            )
    }
}

struct CustomWaveShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // Noktaları Tanımlayın
        let P0 = CGPoint(x: 0, y: rect.height * 1.7) // Başlangıç noktası
        let P2 = CGPoint(x: rect.width * 0.4, y: rect.height * 2.3) // İlk dalganın inişi (yükseltilmiş)
        let P4 = CGPoint(x: rect.width * 2, y: rect.height * 10) // Bitiş noktası (yükseltilmiş)        // Çizim Başlangıcı
        path.move(to: P0)
        
        // Birinci Bezier Eğrisi (P0 -> P2)
        path.addCurve(
            to: P2, // Bitiş noktası
            control1: CGPoint(x: rect.width * 0.1, y: rect.height * 0.8), // İlk kontrol noktası (daha yukarı çekildi)
            control2: CGPoint(x: rect.width * 0.3, y: rect.height * 3.7) // İkinci kontrol noktası (daha aşağı çekildi)
        )
        
        // İkinci Bezier Eğrisi (P2 -> P4)
        path.addCurve(
            to: P4, // Bitiş noktası
            control1: CGPoint(x: rect.width * 0.53, y: rect.height * 0.9), // İlk kontrol noktası (daha yukarı çekildi)
            control2: CGPoint(x: rect.width * 0.7, y: rect.height * 2) // İkinci kontrol noktası (daha aşağı çekildi)
        )
        path.addCurve(
            to: P4, // Bitiş noktası
            control1: CGPoint(x: rect.width * 0.53, y: rect.height * 0.9), // İlk kontrol noktası (daha yukarı çekildi)
            control2: CGPoint(x: rect.width * 0.7, y: rect.height * 2) // İkinci kontrol noktası (daha aşağı çekildi)
        )
        
        // Sağ üst köşe
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        
        // Sol üst köşe
        path.addLine(to: CGPoint(x: 0, y: 0))
        
        // Şekli kapatma
        path.closeSubpath()
        
        return path
    }
}
