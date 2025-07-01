# AppStance SDK for Apple Ads attribution

# AppStance SDK

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/AppStanceHQ/ios-appstance-sdk/blob/main/LICENSE)
[![SPM Compatible](https://img.shields.io/badge/SPM-compatible-brightgreen.svg)](https://swift.org/package-manager/)
[![Version](https://img.shields.io/badge/version-0.7.5-blue.svg)](https://github.com/AppStanceHQ/ios-appstance-sdk/releases)

## Overview
AppStance SDK is a plug-and-play iOS attribution and analytics framework that provides comprehensive tracking for Apple Ads (Apple Search Ads) attribution, revenue events, and custom analytics. Designed for ease of use with intelligent defaults, the SDK offers flexible customization options to meet specific app requirements. The SDK supports iOS and iPadOS platforms.

**Privacy-First Design**: AppStance SDK is built with privacy at its core - no personal data is collected or stored, ensuring full compliance with privacy regulations while providing accurate attribution insights.

## System Requirements
- **iOS 13.0+**
- **Xcode 14.0+**
- **Swift 5.7+**


## Installation
Add the AppStance SDK to your project using your preferred method (SPM, CocoaPods, or manual integration).

### Swift Package Manager (Recommended)
Add the AppStance SDK via Swift Package Manager by including the following dependency in your : `Package.swift`

```
dependencies: [
    .package(url: "https://github.com/AppStanceHQ/ios-appstance-sdk.git", from: "0.7.5")
]
```

**Or add directly through Xcode:**
1. Open your project in Xcode
2. Navigate to **File > Add Package Dependencies**
3. Enter the repository URL: `https://github.com/AppStanceHQ/ios-appstance-sdk.git`
4. Choose the version and click **Add Package**

### CocoaPods
Add the following line to your `Podfile`:
``` 
pod 'AppStanceSDK', '~> 0.7.5'
```
Then run:
``` 
pod install
```



## Core Functions
### 1. Initialize
The `initialize` method sets up the AppStance SDK with your API key and configuration options. This must be called before using any other SDK functionality.

**Important**: If your app displays the App Tracking Transparency (ATT) prompt, call this method **after** you receive the ATT prompt result to ensure accurate attribution and analytics.

#### Example Usage


``` swift
// Basic initialization
AppStance.initialize(apiKey: "your-api-key-here")

// Advanced initialization with custom options
AppStance.initialize(
    apiKey: "your-api-key-here",
    enableStoreKitPurchaseMonitor: true,
    optOut: false,
    customUserID: "user123",
    debugLogs: true
)
```

#### Parameters
- **apiKey** (required): Your AppStance API key
- **enableStoreKitPurchaseMonitor**: Automatically monitor StoreKit purchases (default: `true`)
- **optOut**: Disable all tracking for a device (default: `false`)
- **customUserID**: Optional custom user identifier
- **debugLogs**: Enable verbose debug logging (default: `false`)

#### Notes
- This method is safe to call multiple times but will only initialize once per app launch
- Typically called in your app's launch sequence (e.g., `application(_:didFinishLaunchingWithOptions:)`)


### 2. Log Custom Revenue Event
The `logCustomRevenueEvent` method tracks external revenue events that occur outside of the App Store (e.g., web purchases, subscriptions).

#### Example Usage
``` swift
// Track a premium subscription purchase
AppStance.logCustomRevenueEvent(
    eventName: "premium_subscription",
    amount: 9.99,
    currency: "USD"
)

// Track a one-time purchase
AppStance.logCustomRevenueEvent(
    eventName: "pro_features_unlock",
    amount: 4.99,
    currency: "USD"
)

// Track international purchase
AppStance.logCustomRevenueEvent(
    eventName: "refund",
    amount: -12.50,
    currency: "EUR"
)
```

#### Parameters
- **eventName** (required): Name of the revenue event
- **amount** (required): Revenue amount as a Double
- **currency** (required): Currency code (e.g., "USD", "EUR")


#### Important Notes
- **Do NOT use this for App Store purchases** - those are automatically tracked by the SDK
- Only use for external revenue sources (web purchases, direct payments, etc.)
- Requires the SDK to be initialized first

### 3. Log Non-Revenue Event Once
The `logNonRevenueEventOnce` method tracks custom events that should only be recorded once per device per event name.


#### Parameters
- **eventName** (required): Name of the non-revenue event to track

#### Example Usage
``` swift
// Track tutorial completion (only once per device)
AppStance.logNonRevenueEventOnce(eventName: "tutorial_completed")

// Track first app launch milestone
AppStance.logNonRevenueEventOnce(eventName: "first_session_completed")

// Track feature discovery
AppStance.logNonRevenueEventOnce(eventName: "discovered_premium_features")

// Track user engagement milestone
AppStance.logNonRevenueEventOnce(eventName: "reached_level_10")
```
#### Important Notes
- Events are tracked only **once per device** - subsequent calls with the same event name are ignored
- Perfect for milestone events, tutorial completions, or feature discoveries
- Requires the SDK to be initialized first

## Complete Integration Example
``` swift
import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Initialize AppStance SDK after ATT prompt (if applicable)
        AppStance.initialize(
            apiKey: "your-api-key-here",
            enableStoreKitPurchaseMonitor: true,
            debugLogs: false
        )
        
        return true
    }
}

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Track tutorial completion once per device
        AppStance.logNonRevenueEventOnce(eventName: "tutorial_completed")
    }
    
    @IBAction func purchasePremiumWeb(_ sender: UIButton) {
        // Track external web purchase
        AppStance.logCustomRevenueEvent(
            eventName: "web_premium_purchase",
            amount: 19.99,
            currency: "USD"
        )
    }
}
```
## Privacy & ATT Integration
If your app uses App Tracking Transparency (ATT), ensure you call `initialize` after receiving the ATT authorization status:
``` swift
import AppTrackingTransparency

func requestTrackingPermission() {
    ATTrackingManager.requestTrackingAuthorization { status in
        DispatchQueue.main.async {
            // Initialize AppStance after ATT response
            AppStance.initialize(apiKey: "your-api-key-here")
        }
    }
}
```
This ensures accurate attribution data collection based on the user's tracking preferences.

Support: Contact us at appstancehq@gmail.com