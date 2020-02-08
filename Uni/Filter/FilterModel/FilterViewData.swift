import UIKit

struct FilterViewData {
    let FilterViewColor = UIColor.View.background
    let addSubjectColor = UIColor.View.tint
    let addSubjectTextColor = UIColor.Text.common
    let FilterDropDownColor = UIColor.alizarin
    
    let countryLabelColor = UIColor.View.tint
    let countryLabelTextColor = UIColor.Text.common
    
    let subjectCellColor = UIColor.TableView.Cell.tintedBackground
    let subjectCellTextColor = UIColor.Text.common
    
    let sliderColor = UIColor.slider
    
    let cornerRadius = CGFloat(10)
    
    let militaryButtonColor = UIColor.switchButton
    let campusButtonColor = UIColor.switchButton
}


// MARK: Slider
extension UIColor{
    static var slider: UIColor {
        switch UIColor.interfaceStyle {
        case .dark:
            return .white
        case .light:
            return UIColor.Customs.lightBlack
        }
    }
}

// MARK: Switch
extension UIColor{
    static var switchButton: UIColor {
        switch UIColor.interfaceStyle {
        case .dark:
            return .white
        case .light:
            return UIColor.Customs.lightBlack
        }
    }
}

// MARK: minPoints
extension UIColor{
    enum MinPoints{
        static var border: UIColor {
            switch UIColor.interfaceStyle {
            case .dark:
                return .white
            case .light:
                return UIColor.Customs.lightBlack
            }
        }
        
        static var background: UIColor {
            switch UIColor.interfaceStyle {
            case .dark:
                return .white
            case .light:
                return UIColor.Customs.lightBlack
            }
        }
    }
}
