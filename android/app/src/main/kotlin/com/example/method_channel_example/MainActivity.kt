package com.example.method_channel_example

import android.content.Context
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel


class MainActivity(context: Context?) : FlutterActivity() {
    private val channel = "flutter_channel"

    protected lateinit var flutterChannel: MethodChannel


    constructor():this(null)

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        flutterChannel= MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            channel
        )
        flutterChannel.setMethodCallHandler { call, result ->
            when (call.method) {
                "functionFromKotlin" -> {
                    val message = messageFromKotlin()
                    result.success(message)
                }
                "moveToBackground" -> {
                    moveTaskToBack(true)
                }
            }
        }
    }

    private fun messageFromKotlin(): String {
        val data: String = "Hello from kotlin"
        return data
    }

    override fun onBackPressed() {
        flutterChannel.invokeMethod("BackBtn", "abc")
    }

}
