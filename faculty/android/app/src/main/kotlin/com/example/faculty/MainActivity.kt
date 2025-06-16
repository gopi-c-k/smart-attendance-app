package com.example.faculty


import android.content.Context
import android.net.nsd.NsdManager
import android.net.nsd.NsdServiceInfo
import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

class MainActivity : FlutterActivity() {
    private lateinit var nsdManager: NsdManager
    private lateinit var registrationListener: NsdManager.RegistrationListener
    private var serviceName: String? = null
    private var servicePort: Int = 0

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        nsdManager = getSystemService(Context.NSD_SERVICE) as NsdManager

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "nsd_service").setMethodCallHandler { call, result ->
            when (call.method) {
                "advertiseService" -> {
                    val serviceName = call.argument<String>("serviceName")
                    val port = call.argument<Int>("port")
                    if (serviceName != null && port != null) {
                        advertiseService(serviceName, port)
                    }
                    result.success(null)
                }
                "stopService" -> {
                    stopService()
                    result.success(null)
                }
                else -> result.notImplemented()
            }
        }

        registrationListener = object : NsdManager.RegistrationListener {
            override fun onServiceRegistered(serviceInfo: NsdServiceInfo) {
                // Service registration successful
                Log.d("MainActivity", "Service registered: ${serviceInfo.serviceName}")
            }

            override fun onRegistrationFailed(serviceInfo: NsdServiceInfo?, errorCode: Int) {
                // Service registration failed
                Log.e("MainActivity", "Service registration failed: $errorCode")
            }

            override fun onServiceUnregistered(serviceInfo: NsdServiceInfo?) {
                // Service unregistration successful
                Log.d("MainActivity", "Service unregistered: ${serviceInfo?.serviceName}")
            }

            override fun onUnregistrationFailed(serviceInfo: NsdServiceInfo?, errorCode: Int) {
                // Service unregistration failed
                Log.e("MainActivity", "Service unregistration failed: $errorCode")
            }
        }
    }

    private fun advertiseService(serviceName: String, port: Int) {
        this.serviceName = serviceName
        servicePort = port

        val serviceInfo = NsdServiceInfo().apply {
            this.serviceName = serviceName
            serviceType = "_http._tcp." // Adjust according to your service type
            this.port = port
        }

        nsdManager.registerService(serviceInfo, NsdManager.PROTOCOL_DNS_SD, registrationListener)
    }

    private fun stopService() {
        nsdManager.unregisterService(registrationListener)
    }
}


