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
	* [Folders Segmentation]()
	* [Architecture]()

* [Services]()

* [Views]()

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