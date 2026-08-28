# pushgenius-ionic

Standalone Capacitor plugin. Native projects wrap `pushgenius-ios` and `pushgenius-android`.

```ts
import { OneSignal } from "@pushgenius/ionic";

await OneSignal.setHost("https://api.pushgeni.us");
await OneSignal.initialize(APP_ID);
await OneSignal.Notifications.requestPermission();
await OneSignal.login("user-123");
await OneSignal.User.addTag("plan", "pro");
```

Publish to npm as `@pushgenius/ionic`, or depend on this git repo.
