//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import Rswift
import UIKit

/// This `R` struct is generated and contains references to static resources.
struct R: Rswift.Validatable {
  fileprivate static let applicationLocale = hostingBundle.preferredLocalizations.first.flatMap(Locale.init) ?? Locale.current
  fileprivate static let hostingBundle = Bundle(for: R.Class.self)
  
  static func validate() throws {
    try intern.validate()
  }
  
  /// This `R.color` struct is generated, and contains static references to 0 colors.
  struct color {
    fileprivate init() {}
  }
  
  /// This `R.file` struct is generated, and contains static references to 2 files.
  struct file {
    /// Resource file `.gitignore`.
    static let gitignore = Rswift.FileResource(bundle: R.hostingBundle, name: ".gitignore", pathExtension: "")
    /// Resource file `GoogleService-Info.plist`.
    static let googleServiceInfoPlist = Rswift.FileResource(bundle: R.hostingBundle, name: "GoogleService-Info", pathExtension: "plist")
    
    /// `bundle.url(forResource: ".gitignore", withExtension: "")`
    static func gitignore(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.gitignore
      return fileResource.bundle.url(forResource: fileResource)
    }
    
    /// `bundle.url(forResource: "GoogleService-Info", withExtension: "plist")`
    static func googleServiceInfoPlist(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.googleServiceInfoPlist
      return fileResource.bundle.url(forResource: fileResource)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.font` struct is generated, and contains static references to 0 fonts.
  struct font {
    fileprivate init() {}
  }
  
  /// This `R.image` struct is generated, and contains static references to 10 images.
  struct image {
    /// Image `Calender`.
    static let calender = Rswift.ImageResource(bundle: R.hostingBundle, name: "Calender")
    /// Image `Close`.
    static let close = Rswift.ImageResource(bundle: R.hostingBundle, name: "Close")
    /// Image `Icon-App-60x60@3x (1)`.
    static let iconApp60x603x1 = Rswift.ImageResource(bundle: R.hostingBundle, name: "Icon-App-60x60@3x (1)")
    /// Image `Note`.
    static let note = Rswift.ImageResource(bundle: R.hostingBundle, name: "Note")
    /// Image `appicon`.
    static let appicon = Rswift.ImageResource(bundle: R.hostingBundle, name: "appicon")
    /// Image `fingerprint-with-crosshair-focus (1)`.
    static let fingerprintWithCrosshairFocus1 = Rswift.ImageResource(bundle: R.hostingBundle, name: "fingerprint-with-crosshair-focus (1)")
    /// Image `fingerprint-with-crosshair-focus (2)`.
    static let fingerprintWithCrosshairFocus2 = Rswift.ImageResource(bundle: R.hostingBundle, name: "fingerprint-with-crosshair-focus (2)")
    /// Image `icon`.
    static let icon = Rswift.ImageResource(bundle: R.hostingBundle, name: "icon")
    /// Image `icons8-Settings-20`.
    static let icons8Settings20 = Rswift.ImageResource(bundle: R.hostingBundle, name: "icons8-Settings-20")
    /// Image `icons8-Timeline-20`.
    static let icons8Timeline20 = Rswift.ImageResource(bundle: R.hostingBundle, name: "icons8-Timeline-20")
    
    /// `UIImage(named: "Calender", bundle: ..., traitCollection: ...)`
    static func calender(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.calender, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "Close", bundle: ..., traitCollection: ...)`
    static func close(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.close, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "Icon-App-60x60@3x (1)", bundle: ..., traitCollection: ...)`
    static func iconApp60x603x1(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.iconApp60x603x1, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "Note", bundle: ..., traitCollection: ...)`
    static func note(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.note, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "appicon", bundle: ..., traitCollection: ...)`
    static func appicon(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.appicon, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "fingerprint-with-crosshair-focus (1)", bundle: ..., traitCollection: ...)`
    static func fingerprintWithCrosshairFocus1(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.fingerprintWithCrosshairFocus1, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "fingerprint-with-crosshair-focus (2)", bundle: ..., traitCollection: ...)`
    static func fingerprintWithCrosshairFocus2(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.fingerprintWithCrosshairFocus2, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "icon", bundle: ..., traitCollection: ...)`
    static func icon(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.icon, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "icons8-Settings-20", bundle: ..., traitCollection: ...)`
    static func icons8Settings20(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.icons8Settings20, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "icons8-Timeline-20", bundle: ..., traitCollection: ...)`
    static func icons8Timeline20(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.icons8Timeline20, compatibleWith: traitCollection)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.nib` struct is generated, and contains static references to 0 nibs.
  struct nib {
    fileprivate init() {}
  }
  
  /// This `R.reuseIdentifier` struct is generated, and contains static references to 4 reuse identifiers.
  struct reuseIdentifier {
    /// Reuse identifier `colorCell`.
    static let colorCell: Rswift.ReuseIdentifier<ColorTableViewCell> = Rswift.ReuseIdentifier(identifier: "colorCell")
    /// Reuse identifier `dateCell`.
    static let dateCell: Rswift.ReuseIdentifier<DateTableViewCell> = Rswift.ReuseIdentifier(identifier: "dateCell")
    /// Reuse identifier `descriptionCell`.
    static let descriptionCell: Rswift.ReuseIdentifier<DescriptionTableViewCell> = Rswift.ReuseIdentifier(identifier: "descriptionCell")
    /// Reuse identifier `reuseIdentifier`.
    static let reuseIdentifier: Rswift.ReuseIdentifier<MomentsTableViewCell> = Rswift.ReuseIdentifier(identifier: "reuseIdentifier")
    
    fileprivate init() {}
  }
  
  /// This `R.segue` struct is generated, and contains static references to 0 view controllers.
  struct segue {
    fileprivate init() {}
  }
  
  /// This `R.storyboard` struct is generated, and contains static references to 2 storyboards.
  struct storyboard {
    /// Storyboard `LaunchScreen`.
    static let launchScreen = _R.storyboard.launchScreen()
    /// Storyboard `Main`.
    static let main = _R.storyboard.main()
    
    /// `UIStoryboard(name: "LaunchScreen", bundle: ...)`
    static func launchScreen(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.launchScreen)
    }
    
    /// `UIStoryboard(name: "Main", bundle: ...)`
    static func main(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.main)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.string` struct is generated, and contains static references to 0 localization tables.
  struct string {
    fileprivate init() {}
  }
  
  fileprivate struct intern: Rswift.Validatable {
    fileprivate static func validate() throws {
      try _R.validate()
    }
    
    fileprivate init() {}
  }
  
  fileprivate class Class {}
  
  fileprivate init() {}
}

struct _R: Rswift.Validatable {
  static func validate() throws {
    try storyboard.validate()
  }
  
