# @pushgenius/ionic

PushGenius push notifications for Capacitor apps (iOS and Android). Requires Capacitor 6+ and iOS 15+. Works with both Swift Package Manager and CocoaPods projects.

## Install

```sh
npm install @pushgenius/ionic
npx cap sync
```

- **iOS:** in Xcode, enable the Push Notifications capability and Background Modes → Remote notifications. The SDK picks up the APNs device token automatically.
- **Android:** add your `google-services.json` to `android/app` and apply the `com.google.gms.google-services` Gradle plugin.

## Usage

```ts
import { BigBrain } from "@pushgenius/ionic";

await BigBrain.setHost("https://api.pushgeni.us");
await BigBrain.initialize(APP_ID);
await BigBrain.Notifications.requestPermission();
await BigBrain.login("user-123");
await BigBrain.User.addTag("plan", "pro");
```

## Count notifications received in the background (iOS)

iOS doesn't run your app when a notification arrives in the background, so by default the SDK can only report notifications that arrive while the app is open. To count every notification, add a Notification Service Extension. iOS runs it for each notification, even when your app is closed.

1. In Xcode, choose **File → New → Target → Notification Service Extension** and name it `NotificationService`. Set its minimum iOS version to match your app's (iOS 15 or later).
2. Choose **File → Add Package Dependencies**, enter `https://github.com/PushGenius/ios-sdk.git`, and add the **PushGeniusNotificationService** library to the extension target only. This works alongside CocoaPods.
3. Replace the contents of the extension's `NotificationService.swift` with:

   ```swift
   import PushGeniusNotificationService

   class NotificationService: BigBrainNotificationService {}
   ```

If you call `setHost`, also override the host in the extension: `override var host: String { "https://your-host" }`.


## Developing

The native iOS and Android SDK sources are vendored into `ios/Sources/PushGeniusIonic/Core` and `android/src/main/java/us/pushgeni/sdk`. After changing either native SDK, run `npm run sync-native` (expects the `ios` and `android` SDK repos next to this one) and commit the result. Don't edit the vendored copies directly.

The Swift package and pod are named `PushgeniusIonic` because the Capacitor CLI derives that name from the npm package name; keep them in sync if the package is ever renamed.

## Publishing

```sh
npm version <patch|minor|major>
npm publish
```

`prepack` builds `dist/` from `src/` first.
