package io.rebble.cobble.bluetooth

import android.bluetooth.BluetoothDevice

sealed class ConnectionState {
    object Disconnected : ConnectionState()
    class WaitingForBluetoothToEnable(val watch: PebbleBluetoothDevice?) : ConnectionState()
    class WaitingForReconnect(val watch: PebbleBluetoothDevice?) : ConnectionState()
    class Connecting(val watch: PebbleBluetoothDevice?) : ConnectionState()
    class Connected(val watch: PebbleBluetoothDevice) : ConnectionState()
}

val ConnectionState.watchOrNull: PebbleBluetoothDevice?
    get() {
        return when (this) {
            is ConnectionState.Connecting -> watch
            is ConnectionState.WaitingForReconnect -> watch
            is ConnectionState.Connected -> watch
            is ConnectionState.WaitingForBluetoothToEnable -> watch
            ConnectionState.Disconnected -> null
        }
    }