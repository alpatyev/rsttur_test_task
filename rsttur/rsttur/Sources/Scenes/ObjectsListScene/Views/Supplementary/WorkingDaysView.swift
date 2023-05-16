import SwiftUI

// MARK: Working days view

struct WorkingDaysView: View {
    
    let workingHoursModels: [WorkingHoursItemModel]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible())], spacing: 2) {
                ForEach(workingHoursModels, id: \.self) { item in
                    ForEach(item.days, id: \.self) { day in
                        HStack {
                            Text(day)
                                .font(.subheadline)
                                .cornerRadius(8)
                                .padding(.horizontal, 10)
                            
                            Spacer()
                            
                            Text(item.available)
                                .font(.title)
                                .foregroundColor(.red)
                                .padding(.horizontal, 10)
                            
                        }
                    }
                }
            }
        }
    }
}
