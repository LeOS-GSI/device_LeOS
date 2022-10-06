#Huawei devices don't declare fingerprint and telephony hardware feature
#TODO: Proper detection
PRODUCT_COPY_FILES := \
	frameworks/native/data/etc/android.hardware.fingerprint.xml:system/etc/permissions/android.hardware.fingerprint.xml \
	frameworks/native/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml \
	frameworks/native/data/etc/android.hardware.telephony.ims.xml:system/etc/permissions/android.hardware.telephony.ims.xml \
	frameworks/native/data/etc/android.hardware.bluetooth.xml:system/etc/permissions/android.hardware.bluetooth.xml \
	frameworks/native/data/etc/android.hardware.bluetooth_le.xml:system/etc/permissions/android.hardware.bluetooth_le.xml \
	frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \

# Bluetooth Audio (System-side HAL, sysbta)
PRODUCT_PACKAGES += \
    audio.sysbta.default \
    android.hardware.bluetooth.audio-service-system

PRODUCT_COPY_FILES += \
    device/LeOSbluetooth/audio/config/sysbta_audio_policy_configuration.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysbta_audio_policy_configuration.xml \
    device/LeOSbluetooth/audio/config/sysbta_audio_policy_configuration_7_0.xml:$(TARGET_COPY_OUTY_SYSTEM)/etc/sysbta_audio_policy_configuration_7_0.xml

BOARD_PLAT_PRIVATE_SEPOLICY_DIR += device/LeOSsepolicy
PRODUCT_PACKAGE_OVERLAYS += device/LeOSoverlay

$(call inherit-product, vendor/hardware_overlay/overlay.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base_telephony.mk)

#Those overrides are here because Huawei's init read properties
#from /system/etc/prop.default, then /vendor/build.prop, then /system/build.prop
#So we need to set our props in prop.default
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
	ro.build.version.sdk=$(PLATFORM_SDK_VERSION) \
	ro.build.version.codename=$(PLATFORM_VERSION_CODENAME) \
	ro.build.version.all_codenames=$(PLATFORM_VERSION_ALL_CODENAMES) \
	ro.build.version.release=$(PLATFORM_VERSION) \
	ro.build.version.security_patch=$(PLATFORM_SECURITY_PATCH) \
	ro.adb.secure=0 \
	ro.logd.auditd=true
	
#Huawei HiSuite (also other OEM custom programs I guess) it's of no use in AOSP builds
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
	persist.sys.usb.config=adb \
	ro.cust.cdrom=/dev/null	

#VNDK config files
PRODUCT_COPY_FILES += \
	device/LeOSvndk-detect:system/bin/vndk-detect \
	device/LeOSvndk.rc:system/etc/init/vndk.rc \

#USB Audio
PRODUCT_COPY_FILES += \
	frameworks/av/services/audiopolicy/config/usb_audio_policy_configuration.xml:system/etc/usb_audio_policy_configuration.xml \
	device/LeOSfiles/fake_audio_policy_volume.xml:system/etc/fake_audio_policy_volume.xml \

# NFC:
#   Provide default libnfc-nci.conf file for devices that does not have one in
#   vendor/etc
PRODUCT_COPY_FILES += \
	system/nfc/conf/libnfc-nci.conf:system/etc/libnfc-nci.conf \
	device/LeOSnfc/libnfc-nci.conf:system/phh/libnfc-nci-oreo.conf \
	device/LeOSnfc/libnfc-nci-huawei.conf:system/phh/libnfc-nci-huawei.conf

# LineageOS build may need this to make NFC work
PRODUCT_PACKAGES += \
        NfcNci \

PRODUCT_COPY_FILES += \
	device/LeOSrw-system.sh:system/bin/rw-system.sh \
	device/LeOSphh-on-data.sh:system/bin/phh-on-data.sh \
	device/LeOSphh-prop-handler.sh:system/bin/phh-prop-handler.sh \
	device/LeOSempty:system/xbin/empty \
	device/LeOSfixSPL/getSPL.arm:system/bin/getSPL

PRODUCT_COPY_FILES += \
	device/LeOSempty:system/phh/empty \
	device/LeOSphh-on-boot.sh:system/bin/phh-on-boot.sh

PRODUCT_PACKAGES += \
	treble-environ-rc \

PRODUCT_PACKAGES += \
	bootctl \
	vintf \

