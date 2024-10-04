adb devices

adb shell pm list users

adb shell pm list packages --user 0 

adb shell pm uninstall --user 0 com.microsoft.skydrive
adb shell pm uninstall --user 0 com.microsoft.appmanager
adb shell pm uninstall --user 0 com.facebook.services
adb shell pm uninstall --user 0 com.facebook.appmanager
adb shell pm uninstall --user 0 com.facebook.system
