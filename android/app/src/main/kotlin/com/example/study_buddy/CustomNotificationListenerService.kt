package com.example.study_buddy


import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.os.Bundle
import android.service.notification.NotificationListenerService
import android.service.notification.StatusBarNotification
import android.util.Log
import io.flutter.plugin.common.EventChannel


  class CustomNotificationListenerService :EventChannel.StreamHandler,NotificationListenerService()  {

    private var commandFromUIReceiver: CommandFromUIReceiver? = null
      var _eventSink: EventChannel.EventSink? = null

     override fun onCancel(arguments: Any?) {
         TODO("not implemented")
         //To change body of created functions use File | Settings | File Templates.
         Log.i(TAG, "just listen");
     }

     override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
         TODO("not implemented")
         //To change body of created functions use File | Settings | File Templates.
         Log.i(TAG, "just listen");

     }

//    override fun onCreate() {
//        super.onCreate()
//
//        // Register broadcast from UI
//        commandFromUIReceiver = CommandFromUIReceiver()
//        val filter = IntentFilter()
//        filter.addAction(READ_COMMAND_ACTION)
//        registerReceiver(commandFromUIReceiver, filter)
//    }


    /**
     * New Notn Added Callback
     */
    override fun onNotificationPosted(newNotification: StatusBarNotification) {
        val extra : Bundle= newNotification.notification.extras


            val message = extra.getCharSequence("android.text").toString()
            val  senderName =  extra.getCharSequence("android.title").toString()


//
//        Log.i(
//                TAG,"\n" +
//         newNotification.id.toString()
//        )
//        Log.i(
//                TAG,
//                newNotification.packageName
//        )
//        Log.i(
//                TAG,
//                senderName
//        )
//
//        Log.i(
//                TAG,
//                message
//        )

        //sendResultOnUI("onNotificationPosted :" + newNotification.packageName + "\n")
    }

    /**
     * Notn Removed callback
     */
    override fun onNotificationRemoved(removedNotification: StatusBarNotification) {
//        Log.i(
//                TAG,
//                "-------- onNotificationRemoved() :" + "ID :" + removedNotification.id + "\t" + removedNotification.notification.tickerText + "\t" + removedNotification.packageName
//        )
       // sendResultOnUI("onNotificationRemoved: " + removedNotification.packageName + "\n")
    }


    internal inner class CommandFromUIReceiver : BroadcastReceiver() {

        override fun onReceive(context: Context, intent: Intent) {
            if (intent.getStringExtra(COMMAND_KEY) == CLEAR_NOTIFICATIONS)
            // remove Notns
                cancelAllNotifications()
//            else if (intent.getStringExtra(COMMAND_KEY) == GET_ACTIVE_NOTIFICATIONS){
//                //fetchCurrentNotifications()
//            }



        }
    }


    /**
     * Fetch list of Active Notns
     */
//    private fun fetchCurrentNotifications() {
//       // sendResultOnUI("===== Notification List START ====")
//
//        val activeNotnCount = this@CustomNotificationListenerService.activeNotifications.size
//
//        if (activeNotnCount > 0) {
//            for (count in 0..activeNotnCount) {
//               // val sbn = this@CustomNotificationListenerService.activeNotifications[count]
//              //  sendResultOnUI("#" + count.toString() + " Package: " + sbn.packageName + "\n")
//            }
//        } else {
//            //sendResultOnUI("No active Notn found")
//        }
//
//       // sendResultOnUI("===== Notification List END====")
//    }





    override fun onDestroy() {
        super.onDestroy()
        unregisterReceiver(commandFromUIReceiver)
    }

    companion object {


        const val TAG = "NotificationListener"



        const val READ_COMMAND_ACTION = "ACTION_READ_COMMAND"



        //Actions sent from UI
        const val COMMAND_KEY = "READ_COMMAND"
        const val CLEAR_NOTIFICATIONS = "clearall"
       // const val GET_ACTIVE_NOTIFICATIONS = "list"


    }
}