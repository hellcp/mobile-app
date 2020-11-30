package io.rebble.cobble.bridges

import io.rebble.cobble.pigeons.Pigeons
import io.rebble.libpebblecommon.packets.blobdb.PushNotification
import io.rebble.libpebblecommon.services.notification.NotificationService
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.launch
import javax.inject.Inject

class Notifications @Inject constructor(
        bridgeLifecycleController: BridgeLifecycleController,
        private val notificationService: NotificationService,
        private val coroutineScope: CoroutineScope
) : FlutterBridge, Pigeons.NotificationsControl {
    init {
        bridgeLifecycleController.setupControl(Pigeons.NotificationsControl::setup, this)
    }

    override fun sendTestNotification() {
        coroutineScope.launch {
            notificationService.send(PushNotification(
                    "Test Notification"

            ))
        }
    }
}