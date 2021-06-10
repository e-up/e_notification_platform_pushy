# Easy To Use Notification

## How To Use

### Android

#### 修改 AndroidManifest`android/app/src/main/AndroidManifest.xml`

##### 权限

```xml

<manifest>
    <!-- Pushy Permissions -->
    <uses-permission android:name="android.permission.INTERNET"/>
    <uses-permission android:name="android.permission.WAKE_LOCK"/>
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"/>
    <uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED"/>
    <!-- End Pushy Permissions -->
</manifest>
```

##### 服务

```xml

<application>
    <!-- Pushy Declarations -->

    <!-- Internal Notification Receiver -->
    <!-- Do not modify - internal BroadcastReceiver that sends notifications to your Flutter app -->
    <receiver android:name="me.pushy.sdk.flutter.internal.PushyInternalReceiver" android:exported="false">
        <intent-filter>
            <!-- Do not modify this -->
            <action android:name="pushy.me"/>
        </intent-filter>
    </receiver>

    <!-- Pushy Update Receiver -->
    <!-- Do not modify - internal BroadcastReceiver that restarts the listener service -->
    <receiver android:name="me.pushy.sdk.receivers.PushyUpdateReceiver" android:exported="false">
        <intent-filter>
            <action android:name="android.intent.action.MY_PACKAGE_REPLACED"/>
        </intent-filter>
    </receiver>

    <!-- Pushy Boot Receiver -->
    <!-- Do not modify - internal BroadcastReceiver that restarts the listener service -->
    <receiver android:name="me.pushy.sdk.receivers.PushyBootReceiver" android:exported="false">
        <intent-filter>
            <action android:name="android.intent.action.BOOT_COMPLETED"/>
        </intent-filter>
    </receiver>

    <!-- Pushy Socket Service -->
    <!-- Do not modify - internal service -->
    <service android:name="me.pushy.sdk.services.PushySocketService" android:stopWithTask="false"/>

    <!-- Pushy Job Service (added in Pushy SDK 1.0.35) -->
    <!-- Do not modify - internal service -->
    <service android:name="me.pushy.sdk.services.PushyJobService"
             android:permission="android.permission.BIND_JOB_SERVICE"
             android:stopWithTask="false"/>

    <!-- End Pushy Declarations -->
</application>
```