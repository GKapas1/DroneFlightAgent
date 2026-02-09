// generated from rosidl_generator_c/resource/idl__description.c.em
// with input from px4_msgs:msg/DeviceInformation.idl
// generated code does not contain a copyright notice

#include "px4_msgs/msg/detail/device_information__functions.h"

ROSIDL_GENERATOR_C_PUBLIC_px4_msgs
const rosidl_type_hash_t *
px4_msgs__msg__DeviceInformation__get_type_hash(
  const rosidl_message_type_support_t * type_support)
{
  (void)type_support;
  static rosidl_type_hash_t hash = {1, {
      0xcf, 0x0b, 0x36, 0x7f, 0x21, 0xf8, 0xd9, 0x5b,
      0xf5, 0x32, 0x7f, 0xf3, 0x0a, 0xfa, 0xa5, 0xaf,
      0xbb, 0x1e, 0xbc, 0xc2, 0xd3, 0x68, 0xc4, 0xb1,
      0x4c, 0x5a, 0x3a, 0x96, 0x24, 0x7d, 0x1c, 0x23,
    }};
  return &hash;
}

#include <assert.h>
#include <string.h>

// Include directives for referenced types

// Hashes for external referenced types
#ifndef NDEBUG
#endif

static char px4_msgs__msg__DeviceInformation__TYPE_NAME[] = "px4_msgs/msg/DeviceInformation";

// Define type names, field names, and default values
static char px4_msgs__msg__DeviceInformation__FIELD_NAME__timestamp[] = "timestamp";
static char px4_msgs__msg__DeviceInformation__FIELD_NAME__device_type[] = "device_type";
static char px4_msgs__msg__DeviceInformation__FIELD_NAME__vendor_name[] = "vendor_name";
static char px4_msgs__msg__DeviceInformation__FIELD_NAME__model_name[] = "model_name";
static char px4_msgs__msg__DeviceInformation__FIELD_NAME__device_id[] = "device_id";
static char px4_msgs__msg__DeviceInformation__FIELD_NAME__firmware_version[] = "firmware_version";
static char px4_msgs__msg__DeviceInformation__FIELD_NAME__hardware_version[] = "hardware_version";
static char px4_msgs__msg__DeviceInformation__FIELD_NAME__serial_number[] = "serial_number";

static rosidl_runtime_c__type_description__Field px4_msgs__msg__DeviceInformation__FIELDS[] = {
  {
    {px4_msgs__msg__DeviceInformation__FIELD_NAME__timestamp, 9, 9},
    {
      rosidl_runtime_c__type_description__FieldType__FIELD_TYPE_UINT64,
      0,
      0,
      {NULL, 0, 0},
    },
    {NULL, 0, 0},
  },
  {
    {px4_msgs__msg__DeviceInformation__FIELD_NAME__device_type, 11, 11},
    {
      rosidl_runtime_c__type_description__FieldType__FIELD_TYPE_UINT8,
      0,
      0,
      {NULL, 0, 0},
    },
    {NULL, 0, 0},
  },
  {
    {px4_msgs__msg__DeviceInformation__FIELD_NAME__vendor_name, 11, 11},
    {
      rosidl_runtime_c__type_description__FieldType__FIELD_TYPE_UINT8_ARRAY,
      32,
      0,
      {NULL, 0, 0},
    },
    {NULL, 0, 0},
  },
  {
    {px4_msgs__msg__DeviceInformation__FIELD_NAME__model_name, 10, 10},
    {
      rosidl_runtime_c__type_description__FieldType__FIELD_TYPE_UINT8_ARRAY,
      32,
      0,
      {NULL, 0, 0},
    },
    {NULL, 0, 0},
  },
  {
    {px4_msgs__msg__DeviceInformation__FIELD_NAME__device_id, 9, 9},
    {
      rosidl_runtime_c__type_description__FieldType__FIELD_TYPE_UINT32,
      0,
      0,
      {NULL, 0, 0},
    },
    {NULL, 0, 0},
  },
  {
    {px4_msgs__msg__DeviceInformation__FIELD_NAME__firmware_version, 16, 16},
    {
      rosidl_runtime_c__type_description__FieldType__FIELD_TYPE_UINT8_ARRAY,
      24,
      0,
      {NULL, 0, 0},
    },
    {NULL, 0, 0},
  },
  {
    {px4_msgs__msg__DeviceInformation__FIELD_NAME__hardware_version, 16, 16},
    {
      rosidl_runtime_c__type_description__FieldType__FIELD_TYPE_UINT8_ARRAY,
      24,
      0,
      {NULL, 0, 0},
    },
    {NULL, 0, 0},
  },
  {
    {px4_msgs__msg__DeviceInformation__FIELD_NAME__serial_number, 13, 13},
    {
      rosidl_runtime_c__type_description__FieldType__FIELD_TYPE_UINT8_ARRAY,
      33,
      0,
      {NULL, 0, 0},
    },
    {NULL, 0, 0},
  },
};

