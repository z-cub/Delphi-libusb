﻿{***********************************************************}
{   Current Version 1.0.1                                   }
{   Libusb 1.0.23 translated by Greg Bayes                  }
{   Copyright © 2018   Greg Bayes                           }
{   Created Version 1.0.0   29/01/2018                      ]
{   DLL Version 1.0.22                                      }
{        Licence MIT                                        }
{                                                           }
{***********************************************************}
{Version 1.0.1                                              }
{ changed Date 18/05/2018                                   }
{  libusb_ss_endpoint_companion_descriptor=> changed the    }
{  extra: byte; //Changed from pbyte                        }
{  changed Date 06/04/2018                                  }
{  endpoint: array of plibusb_endpoint_descriptor;          }
{  changed  Date 21/02/2018                                 }
{  Adjusted uint8_t to arrays :                             }
{  altsetting: array of plibusb_interface_descriptor;       }
{  &interface: array of plibusb_interface;
{***********************************************************}
{ Translated C ++ Public libusb header file  C++            }
{ Copyright © 2001 Johannes Erdfelt <johannes@erdfelt.com>  }
{ Copyright © 2007-2008 Daniel Drake <dsd@gentoo.org>       }
{ Copyright © 2012 Pete Batard <pete@akeo.ie>               }
{ Copyright © 2012 Nathan Hjelm <hjelmn@cs.unm.edu>         }
{ For more information, please visit: http://libusb.info    }
{***********************************************************}

unit libusb1;

interface

uses
 Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,


 type
    PLongint  = ^Longint;
    PSmallInt = ^SmallInt;
    PByte     = ^Byte;
    PWord     = ^Word;
    PDWord    = ^DWord;
    PuInt8_t  = ^uInt8;
    PDouble   = ^Double;
    __int64   = uInt64;
    __int32   = uInt32;
    __int16   = uInt16;
    __int8    = uInt8 ;
    Uint      = DWord;

 {$IF Defined(MSWINDOWS)}
 {$IFDEF WIN64}
    ssize_t   = __int64;
{$ELSE}
    ssize_t   = __int32;
{$ENDIF}
{$ENDIF}

 (*Conversions*)
   uint8_t   = __int8;
   uint16_t  = __int16;
   uint32_t  = __int32;

  const
 LIBUSB_DLL_NAME =  'libusb-1.0.dll';  //defined for windows stdcall
 ZERO_SIZED_ARRAY = 0; (* [0] - non-standard, but usually working code *)
 (* 'interface' might be defined as a macro on Windows, so we need to
 * undefine it so as not to break the current libusb API, because
 * libusb_config_descriptor has an 'interface' member
 * As this can be problematic if you include windows.h after libusb.h
 * in your sources, we force windows.h to be included first.

 (* Since version 1.0.13, to help with feature detection, libusb defines
 * a LIBUSB_API_VERSION macro that gets increased every time there is a
 * significant change to the API, such as the introduction of a new call,
 * the definition of a new macro/enum member, or any other element that
 * libusb applications may want to detect at compilation time.
 * The macro is typically used in an application as follows:

 * Internally, LIBUSB_API_VERSION is defined as follows:
 * (libusb major << 24) | (libusb minor << 16) | (16 bit incremental) *)
LIBUSB_API_VERSION = $01000106;
(*The following is kept for compatibility, but will be deprecated in the future*)
LIBUSBX_API_VERSION = LIBUSB_API_VERSION;

const
    (* standard USB stuff *)
  (** \ingroup libusb_desc Device and/or Interface Class codes *)
 (** In the context of a \ref libusb_device_descriptor "device descriptor",
 * this bDeviceClass value indicates that each interface specifies its own class
 * information and all interfaces operate independently.*)
    LIBUSB_CLASS_PER_INTERFACE = 0;

    LIBUSB_CLASS_AUDIO = 1;
    (** Audio class *)
    LIBUSB_CLASS_COMM = 2;
    (** Communications class *)
    LIBUSB_CLASS_HID = 3;
    (** Human Interface Device class *)
    LIBUSB_CLASS_PHYSICAL = 5;
    (** Physical *)
    LIBUSB_CLASS_PRINTER = 7;
    (** Printer class *)
    LIBUSB_CLASS_PTP = 6;
    (** Image class *)
    LIBUSB_CLASS_IMAGE = 6;
    (* legacy name from libusb-0.1 usb.h *)
    LIBUSB_CLASS_MASS_STORAGE = 8;
    (** Mass storage class *)
    LIBUSB_CLASS_HUB = 9;
    (** Hub class *)
    LIBUSB_CLASS_DATA = 10;
    (** Data class *)
    LIBUSB_CLASS_SMART_CARD = $0b;
    (** Smart Card *)
    LIBUSB_CLASS_CONTENT_SECURITY = $0d;
    (** Content Security *)
    LIBUSB_CLASS_VIDEO = $0e;
    (** Video *)
    LIBUSB_CLASS_PERSONAL_HEALTHCARE = $0f;
    (** Personal Healthcare *)
    LIBUSB_CLASS_DIAGNOSTIC_DEVICE = $dc;
    (** Diagnostic Device *)
    LIBUSB_CLASS_WIRELESS = $e0;
    (** Wireless class *)
    LIBUSB_CLASS_APPLICATION = $fe;
    (** Application class *)
    LIBUSB_CLASS_VENDOR_SPEC = $ff;
    (** Class is vendor-specific *)

 const
(*ingroup libusb_desc Descriptor types as defined by the USB specification. *)
    (** Device descriptor. See libusb_device_descriptor. *)
    LIBUSB_DT_DEVICE = $01;
    LIBUSB_DT_CONFIG = $02;
    (** Configuration descriptor. See libusb_config_descriptor. *)
    LIBUSB_DT_STRING = $03;
    (** String descriptor *)
    LIBUSB_DT_INTERFACE = $04;
    (** Interface descriptor. See libusb_interface_descriptor. *)
    LIBUSB_DT_ENDPOINT = $05;
    (** Endpoint descriptor. See libusb_endpoint_descriptor. *)
    LIBUSB_DT_BOS = $0f;
    (** BOS descriptor *)
    LIBUSB_DT_DEVICE_CAPABILITY = $10;
    (** Device Capability descriptor *)
    LIBUSB_DT_HID = $21;
    (** HID descriptor *)
    LIBUSB_DT_REPORT = $22;
    (** HID report descriptor *)
    LIBUSB_DT_PHYSICAL = $23;
    (** Physical descriptor *)
    LIBUSB_DT_HUB = $29;
    (** Hub descriptor *)
    LIBUSB_DT_SUPERSPEED_HUB = $2a;
    (** SuperSpeed Hub descriptor *)
    LIBUSB_DT_SS_ENDPOINT_COMPANION = $30;
    (** SuperSpeed Endpoint Companion descriptor *)

 const
  (* Descriptor sizes per descriptor type *)
  LIBUSB_DT_DEVICE_SIZE = 18;
  LIBUSB_DT_CONFIG_SIZE = 9;
  LIBUSB_DT_INTERFACE_SIZE = 9;
  LIBUSB_DT_ENDPOINT_SIZE = 7;
  LIBUSB_DT_ENDPOINT_AUDIO_SIZE = 9; (* Audio extension *)
  LIBUSB_DT_HUB_NONVAR_SIZE = 7;
  LIBUSB_DT_SS_ENDPOINT_COMPANION_SIZE = 6;
  LIBUSB_DT_BOS_SIZE = 5;
  LIBUSB_DT_DEVICE_CAPABILITY_SIZE = 3;
  (* BOS descriptor sizes *)
  LIBUSB_BT_USB_2_0_EXTENSION_SIZE = 7;
  LIBUSB_BT_SS_USB_DEVICE_CAPABILITY_SIZE = 10;
  LIBUSB_BT_CONTAINER_ID_SIZE = 20;
  (* We unwrap the BOS => define its max size *)
  LIBUSB_DT_BOS_MAX_SIZE = ((LIBUSB_DT_BOS_SIZE)+(LIBUSB_BT_USB_2_0_EXTENSION_SIZE)+(LIBUSB_BT_SS_USB_DEVICE_CAPABILITY_SIZE)+(LIBUSB_BT_CONTAINER_ID_SIZE));
  LIBUSB_ENDPOINT_ADDRESS_MASK = $0f; (* in bEndpointAddress *)
  LIBUSB_ENDPOINT_DIR_MASK = $80;
  (** \ingroup libusb_desc
   * Endpoint direction. Values for bit 7 of the
   * \ref libusb_endpoint_descriptor::bEndpointAddress "endpoint address" scheme. *)
     (** In: device-to-host *)
    LIBUSB_ENDPOINT_IN = $80;
    LIBUSB_ENDPOINT_OUT = $00;
    (** Out: host-to-device *)

  LIBUSB_TRANSFER_TYPE_MASK = $03; (* in bmAttributes *)
  (** \ingroup libusb_desc
   * Endpoint transfer type. Values for bits 0:1 of the
   * \ref libusb_endpoint_descriptor::bmAttributes "endpoint attributes" field.  *)
      (** Control endpoint *)
    LIBUSB_TRANSFER_TYPE_CONTROL = 0;
    LIBUSB_TRANSFER_TYPE_ISOCHRONOUS = 1;
    (** Isochronous endpoint *)
    LIBUSB_TRANSFER_TYPE_BULK = 2;
    (** Bulk endpoint *)
    LIBUSB_TRANSFER_TYPE_INTERRUPT = 3;
    (** Interrupt endpoint *)
    LIBUSB_TRANSFER_TYPE_BULK_STREAM = 4;
    (** Stream endpoint *)
   (** \ingroup libusb_misc
   * Standard requests, as defined in table 9-5 of the USB 3.0 specifications *)

    (** Request status of the specific recipient *)
    LIBUSB_REQUEST_GET_STATUS = $00;
    LIBUSB_REQUEST_CLEAR_FEATURE = $01;
    (** Clear or disable a specific feature *)
    LIBUSB_REQUEST_SET_FEATURE = $03;
    (* 0x02 is reserved *)
    (** Set or enable a specific feature *)
    LIBUSB_REQUEST_SET_ADDRESS = $05;
    (* 0x04 is reserved *)
    (** Set device address for all future accesses *)
    LIBUSB_REQUEST_GET_DESCRIPTOR = $06;
    (** Get the specified descriptor *)
    LIBUSB_REQUEST_SET_DESCRIPTOR = $07;
    (** Used to update existing descriptors or add new descriptors *)
    LIBUSB_REQUEST_GET_CONFIGURATION = $08;
    (** Get the current device configuration value *)
    LIBUSB_REQUEST_SET_CONFIGURATION = $09;
    (** Set device configuration *)
    LIBUSB_REQUEST_GET_INTERFACE = $0A;
    (** Return the selected alternate setting for the specified interface *)
    LIBUSB_REQUEST_SET_INTERFACE = $0B;
    (** Select an alternate interface for the specified interface *)
    LIBUSB_REQUEST_SYNCH_FRAME = $0C;
    (** Set then report an endpoint's synchronization frame *)
    LIBUSB_REQUEST_SET_SEL = $30;
    (** Sets both the U1 and U2 Exit Latency *)
    LIBUSB_SET_ISOCH_DELAY = $31;
    (** Delay from the time a host transmits a packet to the time it is
       * received by the device. *)

  (** \ingroup libusb_misc
   * Request type bits of the
  * \ref libusb_control_setup::bmRequestType "bmRequestType" field in control transfers. *)
      (** Standard *)
    LIBUSB_REQUEST_TYPE_STANDARD = ($00 shl 5);
    LIBUSB_REQUEST_TYPE_CLASS = ($01 shl 5);
    (** Class *)
    LIBUSB_REQUEST_TYPE_VENDOR = ($02 shl 5);
    (** Vendor *)
    LIBUSB_REQUEST_TYPE_RESERVED = ($03 shl 5);
    (** Reserved *)
    (** \ingroup libusb_misc
   * Recipient bits of the
   * \ref libusb_control_setup::bmRequestType "bmRequestType" field in control
   * transfers. Values 4 through 31 are reserved. *)
     (** Device *)
    LIBUSB_RECIPIENT_DEVICE = $00;
    LIBUSB_RECIPIENT_INTERFACE = $01;
    (** Interface *)
    LIBUSB_RECIPIENT_ENDPOINT = $02;
    (** Endpoint *)
    LIBUSB_RECIPIENT_OTHER = $03;
    (** Other *)

  LIBUSB_ISO_SYNC_TYPE_MASK = $0C;
   (** \ingroup libusb_desc
   * Synchronization type for isochronous endpoints. Values for bits 2:3 of the
   * \ref libusb_endpoint_descriptor::bmAttributes "bmAttributes" field in
   * libusb_endpoint_descriptor.    *)

    (** No synchronization *)
    LIBUSB_ISO_SYNC_TYPE_NONE = 0;
    LIBUSB_ISO_SYNC_TYPE_ASYNC = 1;
    (** Asynchronous *)
    LIBUSB_ISO_SYNC_TYPE_ADAPTIVE = 2;
    (** Adaptive *)
    LIBUSB_ISO_SYNC_TYPE_SYNC = 3;
    (** Synchronous *)
   LIBUSB_ISO_USAGE_TYPE_MASK = $30;

  (** \ingroup libusb_desc
   * Usage type for isochronous endpoints. Values for bits 4:5 of the
   * \ref libusb_endpoint_descriptor::bmAttributes "bmAttributes" field in
   * libusb_endpoint_descriptor. *)
     (** Data endpoint *)
    LIBUSB_ISO_USAGE_TYPE_DATA = 0;
    LIBUSB_ISO_USAGE_TYPE_FEEDBACK = 1;
    (** Feedback endpoint *)
    LIBUSB_ISO_USAGE_TYPE_IMPLICIT = 2;
    (** Implicit feedback Data endpoint *)


 (** \ingroup libusb_dev
 * Speed codes. Indicates the speed at which the device is operating. *)
  (** The OS doesn't report or know the device speed. *)
  LIBUSB_SPEED_UNKNOWN = 0;
  LIBUSB_SPEED_LOW = 1;
  (** The device is operating at low speed (1.5MBit/s). *)
  LIBUSB_SPEED_FULL = 2;
  (** The device is operating at full speed (12MBit/s). *)
  LIBUSB_SPEED_HIGH = 3;
  (** The device is operating at high speed (480MBit/s). *)
  LIBUSB_SPEED_SUPER = 4;
  (** The device is operating at super speed (5000MBit/s). *)
  LIBUSB_SPEED_SUPER_PLUS = 5;
  (** The device is operating at super speed plus (10000MBit/s). *)

  (** \ingroup libusb_dev
 * Supported speeds (wSpeedSupported) bitfield. Indicates what
 * speeds the device supports.
 *)
 (** Low speed operation supported (1.5MBit/s). *)
  LIBUSB_LOW_SPEED_OPERATION = 1;
  LIBUSB_FULL_SPEED_OPERATION = 2;
  (** Full speed operation supported (12MBit/s). *)
  LIBUSB_HIGH_SPEED_OPERATION = 4;
  (** High speed operation supported (480MBit/s). *)
  LIBUSB_SUPER_SPEED_OPERATION = 8;
  (** Superspeed operation supported (5000MBit/s). *)

(** \ingroup libusb_dev
 * Masks for the bits of the
 * \ref libusb_usb_2_0_extension_descriptor::bmAttributes "bmAttributes" field
 * of the USB 2.0 Extension descriptor. *)

  (** Supports Link Power Management (LPM) *)
  LIBUSB_BM_LPM_SUPPORT = 2;

 (** \ingroup libusb_dev
 * Masks for the bits of the
 * \ref libusb_ss_usb_device_capability_descriptor::bmAttributes "bmAttributes" field
 * field of the SuperSpeed USB Device Capability descriptor.  *)

  (** Supports Latency Tolerance Messages (LTM) *)
  LIBUSB_BM_LTM_SUPPORT = 2;

 (** \ingroup libusb_dev
 * USB capability types   *)
  (** Wireless USB device capability *)
  LIBUSB_BT_WIRELESS_USB_DEVICE_CAPABILITY = 1;
  LIBUSB_BT_USB_2_0_EXTENSION = 2;
  (** USB 2.0 extensions *)
  LIBUSB_BT_SS_USB_DEVICE_CAPABILITY = 3;
  (** SuperSpeed USB device capability *)
  LIBUSB_BT_CONTAINER_ID = 4;
  (** Container ID type *)

(** \ingroup libusb_misc
 * Error codes. Most libusb functions return 0 on success or one of these
 * codes on failure.
 * You can call libusb_error_name() to retrieve a string representation of an
 * error code or libusb_strerror() to get an end-user suitable description of
 * an error code.  *)

  (** Success (no error) *)
 type  libusb_error = (
  LIBUSB_SUCCESS = 0,
  LIBUSB_ERROR_IO = -1,
  (** Input/output error *)
  LIBUSB_ERROR_INVALID_PARAM= -2,
  (** Invalid parameter *)
  LIBUSB_ERROR_ACCESS = -3,
  (** Access denied (insufficient permissions) *)
  LIBUSB_ERROR_NO_DEVICE = -4,
  (** No such device (it may have been disconnected) *)
  LIBUSB_ERROR_NOT_FOUND = -5,
  (** Entity not found *)
  LIBUSB_ERROR_BUSY = -6,
  (** Resource busy *)
  LIBUSB_ERROR_TIMEOUT = -7,
  (** Operation timed out *)
  LIBUSB_ERROR_OVERFLOW = -8,
  (** Overflow *)
  LIBUSB_ERROR_PIPE = -9,
  (** Pipe error *)
  LIBUSB_ERROR_INTERRUPTED = -10,
  (** System call interrupted (perhaps due to signal) *)
  LIBUSB_ERROR_NO_MEM = -11,
  (** Insufficient memory *)
  LIBUSB_ERROR_NOT_SUPPORTED = -12,
  (** Operation not supported or unimplemented on this platform *)
  LIBUSB_ERROR_OTHER = -99
  );
 (* ** \def libusb_le16_to_cpu
   * \ingroup libusb_misc
   * Convert a 16-bit value from little-endian to host-endian format. On
   * little endian systems, this function does nothing. On big endian systems,
   * the bytes are swapped.
   * \param x the little-endian value to convert
   * \returns the value in host-endian byte order *)

 var
  libusb_le16_to_cpu : uint16_t ;

Const
  (* NB: Remember to update LIBUSB_ERROR_COUNT below as well as the
      message strings in strerror.c when adding new error codes here. *)
  (** Other error *)
(* Total number of error codes in enum libusb_error *)
LIBUSB_ERROR_COUNT = 14 ;

(* NB! Remember to update libusb_error_name()
    when adding new status codes here. *)
(** \ingroup libusb_asyncio
 * libusb_transfer.flags values *)
  (** Report short frames as errors *)
  LIBUSB_TRANSFER_SHORT_NOT_OK = 1 shl 0;
  LIBUSB_TRANSFER_FREE_BUFFER = 1 shl 1;
  (** Automatically free() transfer buffer during libusb_free_transfer().
    * Note that buffers allocated with libusb_dev_mem_alloc() should not
    * be attempted freed in this way, since free() is not an appropriate
    * way to release such memory. *)
  LIBUSB_TRANSFER_FREE_TRANSFER = 1 shl 2;
  (** Automatically call libusb_free_transfer() after callback returns.
    * If this flag is set, it is illegal to call libusb_free_transfer()
    * from your transfer callback, as this will result in a double-free
    * when this flag is acted upon. *)
  LIBUSB_TRANSFER_ADD_ZERO_PACKET = 1 shl 3;
  (** Terminate transfers that are a multiple of the endpoint's
    * wMaxPacketSize with an extra zero length packet. This is useful
    * when a device protocol mandates that each logical request is
    * terminated by an incomplete packet (i.e. the logical requests are
    * not separated by other meansdelphi ).
    * This flag only affects host-to-device transfers to bulk and interrupt
    * endpoints. In other situations, it is ignored.
    * This flag only affects transfers with a length that is a multiple of
    * the endpoint's wMaxPacketSize. On transfers of other lengths, this
    * flag has no effect. Therefore, if you are working with a device that
    * needs a ZLP whenever the end of the logical request falls on a packet
    * boundary, then it is sensible to set this flag on <em>every</em>
    * transfer (you do not have to worry about only setting it on transfers
    * that end on the boundary).
    * This flag is currently only supported on Linux.
    * On other systems, libusb_submit_transfer() will return
    * LIBUSB_ERROR_NOT_SUPPORTED for every transfer where this flag is set.
    * Available since libusb-1.0.9. *)
   (** \ingroup libusb_misc
 * Capabilities supported by an instance of libusb on the current running
 * platform. Test if the loaded library supports a given capability by calling
 * \ref libusb_has_capability().*)

  (** The libusb_has_capability() API is available. *)
  LIBUSB_CAP_HAS_CAPABILITY = $0000;
  LIBUSB_CAP_HAS_HOTPLUG = $0001;
  (** Hotplug support is available on this platform. *)
  LIBUSB_CAP_HAS_HID_ACCESS = $0100;
  (** The library can access HID devices without requiring user intervention.
    * Note that before being able to actually access an HID device, you may
    * still have to call additional libusb functions such as
    * \ref libusb_detach_kernel_driver(). *)
  LIBUSB_CAP_SUPPORTS_DETACH_KERNEL_DRIVER = $0101;
  (** The library supports detaching of the default USB driver, using
    * \ref libusb_detach_kernel_driver(), if one is set by the OS kernel *)

  LIBUSB_LOG_LEVEL_NONE = 0;  // no messages ever printed by the library (default)
  LIBUSB_LOG_LEVEL_ERROR  = 1; //  error messages are printed to stderr
  LIBUSB_LOG_LEVEL_WARNING = 2; // warning and error messages are printed to stderr
  LIBUSB_LOG_LEVEL_INFO = 3;  // informational messages are printed to stderr
  LIBUSB_LOG_LEVEL_DEBUG = 4;  // debug and informational messages are printed to stderr

(** \ingroup libusb_hotplug
 * Since version 1.0.16, \ref LIBUSB_API_VERSION >= 0x01000102
 * Hotplug events *)
const
(** \ingroup libusb_hotplug
 * Wildcard matching for hotplug events *)
    LIBUSB_HOTPLUG_MATCH_ANY = -1;
(** \ingroup libusb_hotplug
 * Hotplug callback function type. When requesting hotplug event notifications,
 * you pass a pointer to a callback function of this type.
 * This callback may be called by an internal event thread and as such it is
 * recommended the callback do minimal processing before returning.
 * libusb will call this function later, when a matching event had happened on
 * a matching device. See \ref libusb_hotplug for more information.
 * It is safe to call either libusb_hotplug_register_callback() or
 * libusb_hotplug_deregister_callback() from within a callback function.
 * Since version 1.0.16, \ref LIBUSB_API_VERSION >= 0x01000102
 * \param ctx            context of this notification
 * \param device         libusb_device this event occurred on
 * \param event          event that occurred
 * \param user_data      user data provided when this callback was registered
 * \returns bool whether this callback is finished processing events.
 *                       returning 1 will cause this callback to be deregistered  *)

 type
 PTimeVal = ^TTimeVal;       // may need  winsock2 to ge this information
 timeval = record
 tv_sec: Longint;
 tv_usec: Longint;
 end;
 TTimeVal = timeval;

 (** \ingroup libusb_asyncio
 * Transfer status codes *)
 (** Transfer completed without error. Note that this does not indicate
   * that the entire amount of requested data was transferred. *)
  type   libusb_transfer_status = (
  LIBUSB_TRANSFER_COMPLETED,
  (** Transfer failed *)
  LIBUSB_TRANSFER_ERROR,
  (** Transfer timed out *)
  LIBUSB_TRANSFER_TIMED_OUT,
  (** Transfer was cancelled *)
  LIBUSB_TRANSFER_CANCELLED,
  (** For bulk/interrupt endpoints: halt condition detected (endpoint
    * stalled). For control endpoints: control request not supported. *)
  LIBUSB_TRANSFER_STALL,
  (** Device was disconnected *)
  LIBUSB_TRANSFER_NO_DEVICE,
  (** Device sent more data than requested *)
  LIBUSB_TRANSFER_OVERFLOW
  );

 (** \ingroup libusb_hotplug
 * Callback handle.
 * Callbacks handles are generated by libusb_hotplug_register_callback()
 * and can be used to deregister callbacks. Callback handles are unique
 * per libusb_context and it is safe to call libusb_hotplug_deregister_callback()
 * on an already deregisted callback.
 * Since version 1.0.16, \ref LIBUSB_API_VERSION >= 0x01000102
 * For more information, see \ref libusb_hotplug. *)
  (** \ingroup libusb_lib Available option values for libusb_set_option(). *)
type
//callback function
libusb_pollfd_added_cb1 = record
end;
 //callback function
type
libusb_pollfd_removed_cb1 = record
 end;

type
libusb_hotplug_callback_fn1 = record
end;

type
_tmp = record
  b8: array [0..1] of uint8_t;
  b16: uint16_t;
end;

type
Plibusb_hotplug_callback_handle =^libusb_hotplug_callback_handle;
libusb_hotplug_callback_handle  = record
end;

 (** \ingroup libusb_hotplug
 * Since version 1.0.16, \ref LIBUSB_API_VERSION >= 0x01000102
  * Flags for hotplug events *)
type
  libusb_hotplug_flag = (
	(* Default value when not using any flags.*)
	LIBUSB_HOTPLUG_NO_FLAGS = 0,
	(* Arm the callback and fire it for all matching currently attached devices.*)
	LIBUSB_HOTPLUG_ENUMERATE = 1 shl 0
);

 type  libusb_hotplug_event =(
(*A device has been plugged in and is ready to use *)
	LIBUSB_HOTPLUG_EVENT_DEVICE_ARRIVED = $01,
  	(*A device has left and is no longer available.
	 * It is the user's responsibility to call libusb_close on any handle associated with a disconnected device.
	 * It is safe to call libusb_get_device_descriptor on a device that has left *)
	LIBUSB_HOTPLUG_EVENT_DEVICE_LEFT    = $02
);

  Type usb_option =(
  (** Set the log message verbosity.
   * The default level is LIBUSB_LOG_LEVEL_NONE, which means no messages are ever
    * printed. If you choose to increase the message verbosity level, ensure
    * that your application does not close the stderr file descriptor.
    * You are advised to use level LIBUSB_LOG_LEVEL_WARNING. libusb is conservative
    * with its message logging and most of the time, will only log messages that
    * explain error conditions and other oddities. This will help you debug
    * your software.
    * If the LIBUSB_DEBUG environment variable was set when libusb was
    * initialized, this function does nothing: the message verbosity is fixed
    * to the value in the environment variable.
    * If libusb was compiled without any message logging, this function does
    * nothing: you'll never get any messages.
    * If libusb was compiled with verbose debug message logging, this function
    * does nothing: you'll always get messages from all levels.     *)
  LIBUSB_OPTION_LOG_LEVEL,
       //LIBUSB_LOG_LEVEL_WARNING
  (** Use the UsbDk backend for a specific context, if available.
    * This option should be set immediately after calling libusb_init(), otherwise
    * unspecified behavior may occur.
    * Only valid on Windows. *)
  LIBUSB_OPTION_USE_USBDK
);

   (** \ingroup libusb_desc
   * A structure representing the standard USB device descriptor. This
   * descriptor is documented in section 9.6.1 of the USB 3.0 specification.
   * All multiple-byte fields are represented in host-endian format.  *)
  type
    Plibusb_device_descriptor = ^libusb_device_descriptor;
     libusb_device_descriptor = record
  bLength: uint8_t; (** Size of this descriptor (in bytes) *)
  (** Descriptor type. Will have value
    * \ref libusb_descriptor_type::LIBUSB_DT_DEVICE LIBUSB_DT_DEVICE in this
    * context. *)
  bDescriptorType: uint8_t; (** USB specification release number in binary-coded decimal. A value of
    * 0x0200 indicates USB 2.0, 0x0110 indicates USB 1.1, etc. *)
  bcdUSB: uint16_t; (** USB-IF class code for the device. See \ref libusb_class_code. *)
  bDeviceClass: uint8_t; (** USB-IF subclass code for the device, qualified by the bDeviceClass
    * value *)
  bDeviceSubClass: uint8_t; (** USB-IF protocol code for the device, qualified by the bDeviceClass and
    * bDeviceSubClass values *)
  bDeviceProtocol: uint8_t; (** Maximum packet size for endpoint 0 *)
  bMaxPacketSize0: uint8_t; (** USB-IF vendor ID *)
  idVendor: uint16_t; (** USB-IF product ID *)
  idProduct: uint16_t; (** Device release number in binary-coded decimal *)
  bcdDevice: uint16_t; (** Index of string descriptor describing manufacturer *)
  iManufacturer: uint8_t; (** Index of string descriptor describing product *)
  iProduct: uint8_t; (** Index of string descriptor containing device serial number *)
  iSerialNumber: uint8_t; (** Number of possible configurations *)
  bNumConfigurations: uint8_t;
end;
(** \ingroup libusb_desc
 * A structure representing the standard USB endpoint descriptor. This
 * descriptor is documented in section 9.6.6 of the USB 3.0 specification.
 * All multiple-byte fields are represented in host-endian format.
 *)

 Plibusb_endpoint_descriptor = ^libusb_endpoint_descriptor;
  libusb_endpoint_descriptor = record
bLength: uint8_t; (** Size of this descriptor (in bytes) *)
(** Descriptor type. Will have value
  * \ref libusb_descriptor_type::LIBUSB_DT_ENDPOINT LIBUSB_DT_ENDPOINT in
  * this context. *)
bDescriptorType: uint8_t;
(** The address of the endpoint described by this descriptor. Bits 0:3 are
  * the endpoint number. Bits 4:6 are reserved. Bit 7 indicates direction,
  * see \ref libusb_endpoint_direction.*)
bEndpointAddress: uint8_t;
(** Attributes which apply to the endpoint when it is configured using
  * the bConfigurationValue. Bits 0:1 determine the transfer type and
  * correspond to \ref libusb_transfer_type. Bits 2:3 are only used for
  * isochronous endpoints and correspond to \ref libusb_iso_sync_type.
  * Bits 4:5 are also only used for isochronous endpoints and correspond to
  * \ref libusb_iso_usage_type. Bits 6:7 are reserved.  *)
bmAttributes: uint8_t; (** Maximum packet size this endpoint is capable of sending/receiving. *)
wMaxPacketSize: uint16_t; (** Interval for polling endpoint for data transfers. *)
bInterval: uint8_t; (** For audio devices only: the rate at which synchronization feedback
  * is provided. *)
bRefresh: uint8_t; (** For audio devices only: the address if the synch endpoint *)
bSynchAddress: uint8_t; (** Extra descriptors. If libusb encounters unknown endpoint descriptors,
  * it will store them here, should you wish to parse them. *)
extra: Byte; //Changed from pbyte; (** Length of the extra descriptors, in bytes. *)
extra_length: integer;
end;

(** \ingroup libusb_desc
 * A structure representing the standard USB interface descriptor. This
 * descriptor is documented in section 9.6.5 of the USB 3.0 specification.
 * All multiple-byte fields are represented in host-endian format.  *)
  type
 Plibusb_interface_descriptor = ^libusb_interface_descriptor;
  libusb_interface_descriptor = record

bLength: uint8_t; (** Size of this descriptor (in bytes) *)
(** Descriptor type. Will have value
  * \ref libusb_descriptor_type::LIBUSB_DT_INTERFACE LIBUSB_DT_INTERFACE
  * in this context. *)
bDescriptorType: uint8_t; (** Number of this interface *)
bInterfaceNumber: uint8_t; (** Value used to select this alternate setting for this interface *)
bAlternateSetting: uint8_t; (** Number of endpoints used by this interface (excluding the control
  * endpoint). *)
bNumEndpoints: uint8_t; (** USB-IF class code for this interface. See \ref libusb_class_code. *)
bInterfaceClass: uint8_t; (** USB-IF subclass code for this interface, qualified by the
  * bInterfaceClass value *)
bInterfaceSubClass: uint8_t; (** USB-IF protocol code for this interface, qualified by the
  * bInterfaceClass and bInterfaceSubClass values *)
bInterfaceProtocol: uint8_t; (** Index of string descriptor describing this interface *)
iInterface: uint8_t; (** Array of endpoint descriptors. This length of this array is determined
  * by the bNumEndpoints field. *)
endpoint: array of plibusb_endpoint_descriptor; (** Extra descriptors. If libusb encounters unknown interface descriptors,
  * it will store them here, should you wish to parse them. *)
extra: PByte;//changed//pchar; (** Length of the extra descriptors, in bytes. *)
extra_length: integer;
end;(** \ingroup libusb_desc
 * A collection of alternate settings for a particular USB interface.
 *)

type
plibusb_interface = ^libusb_interface;
libusb_interface = record
altsetting: array of  plibusb_interface_descriptor; (** Array of interface descriptors. The length of this array is determined
  * by the num_altsetting field. *)
(** The number of alternate settings that belong to this interface *)
num_altsetting: integer;
end;
(** \ingroup libusb_desc
 * A structure representing the standard USB configuration descriptor. This
 * descriptor is documented in section 9.6.3 of the USB 3.0 specification.
 * All multiple-byte fields are represented in host-endian format.
 *)
type
PPlibusb_config_descriptor = ^Plibusb_config_descriptor;
Plibusb_config_descriptor = ^libusb_config_descriptor;
libusb_config_descriptor = record

bLength: uint8_t; (** Size of this descriptor (in bytes) *)
(** Descriptor type. Will have value
  * \ref libusb_descriptor_type::LIBUSB_DT_CONFIG LIBUSB_DT_CONFIG
  * in this context. *)
bDescriptorType: uint8_t; (** Total length of data returned for this configuration *)
wTotalLength: uint16_t; (** Number of interfaces supported by this configuration *)
bNumInterfaces: uint8_t; (** Identifier value for this configuration *)
bConfigurationValue: uint8_t; (** Index of string descriptor describing this configuration *)
iConfiguration: uint8_t; (** Configuration characteristics *)
bmAttributes: uint8_t; (** Maximum power consumption of the USB device from this bus in this
  * configuration when the device is fully operation. Expressed in units
  * of 2 mA when the device is operating in high-speed mode and in units
  * of 8 mA when the device is operating in super-speed mode. *)
MaxPower: uint8_t; (** Array of interfaces supported by this configuration. The length of
  * this array is determined by the bNumInterfaces field. *)
&interface: array of plibusb_interface; //added &// (** Extra descriptors. If libusb encounters unknown configuration
  //* descriptors, it will store them here, should you wish to parse them. *)
extra: Byte;//pchar; (** Length of the extra descriptors, in bytes. *)
extra_length: integer;
end;(** \ingroup libusb_desc
 * A structure representing the superspeed endpoint companion
 * descriptor. This descriptor is documented in section 9.6.7 of
 * the USB 3.0 specification. All multiple-byte fields are represented in
 * host-endian format.
 *)
 type
  PPlibusb_ss_endpoint_companion_descriptor = ^Plibusb_ss_endpoint_companion_descriptor;
 Plibusb_ss_endpoint_companion_descriptor = ^libusb_ss_endpoint_companion_descriptor;
 libusb_ss_endpoint_companion_descriptor = record

bLength: uint8_t; (** Size of this descriptor (in bytes) *)
(** Descriptor type. Will have value
  * \ref libusb_descriptor_type::LIBUSB_DT_SS_ENDPOINT_COMPANION in
  * this context. *)
bDescriptorType: uint8_t; (** The maximum number of packets the endpoint can send or
  *  receive as part of a burst. *)
bMaxBurst: uint8_t; (** In bulk EP: bits 4:0 represents the maximum number of
  *  streams the EP supports. In isochronous EP: bits 1:0
  *  represents the Mult - a zero based value that determines
  *  the maximum number of packets within a service interval  *)
bmAttributes: uint8_t; (** The total number of bytes this EP will transfer every
  *  service interval. valid only for periodic EPs. *)
wBytesPerInterval: uint16_t;
end;

(** \ingroup libusb_desc
 * A generic representation of a BOS Device Capability descriptor. It is
 * advised to check bDevCapabilityType and call the matching
 * libusb_get_*_descriptor function to get a structure fully matching the type. *)
type
PPlibusb_bos_dev_capability_descriptor = ^plibusb_bos_dev_capability_descriptor;
Plibusb_bos_dev_capability_descriptor = ^libusb_bos_dev_capability_descriptor;
libusb_bos_dev_capability_descriptor = record

bLength: uint8_t; (** Size of this descriptor (in bytes) *)
(** Descriptor type. Will have value
  * \ref libusb_descriptor_type::LIBUSB_DT_DEVICE_CAPABILITY
  * LIBUSB_DT_DEVICE_CAPABILITY in this context. *)
bDescriptorType: uint8_t; (** Device Capability type *)
bDevCapabilityType: uint8_t; (** Device Capability data (bLength - 3 bytes) *)
dev_capability_data:array [0..ZERO_SIZED_ARRAY] of uint8_t;
end;

(** \ingroup libusb_desc
 * A structure representing the Binary Device Object Store (BOS) descriptor.
 * This descriptor is documented in section 9.6.2 of the USB 3.0 specification.
 * All multiple-byte fields are represented in host-endian format.
 *)
 Type
  PPlibusb_bos_descriptor =  ^Plibusb_bos_descriptor;
  Plibusb_bos_descriptor =  ^libusb_bos_descriptor;
 libusb_bos_descriptor = record
bLength: uint8_t; (** Size of this descriptor (in bytes) *)
(** Descriptor type. Will have value
  * \ref libusb_descriptor_type::LIBUSB_DT_BOS LIBUSB_DT_BOS
  * in this context. *)
bDescriptorType: uint8_t; (** Length of this descriptor and all of its sub descriptors *)
wTotalLength: uint16_t; (** The number of separate device capability descriptors in
  * the BOS *)
bNumDeviceCaps: uint8_t; (** bNumDeviceCap Device Capability Descriptors *)
dev_capability: array [0..(ZERO_SIZED_ARRAY)] of plibusb_bos_dev_capability_descriptor;
end;

(** \ingroup libusb_desc
 * A structure representing the USB 2.0 Extension descriptor
 * This descriptor is documented in section 9.6.2.1 of the USB 3.0 specification.
 * All multiple-byte fields are represented in host-endian format. *)
type
 PPlibusb_usb_2_0_extension_descriptor = ^Plibusb_usb_2_0_extension_descriptor ;
 Plibusb_usb_2_0_extension_descriptor = ^libusb_usb_2_0_extension_descriptor ;
libusb_usb_2_0_extension_descriptor = record
bLength: uint8_t; (** Size of this descriptor (in bytes) *)
(** Descriptor type. Will have value
  * \ref libusb_descriptor_type::LIBUSB_DT_DEVICE_CAPABILITY
  * LIBUSB_DT_DEVICE_CAPABILITY in this context. *)
bDescriptorType: uint8_t; (** Capability type. Will have value
  * \ref libusb_capability_type::LIBUSB_BT_USB_2_0_EXTENSION
  * LIBUSB_BT_USB_2_0_EXTENSION in this context. *)
bDevCapabilityType: uint8_t; (** Bitmap encoding of supported device level features.
  * A value of one in a bit location indicates a feature is
  * supported; a value of zero indicates it is not supported.
  * See \ref libusb_usb_2_0_extension_attributes. *)
bmAttributes: uint32_t;
end;

(** \ingroup libusb_desc
 * A structure representing the SuperSpeed USB Device Capability descriptor
 * This descriptor is documented in section 9.6.2.2 of the USB 3.0 specification.
 * All multiple-byte fields are represented in host-endian format. *)
 type
   PPlibusb_ss_usb_device_capability_descriptor= ^Plibusb_ss_usb_device_capability_descriptor;
   Plibusb_ss_usb_device_capability_descriptor= ^libusb_ss_usb_device_capability_descriptor;
  libusb_ss_usb_device_capability_descriptor = record
bLength: uint8_t; (** Size of this descriptor (in bytes) *)
(** Descriptor type. Will have value
  * \ref libusb_descriptor_type::LIBUSB_DT_DEVICE_CAPABILITY
  * LIBUSB_DT_DEVICE_CAPABILITY in this context. *)
bDescriptorType: uint8_t; (** Capability type. Will have value
  * \ref libusb_capability_type::LIBUSB_BT_SS_USB_DEVICE_CAPABILITY
  * LIBUSB_BT_SS_USB_DEVICE_CAPABILITY in this context. *)
bDevCapabilityType: uint8_t; (** Bitmap encoding of supported device level features.
  * A value of one in a bit location indicates a feature is
  * supported; a value of zero indicates it is not supported.
  * See \ref libusb_ss_usb_device_capability_attributes. *)
bmAttributes: uint8_t; (** Bitmap encoding of the speed supported by this device when
  * operating in SuperSpeed mode. See \ref libusb_supported_speed. *)
wSpeedSupported: uint16_t; (** The lowest speed at which all the functionality supported
  * by the device is available to the user. For example if the
  * device supports all its functionality when connected at
  * full speed and above then it sets this value to 1. *)
bFunctionalitySupport: uint8_t; (** U1 Device Exit Latency. *)
bU1DevExitLat: uint8_t; (** U2 Device Exit Latency. *)
bU2DevExitLat: uint16_t;
end;

(** \ingroup libusb_desc
 * A structure representing the Container ID descriptor.
 * This descriptor is documented in section 9.6.2.3 of the USB 3.0 specification.
 * All multiple-byte fields, except UUIDs, are represented in host-endian format.  *)
Type
PPlibusb_container_id_descriptor =^Plibusb_container_id_descriptor;
Plibusb_container_id_descriptor =^libusb_container_id_descriptor;
libusb_container_id_descriptor = record
bLength: uint8_t; (** Size of this descriptor (in bytes) *)
(** Descriptor type. Will have value
  * \ref libusb_descriptor_type::LIBUSB_DT_DEVICE_CAPABILITY
  * LIBUSB_DT_DEVICE_CAPABILITY in this context. *)
bDescriptorType: uint8_t; (** Capability type. Will have value
  * \ref libusb_capability_type::LIBUSB_BT_CONTAINER_ID
  * LIBUSB_BT_CONTAINER_ID in this context. *)
bDevCapabilityType: uint8_t; (** Reserved field *)
bReserved: uint8_t; (** 128 bit UUID *)
ContainerID: array [0..15] of uint8_t;
end;
(** \ingroup libusb_asyncio
 * Setup packet for control transfers. *)
 type
Plibusb_control_setup = ^libusb_control_setup;
libusb_control_setup = record
bmRequestType: uint8_t;
(** Request type. Bits 0:4 determine recipient, see
  * \ref libusb_request_recipient. Bits 5:6 determine type, see
  * \ref libusb_request_type. Bit 7 determines data transfer direction, see
  * \ref libusb_endpoint_direction. *)
(** Request. If the type bits of bmRequestType are equal to
  * \ref libusb_request_type::LIBUSB_REQUEST_TYPE_STANDARD
  * "LIBUSB_REQUEST_TYPE_STANDARD" then this field refers to
  * \ref libusb_standard_request. For other cases, use of this field is
  * application-specific. *)
bRequest: uint8_t; (** Value. Varies according to request *)
wValue: uint16_t; (** Index. Varies according to request, typically used to pass an index
  * or offset *)
wIndex: uint16_t; (** Number of bytes to transfer *)
wLength: uint16_t;
end;

(** \ingroup libusb_lib
 * Structure providing the version of the libusb runtime  *)
  type
plibusb_version =  ^libusb_version;
libusb_version = record

major: uint16_t; (** Library major version. *)
(** Library minor version. *)
minor: uint16_t; (** Library micro version. *)
micro: uint16_t; (** Library nano version. *)
nano: uint16_t; (** Library release candidate suffix string, e.g. "-rc4". *)
rc: Byte;//pchar; (** For ABI compatibility only. *)
describe: Byte;//pchar;
end;

const
 LIBUSB_CONTROL_SETUP_SIZE = (SizeOf( libusb_control_setup));
(* libusb *)

(** \ingroup libusb_lib
 * Structure representing a libusb session. The concept of individual libusb
 * sessions allows for your program to use two libraries (or dynamically
 * load two modules) which both independently use libusb. This will prevent
 * interference between the individual libusb users - for example
 * libusb_set_option() will not affect the other user of the library, and
 * libusb_exit() will not destroy resources that the other user is still
 * using.
 * Sessions are created by libusb_init() and destroyed through libusb_exit().
 * If your application is guaranteed to only ever include a single libusb
 * user (i.e. you), you do not have to worry about contexts: pass NULL in
 * every function call where a context is required. The default context
 * will be used.
  * For more information, see \ref libusb_contexts.
 *)

type
 pplibusb_context = ^plibusb_context;
 plibusb_context = ^libusb_context;
 libusb_context = record
 end;

(** \ingroup libusb_dev
 * Structure representing a USB device detected on the system. This is an
 * opaque type for which you are only ever provided with a pointer, usually
 * originating from libusb_get_device_list().
 * Certain operations can be performed on a device, but in order to do any
 * I/O you will have to first obtain a device handle using libusb_open().
 * Devices are reference counted with libusb_ref_device() and
 * libusb_unref_device(), and are freed when the reference count reaches 0.
 * New devices presented by libusb_get_device_list() have a reference count of
 * 1, and libusb_free_device_list() can optionally decrease the reference count
 * on all devices in the list. libusb_open() adds another reference which is
 * later destroyed by libusb_close(). *)
 type
  ppplibusb_device = ^pplibusb_device;
  pplibusb_device = ^plibusb_device;
  plibusb_device = ^libusb_device;
  libusb_device = record
  end;

 (** \ingroup libusb_dev
 * Structure representing a handle on a USB device. This is an opaque type for
 * which you are only ever provided with a pointer, usually originating from
 * libusb_open().
 * A device handle is used to perform I/O and other operations. When finished
 * with a device handle, you should call libusb_close(). *)

type
 pplibusb_device_handle = ^plibusb_device_handle;
  plibusb_device_handle = ^libusb_device_handle;
 libusb_device_handle = record
 end;

(** \ingroup libusb_asyncio
 * Isochronous packet descriptor. *)
type
 Plibusb_iso_packet_descriptor = ^libusb_iso_packet_descriptor;
 libusb_iso_packet_descriptor = record
 length: UINT; (** Length of data to request in this packet *)
(** Amount of data that was actually transferred *)
 actual_length: UINT; (** Status code for this packet *)
 status:libusb_transfer_status;
end;

(** \ingroup libusb_asyncio
 * Asynchronous transfer callback function type. When submitting asynchronous
 * transfers, you pass a pointer to a callback function of this type via the
 * \ref libusb_transfer::callback "callback" member of the libusb_transfer
 * structure. libusb will call this function later, when the transfer has
 * completed or failed. See \ref libusb_asyncio for more information.
 * \param transfer The libusb_transfer struct the callback function is being
 * notified about.
 *)
 type
  Pstructlibusb_transfer = ^structlibusb_transfer;
  libusb_transfer_cb_fn= procedure(transfer : Pstructlibusb_transfer);
  Plibusb_transfer_cb_fn = ^libusb_transfer_cb_fn;
  structlibusb_transfer = record
   dev_handle: ^libusb_device_handle;
	 flags: uint8_t;
	 endpoint:byte;
	 ctype: byte; // type is reserved word
	 timeout: DWORD ;
	 status: libusb_transfer_status;
	 length: integer;
	 actual_length: integer ;
	 callback: Plibusb_transfer_cb_fn;
   user_data: pointer;
	 buffer:PChar;
	 num_iso_packets: integer ;
	 iso_packet_desc: plibusb_iso_packet_descriptor;
   end;

 (** \ingroup libusb_asyncio
 * The generic USB transfer structure. The user populates this structure and
 * then submits it in order to request a transfer. After the transfer has
 * completed, the library populates the transfer with the results and passes
 * it back to the user.   *)
type
  Plibusb_transfer  = ^libusb_transfer;
 libusb_transfer = record
dev_handle: plibusb_device_handle; (** Handle of the device that this transfer will be submitted to *)
(** A bitwise OR combination of \ref libusb_transfer_flags. *)
flags: uint8_t; (** Address of the endpoint where this transfer will be sent. *)
endpoint: char; (** Type of the endpoint from \ref libusb_transfer_type *)
&type: char; (** Timeout for this transfer in milliseconds. A value of 0 indicates no
  * timeout. *)
timeout: UINT; (** The status of the transfer. Read-only, and only for use within
  * transfer callback function.
  *
  * If this is an isochronous transfer, this field may read COMPLETED even
  * if there were errors in the frames. Use the
  * \ref libusb_iso_packet_descriptor::status "status" field in each packet
  * to determine if errors occurred. *)
status: libusb_transfer_status;//enum{libusb_transfer_status}{<= !!!4 unknown type}; (** Length of the data buffer *)
length: integer; (** Actual length of data that was transferred. Read-only, and only for
  * use within transfer callback function. Not valid for isochronous
  * endpoint transfers. *)
actual_length: integer; (** Callback function. This will be invoked when the transfer completes,
  * fails, or is cancelled. *)
callback: libusb_transfer_cb_fn; (** User context data to pass to the callback function. *)
user_data: pinteger; (** Data buffer *)
buffer: pchar; (** Number of isochronous packets. Only used for I/O with isochronous
  * endpoints. *)
num_iso_packets: integer; (** Isochronous packet descriptors, for isochronous transfers only. *)
iso_packet_desc: array [0..0] of libusb_iso_packet_descriptor;
end;
  (** \ingroup libusb_poll
 * File descriptor for polling   *)
type
pplibusb_pollfd = ^plibusb_pollfd;
plibusb_pollfd = ^libusb_pollfd;
libusb_pollfd = record
fd: integer;
(** Numeric file descriptor *)
(** Event flags to poll for from <poll.h>. POLLIN indicates that you
  * should monitor this file descriptor for becoming ready to read from,
  * and POLLOUT indicates that you should monitor this file descriptor for
  * nonblocking write readiness. *)
events: smallint;
end;
(** \ingroup libusb_poll
 * Callback function, invoked when a new file descriptor should be added
 * to the set of file descriptors monitored for events.
 * \param fd the new file descriptor
 * \param events events to monitor for, see \ref libusb_pollfd for a
 * description
 * \param user_data User data pointer specified in
 * libusb_set_pollfd_notifiers() call
 * \see libusb_set_pollfd_notifiers()
 *)
(** \ingroup libusb_poll
 * Callback function, invoked when a file descriptor should be removed from
 * the set of file descriptors being monitored for events. After returning
 * from this callback, do not use that file descriptor again.
 * \param fd the file descriptor to stop monitoring
 * \param user_data User data pointer specified in
 * libusb_set_pollfd_notifiers() call
 * \see libusb_set_pollfd_notifiers()
 *)

(* HELPER Procedures and Functions*)

//external call to DLL and extended functions and procedures

    //adjusted pplibusb_context for init and exit
function libusb_init(ctx: plibusb_context):integer;stdcall;
procedure libusb_exit(ctx: plibusb_context); stdcall;
// removed LIBUSB_DEPRECATED_FOR(libusb_set_option)
procedure libusb_set_debug(ctx: plibusb_context; level: integer); stdcall;
function libusb_get_version():plibusb_version; stdcall;
function libusb_has_capability(capability: uint32_t):integer; stdcall;
procedure libusb_error_name(errcode:integer); stdcall;
function libusb_setlocale(locale: pchar):integer; stdcall;
function libusb_strerror(const errorcode:libusb_error):pchar; stdcall;
function libusb_get_device_list(ctx:plibusb_context; list: pplibusb_device):ssize_t; stdcall;
procedure libusb_free_device_list(list:pplibusb_device; unref_devices:integer); stdcall;
function libusb_ref_device(dev:plibusb_device):plibusb_device;stdcall;
procedure libusb_unref_device(dev:plibusb_device); stdcall;
function libusb_get_configuration(dev:plibusb_device_handle;config:pinteger):integer;stdcall;
function libusb_get_device_descriptor(dev: plibusb_device; desc: plibusb_device_descriptor):integer;stdcall;
function libusb_get_active_config_descriptor(dev: plibusb_device; const config:pplibusb_config_descriptor):integer;stdcall;
function libusb_get_config_descriptor(dev: plibusb_device;  config_index: uint8_t;const config:pplibusb_config_descriptor ):integer;stdcall;
function libusb_get_config_descriptor_by_value(dev: plibusb_device;  bConfigurationValue: uint8_t; config:plibusb_config_descriptor ):integer;stdcall;
procedure libusb_free_config_descriptor(const config:plibusb_config_descriptor);stdcall;
function libusb_get_ss_endpoint_companion_descriptor(const ctx: plibusb_context;  endpoint: plibusb_endpoint_descriptor;ep_comp:pplibusb_ss_endpoint_companion_descriptor):integer;stdcall;
procedure libusb_free_ss_endpoint_companion_descriptor(ep_comp: plibusb_ss_endpoint_companion_descriptor);stdcall;
function libusb_get_bos_descriptor(handle: plibusb_device_handle;bos:pplibusb_bos_descriptor):integer;stdcall;
procedure libusb_free_bos_descriptor(bos: plibusb_bos_descriptor);stdcall;
function libusb_get_usb_2_0_extension_descriptor(ctx: plibusb_context;dev_cap: plibusb_bos_dev_capability_descriptor;usb_2_0_extension:pplibusb_usb_2_0_extension_descriptor):integer;stdcall;
procedure libusb_free_usb_2_0_extension_descriptor(usb_2_0_extension: plibusb_usb_2_0_extension_descriptor);stdcall;
function libusb_get_ss_usb_device_capability_descriptor(ctx: plibusb_context;dev_cap:plibusb_bos_dev_capability_descriptor;ss_usb_device_cap:pplibusb_ss_usb_device_capability_descriptor):integer;stdcall;
procedure libusb_free_ss_usb_device_capability_descriptor(ss_usb_device_cap: plibusb_ss_usb_device_capability_descriptor);stdcall;
function libusb_get_container_id_descriptor(ctx: plibusb_context; dev_cap: plibusb_bos_dev_capability_descriptor;container_id: pplibusb_container_id_descriptor ):integer;stdcall;
procedure libusb_free_container_id_descriptor(container_id: plibusb_container_id_descriptor);stdcall;
function libusb_get_bus_number(dev: Plibusb_device): uint8_t;stdcall;
function libusb_get_port_number(dev: Plibusb_device):uint8_t;stdcall;
function libusb_get_port_numbers(dev: Plibusb_device; port_numbers: PuInt8_t; port_numbers_len: integer):integer;stdcall;//deprecated
function libusb_get_port_path(ctx: Plibusb_context;  dev: plibusb_device;  path: PuInt8_t;  path_length: uint8_t):integer;stdcall;
function libusb_get_parent(dev:plibusb_device):Plibusb_device;stdcall;
function libusb_get_device_address(dev: plibusb_device):uint8_t;stdcall;stdcall;
function libusb_get_device_speed(dev: plibusb_device):integer;stdcall;
function libusb_get_max_packet_size(dev: plibusb_device;endpoint:Byte):integer;stdcall;
function libusb_get_max_iso_packet_size(dev: plibusb_device; endpoint:Byte):integer;stdcall;
function libusb_open(dev: plibusb_device;dev_handle:pplibusb_device_handle ):integer;stdcall;
procedure libusb_close(dev_handle: plibusb_device_handle);stdcall;
function libusb_get_device(dev_handle:libusb_device_handle):libusb_device;stdcall;
function libusb_set_configuration(dev_handle: plibusb_device_handle; configuration:integer):integer;stdcall;
function libusb_claim_interface(dev_handle: plibusb_device_handle;interface_number:integer):integer;stdcall;
function libusb_release_interface(dev_handle: plibusb_device_handle; interface_number: integer):integer;stdcall;
function libusb_open_device_with_vid_pid(ctx:plibusb_context;vendor_id:uint16_t;product_id:uint16_t):plibusb_device_handle;stdcall;
function libusb_set_interface_alt_setting(dev_handle: plibusb_device_handle;  interface_number: integer;  alternate_setting: integer):integer;stdcall;
function libusb_clear_halt(dev_handle: plibusb_device_handle; endpoint:Byte):integer;stdcall;
function libusb_reset_device(dev_handle: plibusb_device_handle):integer;stdcall;
(*Since version 1.0.19 Returns number of streams allocated*)
function libusb_alloc_streams(dev_handle: plibusb_device_handle; num_streams: uint32_t;endpoints: pByte;  num_endpoints: integer):Integer;stdcall;
(*Since version 1.0.19 Free USB streams allocated with libusb_alloc_atreams() returns Libusb_success = 0*)
function libusb_free_streams(dev_handle: plibusb_device_handle;  endpoints: pbyte;  num_endpoints: integer):Integer;stdcall;
//procedure libusb_free_transfer(transfer: Pstructlibusb_transfer);stdcall;
function libusb_dev_mem_alloc(dev_handle:plibusb_device_handle;length:size_t):pbyte;stdcall;
function libusb_dev_mem_free(dev_handle: plibusb_device_handle;  buffer: pbyte;length: size_t):integer;stdcall;
function libusb_kernel_driver_active(dev_handle: plibusb_device_handle; interface_number:integer):integer;stdcall;
function libusb_detach_kernel_driver(dev_handle: plibusb_device_handle; interface_number: integer):integer;stdcall;
function libusb_attach_kernel_driver(dev_handle: plibusb_device_handle; interface_number: integer):integer;stdcall;
function libusb_set_auto_detach_kernel_driver(dev_handle: plibusb_device_handle;  enable: integer):integer;stdcall;
 (*Helper functions and procedures *)
 (* async I/O *)
function libusb_control_transfer_get_data(transfer: plibusb_transfer): pChar;
function libusb_control_transfer_get_setup(transfer: plibusb_transfer):plibusb_control_setup;
procedure libusb_fill_control_setup(buffer: pchar;bmRequestType:uint8_t;bRequest:uint8_t;
wValue:uint16_t;wIndex:uint16_t;wLength:uint16_t);
  (*End Helper functions and procedures *)
function libusb_alloc_transfer(iso_packets:integer):Plibusb_transfer;stdcall;
function libusb_submit_transfer(transfer: plibusb_transfer):integer;stdcall;
function libusb_cancel_transfer(transfer: plibusb_transfer):integer;stdcall;
(*Use libusb_fill_bulk_stream_transfer()* **Deprecated** *)
procedure libusb_free_transfer(transfer:plibusb_transfer);stdcall;
procedure libusb_transfer_set_stream_id(transfer:plibusb_transfer;stream_id : uint32_t);stdcall;
function libusb_tranfer_get_stream_id(transfer:plibusb_transfer):uint32_t;stdcall;
 (* Helper functions and procedures *)
procedure libusb_fill_control_transfer(transfer: plibusb_transfer;
 dev_handle: plibusb_device_handle; buffer: pchar;
 callback: libusb_transfer_cb_fn; user_data: pointer; timeout: cardinal);
procedure libusb_fill_bulk_transfer(transfer: plibusb_transfer;
 dev_handle: plibusb_device_handle; endpoint: char; buffer: pchar;
 length: integer;  callback: libusb_transfer_cb_fn; user_data: pointer;
 timeout: uint);
procedure libusb_fill_bulk_stream_transfer(transfer: plibusb_transfer; dev_handle: plibusb_device_handle; endpoint: char;
 stream_id: uint32_t;buffer: pchar;length: integer; callback: libusb_transfer_cb_fn;user_data:pointer;timeout:uint);
procedure libusb_fill_interrupt_transfer(transfer:plibusb_transfer;dev_handle:plibusb_device_handle;endpoint:char;
 buffer:pchar; length:integer;callback:libusb_transfer_cb_fn; user_data:pointer;timeout:uint);
procedure libusb_fill_iso_transfer(transfer:plibusb_transfer;dev_handle:plibusb_device_handle;endpoint:char;
buffer:pchar;length: integer; num_iso_packets:integer; callback: libusb_transfer_cb_fn;user_data:pointer;timeout: UINT);
procedure libusb_set_iso_packet_lengths(transfer:plibusb_transfer;length:uint);
function libusb_get_iso_packet_buffer(transfer:plibusb_transfer;packet:uint):pchar;
function libusb_get_iso_packet_buffer_simple(transfer:plibusb_transfer;packet:uint):pchar;
 (* End Helper functions and procedures *)
 (* sync I/O *)
function libusb_control_transfer(dev_handle:plibusb_device_handle;request_type:uint8_t;bRequest:uint8_t;
 wValue:uint16_t;wIndex: uint16_t; data: pbyte;wLength:uint16_t;timeout: uint):integer;stdcall;
function libusb_bulk_transfer(dev_handle:plibusb_device_handle;endpoint:byte;data: pbyte; length: integer;
actual_length: pinteger;timeout:uint):integer;stdcall;
function libusb_interrupt_transfer(dev_handle:plibusb_device_handle;endpoint:byte;data:pbyte;length:integer;
actual_length:pinteger;timeout:uint):integer;stdcall;
 (*Helper Functions and Procedures*)
function libusb_get_descriptor(dev_handle: plibusb_device_handle; desc_type: uint8_t;desc_index: uint8_t; data:pbyte;length:integer):integer;
function libusb_get_string_descriptor(dev_handle: plibusb_device_handle;desc_index: uint8_t;langid:uint16_t;data:pbyte;length:integer):integer;
 (* End Helper Functions and Procedures*)
function libusb_get_string_descriptor_ascii(dev_handle: plibusb_device_handle;
 desc_index:uint8_t; data:pbyte;length:integer):integer;stdcall;
   (* polling and timeouts *)
function libusb_try_lock_events(ctx: plibusb_context):integer;stdcall;
procedure libusb_lock_events(ctx: plibusb_context);stdcall;
procedure libusb_unlock_events(ctx: plibusb_context);stdcall;
function libusb_event_handling_ok(ctx: plibusb_context):integer;stdcall;
function libusb_event_handler_active(ctx: plibusb_context):integer;stdcall;
procedure libusb_interrupt_event_handler(ctx: plibusb_context);stdcall;
procedure libusb_lock_event_waiters(ctx: plibusb_context);stdcall;
procedure libusb_unlock_event_waiters(ctx:plibusb_context);stdcall;
function libusb_wait_for_event(ctx:plibusb_context;tv:ptimeval):integer;stdcall;
function libusb_handle_events_timeout(ctx:plibusb_context; tv:ptimeval):integer;stdcall;
function libusb_handle_events_timeout_completed(ctx:plibusb_context;tv:ptimeval;completed:pinteger):integer;stdcall;
function libusb_handle_events(ctx: plibusb_context):integer;stdcall;
function libusb_handle_events_completed(ctx:plibusb_context; completed:pinteger):integer;stdcall;
function libusb_handle_events_locked(ctx:plibusb_context;tv:ptimeval):integer;stdcall;
function libusb_pollfds_handle_timeouts(ctx:plibusb_context):integer;stdcall;
function libusb_get_next_timeout(ctx:plibusb_context; tv:ptimeval):integer;stdcall;
function libusb_pollfd_added_cb(fd:integer;events:Smallint;user_data:pointer):pointer;stdcall;
function libusb_pollfd_removed_cb(fd:integer; user_data:pointer):pointer;stdcall;
function libusb_get_pollfds(ctx:plibusb_context):pplibusb_pollfd;stdcall;
procedure libusb_free_pollfds(pollfds:pplibusb_pollfd );stdcall;
procedure libusb_set_pollfd_notifiers(ctx:plibusb_context;added_cb:libusb_pollfd_added_cb1;removed_cb: libusb_pollfd_removed_cb1;
user_data:pointer);stdcall;
function libusb_hotplugin_callback_fn(ctx:plibusb_context;device:plibusb_device;event:libusb_hotplug_event;user_data:pbyte):integer;stdcall;
function libusb_hotplug_register_callback(ctx: plibusb_context; events: libusb_hotplug_event;
 flags: libusb_hotplug_flag;vendor_id: integer;product_id: integer;dev_class: integer;cb_fn:libusb_hotplug_callback_fn1;user_data: pbyte;callback_handle:plibusb_hotplug_callback_handle):integer;stdcall;
function libusb_hotplug_deregister_callback(ctx: plibusb_context; callback_handle: libusb_hotplug_callback_handle):integer;stdcall;
      (*Helper Function and Procedures *)
 function libusb_cpu_to_le16(x: uint16_t): uint16_t;
    (*End Helper Function and Procedures *)

  implementation

 //external call to DLL and extended functions and procedures
function libusb_init(ctx: plibusb_context):integer;stdcall; external LIBUSB_DLL_NAME name 'libusb_init';
procedure libusb_exit(ctx: plibusb_context); stdcall; external LIBUSB_DLL_NAME name 'libusb_exit';
// removed LIBUSB_DEPRECATED_FOR(libusb_set_option)
procedure libusb_set_debug(ctx: plibusb_context; level: integer); stdcall; external LIBUSB_DLL_NAME name 'libusb_set_debug';
function libusb_get_version():plibusb_version; stdcall; external LIBUSB_DLL_NAME name 'libusb_get_version';
function libusb_has_capability(capability: uint32_t):integer; stdcall; external LIBUSB_DLL_NAME name 'libusb_has_capability';
procedure libusb_error_name(errcode:integer); stdcall; external LIBUSB_DLL_NAME name 'libusb_error_name';
function libusb_setlocale(locale: pchar):integer; stdcall; external LIBUSB_DLL_NAME name 'libusb_setlocale';
function libusb_strerror(const errorcode:libusb_error):pchar; stdcall; external LIBUSB_DLL_NAME name 'libusb_strerror';
function libusb_get_device_list(ctx:plibusb_context; list: pplibusb_device):ssize_t; stdcall; external LIBUSB_DLL_NAME name 'libusb_get_device_list';
procedure libusb_free_device_list(list:pplibusb_device; unref_devices:integer); stdcall; external LIBUSB_DLL_NAME name 'libusb_free_device_list';
function libusb_ref_device(dev:plibusb_device):plibusb_device;stdcall;external LIBUSB_DLL_NAME name 'libusb_ref_device';
procedure libusb_unref_device(dev: plibusb_device);stdcall;external LIBUSB_DLL_NAME name 'libusb_unref_device';
function libusb_get_configuration(dev: plibusb_device_handle;  config: pinteger):integer;stdcall;external LIBUSB_DLL_NAME name 'libusb_get_configuration';
function libusb_get_device_descriptor(dev: plibusb_device;  desc: plibusb_device_descriptor):integer;stdcall;external LIBUSB_DLL_NAME name 'libusb_get_device_descriptor';
function libusb_get_active_config_descriptor(dev: plibusb_device; const config:pplibusb_config_descriptor):integer;stdcall;external LIBUSB_DLL_NAME name 'libusb_get_active_config_descriptor';
function libusb_get_config_descriptor(dev: plibusb_device;  config_index: uint8_t; const config:pplibusb_config_descriptor ):integer;stdcall;external LIBUSB_DLL_NAME name 'libusb_get_config_descriptor';
function libusb_get_config_descriptor_by_value(dev: plibusb_device;  bConfigurationValue: uint8_t; config:plibusb_config_descriptor ):integer;stdcall;external LIBUSB_DLL_NAME name 'libusb_get_config_descriptor_by_value';
procedure libusb_free_config_descriptor(const config: plibusb_config_descriptor);stdcall;external LIBUSB_DLL_NAME name 'libusb_free_config_descriptor';
function libusb_get_ss_endpoint_companion_descriptor(const ctx: plibusb_context;  endpoint: plibusb_endpoint_descriptor;ep_comp:pplibusb_ss_endpoint_companion_descriptor):integer;stdcall;external LIBUSB_DLL_NAME name 'libusb_get_ss_endpoint_companion_descriptor';
procedure libusb_free_ss_endpoint_companion_descriptor(ep_comp: plibusb_ss_endpoint_companion_descriptor);stdcall;external LIBUSB_DLL_NAME name 'libusb_free_ss_endpoint_companion_descriptor';
function libusb_get_bos_descriptor(handle: plibusb_device_handle;bos:pplibusb_bos_descriptor):integer;stdcall;external LIBUSB_DLL_NAME name 'libusb_get_bos_descriptor';
procedure libusb_free_bos_descriptor(bos: plibusb_bos_descriptor);stdcall;external LIBUSB_DLL_NAME name 'libusb_free_bos_descriptor';
function libusb_get_usb_2_0_extension_descriptor(ctx: plibusb_context;dev_cap: plibusb_bos_dev_capability_descriptor;usb_2_0_extension:pplibusb_usb_2_0_extension_descriptor):integer;stdcall;external LIBUSB_DLL_NAME name 'libusb_get_usb_2_0_extension_descriptor';
procedure libusb_free_usb_2_0_extension_descriptor(usb_2_0_extension: plibusb_usb_2_0_extension_descriptor);stdcall;external LIBUSB_DLL_NAME name 'libusb_free_usb_2_0_extension_descriptor';
function libusb_get_ss_usb_device_capability_descriptor(ctx: plibusb_context;dev_cap:plibusb_bos_dev_capability_descriptor;ss_usb_device_cap:pplibusb_ss_usb_device_capability_descriptor):integer;stdcall;external LIBUSB_DLL_NAME name 'libusb_get_ss_usb_device_capability_descriptor';
procedure libusb_free_ss_usb_device_capability_descriptor(ss_usb_device_cap: plibusb_ss_usb_device_capability_descriptor);stdcall;external LIBUSB_DLL_NAME name 'libusb_free_ss_usb_device_capability_descriptor';
function libusb_get_container_id_descriptor(ctx: plibusb_context; dev_cap: plibusb_bos_dev_capability_descriptor;container_id: pplibusb_container_id_descriptor ):integer;stdcall;external LIBUSB_DLL_NAME name 'libusb_get_container_id_descriptor';
procedure libusb_free_container_id_descriptor(container_id: plibusb_container_id_descriptor);stdcall;external LIBUSB_DLL_NAME name 'libusb_free_container_id_descriptor';
function libusb_get_bus_number(dev: plibusb_device): uint8_t;stdcall;external LIBUSB_DLL_NAME name 'libusb_get_bus_number';
function libusb_get_port_number(dev: plibusb_device):uint8_t;stdcall;external LIBUSB_DLL_NAME name 'libusb_get_port_number';
function libusb_get_port_numbers(dev: plibusb_device; port_numbers: puint8_t; port_numbers_len: integer):integer;stdcall;external LIBUSB_DLL_NAME name 'libusb_get_port_numbers'; //deprecated
function libusb_get_port_path(ctx: plibusb_context;  dev: plibusb_device;  path: puint8_t;  path_length: uint8_t):integer;stdcall;external LIBUSB_DLL_NAME name 'libusb_get_port_path';
function libusb_get_parent(dev:plibusb_device):plibusb_device;stdcall;external LIBUSB_DLL_NAME name 'libusb_get_parent';
function libusb_get_device_address(dev: plibusb_device):uint8_t;stdcall;stdcall;external LIBUSB_DLL_NAME name 'libusb_get_device_address';
function libusb_get_device_speed(dev: plibusb_device):integer;stdcall;external LIBUSB_DLL_NAME name 'libusb_get_device_speed';
function libusb_get_max_packet_size(dev: plibusb_device;endpoint:Byte):integer;stdcall;external LIBUSB_DLL_NAME name 'libusb_get_max_packet_size';
function libusb_get_max_iso_packet_size(dev: plibusb_device; endpoint:Byte):integer;stdcall;external LIBUSB_DLL_NAME name 'libusb_get_max_iso_packet_size';
function libusb_open(dev: plibusb_device;dev_handle:pplibusb_device_handle ):integer;stdcall;external LIBUSB_DLL_NAME name 'libusb_open';
procedure libusb_close(dev_handle: plibusb_device_handle);stdcall;external LIBUSB_DLL_NAME name 'libusb_close';
function libusb_get_device(dev_handle:libusb_device_handle):libusb_device;stdcall;external LIBUSB_DLL_NAME name 'libusb_get_device';
function libusb_set_configuration(dev_handle: plibusb_device_handle; configuration:integer):integer;stdcall;external LIBUSB_DLL_NAME name 'libusb_set_configuration';
function libusb_claim_interface(dev_handle: plibusb_device_handle;interface_number:integer):integer;stdcall;external LIBUSB_DLL_NAME name 'libusb_claim_interface';
function libusb_release_interface(dev_handle: plibusb_device_handle; interface_number: integer):integer;stdcall;external LIBUSB_DLL_NAME name 'libusb_release_interface';
function libusb_open_device_with_vid_pid(ctx:plibusb_context;vendor_id:uint16_t;product_id:uint16_t):plibusb_device_handle;stdcall;external LIBUSB_DLL_NAME name 'libusb_open_device_with_vid_pid';
function libusb_set_interface_alt_setting(dev_handle: plibusb_device_handle;  interface_number: integer;  alternate_setting: integer):integer;stdcall;external LIBUSB_DLL_NAME name 'libusb_set_interface_alt_setting';
function libusb_clear_halt(dev_handle: plibusb_device_handle; endpoint:Byte):integer;stdcall;external LIBUSB_DLL_NAME name 'libusb_clear_halt';
function libusb_reset_device(dev_handle: plibusb_device_handle):integer;stdcall;external LIBUSB_DLL_NAME name 'libusb_reset_device';
//Since version 1.0.19 Returns number of streams allocated
function libusb_alloc_streams(dev_handle: plibusb_device_handle; num_streams: uint32_t;endpoints: pByte;  num_endpoints: integer):Integer;stdcall; external LIBUSB_DLL_NAME name 'libusb_alloc_streams';
//Since version 1.0.19 Free USB streams allocated with libusb_alloc_atreams() returns Libusb_success = 0
function libusb_free_streams(dev_handle: plibusb_device_handle;  endpoints: pbyte;  num_endpoints: integer):Integer;stdcall; external LIBUSB_DLL_NAME name 'libusb_free_streams';
//procedure libusb_free_transfer(transfer: Plibusb_transfer);stdcall;external LIBUSB_DLL_NAME name 'libusb_free_transfer';
function libusb_dev_mem_alloc(dev_handle:plibusb_device_handle;length:size_t):pbyte;stdcall;external LIBUSB_DLL_NAME name 'libusb_dev_mem_alloc';
function libusb_dev_mem_free(dev_handle: plibusb_device_handle;  buffer: pbyte;length: size_t):integer;stdcall;external LIBUSB_DLL_NAME name 'libusb_dev_mem_free';
function libusb_kernel_driver_active(dev_handle: plibusb_device_handle; interface_number:integer):integer;stdcall;external LIBUSB_DLL_NAME name 'libusb_kernel_driver_active';
function libusb_detach_kernel_driver(dev_handle: plibusb_device_handle; interface_number: integer):integer;stdcall;external LIBUSB_DLL_NAME name 'libusb_detach_kernel_driver';
function libusb_attach_kernel_driver(dev_handle: plibusb_device_handle; interface_number: integer):integer;stdcall;external LIBUSB_DLL_NAME name 'libusb_attach_kernel_driver';
function libusb_set_auto_detach_kernel_driver(dev_handle: plibusb_device_handle;  enable: integer):integer;stdcall;external LIBUSB_DLL_NAME name 'libusb_set_auto_detach_kernel_driver';

(*Helper functions and procedures *)
(* async I/O *)
(** \ingroup libusb_asyncio
 * Get the data section of a control transfer. This convenience function is here
 * to remind you that the data does not start until 8 bytes into the actual
 * buffer, as the setup packet comes first.
 *
 * Calling this function only makes sense from a transfer callback function,
 * or situations where you have already allocated a suitably sized buffer at
 * transfer->buffer.
 *
 * \param transfer a transfer
 * \returns pointer to the first byte of the data section *)

function libusb_control_transfer_get_data(transfer: plibusb_transfer): pchar;
begin
  result:= transfer.buffer + LIBUSB_CONTROL_SETUP_SIZE;
 end;
(** \ingroup libusb_asyncio
 * Get the control setup packet of a control transfer. This convenience
 * function is here to remind you that the control setup occupies the first
 * 8 bytes of the transfer data buffer.
 *
 * Calling this function only makes sense from a transfer callback function,
 * or situations where you have already allocated a suitably sized buffer at
 * transfer->buffer.
 *
 * \param transfer a transfer
 * \returns a casted pointer to the start of the transfer data buffer *)

function libusb_control_transfer_get_setup(transfer: plibusb_transfer):plibusb_control_setup;
begin
   result:= plibusb_control_setup(transfer.buffer);
     end;
(** \ingroup libusb_asyncio
 * Helper function to populate the setup packet (first 8 bytes of the data
 * buffer) for a control transfer. The wIndex, wValue and wLength values should
 * be given in host-endian byte order.
 *
 * \param buffer buffer to output the setup packet into
 * This pointer must be aligned to at least 2 bytes boundary.
 * \param bmRequestType see the
 * \ref libusb_control_setup::bmRequestType "bmRequestType" field of
 * \ref libusb_control_setup
 * \param bRequest see the
 * \ref libusb_control_setup::bRequest "bRequest" field of
 * \ref libusb_control_setup
 * \param wValue see the
 * \ref libusb_control_setup::wValue "wValue" field of
 * \ref libusb_control_setup
 * \param wIndex see the
 * \ref libusb_control_setup::wIndex "wIndex" field of
 * \ref libusb_control_setup
 * \param wLength see the
 * \ref libusb_control_setup::wLength "wLength" field of
 * \ref libusb_control_setup  *)

procedure libusb_fill_control_setup(buffer: pchar;bmRequestType:uint8_t;bRequest:uint8_t;
wValue:uint16_t;wIndex:uint16_t;wLength:uint16_t);
var
setup:plibusb_control_setup;
begin
  setup:= plibusb_control_setup(buffer);
  setup.bmRequestType:= bmRequestType;
  setup.bRequest:= bRequest;
  setup.wValue:= libusb_cpu_to_le16(wValue);
  setup.wIndex:= libusb_cpu_to_le16(wIndex);
  setup.wLength:= libusb_cpu_to_le16(wLength);
end;

 (*End Helper Functions and Procedure*)
function libusb_alloc_transfer(iso_packets:integer):Plibusb_transfer; stdcall;external LIBUSB_DLL_NAME name 'libusb_alloc_transfer';
(* 0 on success*)
function libusb_submit_transfer(transfer: plibusb_transfer):integer;stdcall;external  LIBUSB_DLL_NAME name 'libusb_submit_transfer';
(* 0 on success - Asynchronously cancel a previous submitted transfer*)
function libusb_cancel_transfer(transfer: plibusb_transfer):integer;stdcall;external  LIBUSB_DLL_NAME name 'libusb_cancel_transfer';
(*Use libusb_fill_bulk_stream_transfer()* **Deprecated** *)
procedure libusb_free_transfer(transfer:plibusb_transfer);stdcall;external  LIBUSB_DLL_NAME name 'libusb_free_transfer';
procedure libusb_transfer_set_stream_id(transfer:plibusb_transfer;stream_id : uint32_t);stdcall;external LIBUSB_DLL_NAME name 'libusb_transfer_set_stream_id';
function libusb_tranfer_get_stream_id(transfer:plibusb_transfer):uint32_t;stdcall;external  LIBUSB_DLL_NAME name 'libusb_tranfer_get_stream_id';

(** Helper function to populate the required \ref libusb_transfer fields
 * for a control transfer.
 *  If you pass a transfer buffer to this function, the first 8 bytes will
 * be interpreted as a control setup packet, and the wLength field will be
 * used to automatically populate the \ref libusb_transfer::length "length"
 * field of the transfer. Therefore the recommended approach is:
 * -# Allocate a suitably sized data buffer (including space for control setup)
 * -# Call libusb_fill_control_setup()
 * -# If this is a host-to-device transfer with a data stage, put the data
 *    in place after the setup packet
 * -# Call this function
 * -# Call libusb_submit_transfer()
 *
 * It is also legal to pass a NULL buffer to this function, in which case this
 * function will not attempt to populate the length field. Remember that you
 * must then populate the buffer and length fields later.
 *
 * \param transfer the transfer to populate
 * \param dev_handle handle of the device that will handle the transfer
 * \param buffer data buffer. If provided, this function will interpret the
 * first 8 bytes as a setup packet and infer the transfer length from that.
 * This pointer must be aligned to at least 2 bytes boundary.
 * \param callback callback function to be invoked on transfer completion
 * \param user_data user data to pass to callback function
 * \param timeout timeout for the transfer in milliseconds  *)

 procedure libusb_fill_control_transfer(transfer: plibusb_transfer;
 dev_handle: plibusb_device_handle; buffer: pchar;
 callback: libusb_transfer_cb_fn; user_data: pointer; timeout: cardinal);
 var
  setup:plibusb_control_setup;
 begin
  setup:= plibusb_control_setup(buffer);

  transfer.dev_handle:= dev_handle;
  transfer.endpoint:= '0';
  transfer.&type:= chr(LIBUSB_TRANSFER_TYPE_CONTROL);
  transfer.timeout:= timeout;
  transfer.buffer:= buffer;
  if buffer <> chr(0) then
  transfer.length:= LIBUSB_CONTROL_SETUP_SIZE+ libusb_cpu_to_le16(setup.wLength);
  transfer.user_data:= user_data;
  transfer.callback:= callback;
end;

(** \ingroup libusb_asyncio
 * Helper function to populate the required \ref libusb_transfer fields
 * for a bulk transfer.
 *
 * \param transfer the transfer to populate
 * \param dev_handle handle of the device that will handle the transfer
 * \param endpoint address of the endpoint where this transfer will be sent
 * \param buffer data buffer
 * \param length length of data buffer
 * \param callback callback function to be invoked on transfer completion
 * \param user_data user data to pass to callback function
 * \param timeout timeout for the transfer in milliseconds  *)

procedure libusb_fill_bulk_transfer(transfer: plibusb_transfer;
 dev_handle: plibusb_device_handle; endpoint: char; buffer: pchar;
 length: integer;  callback: libusb_transfer_cb_fn; user_data: pointer;
 timeout: uint);
begin
  transfer.dev_handle:= dev_handle;
  transfer.endpoint:= endpoint;
  transfer.&type:= chr(LIBUSB_TRANSFER_TYPE_BULK);
  transfer.timeout:= timeout;
  transfer.buffer:= buffer;
  transfer.length:= length;
  transfer.user_data:= user_data;
  transfer.callback:= callback;
end;
 (** \ingroup libusb_asyncio
 * Helper function to populate the required \ref libusb_transfer fields
 * for a bulk transfer using bulk streams.
 *
 * Since version 1.0.19, \ref LIBUSB_API_VERSION >= 0x01000103
 *
 * \param transfer the transfer to populate
 * \param dev_handle handle of the device that will handle the transfer
 * \param endpoint address of the endpoint where this transfer will be sent
 * \param stream_id bulk stream id for this transfer
 * \param buffer data buffer
 * \param length length of data buffer
 * \param callback callback function to be invoked on transfer completion
 * \param user_data user data to pass to callback function
 * \param timeout timeout for the transfer in milliseconds *)

procedure libusb_fill_bulk_stream_transfer(transfer: plibusb_transfer; dev_handle: plibusb_device_handle; endpoint: char;
 stream_id: uint32_t;buffer: pchar;length: integer; callback: libusb_transfer_cb_fn;user_data:pointer;timeout:uint);
begin
  libusb_fill_bulk_transfer(transfer,dev_handle,endpoint,buffer,length,callback,user_data,timeout);
  transfer.&type:= chr(LIBUSB_TRANSFER_TYPE_BULK_STREAM);
  libusb_transfer_set_stream_id(transfer,stream_id);
end;
(** \ingroup libusb_asyncio
 * Helper function to populate the required \ref libusb_transfer fields
 * for an interrupt transfer.
 *
 * \param transfer the transfer to populate
 * \param dev_handle handle of the device that will handle the transfer
 * \param endpoint address of the endpoint where this transfer will be sent
 * \param buffer data buffer
 * \param length length of data buffer
 * \param callback callback function to be invoked on transfer completion
 * \param user_data user data to pass to callback function
 * \param timeout timeout for the transfer in milliseconds  *)

procedure libusb_fill_interrupt_transfer(transfer:plibusb_transfer;dev_handle:plibusb_device_handle;endpoint:char;
 buffer:pchar; length:integer;callback:libusb_transfer_cb_fn; user_data:pointer;timeout:uint);
begin
  transfer.dev_handle:= dev_handle;
  transfer.endpoint:= endpoint;
  transfer.&type:= chr(LIBUSB_TRANSFER_TYPE_INTERRUPT);
  transfer.timeout:= timeout;
  transfer.buffer:= buffer;
  transfer.length:= length;
  transfer.user_data:= user_data;
  transfer.callback:= callback;
end;
(** \ingroup libusb_asyncio
 * Helper function to populate the required \ref libusb_transfer fields
 * for an isochronous transfer.
 * \param transfer the transfer to populate
 * \param dev_handle handle of the device that will handle the transfer
 * \param endpoint address of the endpoint where this transfer will be sent
 * \param buffer data buffer
 * \param length length of data buffer
 * \param num_iso_packets the number of isochronous packets
 * \param callback callback function to be invoked on transfer completion
 * \param user_data user data to pass to callback function
 * \param timeout timeout for the transfer in milliseconds *)

procedure libusb_fill_iso_transfer(transfer:plibusb_transfer;dev_handle:plibusb_device_handle;endpoint:char;
buffer:pchar;length: integer; num_iso_packets:integer; callback: libusb_transfer_cb_fn;user_data:pointer;timeout: UINT);
begin
  transfer.dev_handle:= dev_handle;
  transfer.endpoint:= endpoint;
  transfer.&type:= chr(LIBUSB_TRANSFER_TYPE_ISOCHRONOUS);
  transfer.timeout:= timeout;
  transfer.buffer:= buffer;
  transfer.length:= length;
  transfer.num_iso_packets:= num_iso_packets;
  transfer.user_data:= user_data;
  transfer.callback:= callback;
end;
(** \ingroup libusb_asyncio
 * Convenience function to set the length of all packets in an isochronous
 * transfer, based on the num_iso_packets field in the transfer structure.
   * \param transfer a transfer
 * \param length the length to set in each isochronous packet descriptor
 * \see libusb_get_max_packet_size()  *)
 procedure libusb_set_iso_packet_lengths(transfer:plibusb_transfer;length:uint);
var
i: integer;
begin
   for i := 0 to transfer.num_iso_packets -1 do
   length:= length+ transfer.iso_packet_desc[i].length;
end;

(** \ingroup libusb_asyncio
 * Convenience function to locate the position of an isochronous packet
 * within the buffer of an isochronous transfer.
 *
 * This is a thorough function which loops through all preceding packets,
 * accumulating their lengths to find the position of the specified packet.
 * Typically you will assign equal lengths to each packet in the transfer,
 * and hence the above method is sub-optimal. You may wish to use
 * libusb_get_iso_packet_buffer_simple() instead.
 *
 * \param transfer a transfer
 * \param packet the packet to return the address of
 * \returns the base address of the packet buffer inside the transfer buffer,
 * or NULL if the packet does not exist.
 * \see libusb_get_iso_packet_buffer_simple()   *)

function libusb_get_iso_packet_buffer(transfer:plibusb_transfer;packet:uint):pchar;
var
i: integer;
offset: size_t;
_packet: integer; (* oops..slight bug in the API. packet is an unsigned int, but we use
  * signed integers almost everywhere else. range-check and convert to
  * signed to avoid compiler warnings. FIXME for libusb-2. *)
begin
   offset:=0;
  if packet > High(integer) then
  begin
    result:= 0;
    exit;
  end;
  _packet:= packet;
  if _packet >= transfer.num_iso_packets  then
  begin
    result:= 0;
    exit;
  end;
    for i:= 0 to _packet -1 do
  offset:= offset + (transfer.iso_packet_desc[i].length);
  result:= transfer.buffer+offset;
  end;

(** \ingroup libusb_asyncio
 * Convenience function to locate the position of an isochronous packet
 * within the buffer of an isochronous transfer, for transfers where each
 * packet is of identical size.
 * This function relies on the assumption that every packet within the transfer
 * is of identical size to the first packet. Calculating the location of
 * the packet buffer is then just a simple calculation:
 * <tt>buffer + (packet_size * packet)</tt>
 * Do not use this function on transfers other than those that have identical
 * packet lengths for each packet.
  * \param transfer a transfer
 * \param packet the packet to return the address of
 * \returns the base address of the packet buffer inside the transfer buffer,
 * or NULL if the packet does not exist.
 * \see libusb_get_iso_packet_buffer()  *)

function libusb_get_iso_packet_buffer_simple(transfer:plibusb_transfer;packet:uint):pchar;
var
_packet: integer; (* oops..slight bug in the API. packet is an unsigned int, but we use
  * signed integers almost everywhere else. range-check and convert to
  * signed to avoid compiler warnings. FIXME for libusb-2. *)
begin
  if packet> High(integer)  then
  begin
    result:= 0;
    exit;
  end;
  _packet:= packet;
  if _packet >= transfer.num_iso_packets
  then
  begin
    result:= 0;
    exit;
  end;
    result:= transfer.buffer+(transfer.iso_packet_desc[0].length * _packet);
   end;

(* sync I/O *)
function libusb_control_transfer(dev_handle:plibusb_device_handle;request_type:uint8_t;bRequest:uint8_t;
 wValue:uint16_t;wIndex: uint16_t; data: pbyte;wLength:uint16_t;timeout: uint):integer;stdcall;  external LIBUSB_DLL_NAME name 'libusb_control_transfer';
function libusb_bulk_transfer(dev_handle:plibusb_device_handle;endpoint:byte;data: pbyte; length: integer;
actual_length: pinteger;timeout:uint):integer;stdcall;  external LIBUSB_DLL_NAME name 'libusb_bulk_transfer';
function libusb_interrupt_transfer(dev_handle:plibusb_device_handle;endpoint:byte;data:pbyte;length:integer;
actual_length:pinteger;timeout:uint):integer;stdcall;  external LIBUSB_DLL_NAME name 'libusb_interrupt_transfer';

(** \ingroup libusb_desc
 * Retrieve a descriptor from the default control pipe.
 * This is a convenience function which formulates the appropriate control
 * message to retrieve the descriptor.
 *
 * \param dev_handle a device handle
 * \param desc_type the descriptor type, see \ref libusb_descriptor_type
 * \param desc_index the index of the descriptor to retrieve
 * \param data output buffer for descriptor
 * \param length size of data buffer
 * \returns number of bytes returned in data, or LIBUSB_ERROR code on failure  *)
function libusb_get_descriptor(dev_handle: plibusb_device_handle;
 desc_type: uint8_t;desc_index: uint8_t; data:pbyte;length:integer):integer;
begin
  result:= libusb_control_transfer(
  dev_handle,
  LIBUSB_ENDPOINT_IN,LIBUSB_REQUEST_GET_DESCRIPTOR,
  uint16_t((desc_type shl 8) or (desc_index)),
  0,
  data,
  uint16_t(length),
  1000);
  end;

(** \ingroup libusb_desc
 * Retrieve a descriptor from a device.
 * This is a convenience function which formulates the appropriate control
 * message to retrieve the descriptor. The string returned is Unicode, as
 * detailed in the USB specifications.
 *
 * \param dev_handle a device handle
 * \param desc_index the index of the descriptor to retrieve
 * \param langid the language ID for the string descriptor
 * \param data output buffer for descriptor
 * \param length size of data buffer
 * \returns number of bytes returned in data, or LIBUSB_ERROR code on failure
 * \see libusb_get_string_descriptor_ascii()  *)

function libusb_get_string_descriptor(dev_handle: plibusb_device_handle;
desc_index: uint8_t; langid: uint16_t; data:pbyte;length:integer):integer;
begin
  begin
    result:= libusb_control_transfer(
    dev_handle,
    LIBUSB_ENDPOINT_IN,LIBUSB_REQUEST_GET_DESCRIPTOR,
    uint16_t((LIBUSB_DT_STRING shl 8) or (desc_index)),
    langid,
    data,
    uint16_t(length),
    1000);
    end;
end;

function libusb_get_string_descriptor_ascii(dev_handle: plibusb_device_handle;
 desc_index:uint8_t; data:pbyte;length:integer):integer;stdcall;external LIBUSB_DLL_NAME name 'libusb_get_string_descriptor_ascii';
  (* polling and timeouts *)
 function libusb_try_lock_events(ctx: plibusb_context):integer;stdcall;external LIBUSB_DLL_NAME name 'libusb_try_lock_events';
procedure libusb_lock_events(ctx: plibusb_context);stdcall;external LIBUSB_DLL_NAME name 'libusb_lock_events';
procedure libusb_unlock_events(ctx: plibusb_context);stdcall;external LIBUSB_DLL_NAME name 'libusb_unlock_events';
function libusb_event_handling_ok(ctx: plibusb_context):integer;stdcall;external LIBUSB_DLL_NAME name 'libusb_event_handling_ok';
function libusb_event_handler_active(ctx: plibusb_context):integer;stdcall;external LIBUSB_DLL_NAME name 'libusb_event_handler_active';
procedure libusb_interrupt_event_handler(ctx: plibusb_context);stdcall;external LIBUSB_DLL_NAME name 'libusb_interrupt_event_handler';
procedure libusb_lock_event_waiters(ctx: plibusb_context);stdcall;external LIBUSB_DLL_NAME name 'libusb_lock_event_waiters';
procedure libusb_unlock_event_waiters(ctx:plibusb_context);stdcall;external LIBUSB_DLL_NAME name 'libusb_unlock_event_waiters';
function libusb_wait_for_event(ctx:plibusb_context;tv:ptimeval):integer;stdcall;external LIBUSB_DLL_NAME name 'libusb_wait_for_event';
function libusb_handle_events_timeout(ctx:plibusb_context; tv:ptimeval):integer;stdcall;external LIBUSB_DLL_NAME name 'libusb_handle_events_timeout';
function libusb_handle_events_timeout_completed(ctx:plibusb_context;tv:ptimeval;completed:pinteger):integer;stdcall;external LIBUSB_DLL_NAME name 'libusb_handle_events_timeout_completed';
function libusb_handle_events(ctx: plibusb_context):integer;stdcall;external LIBUSB_DLL_NAME name 'libusb_handle_events';
function libusb_handle_events_completed(ctx:plibusb_context; completed:pinteger):integer;stdcall;external LIBUSB_DLL_NAME name 'libusb_handle_events_completed';
function libusb_handle_events_locked(ctx:plibusb_context;tv:ptimeval):integer;stdcall;external LIBUSB_DLL_NAME name 'libusb_handle_events_locked';
function libusb_pollfds_handle_timeouts(ctx:plibusb_context):integer;stdcall;external LIBUSB_DLL_NAME name 'libusb_pollfds_handle_timeouts';
function libusb_get_next_timeout(ctx:plibusb_context; tv:ptimeval):integer;stdcall;external LIBUSB_DLL_NAME name 'libusb_get_next_timeout';
function libusb_get_pollfds(ctx:plibusb_context):pplibusb_pollfd;stdcall;external LIBUSB_DLL_NAME name 'libusb_get_pollfds';
procedure libusb_free_pollfds(pollfds:pplibusb_pollfd );stdcall;external LIBUSB_DLL_NAME name 'libusb_free_pollfds';
procedure libusb_set_pollfd_notifiers(ctx:plibusb_context;added_cb:libusb_pollfd_added_cb1;removed_cb: libusb_pollfd_removed_cb1;
user_data:pointer);stdcall;external LIBUSB_DLL_NAME name 'libusb_set_pollfd_notifiers';
function libusb_pollfd_added_cb(fd:integer;events:Smallint;user_data:pointer):pointer;stdcall;external LIBUSB_DLL_NAME name 'libusb_pollfd_added_cb';
function libusb_pollfd_removed_cb(fd:integer; user_data:pointer):pointer;stdcall;external LIBUSB_DLL_NAME name 'libusb_pollfd_removed_cb';
function libusb_hotplugin_callback_fn(ctx:plibusb_context;device:plibusb_device;event:libusb_hotplug_event;user_data:pbyte):integer;stdcall;external LIBUSB_DLL_NAME name 'libusb_hotplugin_callback_fn';
function libusb_hotplug_register_callback(ctx: plibusb_context; events: libusb_hotplug_event;
 flags: libusb_hotplug_flag;vendor_id: integer;product_id: integer;dev_class: integer;cb_fn:libusb_hotplug_callback_fn1;user_data: pbyte;callback_handle:plibusb_hotplug_callback_handle):integer;stdcall;external LIBUSB_DLL_NAME name 'libusb_hotplug_register_callback';
function libusb_hotplug_deregister_callback(ctx: plibusb_context; callback_handle: libusb_hotplug_callback_handle):integer;stdcall;external LIBUSB_DLL_NAME name 'libusb_hotplug_deregister_callback';

(* Other helpers*)
  (*Helper Function and Procedures for Called external *)

 (** \def libusb_le16_to_cpu
 * \ingroup libusb_misc
 * Convert a 16-bit value from little-endian to host-endian format. On
 * little endian systems, this function does nothing. On big endian systems,
 * the bytes are swapped.
 * \param x the little-endian value to convert
 * \returns the value in host-endian byte order *)


 var
 z:_tmp;
    begin
 {IFDEF BIGENDIAN}
 result:= libusb_le16_to_cpu;
 {ELSE}
   case x of
 0:z.b8[1] := (x shr 8);
 1:z.b8[0] := (x and $ff);
  end;
     result:= z.b8[1]+z.b8[0];
    {ENDIF}
  end;

   (*HOTPLUG INFO*)
  //register
 (** \ingroup libusb_hotplug
 * Register a hotplug callback function
 * Register a callback with the libusb_context. The callback will fire
 * when a matching event occurs on a matching device. The callback is
 * armed until either it is deregistered with libusb_hotplug_deregister_callback()
 * or the supplied callback returns 1 to indicate it is finished processing events.
 * If the \ref LIBUSB_HOTPLUG_ENUMERATE is passed the callback will be
 * called with a \ref LIBUSB_HOTPLUG_EVENT_DEVICE_ARRIVED for all devices
 * already plugged into the machine. Note that libusb modifies its internal
 * device list from a separate thread, while calling hotplug callbacks from
 * libusb_handle_events(), so it is possible for a device to already be present
 * on, or removed from, its internal device list, while the hotplug callbacks
 * still need to be dispatched. This means that when using \ref
 * LIBUSB_HOTPLUG_ENUMERATE, your callback may be called twice for the arrival
 * of the same device, once from libusb_hotplug_register_callback() and once
 * from libusb_handle_events(); and/or your callback may be called for the
 * removal of a device for which an arrived call was never made.
  * Since version 1.0.16, \ref LIBUSB_API_VERSION >= 0x01000102
 * \param[in] ctx context to register this callback with
 * \param[in] events bitwise or of events that will trigger this callback. See \ref
 *            libusb_hotplug_event
 * \param[in] flags hotplug callback flags. See \ref libusb_hotplug_flag
 * \param[in] vendor_id the vendor id to match or \ref LIBUSB_HOTPLUG_MATCH_ANY
 * \param[in] product_id the product id to match or \ref LIBUSB_HOTPLUG_MATCH_ANY
 * \param[in] dev_class the device class to match or \ref LIBUSB_HOTPLUG_MATCH_ANY
 * \param[in] cb_fn the function to be invoked on a matching event/device
 * \param[in] user_data user data to pass to the callback function
 * \param[out] callback_handle pointer to store the handle of the allocated callback (can be NULL)
 * \returns LIBUSB_SUCCESS on success LIBUSB_ERROR code on failure *)
 //deregister
 (** \ingroup libusb_hotplug
 * Deregisters a hotplug callback.
 * Deregister a callback from a libusb_context. This function is safe to call from within
 * a hotplug callback.
  * Since version 1.0.16, \ref LIBUSB_API_VERSION >= 0x01000102
 * \param[in] ctx context this callback is registered with
 * \param[in] callback_handle the handle of the callback to deregister *)
 end.