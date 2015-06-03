#import "SnapshotHelper.js"

var target = UIATarget.localTarget();
var app = target.frontMostApp();
var window = app.mainWindow();

// Setting to initial orientation (not necessary unless taking screenshots in multiple orientations)

target.delay(2)

captureLocalizedScreenshot("1-MainScreen")

target.frontMostApp().mainWindow().buttons()[2].tap();

captureLocalizedScreenshot("1-AboutScreen")

target.frontMostApp().mainWindow().staticTexts()["- Time increase per point 5.0 "].tapWithOptions({tapOffset:{x:0.97, y:0.93}});
target.frontMostApp().mainWindow().tableViews()[0].tapWithOptions({tapOffset:{x:0.47, y:0.65}});

captureLocalizedScreenshot("1-SecondScreen")

target.frontMostApp().mainWindow().tableViews()[0].tapWithOptions({tapOffset:{x:0.48, y:0.39}});
target.frontMostApp().mainWindow().buttons()["Add"].tap();

captureLocalizedScreenshot("1-LastScreen")