# Fix Offline Charging on Huawmeme
PRODUCT_PACKAGES += \
	huawei-charger
PRODUCT_COPY_FILES += \
	$(call find-copy-subdir-files,*,device/LeOShuawei_charger/files,system/etc/charger)

PRODUCT_COPY_FILES += \
	device/LeOStwrp/twrp.rc:system/etc/init/twrp.rc \
	device/LeOStwrp/twrp.sh:system/bin/twrp.sh \
	device/LeOStwrp/busybox-armv7l:system/bin/busybox_phh

PRODUCT_PACKAGES += \
    simg2img_simple \
    lptools

ifneq (,$(wildcard external/exfat))
PRODUCT_PACKAGES += \
	mkfs.exfat \
	fsck.exfat
endif

PRODUCT_PACKAGES += \
	android.hidl.manager-V1.0-java \
	android.hardware.wifi.hostapd-V1.0-java \
	vendor.huawei.hardware.biometrics.fingerprint-V2.1-java \
	vendor.huawei.hardware.tp-V1.0-java \
	vendor.qti.hardware.radio.am-V1.0-java \
	vendor.qti.qcril.am-V1.0-java \
	vendor.xiaomi.hardware.displayfeature-V1.0-java

PRODUCT_COPY_FILES += \
	device/LeOSinterfaces.xml:system/etc/permissions/interfaces.xml

PRODUCT_COPY_FILES += \
	device/LeOSfiles/samsung-gpio_keys.kl:system/phh/samsung-gpio_keys.kl \
	device/LeOSfiles/samsung-sec_touchscreen.kl:system/phh/samsung-sec_touchscreen.kl \
	device/LeOSfiles/samsung-sec_touchkey.kl:system/phh/samsung-sec_touchkey.kl \
	device/LeOSfiles/oneplus6-synaptics_s3320.kl:system/phh/oneplus6-synaptics_s3320.kl \
	device/LeOSfiles/huawei-fingerprint.kl:system/phh/huawei/fingerprint.kl \
	device/LeOSfiles/samsung-sec_e-pen.idc:system/usr/idc/sec_e-pen.idc \
	device/LeOSfiles/samsung-9810-floating_feature.xml:system/ph/sam-9810-flo_feat.xml \
	device/LeOSfiles/mimix3-gpio-keys.kl:system/phh/mimix3-gpio-keys.kl \
	device/LeOSfiles/nokia-soc_gpio_keys.kl:system/phh/nokia-soc_gpio_keys.kl \
	device/LeOSfiles/lenovo-synaptics_dsx.kl:system/phh/lenovo-synaptics_dsx.kl \
	device/LeOSfiles/oppo-touchpanel.kl:system/phh/oppo-touchpanel.kl \
	device/LeOSfiles/google-uinput-fpc.kl:system/phh/google-uinput-fpc.kl \
	device/LeOSfiles/moto-uinput-egis.kl:system/phh/moto-uinput-egis.kl \
	device/LeOSfiles/daisy-buttonJack.kl:system/phh/daisy-buttonJack.kl \
	device/LeOSfiles/daisy-uinput-fpc.kl:system/phh/daisy-uinput-fpc.kl \
	device/LeOSfiles/daisy-uinput-goodix.kl:system/phh/daisy-uinput-goodix.kl \
	device/LeOSfiles/nubia-nubia_synaptics_dsx.kl:system/phh/nubia-nubia_synaptics_dsx.kl \
	device/LeOSfiles/unihertz-mtk-kpd.kl:system/phh/unihertz-mtk-kpd.kl \
	device/LeOSfiles/unihertz-mtk-tpd.kl:system/phh/unihertz-mtk-tpd.kl \
	device/LeOSfiles/unihertz-mtk-tpd-kpd.kl:system/phh/unihertz-mtk-tpd-kpd.kl \
	device/LeOSfiles/unihertz-fingerprint_key.kl:system/phh/unihertz-fingerprint_key.kl \
	device/LeOSfiles/zf6-goodixfp.kl:system/phh/zf6-goodixfp.kl \
	device/LeOSfiles/zf6-googlekey_input.kl:system/phh/zf6-googlekey_input.kl \
	device/LeOSfiles/teracube2e-mtk-kpd.kl:system/phh/teracube2e-mtk-kpd.kl \
	device/LeOSfiles/bv9500plus-mtk-kpd.kl:system/phh/bv9500plus-mtk-kpd.kl \
	device/LeOSfiles/moto-liber-gpio-keys.kl:system/phh/moto-liber-gpio-keys.kl \
	device/LeOSfiles/tecno-touchpanel.kl:system/phh/tecno-touchpanel.kl \

