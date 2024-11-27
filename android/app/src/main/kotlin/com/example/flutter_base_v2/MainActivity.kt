package com.example.flutter_base_v2

import android.os.Bundle
import android.util.Log
import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity() {

    private val TAG = "FlutterActivity"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        // Custom logging or suppressing logs here
        Log.d(TAG, "onCreate() called - Debug level log")  // Debug log
        Log.i(TAG, "onCreate() called - Info level log")   // Info log
        Log.w(TAG, "handleWindowFocusChanged - Warning level log")  // Warning log
        Log.e(TAG, "onCreate() called - Error level log")   // Error log

        // Conditional logging based on build type (Release or Debug)
        if (BuildConfig.DEBUG) {
            Log.v(TAG, "Verbose log in DEBUG build")  // Only log in Debug mode
        } else {
            // In Release mode, suppress verbose and debug logs
            Log.w(TAG, "Release build - Suppressing verbose and debug logs")
        }
    }

    // Override the onWindowFocusChanged method
    override fun onWindowFocusChanged(hasFocus: Boolean) {
        super.onWindowFocusChanged(hasFocus)
        // Suppress or handle the log message here
        if (hasFocus) {
            // Window gained focus
            // Do custom logging or logic here if necessary
            Log.d(TAG, "Window gained focus")
        } else {
            // Window lost focus
            // Suppress the log or log your custom message
            Log.d(TAG, "Window lost focus")
        }

        // You can suppress the Flutter logs if needed here
        // For example, you can add more logic or prevent logs from printing
    }

    // You can also override other lifecycle methods like onResume, onPause, etc.
    override fun onResume() {
        super.onResume()
        Log.d(TAG, "onResume() - Activity is now in the foreground")
    }

    override fun onPause() {
        super.onPause()
        Log.d(TAG, "onPause() - Activity is in the background")
    }
}
