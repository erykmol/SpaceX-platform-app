# SpaceX-platform-app
This application allows user to see the list of all of the SpaceXs lanuch platforms, and see the details of the specific platform, for example vechicles launched from it or location, be it as coordinates or a point on a map. 

## Getting started

You will need an IOS device on which the app will be launched, and a Mac or Macbook with an Xcode installed that supports Swift 5 to be able to build the app. Also, because the app has a pods dependecy installed, you will want to open the project using Scanner.xcworkspace.

## Setting the app for your region
By default, the ingredients retrived from the database are in English, and if you want to have them displayed in another language, only thing you will need to change is `product["ingredients_text_en"]` in  the `DetailsViewController` to for example `product["ingredients_text_pl"]` to have the ingredients in Polish language.

## Demo
![SpaceX platform app Demo](demo/SpaceX-app-demo.gif)