SELINUX_IGNORE_NEVERALLOWS := true

# Universal NoCutoutOverlay
PRODUCT_PACKAGES += \
    NoCutoutOverlay

PRODUCT_PACKAGES += \
    lightsctl \
    lightsctl-aidl \
    uevent

PRODUCT_COPY_FILES += \
	device/LeOSfiles/adbd.rc:system/etc/init/adbd.rc

#MTK incoming SMS fix
PRODUCT_PACKAGES += \
	mtk-sms-fwk-ready

# Helper to debug Xiaomi motorized camera
PRODUCT_PACKAGES += \
	xiaomi-motor \
	oneplus-motor

PRODUCT_PACKAGES += \
	Stk

PRODUCT_PACKAGES += \
	resetprop_phh

PRODUCT_COPY_FILES += \
	device/LeOSfiles/ota.sh:system/bin/ota.sh \

PRODUCT_COPY_FILES += \
	device/LeOSremove-telephony.sh:system/bin/remove-telephony.sh \

PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/android.software.secure_lock_screen.xml:system/etc/permissions/android.software.secure_lock_screen.xml \
	device/LeOSfiles/android.software.controls.xml:system/etc/permissions/android.software.controls.xml \

PRODUCT_COPY_FILES += \
        device/LeOSld.config.26.txt:system/etc/ld.config.26.txt \

PRODUCT_PACKAGES += \
    asus-motor

# Privapp-permissions whitelist for PhhTrebleApp
PRODUCT_COPY_FILES += \
	device/LeOSprivapp-permissions-me.phh.treble.app.xml:system/etc/permissions/privapp-permissions-me.phh.treble.app.xml

# Remote debugging
PRODUCT_COPY_FILES += \
	device/LeOSremote/dbclient:system/bin/dbclient \
	device/LeOSremote/phh-remotectl.rc:system/etc/init/phh-remotectl.rc \
	device/LeOSremote/phh-remotectl.sh:system/bin/phh-remotectl.sh \

PRODUCT_PACKAGES += \
	android.hardware.biometrics.fingerprint@2.1-service.oppo.compat \
	android.hardware.biometrics.fingerprint@2.1-service.oplus.compat \

PRODUCT_PACKAGES += \
	vr_hwc \
	curl \
	healthd \

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
	debug.fdsan=warn_once \
	ro.apex.updatable=false \
	persist.sys.fflag.override.settings_provider_model=false \
	ro.setupwizard.mode=OPTIONAL \

PRODUCT_PRODUCT_PROPERTIES += \
	ro.setupwizard.mode=OPTIONAL \

# AOSP overlays
PRODUCT_PACKAGES += \
    NavigationBarMode2ButtonOverlay

PRODUCT_PACKAGES += \
	oplus-alert-slider

PRODUCT_COPY_FILES += \
	device/LeOSempty:system/etc/smartpa_params/empty \
	device/LeOSproprietary-files/gome/fs16xx_01s_left.preset:system/phh/gome/fs16xx_01s_left.preset \
	device/LeOSproprietary-files/gome/fs16xx_01s_mono.preset:system/phh/gome/fs16xx_01s_mono.preset \
	device/LeOSproprietary-files/gome/fs16xx_01s_right.preset:system/phh/gome/fs16xx_01s_right.preset \
	device/LeOSproprietary-files/umidigi/fs16xx_01s_mono.preset:system/phh/umidigi/fs16xx_01s_mono.preset

PRODUCT_PACKAGES += phh-ota

PRODUCT_PACKAGES += \
    xiaomi-touch

PRODUCT_COPY_FILES += \
	frameworks/av/services/audiopolicy/config/a2dp_audio_policy_configuration_7_0.xml:system/etc/a2dp_audio_policy_configuration_7_0.xml \
	frameworks/av/services/audiopolicy/config/a2dp_audio_policy_configuration.xml:system/etc/a2dp_audio_policy_configuration.xml \

include build/make/target/product/gsi_release.mk

# Protect deskclock from power save
PRODUCT_COPY_FILES += \
	device/LeOSfiles/com.android.deskclock_whitelist.xml:system/etc/sysconfig/com.android.deskclock_whitelist.xml
