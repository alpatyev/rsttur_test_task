import Foundation

// MARK: - Default value for place

extension PlaceDataModel {
    init() {
        self.init(id: 0,
                  name: "",
                  description: "",
                  image: "",
                  type: "",
                  close: true,
                  icon: "",
                  color: "",
                  lat: 0,
                  lon: 0,
                  working_hours: nil)
    }
}
