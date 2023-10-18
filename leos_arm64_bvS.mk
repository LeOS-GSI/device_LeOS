$(call inherit-product, device/LeOS/base-pre.mk)
include build/make/target/product/aosp_arm64.mk
$(call inherit-product, device/LeOS/base.mk)
$(call inherit-product, vendor/LeOS/leos.mk)




PRODUCT_NAME := leos_arm64_bvS
PRODUCT_DEVICE := leos_arm64_ab
PRODUCT_BRAND := google
PRODUCT_SYSTEM_BRAND := google
PRODUCT_MODEL := LeOS-A14

# Overwrite the inherited "emulator" characteristics
PRODUCT_CHARACTERISTICS := device

#PRODUCT_PACKAGES +=  phh-su me.phh.superuser su

