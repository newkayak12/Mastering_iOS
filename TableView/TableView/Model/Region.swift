import Foundation

class Region {
    let title: String
    var countries: [String]
    
    init(title: String, countries: [String]) {
        self.title = title
        self.countries = countries
    }
    
    static func generateData() -> [Region] {
        var list = [Region]()
        let localeList = [Locale(identifier: "en_US"), Locale(identifier: "ko_KR")]
        
        for l in localeList {
            for id in Locale.isoRegionCodes {
                guard let name = l.localizedString(forRegionCode: id) else {
                    continue
                }
                
                guard let chosung = name.chosung else {
                    continue
                }
                
                let region = list.first { $0.title.compare(chosung, options: .diacriticInsensitive) == .orderedSame }
                
                if let region = region {
                    region.countries.append(name)
                } else {
                    list.append(Region(title: chosung, countries: [name]))
                }
            }
        }
        
        for item in list {
            item.countries.sort()
        }
        
        list.sort(by: { $0.title < $1.title } )
        
        return list
    }
}

extension String {
    private var koreanUnicodeRange: (Int, Int) {
        return (0xAC00, 0xD7AF)
    }
    
    var chosung: String? {
        guard utf16.count > 0 else {
            return nil
        }
        
        let chosungList = ["ㄱ","ㄲ","ㄴ","ㄷ","ㄸ","ㄹ","ㅁ","ㅂ","ㅃ","ㅅ","ㅆ","ㅇ","ㅈ","ㅉ","ㅊ","ㅋ","ㅌ","ㅍ","ㅎ"]
        let code = utf16[utf16.startIndex]
        
        if code >= UInt16(koreanUnicodeRange.0) && code <= UInt16(koreanUnicodeRange.1) {
            let unicode = code - UInt16(koreanUnicodeRange.0)
            let chosungIndex = Int(unicode / 21 / 28)
            return chosungList[chosungIndex]
        }
        
        return String(first!)
    }
}
