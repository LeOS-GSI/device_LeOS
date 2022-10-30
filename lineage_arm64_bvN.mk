$(call inherit-product, device/LeOS/base-pre.mk)
include build/make/target/product/aosp_arm64.mk
$(call inherit-product, device/LeOS/base-secure.mk)
$(call inherit-product, vendor/LeOS/leos.mk)
$(call inherit-product, device/LeOS/lineage.mk)


PRODUCT_NAME := lineage_arm64_bvN
PRODUCT_DEVICE := LeOS_arm64_ab
PRODUCT_BRAND := google
PRODUCT_SYSTEM_BRAND := google
PRODUCT_MODEL := LeOS-20TD

# Overwrite the inherited "emulator" characteristics
PRODUCT_CHARACTERISTICS := device

PRODUCT_PACKAGES += 