  struct nib {
    fileprivate init() {}
  }
  
  struct storyboard: Rswift.Validatable {
    static func validate() throws {
      try main.validate()
      try launchScreen.validate()
    }
    
    struct launchScreen: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UIViewController
      
      let bundle = R.hostingBundle
      let name = "LaunchScreen"
      
      static func validate() throws {
        if UIKit.UIImage(named: "appicon") == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'appicon' is used in storyboard 'LaunchScreen', but couldn't be loaded.") }
      }
      
      fileprivate init() {}
    }
    
    struct main: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = MainNavigationController
      
      let bundle = R.hostingBundle
      let colorsViewController = StoryboardViewControllerResource<ColorsViewController>(identifier: "ColorsViewController")
      let createMomentsViewController = StoryboardViewControllerResource<CreateMomentsViewController>(identifier: "CreateMomentsViewController")
      let feedBackViewController = StoryboardViewControllerResource<FeedBackViewController>(identifier: "FeedBackViewController")
      let launchViewController = StoryboardViewControllerResource<LaunchViewController>(identifier: "LaunchViewController")
      let loadingViewController = StoryboardViewControllerResource<LoadingViewController>(identifier: "LoadingViewController")
      let mainNavigationController = StoryboardViewControllerResource<MainNavigationController>(identifier: "MainNavigationController")
      let momentsTimeLinePage = StoryboardViewControllerResource<MomentsTimeLinePage>(identifier: "MomentsTimeLinePage")
      let name = "Main"
      let newMomentsPageViewController = StoryboardViewControllerResource<NewMomentsPageViewController>(identifier: "NewMomentsPageViewController")
      let passcodeSettingsViewController = StoryboardViewControllerResource<PasscodeSettingsViewController>(identifier: "PasscodeSettingsViewController")
      let passcodeViewController = StoryboardViewControllerResource<PasscodeViewController>(identifier: "PasscodeViewController")
      let settingsPage = StoryboardViewControllerResource<SettingsPage>(identifier: "SettingsPage")
      let tabBar = StoryboardViewControllerResource<TabBar>(identifier: "TabBar")
      
