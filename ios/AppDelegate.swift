/**
 * Copyright (c) 2015-present, Facebook, Inc.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the root directory of this source tree. An additional grant
 * of patent rights can be found in the PATENTS file in the same directory.
 */

import React
import UIKit

#if FB_SONARKIT_ENABLED
private func InitializeFlipper(_ application: UIApplication?) {
    let client = FlipperClient.shared()
    let layoutDescriptorMapper = SKDescriptorMapper()
    client?.add(FlipperKitLayoutPlugin(rootNode: application, with: layoutDescriptorMapper))
    client?.add(FKUserDefaultsPlugin(suiteName: nil))
    client?.add(FlipperKitReactPlugin())
    client?.add(FlipperKitNetworkPlugin(networkAdapter: SKIOSNetworkAdapter()))
    client?.start()
}
#endif

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, RCTBridgeDelegate {
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    #if FB_SONARKIT_ENABLED
        InitializeFlipper(application)
    #endif
    
    let bridge = RCTBridge(delegate: self, launchOptions: launchOptions)
    ReactNativeNavigation.bootstrap(with: bridge)
    
    return true
  }
  
  func sourceURL(for bridge: RCTBridge?) -> URL? {
      #if DEBUG
      return RCTBundleURLProvider.sharedSettings().jsBundleURL(forBundleRoot: "index", fallbackResource: nil)
      #else
      return Bundle.main.url(forResource: "main", withExtension: "jsbundle")
      #endif
  }

  func extraModules(for bridge: RCTBridge?) -> [RCTBridgeModule?]? {
      return ReactNativeNavigation.extraModules(for: bridge)
  }
}
