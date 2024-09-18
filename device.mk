#
# Copyright (C) 2024 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Generic ramdisk allow list
$(call inherit-product, $(SRC_TARGET_DIR)/product/generic_ramdisk.mk)

# Fastbootd
PRODUCT_PACKAGES += \
    fastbootd

# Partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# Rootdir
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/fstab.mt6886:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/fstab.mt6886 \
    $(LOCAL_PATH)/rootdir/init.recovery.mt6886.rc:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/init.recovery.mt6886.rc

# Shipping API Level
PRODUCT_SHIPPING_API_LEVEL := 33

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)
