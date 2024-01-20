import SwiftUI

struct ItemNavigationBar: View {
    @Binding var searchText: String
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                // MARK: Back Button
                Button {
                    dismiss()
                } label: {
                    HStack(spacing: 5) {
                        // MARK: Back Button Icon
                        Image(systemName: "chevron.left")
                            .font(.system(size: 23).weight(.medium))
                            .foregroundColor(.white)
                        
                        // MARK: Back Button Label
                        Text("Assets Store")
                            .font(.title)
                            .foregroundColor(.white)
                    }
                    .frame(height: 44)
                }
                
                Spacer()
                
                // MARK: More Button
                Image(systemName: "ellipsis.circle")
                    .font(.system(size: 28))
                    .frame(width: 44, height: 44, alignment: .trailing)
                    .foregroundColor(.white)
            }
            .frame(height: 52)
            HStack{
                Image(systemName: "list.bullet")
                    .foregroundColor(.white)
                // MARK: Search Bar
                HStack(spacing: 2) {
                    Image(systemName: "magnifyingglass")
                    
                    TextField("Search for an Item Name", text: $searchText)
                        .foregroundColor(.white)
                        .background(Color.clear)
                        .foregroundColor(.white)
                        .accentColor(.white)
                        .font(.subheadline)
                }
                .foregroundColor(.white)
                .padding(.horizontal, 6)
                .padding(.vertical, 7)
                .frame(height: 36, alignment: .leading)
                .background(Color.bottomSheetBackground, in: RoundedRectangle(cornerRadius: 10))
                .innerShadow(shape: RoundedRectangle(cornerRadius: 10), color: .black.opacity(0.50), lineWidth: 2, offsetX: 0, offsetY: 2, blur: 2)
            }
            
        }
        .frame(height: 106, alignment: .top)
        .padding(.horizontal, 16)
        .padding(.top, 49)
        .backgroundBlur(radius: 20, opaque: true)
        .background(Color.navBarBackground)
        .frame(maxHeight: .infinity, alignment: .top)
        .ignoresSafeArea()
    }
}

struct ItemNavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        ItemNavigationBar(searchText: .constant(""))
    }
}