//
//  LanguageChange.swift
//  ScreenDemo
//
//  Created by Shubham Kumar Singh on 07/02/21.
//

import Foundation

enum Language: String {
    case arabic = "ar"
    case english = "en"
}

extension String {

    /// Localizes a string using given language from Language enum.
    /// - parameter language: The language that will be used to localized string.
    /// - Returns: localized string.
    func localized(reqBundle: Bundle = Bundle.main) -> String {
        var path = Bundle.main.path(forResource: LocalizationService.shared.language.rawValue, ofType: "lproj")
        
        var localizedString = localized(bundle: self.getBundle(path: path))
        if localizedString == self {
            path = reqBundle.path(forResource: LocalizationService.shared.language.rawValue, ofType: "lproj")
            localizedString = localized(bundle: self.getBundle(path: path))
        }
        
        return localizedString
    }

    /// Localizes a string using given language from Language enum.
    ///  - Parameters:
    ///  - language: The language that will be used to localized string.
    ///  - args:  dynamic arguments provided for the localized string.
    /// - Returns: localized string.
    func localized(args arguments: CVarArg..., reqBundle: Bundle = Bundle.main) -> String {
        var path = Bundle.main.path(forResource: LocalizationService.shared.language.rawValue, ofType: "lproj")
        
        var localizedString = String(format: localized(bundle: self.getBundle(path: path)), arguments: arguments)
        if localizedString == self {
            path = reqBundle.path(forResource: LocalizationService.shared.language.rawValue, ofType: "lproj")
            localizedString = String(format: localized(bundle: self.getBundle(path: path)), arguments: arguments)
        }
        
        return localizedString
    }
    
    private func getBundle(path: String?) -> Bundle {
        
        let bundle: Bundle
        if let path = path {
            bundle = Bundle(path: path) ?? .main
        } else {
            bundle = .main
        }
        
        return bundle
    }

    /// Localizes a string using self as key.
    ///
    /// - Parameters:
    ///   - bundle: the bundle where the Localizable.strings file lies.
    /// - Returns: localized string.
    private func localized(bundle: Bundle) -> String {
        return NSLocalizedString(self, tableName: nil, bundle: bundle, value: "", comment: "")
    }
}

import AppStorage

class LocalizationService {

    static let shared = LocalizationService()
    static let changedLanguage = Notification.Name("changedLanguage")

    private init() {}
    
    var language: Language {
        get {
            guard let languageString = UserDefaults.standard.string(forKey: "language") else {
                return .english
            }
            return Language(rawValue: languageString) ?? .english
        } set {
            if newValue != language {
                UserDefaults.standard.setValue(newValue.rawValue, forKey: "language")
                UserDefaults.standard.synchronize()
                NotificationCenter.default.post(name: LocalizationService.changedLanguage, object: nil)
            }
        }
    }
}
