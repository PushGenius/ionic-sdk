package us.pushgeni.ionic;

import com.getcapacitor.JSArray;
import com.getcapacitor.JSObject;
import com.getcapacitor.Plugin;
import com.getcapacitor.PluginCall;
import com.getcapacitor.PluginMethod;
import com.getcapacitor.annotation.CapacitorPlugin;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import kotlin.Unit;
import org.json.JSONException;
import us.pushgeni.sdk.BigBrain;
import us.pushgeni.sdk.PushGenius;

/** Capacitor bridge over the vendored PushGenius Android SDK (us.pushgeni.sdk). */
@CapacitorPlugin(name = "PushGenius")
public class PushGeniusPlugin extends Plugin {
  @PluginMethod
  public void setHost(PluginCall call) {
    PushGenius.setHost(call.getString("url", ""));
    call.resolve();
  }

  @PluginMethod
  public void initialize(PluginCall call) {
    String appId = call.getString("appId");
    if (appId == null || appId.isEmpty()) {
      call.reject("appId is required");
      return;
    }
    BigBrain.initialize(appId);
    call.resolve();
  }

  @PluginMethod
  public void login(PluginCall call) {
    String externalId = call.getString("externalId");
    if (externalId == null || externalId.isEmpty()) {
      call.reject("externalId is required");
      return;
    }
    BigBrain.login(externalId);
    call.resolve();
  }

  @PluginMethod
  public void logout(PluginCall call) {
    BigBrain.logout();
    call.resolve();
  }

  @PluginMethod
  public void addTags(PluginCall call) {
    Map<String, String> tags = new HashMap<>();
    JSObject obj = call.getObject("tags", new JSObject());
    for (Iterator<String> keys = obj.keys(); keys.hasNext(); ) {
      String key = keys.next();
      tags.put(key, String.valueOf(obj.opt(key)));
    }
    BigBrain.getUser().addTags(tags);
    call.resolve();
  }

  @PluginMethod
  public void removeTags(PluginCall call) {
    JSArray array = call.getArray("keys", new JSArray());
    List<String> keys = new ArrayList<>();
    try {
      for (Object key : array.toList()) keys.add(String.valueOf(key));
    } catch (JSONException e) {
      call.reject("keys must be an array of strings");
      return;
    }
    BigBrain.getUser().removeTags(keys);
    call.resolve();
  }

  @PluginMethod
  public void addAlias(PluginCall call) {
    String label = call.getString("label");
    String id = call.getString("id");
    if (label == null || id == null) {
      call.reject("label and id are required");
      return;
    }
    BigBrain.getUser().addAlias(label, id);
    call.resolve();
  }

  @PluginMethod
  public void requestPermission(PluginCall call) {
    BigBrain.getNotifications().requestPermission(true, granted -> {
      JSObject ret = new JSObject();
      ret.put("granted", granted);
      call.resolve(ret);
      return Unit.INSTANCE;
    });
  }

  @PluginMethod
  public void optIn(PluginCall call) {
    BigBrain.getUser().getPushSubscription().optIn();
    call.resolve();
  }

  @PluginMethod
  public void optOut(PluginCall call) {
    BigBrain.getUser().getPushSubscription().optOut();
    call.resolve();
  }
}
