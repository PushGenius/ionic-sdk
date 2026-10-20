# pushgenius-ionic

Standalone Capacitor plugin. Native projects wrap `pushgenius-ios` and `pushgenius-android`.

```ts
import { BigBrain } from "@pushgenius/ionic";

await BigBrain.setHost("https://api.pushgeni.us");
await BigBrain.initialize(APP_ID);
await BigBrain.Notifications.requestPermission();
await BigBrain.login("user-123");
await BigBrain.User.addTag("plan", "pro");
```

Publish to npm as `@pushgenius/ionic`, or depend on this git repo.