const rosidl_runtime_c__type_description__TypeDescription *
px4_msgs__msg__DeviceInformation__get_type_description(
  const rosidl_message_type_support_t * type_support)
{
  (void)type_support;
  static bool constructed = false;
  static const rosidl_runtime_c__type_description__TypeDescription description = {
    {
      {px4_msgs__msg__DeviceInformation__TYPE_NAME, 30, 30},
      {px4_msgs__msg__DeviceInformation__FIELDS, 8, 8},
    },
    {NULL, 0, 0},
  };
  if (!constructed) {
    constructed = true;
  }
  return &description;
}

static char toplevel_type_raw_source[] =
  "# Device information\n"
  "#\n"
  "# Can be used to uniquely associate a device_id from a sensor topic with a physical device using serial number.\n"
  "# as well as tracking of the used firmware versions on the devices.\n"
  "\n"
  "uint64 timestamp  # time since system start (microseconds)\n"
  "\n"
  "uint8 device_type  # [@enum DEVICE_TYPE] Type of the device. Matches MAVLink DEVICE_TYPE enum\n"
  "\n"
  "uint8 DEVICE_TYPE_GENERIC = 0                 # Generic/unknown sensor\n"
  "uint8 DEVICE_TYPE_AIRSPEED = 1                # Airspeed sensor\n"
  "uint8 DEVICE_TYPE_ESC = 2                     # ESC\n"
  "uint8 DEVICE_TYPE_SERVO = 3                   # Servo\n"
  "uint8 DEVICE_TYPE_GPS = 4                     # GPS\n"
  "uint8 DEVICE_TYPE_MAGNETOMETER = 5            # Magnetometer\n"
  "uint8 DEVICE_TYPE_PARACHUTE = 6               # Parachute\n"
  "uint8 DEVICE_TYPE_RANGEFINDER = 7             # Rangefinder\n"
  "uint8 DEVICE_TYPE_WINCH = 8                   # Winch\n"
  "uint8 DEVICE_TYPE_BAROMETER = 9               # Barometer\n"
  "uint8 DEVICE_TYPE_OPTICAL_FLOW = 10           # Optical flow\n"
  "uint8 DEVICE_TYPE_ACCELEROMETER = 11          # Accelerometer\n"
  "uint8 DEVICE_TYPE_GYROSCOPE = 12              # Gyroscope\n"
  "uint8 DEVICE_TYPE_DIFFERENTIAL_PRESSURE = 13  # Differential pressure\n"
  "uint8 DEVICE_TYPE_BATTERY = 14                # Battery\n"
  "uint8 DEVICE_TYPE_HYGROMETER = 15             # Hygrometer\n"
  "\n"
  "char[32] vendor_name  # Name of the device vendor\n"
  "char[32] model_name   # Name of the device model\n"
  "\n"
  "uint32   device_id         # [-] [@invalid 0 if not available] Unique device ID for the sensor. Does not change between power cycles.\n"
  "char[24] firmware_version  # [-] [@invalid empty if not available] Firmware version.\n"
  "char[24] hardware_version  # [-] [@invalid empty if not available] Hardware version.\n"
  "char[33] serial_number     # [-] [@invalid empty if not available] Device serial number or unique identifier.";

static char msg_encoding[] = "msg";

// Define all individual source functions

const rosidl_runtime_c__type_description__TypeSource *
px4_msgs__msg__DeviceInformation__get_individual_type_description_source(
  const rosidl_message_type_support_t * type_support)
{
  (void)type_support;
  static const rosidl_runtime_c__type_description__TypeSource source = {
    {px4_msgs__msg__DeviceInformation__TYPE_NAME, 30, 30},
    {msg_encoding, 3, 3},
    {toplevel_type_raw_source, 1824, 1824},
  };
  return &source;
}

const rosidl_runtime_c__type_description__TypeSource__Sequence *
px4_msgs__msg__DeviceInformation__get_type_description_sources(
  const rosidl_message_type_support_t * type_support)
{
  (void)type_support;
  static rosidl_runtime_c__type_description__TypeSource sources[1];
  static const rosidl_runtime_c__type_description__TypeSource__Sequence source_sequence = {sources, 1, 1};
  static bool constructed = false;
  if (!constructed) {
    sources[0] = *px4_msgs__msg__DeviceInformation__get_individual_type_description_source(NULL),
    constructed = true;
  }
  return &source_sequence;
}
