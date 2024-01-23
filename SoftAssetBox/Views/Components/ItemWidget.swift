//
//  ItemWidget is the 正方形  card in ItemView


import SwiftUI
struct ItemWidget: View {
    var image: Image
    var title: String
    var type: String
    var price: Double
    
    @State private var isShowingOptions = false
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            ZStack(alignment: .topTrailing) {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 150, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black, lineWidth: 0)
                    )
                    .overlay(
                        LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.4), Color.clear]), startPoint: .top, endPoint: .bottom)
                    )
                
                Button(action: {
                    isShowingOptions.toggle()
                }) {
                    Image(systemName: "ellipsis")
                        .foregroundColor(.yellow)
                        .padding(5)
                }
                .padding(.trailing, 0)
    //            .padding(.left, -120)
                .frame(alignment: .topTrailing)
                .actionSheet(isPresented: $isShowingOptions) {
                    ActionSheet(title: Text(""), buttons: [
                        .default(Text("Share"), action: {
                            // Handle share button action
                        }),
                        .default(Text("Report"), action: {
                            // Handle report button action
                        }),
                        .cancel(Text("Cancel"))
                    ])
                }
            }
                       
            
            
            VStack(alignment: .leading, spacing: 2) {
                Spacer().frame(height: 2)
                Text(title)
                    .font(.system(size: 14, weight: .light))
                    .foregroundColor(.black)
                Text("$" + String(format: "%.2f", price))
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.black)
                Text(type)
                    .font(.system(size: 11, weight: .regular))
                    .foregroundColor(.gray)
                Spacer().frame(height: 2)
            }
            .padding(.horizontal, 10)
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(color: Color.gray.opacity(0.4), radius: 4, x: 0, y: 2)
        }
        .padding(.all, 10)
    }
}