      func colorsViewController(_: Void = ()) -> ColorsViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: colorsViewController)
      }
      
      func createMomentsViewController(_: Void = ()) -> CreateMomentsViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: createMomentsViewController)
      }
      
      func feedBackViewController(_: Void = ()) -> FeedBackViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: feedBackViewController)
      }
      
      func launchViewController(_: Void = ()) -> LaunchViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: launchViewController)
      }
      
      func loadingViewController(_: Void = ()) -> LoadingViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: loadingViewController)
      }
      
      func mainNavigationController(_: Void = ()) -> MainNavigationController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: mainNavigationController)
      }
      
      func momentsTimeLinePage(_: Void = ()) -> MomentsTimeLinePage? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: momentsTimeLinePage)
      }
      
      func newMomentsPageViewController(_: Void = ()) -> NewMomentsPageViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: newMomentsPageViewController)
      }
      
      func passcodeSettingsViewController(_: Void = ()) -> PasscodeSettingsViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: passcodeSettingsViewController)
      }
      
      func passcodeViewController(_: Void = ()) -> PasscodeViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: passcodeViewController)
      }
      
      func settingsPage(_: Void = ()) -> SettingsPage? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: settingsPage)
      }
      
      func tabBar(_: Void = ()) -> TabBar? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: tabBar)
      }
      
      static func validate() throws {
        if UIKit.UIImage(named: "Calender") == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'Calender' is used in storyboard 'Main', but couldn't be loaded.") }
        if UIKit.UIImage(named: "icon") == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'icon' is used in storyboard 'Main', but couldn't be loaded.") }
        if UIKit.UIImage(named: "Close") == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'Close' is used in storyboard 'Main', but couldn't be loaded.") }
        if UIKit.UIImage(named: "icons8-Timeline-20") == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'icons8-Timeline-20' is used in storyboard 'Main', but couldn't be loaded.") }
        if UIKit.UIImage(named: "fingerprint-with-crosshair-focus (2)") == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'fingerprint-with-crosshair-focus (2)' is used in storyboard 'Main', but couldn't be loaded.") }
        if UIKit.UIImage(named: "icons8-Settings-20") == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'icons8-Settings-20' is used in storyboard 'Main', but couldn't be loaded.") }
        if UIKit.UIImage(named: "Note") == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'Note' is used in storyboard 'Main', but couldn't be loaded.") }
        if _R.storyboard.main().launchViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'launchViewController' could not be loaded from storyboard 'Main' as 'LaunchViewController'.") }
        if _R.storyboard.main().passcodeSettingsViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'passcodeSettingsViewController' could not be loaded from storyboard 'Main' as 'PasscodeSettingsViewController'.") }
        if _R.storyboard.main().settingsPage() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'settingsPage' could not be loaded from storyboard 'Main' as 'SettingsPage'.") }
        if _R.storyboard.main().newMomentsPageViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'newMomentsPageViewController' could not be loaded from storyboard 'Main' as 'NewMomentsPageViewController'.") }
        if _R.storyboard.main().mainNavigationController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'mainNavigationController' could not be loaded from storyboard 'Main' as 'MainNavigationController'.") }
        if _R.storyboard.main().loadingViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'loadingViewController' could not be loaded from storyboard 'Main' as 'LoadingViewController'.") }
        if _R.storyboard.main().momentsTimeLinePage() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'momentsTimeLinePage' could not be loaded from storyboard 'Main' as 'MomentsTimeLinePage'.") }
        if _R.storyboard.main().tabBar() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'tabBar' could not be loaded from storyboard 'Main' as 'TabBar'.") }
        if _R.storyboard.main().passcodeViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'passcodeViewController' could not be loaded from storyboard 'Main' as 'PasscodeViewController'.") }
        if _R.storyboard.main().colorsViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'colorsViewController' could not be loaded from storyboard 'Main' as 'ColorsViewController'.") }
        if _R.storyboard.main().feedBackViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'feedBackViewController' could not be loaded from storyboard 'Main' as 'FeedBackViewController'.") }
        if _R.storyboard.main().createMomentsViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'createMomentsViewController' could not be loaded from storyboard 'Main' as 'CreateMomentsViewController'.") }
      }
      
      fileprivate init() {}
    }
    
    fileprivate init() {}
  }
  
  fileprivate init() {}
}