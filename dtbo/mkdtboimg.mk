#
# Copyright (C) 2022 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

MKDTBOIMG := $(HOST_OUT_EXECUTABLES)/mkdtboimg
DTBDIR := $(PRODUCT_OUT)/obj/KERNEL_OBJ/arch/arm64/boot/dts/mediatek/
APPEND_CERTS := $(DEVICE_PATH)/dtbo/append_certs.py

TARGET_DTBO_NAME ?= zircon

$(BOARD_PREBUILT_DTBOIMAGE): $(INSTALLED_KERNEL_TARGET) $(MKDTBOIMG)
$(BOARD_PREBUILT_DTBOIMAGE):
	@echo "Creating DTBO image for $(TARGET_DTBO_NAME)..."
	$(MKDTBOIMG) create $@ $(foreach dtbo, $(TARGET_DTBO_NAME), \
		$(DTBDIR)/$(strip $(dtbo)).dtb \
	)
	@echo "DTBO image created successfully at $(BOARD_PREBUILT_DTBOIMAGE)."
	@echo "Appending certificates and encrypted data to DTBO image..."
	$(APPEND_CERTS) --alignment 16 \
		--cert1 $(DEVICE_PATH)/dtbo/security/cert1.der \
		--cert2 $(DEVICE_PATH)/dtbo/security/cert2.der \
		--encrypted_data $(DEVICE_PATH)/dtbo/security/test.bin \
		--dtbo $(BOARD_PREBUILT_DTBOIMAGE)
	@echo "Certificates and encrypted data appended to $(BOARD_PREBUILT_DTBOIMAGE)."
