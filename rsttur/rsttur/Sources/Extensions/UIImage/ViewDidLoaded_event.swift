import SwiftUI

// MARK: - Create a view modifier

struct ViewDidLoadModifier: ViewModifier {
    
    @State private var viewDidLoad = false
    let action: (() -> Void)?
    
    func body(content: Content) -> some View {
        content
            .onAppear {
                if viewDidLoad == false {
                    viewDidLoad = true
                    action?()
                }
            }
    }
}

// MARK: - Extension on didLoad event

extension View {
    func onDidLoad(perform action: (() -> Void)? = nil) -> some View {
        self.modifier(ViewDidLoadModifier(action: action))
    }
}
