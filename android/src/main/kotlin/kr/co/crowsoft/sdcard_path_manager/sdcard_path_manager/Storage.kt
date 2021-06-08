package kr.co.crowsoft.sdcard_path_manager.sdcard_path_manager



import android.content.Context
import android.os.Build
import android.os.Environment
import android.os.StatFs
import android.util.Log
import androidx.core.content.ContextCompat
import java.io.File

object Storage {
    private const val TAG = "Storage"
    private const val ONE_GIGABYTE = 1024L * 1024L * 1024L

    fun isExistAvailableSDCardMemory(context: Context): Boolean {
        val microwSDPath = getSDCardMemoryPath(context)
        if (microwSDPath.isNotEmpty()) {
            return true
        }
        return false
    }


    fun mkdirMemoryPath(context: Context, dirName : String): Boolean {
        val path = "${getMemoryPath(context)}/$dirName"
        Log.d(TAG, "mkdir path : $path")
        val file = File(path)
        if (!file.exists()) {
            file.mkdirs()
            return true
        }
        return false
    }


    fun mkdirSDCardMemoryPath(context: Context, dirName : String) : Boolean {
        val path = "${getSDCardMemoryPath(context)}/$dirName"
        Log.d(TAG, "mkdir path : $path")
        val file = File(path)
        if (!file.exists()) {
            file.mkdirs()
            return true
        }
        return false
    }


    fun getSDCardMemoryPath(context: Context, dirName: String? = null): String {
        var microwSDPath: String = ""
        try {
            microwSDPath = getExternalSdCardPath(context)
            dirName?.let {
                microwSDPath += "/${it}"
            }

        } catch (e: Exception) {
            e.printStackTrace()
        }
        return microwSDPath
    }

    fun getAvailableSDCardMemorySize(context: Context): Long {
        if (isExternalMemoryAvailable()) {
            val path = File(getSDCardMemoryPath(context))
            val stat = StatFs(path.path)
            val blockSize: Long
            val availableBlocks: Long
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN_MR2) {
                blockSize = stat.blockSizeLong
                availableBlocks = stat.availableBlocksLong
            } else {
                blockSize = stat.blockSize.toLong()
                availableBlocks = stat.availableBlocks.toLong()
            }
            return blockSize * availableBlocks
        }
        return -1
    }


    fun getMemoryPath(context: Context, dirName: String? = null): String {
        val externalStorageVolumes: Array<out File> =
            ContextCompat.getExternalFilesDirs(context.applicationContext, null)
        var path = externalStorageVolumes[0].path

        dirName?.let {
            path += "/${it}"
        }
        return path
    }


    fun getAvailableMemorySize(context: Context): Long {
        val externalStorageVolumes: Array<out File> =
            ContextCompat.getExternalFilesDirs(context.applicationContext, null)
        //val primaryExternalStorage = externalStorageVolumes[0]

        if (isExternalMemoryAvailable()) {
            val path = externalStorageVolumes[0]
            val stat = StatFs(path.path)
            val blockSize: Long
            val availableBlocks: Long
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN_MR2) {
                blockSize = stat.blockSizeLong
                availableBlocks = stat.availableBlocksLong
            } else {
                blockSize = stat.blockSize.toLong()
                availableBlocks = stat.availableBlocks.toLong()
            }
            return blockSize * availableBlocks
        }
        return -1

    }


    private fun isExternalMemoryAvailable(): Boolean {
        return Environment.getExternalStorageState() == Environment.MEDIA_MOUNTED
    }




    private fun getExternalSdCardPath(context: Context): String {
        val appsDir: Array<File>
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            appsDir = context.getExternalFilesDirs(null)
            if (appsDir.size < 2) {
                return ""
            }
            var isFirst = true
            for (file in appsDir) {
                if (isFirst) {
                    isFirst = false
                    continue
                }
                if (Environment.getExternalStorageState(file) == Environment.MEDIA_MOUNTED && checkMicroSDCard(file.absolutePath)) {
                    return file.absolutePath
                }
            }
        } else {
            appsDir = ContextCompat.getExternalFilesDirs(context, null)
            val strSDCardPath = Environment.getExternalStorageDirectory().absolutePath
            for (file in appsDir) {
                val path = file.parentFile?.parentFile?.parentFile?.parentFile?.absolutePath ?: continue
                Log.d(TAG, "getExternalMediaDirs " + file.absolutePath)
                if (path != strSDCardPath && checkMicroSDCard(path)) {
                    return path
                }
            }
        }
        return ""
    }

    private fun checkMicroSDCard(fileSystemName: String): Boolean {
        val statFs = StatFs(fileSystemName)
        // (statFs.blockSize * statFs.blockCount).toLong()
        val totalSize: Long = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN_MR2) {
            statFs.blockSizeLong * statFs.blockCountLong
        } else {
            (statFs.blockSize * statFs.blockCount).toLong()
        }
        return totalSize >= ONE_GIGABYTE
    }


}
