package us.pushgeni.ionic;

import com.getcapacitor.Plugin;
import com.getcapacitor.PluginCall;
import com.getcapacitor.PluginMethod;
import com.getcapacitor.annotation.CapacitorPlugin;
import us.pushgeni.sdk.OneSignal;
import us.pushgeni.sdk.PushGenius;
import java.util.HashMap;
import java.util.Map;

@CapacitorPlugin(name = "PushGenius")
public class PushGeniusPlugin extends Plugin {
  @PluginMethod
  public void setHost(PluginCall call) {
    PushGenius.setHost(call.getString("url", ""));
    call.resolve();
  }

  @PluginMethod
  public void initialize(PluginCall call) {
    OneSignal.initialize(call.getString("appId", ""));
    call.resolve();
  }

  @PluginMethod
  public void login(PluginCall call) {
    OneSignal.login(call.getString("externalId", ""));
    call.resolve();
  }

  @PluginMethod
  public void logout(PluginCall call) {
    OneSignal.logout();
    call.resolve();
  }

  @PluginMethod
  public void addTags(PluginCall call) {
    Map<String, String> tags = new HashMap<>();
    if (call.getObject("tags") != null) {
      var obj = call.getObject("tags");
      for (String k : obj.keySet()) tags.put(k, obj.getString(k));
    }
    OneSignal.getUser().addTags(tags);
    call.resolve();
  }

  @PluginMethod
  public void requestPermission(PluginCall call) {
    OneSignal.getNotifications().requestPermission(true, granted -> {
      var ret = new com.getcapacitor.JSObject();
      ret.put("granted", granted);
      call.resolve(ret);
    });
  }
}
