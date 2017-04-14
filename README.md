# NXJumpToSettingTools
梳理一下截止iOS 10.3为止，由APP跳转到系统设置、隐私权限等方式的变化，并整理抽象出统一的工具类。

## iOS2推出的openURL

>`- (BOOL)openURL:(NSURL*)url`

是苹果在iOS 2时推出的用于跳出APP，访问app以外的一些操作，比如用Safari打开一个网页、跳转到App Store评分、打电话、发短信、设置隐私权限以及APP的应用间跳转，使用的方法如下：

>`NSURL *url = [NSURL URLWithString:@"your schem or url"]; 
[[UIApplication sharedApplication] openURL:url]; `

## iOS8新推出的跳转本应用的设置

iOS 8时，苹果推出了 

>`UIKIT_EXTERN NSString *const UIApplicationOpenSettingsURLString NS_AVAILABLE_IOS(8_0);`

设置该URL，则允许用户直接跳转到本app的相关设置，使用发放如下：
需要在 URL Types 添加 一个叫 prefs 的 URL Schemes

>`NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];`

另外，iOS系统版本 >= iOS8 ，**支持跳转到第三方应用的设置界面中**
使用prefs:root=bundleID ,bundleID是你第三方应用工程的唯一ID
局限性：只支持iOS8,iOS9系统,在iOS10系统上，不会跳转。 在iOS7系统上，仅仅只是跳转到设置应用，不推荐使用。

## iOS 9私有化canOpenURL:API

从iOS 9开始，苹果禁止开发者通过该API查询手机上是否安装了某app

## iOS 10 保护隐私政策更进一步

从iOS 10开始，所有app外的权限访问都必须添加到系统info.plist的白名单中。而且，弃用了openURL的API，新推出

>`openURL:options:completionHandler:`

用于替代旧的API。

## 备忘

由于真机设备问题以及Xcode8不支持编译iOS7系统的真机，demo未对所有型号设备和系统版本做测试（后续慢慢补上）

