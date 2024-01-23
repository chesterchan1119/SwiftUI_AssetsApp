
import SwiftUI

struct ItemView: View {
    @State private var searchText = ""
    @State private var isModelEntityContainerViewPresented = false
    
    var searchResults: [Forecast] {
        if searchText.isEmpty {
            return Forecast.cities
        } else {
            return Forecast.cities.filter { $0.location.contains(searchText) }
        }
    }
    
    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: [GridItem(.flexible(), spacing: 20), GridItem(.flexible(), spacing: 20)], spacing: 20) {
                    ItemWidget(image: Image("visionProImage"), title: "VR Gymnastic Trainer - CVPR with MediaPipe", type: "AI Application", price: 249.99)
                    ItemWidget(image: Image("AndroidAppImage"), title: "Inventory Mobile App - Android Studio", type: "Mobile App", price: 179.99)
                    ItemWidget(image: Image("CVPRImage"), title: "Classification on Chest X-Ray with ResNet-18", type: "Machine Learning", price: 229.99)
                    ItemWidget(image: Image("ZTPImage"), title: "Zero Touch Provisioning", type: "MERN Appplication", price: 140.99)
                    NavigationLink(destination: ModelEntityContainerView(isPresented: $isModelEntityContainerViewPresented)) {
                        ItemWidget(image: Image("khronos_spaceship"), title: "Khronos Spaceship Model Prototype", type: "Blender", price: 69.99)
                        
                    }
                   
                }
                .padding()
            }
            .safeAreaInset(edge: .top) {
                EmptyView()
                    .frame(height: 110)
            }
        }
        .overlay {
            ItemNavigationBar(searchText: $searchText)
        }
        .navigationBarHidden(true)
    }
}
struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ItemView()
                .preferredColorScheme(.dark)
        }
    }
}
