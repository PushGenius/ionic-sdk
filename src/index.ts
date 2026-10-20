import { registerPlugin } from "@capacitor/core";

type Native = {
  setHost(opts: { url: string }): Promise<void>;
  initialize(opts: { appId: string }): Promise<void>;
  login(opts: { externalId: string }): Promise<void>;
  logout(): Promise<void>;
  addTags(opts: { tags: Record<string, string> }): Promise<void>;
  removeTags(opts: { keys: string[] }): Promise<void>;
  addAlias(opts: { label: string; id: string }): Promise<void>;
  requestPermission(): Promise<{ granted: boolean }>;
  optIn(): Promise<void>;
  optOut(): Promise<void>;
};

const native = registerPlugin<Native>("PushGenius");

class PushSubscription {
  optIn() {
    return native.optIn();
  }
  optOut() {
    return native.optOut();
  }
}

class UserNamespace {
  pushSubscription = new PushSubscription();
  addTag(key: string, value: string) {
    return this.addTags({ [key]: value });
  }
  addTags(tags: Record<string, string>) {
    return native.addTags({ tags });
  }
  removeTag(key: string) {
    return this.removeTags([key]);
  }
  removeTags(keys: string[]) {
    return native.removeTags({ keys });
  }
  addAlias(label: string, id: string) {
    return native.addAlias({ label, id });
  }
}

class NotificationsNamespace {
  async requestPermission(_fallback = true) {
    const { granted } = await native.requestPermission();
    return granted;
  }
}

export const BigBrain = {
  User: new UserNamespace(),
  Notifications: new NotificationsNamespace(),
  setHost: (url: string) => native.setHost({ url }),
  initialize: (appId: string) => native.initialize({ appId }),
  login: (externalId: string) => native.login({ externalId }),
  logout: () => native.logout(),
};

export const PushGenius = BigBrain;
export default BigBrain;
