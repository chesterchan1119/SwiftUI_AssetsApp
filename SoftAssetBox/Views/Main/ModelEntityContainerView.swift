import SwiftUI
import Model3DView

struct ModelEntityContainerView: View {
    
    /// The content of the pages.
    private static let pages: [(title: LocalizedStringKey, body: LocalizedStringKey)] = [
        ("3D Asset - The Solaris Starship", "A revolutionary starship that embraces sustainable design principles."),
        ("Functionality", "It features large, transparent solar panels integrated into its exterior, harnessing the power of the sun to generate clean energy for propulsion and onboard systems."),
        ("Minialist & Harmonious", "With its vibrant black and white accents and a modern minimalist design, the Solaris Starship showcases a harmonious fusion of technology and environmental consciousness."),
        ("Adventure and Nostalgia", "The spaceship's timeless aesthetic evokes a sense of adventure and nostalgia, capturing the imagination of those who gaze upon it. Credit to: *Model3DView*!"),
    ]
    
    
    // MARK: -
    @Binding var isPresented: Bool
    @State private var modelLoaded = false
    
    /**
     We position the (perspective) camera exactly where we want it.
     Angled slightly to add a bit more perspective.
     */
    private let camera = PerspectiveCamera(position: [0, 0.5, 2], fov: .degrees(25)).lookingAt(center: [0, -0.25, 0])
    
    /**
     The rotation angle(s) of the model. This will change accordingly to `currentIndex`.
     Keep in mind we're rotating the model, *not* the camera.
     */
    @State private var rotation = Euler(y: .degrees(-45))
    
    /**
     The current index of the `TabView` we use for the paged effect.
     */
    @State private var currentIndex = 0
    
    // MARK: -
    private func onNextPressed() {
        if currentIndex < Self.pages.count - 1 {
            withAnimation(.linear) {
                currentIndex += 1
            }
        }
        else {
            isPresented = false
        }
    }
    
    var body: some View {
        NavigationView {
            VStack (spacing:0){
          
                GeometryReader { proxy in
                    VStack(spacing: 0) {
            
                        Model3DView(named: "scene.gltf")
                            .onLoad { state in
                                modelLoaded = state == .success
                            }
                            .transform(rotate: rotation)
                            .camera(camera)
                            .frame(height: proxy.size.height / 2.5)
            
                        
                        TabView(selection: $currentIndex) {
                            ForEach(Array(Self.pages.enumerated()), id: \.offset) { (index, page) in
                                PagedView(title: page.title, content: page.body)
                                    .tag(index)
                            }
                        }
                        .tabViewStyle(.page(indexDisplayMode: .always))
                        
//                        .overlay(PageControl(numberOfPages: Self.pages.count, currentIndex: $currentIndex).padding(.vertical, 10))
                        
                        HStack {
                            Spacer()
                            PageControl(numberOfPages: Self.pages.count, currentIndex: $currentIndex)
                            Spacer()
                        }
                        .padding(.vertical, 10) // Adjust the vertical padding of the dots
                        
                        Button(action: onNextPressed) {
                            HStack {
                                Text("Continue")
                                Image(systemName: "arrow.turn.down.right")
                            }
                        }
                        .buttonStyle(.borderedProminent)
                        .frame(maxWidth: .infinity)
                    }
                    .padding(.bottom, 10)
                }
                /**
                 Only show the contents once the model is fully loaded.
                 */
                .opacity(modelLoaded ? 1 : 0)
                .animation(.linear(duration: 0.6), value: modelLoaded)
                .background(Color.white)
                /**
                 Keep track of changes to `currentIndex`. Once it changes, rotate the model accordingly.
                 Note we're using `withAnimation` here. The `transform()` modifier of Model3DView is animatable!
                 */
                .onChange(of: currentIndex) { newIndex in
                    withAnimation(.easeInOut(duration: 0.5)) {
                        // Basically calculating how many degrees we should rotate based on the total number of pages.
                        let slice = 360.0 / Double(Self.pages.count)
                        let degrees = Double(newIndex) * -slice - (slice * 0.5)
                        rotation.y = .degrees(degrees)
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity) // Fill the entire view
            .navigationBarItems(trailing:
                HStack {
                Button(action: {}) {
                    Image(systemName: "square.and.arrow.up")
                }
                .foregroundColor(.blue)
                
                Button(action: {}) {
                    Image(systemName: "flag")
                }
            }
            )
        }
    }
}

/**
 A single "page" view holding nothing but a title and body text.
 Using `LocalizedStringKey` we can use markdown formatting.
 */
private struct PagedView: View {
    let title: LocalizedStringKey
    let content: LocalizedStringKey
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 20) {
                Text(title)
                    .font(.system(size: 30, weight: .bold))
                
                Text(content)
                    .font(.system(size: 20))
                    .lineSpacing(6)
                    .frame(alignment: .leading)
                
                Spacer()
            }
            
            Spacer()
        }
        .padding(.horizontal, 30)
        .foregroundColor(.black)
    }
}
private struct PageControl: View {
    let numberOfPages: Int
    @Binding var currentIndex: Int
    
    var body: some View {
        HStack(spacing: 6) {
            ForEach(0..<numberOfPages, id: \.self) { index in
                Circle()
                    .foregroundColor(index == currentIndex ? .blue : .gray)
                    .frame(width: 8, height: 8)
            }
        }
    }
}


#if DEBUG

struct IntroductionView_Preview: PreviewProvider {
    static var previews: some View {
        ModelEntityContainerView(isPresented: .constant(true))
    }
}

#endif
