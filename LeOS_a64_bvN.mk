TARGET_GAPPS_ARCH := arm
$(call inherit-product, device/LeOS/base-pre.mk)
include build/make/target/product/aosp_arm.mk
$(call inherit-product, device/LeOS/base.mk)
$(call inherit-product, vendor/LeOS/leos.mk)





PRODUCT_NAME := LeOS_a64_bvN
PRODUCT_DEVICE := LeOS_a64_ab
PRODUCT_BRAND := google
PRODUCT_SYSTEM_BRAND := google
PRODUCT_MODEL := LeOS
PRODUCT_BROKEN_VERIFY_USES_LIBRARIES := true

# Overwrite the inherited "emulator" characteristics
PRODUCT_CHARACTERISTICS := device

PRODUCT_PACKAGES += 

