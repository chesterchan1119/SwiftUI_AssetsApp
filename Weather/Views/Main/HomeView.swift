import SwiftUI
import BottomSheet
import RealityKit
import Model3DView


enum BottomSheetPosition: CGFloat, CaseIterable {
    case top = 0.83 // 702/844
    case middle = 0.385 // 325/844
}

struct HomeView: View {
    @State var bottomSheetPosition: BottomSheetPosition = .middle
    @State var bottomSheetTranslation: CGFloat = BottomSheetPosition.middle.rawValue
    @State var hasDragged: Bool = false
    @State private var isLoginViewPresented = false
    @State private var isModelEntityContainerViewPresented = false
    @State private var isModelLoading = true

    
    
    
    private let camera = PerspectiveCamera(position: [0, 0.5, 2], fov: .degrees(25)).lookingAt(center: [0, -0.25, 0])
    
    var bottomSheetTranslationProrated: CGFloat {
        (bottomSheetTranslation - BottomSheetPosition.middle.rawValue) / (BottomSheetPosition.top.rawValue - BottomSheetPosition.middle.rawValue)
    }
    
    
    var body: some View {
        
        
        NavigationView {
            GeometryReader { geometry in
                let screenHeight = geometry.size.height + geometry.safeAreaInsets.top + geometry.safeAreaInsets.bottom
                let imageOffset = screenHeight + 36
                
                ZStack {
                    // MARK: Background Color
                    Color.background
                        .ignoresSafeArea()
                    
                    // MARK: Background Image
                    Image("Background")
                        .resizable()
                        .ignoresSafeArea()
                        .offset(y: -bottomSheetTranslationProrated * imageOffset)

                    // MARK: Current Weather
                    VStack(spacing: -10 * (1 - bottomSheetTranslationProrated)) {
                        Text("Dublin")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                        VStack {
                            Text(attributedString)
                                .foregroundColor(.white)
                            
                            Text("H:16°   L:9°")
                                .font(.title3.weight(.semibold))
                                .opacity(1 - bottomSheetTranslationProrated)
                                .foregroundColor(.white)
                            NavigationLink(destination: ModelEntityContainerView(isPresented: $isModelEntityContainerViewPresented)) {
                                Text("View the Model Details")
                            }
                            NavigationLink(destination: LoginView()) {
                                Text("View the Login")
                            }
                        }
                        .navigationTitle("Home Page")

                    
                    Spacer()
                }
                .padding(.top, 51)
                .offset(y: -bottomSheetTranslationProrated * 46)
               
                    if isModelLoading {
                        Text("Loading...")
                            .foregroundColor(.white)
                            .onAppear {
                                loadModel()
                            }
                    } else {
                        Spacer()
                    }

                    Spacer()

                    // MARK: House Model
                    if !isModelLoading {
                        Model3DView(named: "scene.gltf")
                            .camera(camera)
                            .frame(height: 150)
                    }
                    
                
                // MARK: Bottom Sheet
                //                    BottomSheetView(position: $bottomSheetPosition) {
                ////                        Text(bottomSheetTranslationProrated.formatted())
                //                    } content: {
                //                        ForecastView(bottomSheetTranslationProrated: bottomSheetTranslationProrated)
                //                    }
                //                    .onBottomSheetDrag { translation in
                //                        bottomSheetTranslation = translation / screenHeight
                //
                //                        withAnimation(.easeInOut) {
                //                            if bottomSheetPosition == BottomSheetPosition.top {
                //                                hasDragged = true
                //                            } else {
                //                                hasDragged = false
                //                            }
                //                        }
                //                    }
                
                // MARK: Tab Bar
                TabBar(action: {
                    bottomSheetPosition = .top
                })
                .offset(y: bottomSheetTranslationProrated * 115)
            }
        }
        .navigationBarHidden(true)
//        .tabBarHidden(true)
    }
    }
    func loadModel() {
        // Start loading the model
        // Show a loading indicator or perform any other necessary setup
        
        // Simulate model loading completion
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
    
            isModelLoading = false
        }
    }

    
    private var attributedString: AttributedString {
        var string = AttributedString("19°" + (hasDragged ? " | " : "\n ") + "Mostly Clear")
        
        if let temp = string.range(of: "19°") {
            string[temp].font = .system(size: (96 - (bottomSheetTranslationProrated * (96 - 20))), weight: hasDragged ? .semibold : .thin)
            string[temp].foregroundColor = hasDragged ? .white : .white
        }
        
        if let pipe = string.range(of: " | ") {
            string[pipe].font = .title3.weight(.semibold)
            string[pipe].foregroundColor = .secondary.opacity(bottomSheetTranslationProrated)
        }
        
        if let weather = string.range(of: "Mostly Clear") {
            string[weather].font = .title3.weight(.semibold)
            string[weather].foregroundColor = .secondary
        }
        
        return string
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .preferredColorScheme(.dark)
    }
}
