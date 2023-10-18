$(call inherit-product, device/LeOS/base-pre.mk)
include build/make/target/product/aosp_arm64.mk
$(call inherit-product, device/LeOS/base.mk)
$(call inherit-product, vendor/LeOS/leos.mk)




PRODUCT_NAME := cetus
PRODUCT_DEVICE := cetus
PRODUCT_BRAND := Xiaomi
PRODUCT_MODEL := Mi Mix Fold


PRODUCT_MANUFACTURER := LeOS
PRODUCT_PRODUCT_MANUFACTURER := Xiaomi
PRODUCT_PRODUCT_BRAND := Xiaomi
PRODUCT_PRODUCT_MODEL := Mi Mix Fold



#PRODUCT_PACKAGES +=  phh-su me.phh.superuser



