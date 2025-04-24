import SwiftUI
import PhotosUI

struct ContentView: View {
    /// En fazla 4 tane UIImage tutuyoruz
    @State private var uiImages: [UIImage] = []
    
    /// En önde göstereceğimiz (kullanıcının baktığı) resmin dizideki indeksi
    @State private var currentIndex: Int = 0
    
    /// Fotoğraf seçici (PhotosPicker) açma/kapama kontrolü
    @State private var isPickerPresented: Bool = false
    
    var body: some View {
        ZStack {
            // Arkadaki eski resimleri ve öndeki resmi üst üste ZStack içinde gösteriyoruz
            ForEach(uiImages.indices, id: \.self) { index in
                // Her resim için View
                imageCardView(for: index)
            }
            
            // En önde "yükleme (kamera) butonu" veya "4 fotoğraf dolu" mesajı
            VStack {
                Spacer()
                
                Button {
                    // 4 resimden azsa yeni resim ekleyebilirsin
                    if uiImages.count < 4 {
                        isPickerPresented = true
                    }
                } label: {
                    if uiImages.count < 4 {
                        Label("Yeni Fotoğraf Ekle", systemImage: "camera.fill")
                            .font(.headline)
                            .padding()
                            .background(Color.white.opacity(0.8))
                            .cornerRadius(12)
                    } else {
                        Text("En fazla 4 fotoğraf yükleyebilirsiniz.")
                            .font(.subheadline)
                            .padding(10)
                            .background(Color.gray.opacity(0.8))
                            .cornerRadius(12)
                    }
                }
                .padding(.bottom, 30)
            }
        }
        // Fotoğraf Seçici (PhotosPicker) sayfasını sheet olarak göster
        .photosPicker(isPresented: $isPickerPresented,
                      selection: $selectedItems,
                      maxSelectionCount: 1,
                      matching: .images)
        .onChange(of: selectedItems) { newItems in
            // Seçim yapıldığında resmi alıp diziye ekle
            Task {
                if let item = newItems.first {
                    if let data = try? await item.loadTransferable(type: Data.self),
                       let image = UIImage(data: data) {
                        // Yeni resmi diziye ekle, en üste(öne) gelsin diye
                        uiImages.append(image)
                        
                        // Maksimum 4 resmi aşmaması için kontrol
                        if uiImages.count > 4 {
                            uiImages.removeFirst(uiImages.count - 4)
                        }
                        
                        // Son eklenen resim en önde olacak şekilde currentIndex ayarı
                        currentIndex = uiImages.count - 1
                        
                        // Seçim bittiğinde ilk elemanı temizleyelim (yeniden seçmek için)
                        selectedItems = []
                    }
                }
            }
        }
    }
    
    /// Seçilen fotoğraf referanslarını tutan değişken
    @State private var selectedItems: [PhotosPickerItem] = []
    
    // MARK: - Her resmi gösteren "kart" benzeri view
    func imageCardView(for index: Int) -> some View {
        // Diziden UIImage çek
        let uiImage = uiImages[index]
        
        // Gösterim için SwiftUI Image oluştur
        return Image(uiImage: uiImage)
            .resizable()
            .scaledToFit()
            .frame(width: 300, height: 400)
            .cornerRadius(16)
            .shadow(color: .black.opacity(0.3), radius: 8, x: 0, y: 4)
            // Görseli ZStack'te sıralarken,
            // currentIndex en önde, diğerleri arkada kalacak şekilde zIndex ayarlıyoruz
            .zIndex(index == currentIndex ? 1 : 0)
            // Ufak bir ölçü farkı ile arkadakilerin biraz küçük görünmesini sağlayabiliriz
            .scaleEffect(index == currentIndex ? 1.0 : 0.9)
            // index farkına göre yatayda hafif kaydırma
            .offset(x: xOffset(for: index))
            // Drag jesti ile sola/sağa sürüklenince currentIndex değişsin
            .gesture(
                DragGesture(minimumDistance: 30)
                    .onEnded { value in
                        let dragAmount = value.translation.width
                        if dragAmount < -50 {
                            // sola sürükleme -> sıradaki resmi öne getir
                            currentIndex = (currentIndex + 1) % uiImages.count
                        } else if dragAmount > 50 {
                            // sağa sürükleme -> bir önceki resmi öne getir
                            currentIndex = (currentIndex - 1 + uiImages.count) % uiImages.count
                        }
                    }
            )
            .animation(.spring(), value: currentIndex)
    }
    
    // MARK: - Yatay konumlama (isteğe göre görsel olarak biraz üst üste binme efekti)
    func xOffset(for index: Int) -> CGFloat {
        // Dizideki sıralamaya göre offset hesaplaması (basit versiyon)
        let distance = CGFloat(index - currentIndex)
        // Örneğin her fark için 30 pt kaydırabiliriz
        return distance * 30
    }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
