
import UIKit

enum CellType: String {
    case action
    case disclosure
    case `switch`
    case checkmark
}


class PhotosSettingItem {
    init(type: CellType, title: String, on: Bool = false, imageName: String? = nil) {
        self.type = type
        self.title = title
        self.on = on
        self.imageName = imageName
    }
    
    let type: CellType
    let title: String
    var on: Bool
    var imageName: String?
}


class PhotosSettingSection {
    init(items: [PhotosSettingItem], header: String? = nil, footer: String? = nil) {
        self.items = items
        self.header = header
        self.footer = footer
    }
    
    let items: [PhotosSettingItem]
    var header: String?
    var footer: String?
    
    static func generateData() -> [PhotosSettingSection] {
        return [
            PhotosSettingSection(items: [
                PhotosSettingItem(type: .disclosure, title: "Siri & Search", imageName: "magnifyingglass.circle.fill")
            ],
            header: "Allow Photos to Access"),
            
            PhotosSettingSection(items: [
                PhotosSettingItem(type: .switch, title: "Hidden Album", on: true)
            ],
            footer: "When enabled, the Hidden album will appear in the Albums tab, under Utilities."),
            
            PhotosSettingSection(items: [
                PhotosSettingItem(type: .switch, title: "Auto-Play Videos", on: false),
                PhotosSettingItem(type: .switch, title: "Summarize Photos", on: true)
            ],
            header: "Photos Tab",
            footer: "The Photos tab shows every photo in your library in all views. You can choose compact, summarized views for Collections and Years."),
            
            PhotosSettingSection(items: [
                PhotosSettingItem(type: .action, title: "Reset Suggested Memories"),
                PhotosSettingItem(type: .switch, title: "Show Holiday Events", on: true)
            ],
            header: "Memories",
            footer: "You can choose to see holiday events for your home country."),
            
            PhotosSettingSection(items: [
                PhotosSettingItem(type: .checkmark, title: "Automatic", on: true),
                PhotosSettingItem(type: .checkmark, title: "Keep Originals", on: false)
            ],
            header: "Transfer to mac or PC",
            footer: "Automatically transfer photos and videos in a compitable format, or always transfer the original file without checking for compatibility.")
        ]
    }
}
