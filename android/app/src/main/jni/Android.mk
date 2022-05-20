LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)
LOCAL_MODULE    := android-arch64
LOCAL_SRC_FILES := prebuilt/arm64-v8a/libandroid-arch64.so
include $(PREBUILT_SHARED_LIBRARY)