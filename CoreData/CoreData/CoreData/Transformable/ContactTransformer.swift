import Foundation
@objc(ContactTransformer)
class ContactTransfomer: ValueTransformer {
    override class func transformedValueClass() -> AnyClass {
        return NSData.self
    }
    
    override class func allowsReverseTransformation() -> Bool {
        return true
    }
    
    override func transformedValue(_ value: Any?) -> Any? {
        return NSKeyedArchiver.archivedData(withRootObject: value!)
    }
    
    override func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let data = value as? Data else { fatalError() }
        return NSKeyedUnarchiver.unarchiveObject(with: data)
    }
}
