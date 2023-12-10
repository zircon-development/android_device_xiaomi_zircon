#
# Copyright (C) 2024 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_PATH := $(call my-dir)

ifeq ($(TARGET_DEVICE),zircon)
include $(LOCAL_PATH)/vendor-symlinks.mk
include $(call all-subdir-makefiles,$(LOCAL_PATH))

GMA_CUSTOM_SYMLINK := $(TARGET_OUT_VENDOR)/etc/camera/gma_custom.xml
$(GMA_CUSTOM_SYMLINK): $(LOCAL_INSTALLED_MODULE)
	@echo "Symlink vendor gma_custom.txt to gma_custom.xml"
	$(hide) ln -sf /vendor/etc/camera/gma_custom.txt $@

ALL_DEFAULT_INSTALLED_MODULES += $(GMA_CUSTOM_SYMLINK)

endif
