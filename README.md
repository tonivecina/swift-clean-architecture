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
	* [Local]()
	* [Coredata]()
	* [Api]()

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