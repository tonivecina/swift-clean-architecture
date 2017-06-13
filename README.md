# Swift clean architecture

This guide will show how to build a Xcode project with a clean architecture with Swift 3.1. It's very important we have a project with folders and subfolders ordered by services, protocols and swift functionalities.

## Table of contents

* [Folders](#folders)
	* [Assets](#assets)
	* [Entities](#entities)
	* [Modules](#modules)
	* [Patterns](#services)
	* [Services](#viewcontrollers)
	* [Views](#views)

* [Entities]()
	* [Local](#local-entity)
	* [Coredata](#coredata-entity)
	* [Api](#api-entity)

* [Modules]()
	* [Module file](#modulefile)
	* [View](#view)
	* [Routes](#routes)
	* [Data Manager](#data-manager)
	* [Processor](#processor)

* [Services](#services)

* [Views](#views)

## Folders

The folders and subfolders must be ordered alphabetically for a fast localization. The valid folders will show hereunder.

### Assets

The Assets folder contains files like Gps files, Localizable files, font files... If exists multiple files for each type, you must use subfolders.

![](https://raw.githubusercontent.com/tonivecina/swift-clean-architecture/master/images/screen_folder_assets.png)

### Entities

Models and entities must be contained in this folder. This folder must contains subfolders to categorize different entities in; Local, Coredata and Api.

![](https://raw.githubusercontent.com/tonivecina/swift-clean-architecture/master/images/screen_folder_entities.png)

### Modules

Each viewController will be considered as view of a module. The modules contains logical, use cases, view maintenance, etc. For each module, a folder must be created.

![](https://raw.githubusercontent.com/tonivecina/swift-clean-architecture/master/images/screen_folder_modules.png)

### Patterns

It's possible that our code needs some patterns for Strings, Integers, Booleans, etc. This patterns will be global extensions and its will be contained here. For each extension type, a file.

![](https://raw.githubusercontent.com/tonivecina/swift-clean-architecture/master/images/screen_folder_patterns.png)

### Services

When your project needs services like location, store data, Siri communication... A normal use would be to implement those frameworks in viewControllers that needs it, but... if various modules needs the location service, would you import CoreLocation in both? If your answer is affirmative, stop reading!

The option of this architecture is to create only a service, unique framework import and serve this service to views. This services will be contained in Services folder.

![](https://raw.githubusercontent.com/tonivecina/swift-clean-architecture/master/images/screen_folder_services.png)

### Views

For a beauty design, it's possible that you needs create custom subclass for UILabels, UITextFields, UIViews with custom content... All this files will be contained in Views folder. We will create subfolders for each object type.

![](https://raw.githubusercontent.com/tonivecina/swift-clean-architecture/master/images/screen_folder_views.png)

## Entities

The entities are organized in Local, CoreData and API.

### Local entity

This entities contains UserDefaults references for example if you wish store some credentials or parameters in UserDefault, this is your entity type.

This is an example for Credentials entity:

```Swift
/// This entity set or get user credentials from User Defaults. Email,
/// password hash or token are contained here.
///
/// - Author: Toni Vecina

public struct Credentials {

    fileprivate let userDefaults = UserDefaults.standard

    public var email: String? {
        return userDefaults.string(forKey: Keys.email)
    }

    public var passwordHash: String? {
        return userDefaults.string(forKey: Keys.password)
    }

    public var isLogged: Bool {
        return email != nil && passwordHash != nil
    }
}

extension Credentials {

    /// This enum contains the keys used to get values from User Defaults under private.

    fileprivate enum Keys {
        static let email:    String = "emailKey"
        static let password: String = "passwordKey"
    }
}

extension Credentials {

    /// This method set email and password hash in User Defaults.
    ///
    /// - Parameters:
    ///     - email: This string define user email.
    ///     - passwordHash: This string define user password hash.
    ///
    /// - Returns: Bool from User Default Synchronize

    public func set(email: String, passwordHash: String) -> Bool {
        userDefaults.set(email, forKey: Keys.email)
        userDefaults.set(passwordHash, forKey: Keys.password)

        return userDefaults.synchronize()
    }

    /// This method delete all values in User Defaults associated to user credentials as email, password
    /// and token.
    ///
    /// - Returns: Bool from User Default Synchronize

    public func delete() -> Bool {
        userDefaults.removeObject(forKey: Keys.email)
        userDefaults.removeObject(forKey: Keys.password)

        return userDefaults.synchronize()
    }

}
```

### CoreData entity

If your project needs store local data with CoreData, the entity that you need to refer to CoreData it's in this category.

This an example of an entity Note stored in CoreData:

```Swift
@objc(Note)
public class Note: NSManagedObject {
    @NSManaged public var title: String?
    @NSManaged public var content: String?
    @NSManaged public var createdAt: Date
    @NSManaged public var modifiedAt: Date
}

extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }
}
```

### API entity

If the user has its notes stored in a server, this notes are necessary to download it. For that case, the entity to use is API entity.

Please, name files for this entities as: [entityname]**Api**

This is a simple struct for Note API entity:

```Swift
struct NoteApi {
    public var title: String?
    public var content: String?
    public var createdAt: Date
    public var modifiedAt: Date
}

extension NoteApi {

    /// Methods and properties will be here
}
```

Remember, Entity folder should be:

![](https://raw.githubusercontent.com/tonivecina/swift-clean-architecture/master/images/screen_folder_entities.png)

## Modules

There are some architectures defined to use under iOS/OSX projects like MVC, MVP, MVVM or VIPER. If you have experience with this architectures, the module architecture will be familiar for you.

The module is segmented in different elements:

### ModuleFile

This class is responsible to configure principal elements of module and contains static parameters used by other clases inside of module. In addition, this class will return its view element.

This example is the HomeModule file:

```Swift
class HomeModule {

    class var view: HomeViewController {
        let view = HomeViewController(nibName: "HomeViewController", bundle: nil)
        view.processor = HomeProcessor(view: view)

        return view
    }
}
```

... or NoteModule file:

```Swift
class NoteModule {

    class func view(note: Note?, editingDelegate: NoteEditingProcess) -> NoteViewController {
        let view = NoteViewController(nibName: "NoteViewController", bundle: nil)
        view.note = note
        view.processor = NoteProcessor(view: view, noteEditingDelegate: editingDelegate)
        
        return view
    }


    enum Placeholder {
        static let title = "Insert title here"
        static let content = "Insert description here"
    }
}
```

### View

It's the viewController of module. All UI layer is contained here. It's very important the code be segmented by protocols in extensions. For example, if the view contains UITextFields and UITableView this view will needs to use protocols like UITextFieldDelegate or UITableViewDataSource and UITableViewDelegate. This protocols must be segmented in extension files.

If the viewController contains IBActions, you must create a new extension file.

![](https://raw.githubusercontent.com/tonivecina/swift-clean-architecture/master/images/screen_folder_modules_view.png)

### Routes

All navigations and connections with other modules are defined here. Look at this example:

```Swift
class HomeRoutes {

    weak var view: HomeViewController?

    init(view: HomeViewController?) {
        self.view = view
    }
}

extension HomeRoutes {

    func presentNoteModule(note: Note?, delegate: NoteEditingProcess) {
        let noteView = NoteModule.view(note: note, editingDelegate: delegate)
        view?.present(noteView, animated: true, completion: nil)
    }
    
}
```

### Data Manager

This is the final element of architecture paradigm. It's responsible to manage entities and offer it to process class.

```Swift
class HomeDataManager {
    lazy fileprivate var notes = [Note]()
    lazy fileprivate var noteCoreDataStorage = NoteCoreDataStorage()
}

extension HomeDataManager {

    func getNotes() -> [Note] {
        do {
            notes = try noteCoreDataStorage.getAll()

        } catch {
            notes = []
        }

        return notes
    }

}
```

### Observers

### Processor

This class is the core of module to connect all elements with the view. If the process contains long logical, it's recommendable use extension files too.

If your process file have implemented some protocols, please... you must create extensions files.

All elements inside of this architecture paradigm will be initialized and managed here, this mean the process class is the core of the module.

This is simple example for the process of HomeModule:

```Swift
class HomeProcessor {

    weak var view: HomeViewController?
    lazy fileprivate var dataManager = HomeDataManager()

    var routes: HomeRoutes!

    init(view: HomeViewController?) {
        self.view = view
        self.routes = HomeRoutes(view: self.view)
    }

}

extension HomeProcessor {

    func viewDidLoad() {
        view?.notes = dataManager.getNotes()
        view?.reloadData()
    }
    
}
```

This architecture paradigm is:

![](https://raw.githubusercontent.com/tonivecina/swift-clean-architecture/master/images/screen_modules_paradigm.png)

## Services

If your project needs location services, network services... Please, not duplicate code. We create shared services for views that need it.

This example is a location service:

```Swift
protocol LocationDelegate: class {
    func onLocationUnavailable()
    func onLocationDenied()
    func onLocationSuccess(_ location: CLLocation)
}

class LocationService: NSObject {

    weak fileprivate var delegate: LocationDelegate!
    fileprivate var locationManager: CLLocationManager?

    init(delegate: LocationDelegate) {
        super.init()
        self.delegate = delegate
    }
}

extension LocationService: CLLocationManagerDelegate {

    func get() {
        Log.set(message: "Trying to get location...")

        locationManager = CLLocationManager()
        locationManager?.delegate = self

        let authorizationStatus = CLLocationManager.authorizationStatus()
        Log.set(message: "Location Authorization: \(authorizationStatus)")

        switch authorizationStatus {
        case .authorizedWhenInUse,
             .notDetermined:
            locationManager?.requestWhenInUseAuthorization()

            if #available(iOS 9.0, *) {
                return locationManager!.requestLocation()

            } else {
                return locationManager!.startUpdatingLocation()
            }

        case .denied:
            return delegate.onLocationDenied()

        default:
            return delegate.onLocationUnavailable()
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        delegate.onLocationUnavailable()
        return Log.set(message: String(describing: error))
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        manager.stopUpdatingLocation()

        guard locations.count > 0, let location = locations.first else {
            delegate.onLocationUnavailable()

            return Log.set(message: "ERROR: Location not found")
        }

        locationManager = nil
        delegate.onLocationSuccess(location)

        return Log.set(message: "SUCCESS: Location found.\n\(location.debugDescription)")
    }
}
```

## Views

For a good design is necessary that we have custom views like UITexts, UIButtons, etc. This custom classes must be localized here.

This is a simple example for an UITableViewCell:

```Swift
class IERequestCell: UITableViewCell {

    @IBOutlet fileprivate weak var nameLabel: UILabel!
    @IBOutlet fileprivate weak var dateLabel: UILabel!
    @IBOutlet fileprivate weak var descriptionLabel: UILabel!
    @IBOutlet fileprivate weak var badgeLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        nameLabel.text = nil
        nameLabel.numberOfLines = 1

        dateLabel.text = nil
        dateLabel.numberOfLines = 1

        descriptionLabel.text = nil

        badgeLabel.text = String(0)
        badgeLabel.numberOfLines = 1
        badgeLabel.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectionStyle = .none
    }
}

extension IERequestCell {

    func bind(request: RequestItem) {
        nameLabel.text = request.title

        if let date = request.date {
            let text = String.dateStringWithFormat(date, format: "dd MMM yyyy")
            dateLabel.text = text.uppercased()
        }

        descriptionLabel.text = request.subtitle
        badgeLabel.text = String(request.unreadCount)
        badgeLabel.isHidden = request.unreadCount == 0
    }
}
```