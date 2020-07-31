package com.example.study_buddy
import android.app.NotificationManager
import android.content.Context
import android.content.Intent
import androidx.annotation.NonNull
import android.os.Bundle
import android.os.PersistableBundle
import android.provider.Settings
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
class MainActivity: FlutterActivity() {
   private  lateinit var notificationManager : NotificationManager
    private val isAboveMarshmello: Boolean
        get() = android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.M

   private  val isNotificationPolicyAccessGranted: Boolean
        get() = notificationManager.isNotificationPolicyAccessGranted

    private val currentInterruptionFilter: Int
        get() = notificationManager.currentInterruptionFilter





    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)


        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "flutter_dnd").setMethodCallHandler{
            call , result ->
            notificationManager = getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
            if (!isAboveMarshmello) {
                result.error("ERROR: INCOMPATIBLE_ANDROID_VERSION", "This methods required android version above 23", null)

            }
            if(call.method == "isNotificationPolicyAccessGranted")
            {
                println("THis is being called")
                result.success(isNotificationPolicyAccessGranted)
            }
            else if (call.method == "gotoPolicySettings")
            {
                println("THis is being called 1")
                gotoPolicySettings()
                result.success(null)
            }
            else if (call.method == "setInterruptionFilter")
            {
                println("THis is being called 2")
                println("What is your name")

                val interruptionFilter = call.arguments<Int>()

                result.success(setInterruptionFilter(interruptionFilter))
            }
            else if (call.method == "getCurrentInterruptionFilter")
            {
                println("THis is being called 3")
                result.success(currentInterruptionFilter)
            }

        }

    }
    override fun onCreate(savedInstanceState: Bundle?, persistentState: PersistableBundle?) {

        super.onCreate(savedInstanceState, persistentState)
        notificationManager = getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager

        //notificationEventManager = CustomNotificationListenerService()
       // EventChannel(flutterEngine?.dartExecutor?.binaryMessenger, EVENT_CHANNEL ).setStreamHandler(notificationEventManager)

    }

    private fun gotoPolicySettings() {
        val intent = Intent(Settings.ACTION_NOTIFICATION_POLICY_ACCESS_SETTINGS)
        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
        context.startActivity(intent)
    }



  private  fun setInterruptionFilter(interruptionFilter: Int): Boolean {
        if (notificationManager.isNotificationPolicyAccessGranted) {

            notificationManager.setInterruptionFilter(interruptionFilter)

            return true
        }
        return false
    }




}

