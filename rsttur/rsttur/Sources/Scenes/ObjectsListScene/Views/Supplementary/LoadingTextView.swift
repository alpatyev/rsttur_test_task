import SwiftUI

// MARK: - Loading text view

struct LoadingTextView: View {
    
    @State private var drawingWidth = false
    
    var body: some View {
        VStack(alignment: .center) {
            Text("Загружаем категории..")
                .font(.title)
                .padding(.bottom, 20)
            
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color(.systemGray5))
                RoundedRectangle(cornerRadius: 4)
                    .fill(.blue)
                    .frame(width: drawingWidth ? 220 : 0, alignment: .leading)
                    .animation(.easeIn(duration: 3), value: drawingWidth)
            }
            .frame(width: 220, height: 12)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                    drawingWidth.toggle()
                }
            }
        }
    }
}
