TARGET_GAPPS_ARCH := arm
$(call inherit-product, device/phh/treble/base-pre.mk)
include build/make/target/product/aosp_arm.mk
$(call inherit-product, device/phh/treble/base.mk)
include vendor/LeOS/leos.mk
$(call inherit-product, vendor/extra/product.mk

$(call inherit-product, device/phh/treble/base-sas.mk)



PRODUCT_NAME := lineage_a64_avS
PRODUCT_DEVICE := phhgsi_a64_a
PRODUCT_BRAND := google
PRODUCT_SYSTEM_BRAND := google
PRODUCT_MODEL := LeOS

# Overwrite the inherited "emulator" characteristics
PRODUCT_CHARACTERISTICS := device

PRODUCT_PACKAGES +=  phh-su me.phh.superuser su



