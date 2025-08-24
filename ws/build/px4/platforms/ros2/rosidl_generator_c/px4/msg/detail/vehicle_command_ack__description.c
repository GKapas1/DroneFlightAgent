// generated from rosidl_generator_c/resource/idl__description.c.em
// with input from px4:msg/VehicleCommandAck.idl
// generated code does not contain a copyright notice

#include "px4/msg/detail/vehicle_command_ack__functions.h"

ROSIDL_GENERATOR_C_PUBLIC_px4
const rosidl_type_hash_t *
px4__msg__VehicleCommandAck__get_type_hash(
  const rosidl_message_type_support_t * type_support)
{
  (void)type_support;
  static rosidl_type_hash_t hash = {1, {
      0x72, 0x23, 0xf6, 0x51, 0x44, 0x65, 0x74, 0x73,
      0x03, 0xbd, 0x1c, 0xa0, 0x02, 0x45, 0x8b, 0xca,
      0x13, 0x58, 0xc1, 0x17, 0x99, 0xda, 0x02, 0x8b,
      0x7a, 0x91, 0x01, 0x0e, 0x74, 0xb8, 0x62, 0xbf,
    }};
  return &hash;
}

#include <assert.h>
#include <string.h>

// Include directives for referenced types

// Hashes for external referenced types
#ifndef NDEBUG
#endif

static char px4__msg__VehicleCommandAck__TYPE_NAME[] = "px4/msg/VehicleCommandAck";

// Define type names, field names, and default values
static char px4__msg__VehicleCommandAck__FIELD_NAME__timestamp[] = "timestamp";
static char px4__msg__VehicleCommandAck__FIELD_NAME__command[] = "command";
static char px4__msg__VehicleCommandAck__FIELD_NAME__result[] = "result";
static char px4__msg__VehicleCommandAck__FIELD_NAME__result_param1[] = "result_param1";
static char px4__msg__VehicleCommandAck__FIELD_NAME__result_param2[] = "result_param2";
static char px4__msg__VehicleCommandAck__FIELD_NAME__target_system[] = "target_system";
static char px4__msg__VehicleCommandAck__FIELD_NAME__target_component[] = "target_component";
static char px4__msg__VehicleCommandAck__FIELD_NAME__from_external[] = "from_external";

static rosidl_runtime_c__type_description__Field px4__msg__VehicleCommandAck__FIELDS[] = {
  {
    {px4__msg__VehicleCommandAck__FIELD_NAME__timestamp, 9, 9},
    {
      rosidl_runtime_c__type_description__FieldType__FIELD_TYPE_UINT64,
      0,
      0,
      {NULL, 0, 0},
    },
    {NULL, 0, 0},
  },
  {
    {px4__msg__VehicleCommandAck__FIELD_NAME__command, 7, 7},
    {
      rosidl_runtime_c__type_description__FieldType__FIELD_TYPE_UINT32,
      0,
      0,
      {NULL, 0, 0},
    },
    {NULL, 0, 0},
  },
  {
    {px4__msg__VehicleCommandAck__FIELD_NAME__result, 6, 6},
    {
      rosidl_runtime_c__type_description__FieldType__FIELD_TYPE_UINT8,
      0,
      0,
      {NULL, 0, 0},
    },
    {NULL, 0, 0},
  },
  {
    {px4__msg__VehicleCommandAck__FIELD_NAME__result_param1, 13, 13},
    {
      rosidl_runtime_c__type_description__FieldType__FIELD_TYPE_UINT8,
      0,
      0,
      {NULL, 0, 0},
    },
    {NULL, 0, 0},
  },
  {
    {px4__msg__VehicleCommandAck__FIELD_NAME__result_param2, 13, 13},
    {
      rosidl_runtime_c__type_description__FieldType__FIELD_TYPE_INT32,
      0,
      0,
      {NULL, 0, 0},
    },
    {NULL, 0, 0},
  },
  {
    {px4__msg__VehicleCommandAck__FIELD_NAME__target_system, 13, 13},
    {
      rosidl_runtime_c__type_description__FieldType__FIELD_TYPE_UINT8,
      0,
      0,
      {NULL, 0, 0},
    },
    {NULL, 0, 0},
  },
  {
    {px4__msg__VehicleCommandAck__FIELD_NAME__target_component, 16, 16},
    {
      rosidl_runtime_c__type_description__FieldType__FIELD_TYPE_UINT8,
      0,
      0,
      {NULL, 0, 0},
    },
    {NULL, 0, 0},
  },
  {
    {px4__msg__VehicleCommandAck__FIELD_NAME__from_external, 13, 13},
    {
      rosidl_runtime_c__type_description__FieldType__FIELD_TYPE_BOOLEAN,
      0,
      0,
      {NULL, 0, 0},
    },
    {NULL, 0, 0},
  },
};

const rosidl_runtime_c__type_description__TypeDescription *
px4__msg__VehicleCommandAck__get_type_description(
  const rosidl_message_type_support_t * type_support)
{
  (void)type_support;
  static bool constructed = false;
  static const rosidl_runtime_c__type_description__TypeDescription description = {
    {
      {px4__msg__VehicleCommandAck__TYPE_NAME, 25, 25},
      {px4__msg__VehicleCommandAck__FIELDS, 8, 8},
    },
    {NULL, 0, 0},
  };
  if (!constructed) {
    constructed = true;
  }
  return &description;
}

static char toplevel_type_raw_source[] =
  "# Vehicle Command Ackonwledgement uORB message.\n"
  "# Used for acknowledging the vehicle command being received.\n"
  "# Follows the MAVLink COMMAND_ACK message definition\n"
  "\n"
  "uint64 timestamp\\t\\t# time since system start (microseconds)\n"
  "\n"
  "# Result cases. This follows the MAVLink MAV_RESULT enum definition\n"
  "uint8 VEHICLE_CMD_RESULT_ACCEPTED = 0\\t\\t\\t# Command ACCEPTED and EXECUTED |\n"
  "uint8 VEHICLE_CMD_RESULT_TEMPORARILY_REJECTED = 1\\t# Command TEMPORARY REJECTED/DENIED |\n"
  "uint8 VEHICLE_CMD_RESULT_DENIED = 2\\t\\t\\t# Command PERMANENTLY DENIED |\n"
  "uint8 VEHICLE_CMD_RESULT_UNSUPPORTED = 3\\t\\t# Command UNKNOWN/UNSUPPORTED |\n"
  "uint8 VEHICLE_CMD_RESULT_FAILED = 4\\t\\t\\t# Command executed, but failed |\n"
  "uint8 VEHICLE_CMD_RESULT_IN_PROGRESS = 5\\t\\t# Command being executed |\n"
  "uint8 VEHICLE_CMD_RESULT_CANCELLED = 6\\t\\t\\t# Command Canceled\n"
  "\n"
  "# Arming denied specific cases\n"
  "uint16 ARM_AUTH_DENIED_REASON_GENERIC = 0\n"
  "uint16 ARM_AUTH_DENIED_REASON_NONE = 1\n"
  "uint16 ARM_AUTH_DENIED_REASON_INVALID_WAYPOINT = 2\n"
  "uint16 ARM_AUTH_DENIED_REASON_TIMEOUT = 3\n"
  "uint16 ARM_AUTH_DENIED_REASON_AIRSPACE_IN_USE = 4\n"
  "uint16 ARM_AUTH_DENIED_REASON_BAD_WEATHER = 5\n"
  "\n"
  "uint8 ORB_QUEUE_LENGTH = 4\n"
  "\n"
  "uint32 command\\t\\t\\t\\t\\t\\t# Command that is being acknowledged\n"
  "uint8 result\\t\\t\\t\\t\\t\\t# Command result\n"
  "uint8 result_param1\\t\\t\\t\\t\\t# Also used as progress[%], it can be set with the reason why the command was denied, or the progress percentage when result is MAV_RESULT_IN_PROGRESS\n"
  "int32 result_param2\\t\\t\\t\\t\\t# Additional parameter of the result, example: which parameter of MAV_CMD_NAV_WAYPOINT caused it to be denied.\n"
  "uint8 target_system\n"
  "uint8 target_component\n"
  "\n"
  "bool from_external\\t\\t\\t\\t\\t# Indicates if the command came from an external source";

static char msg_encoding[] = "msg";

// Define all individual source functions

const rosidl_runtime_c__type_description__TypeSource *
px4__msg__VehicleCommandAck__get_individual_type_description_source(
  const rosidl_message_type_support_t * type_support)
{
  (void)type_support;
  static const rosidl_runtime_c__type_description__TypeSource source = {
    {px4__msg__VehicleCommandAck__TYPE_NAME, 25, 25},
    {msg_encoding, 3, 3},
    {toplevel_type_raw_source, 1652, 1652},
  };
  return &source;
}

const rosidl_runtime_c__type_description__TypeSource__Sequence *
px4__msg__VehicleCommandAck__get_type_description_sources(
  const rosidl_message_type_support_t * type_support)
{
  (void)type_support;
  static rosidl_runtime_c__type_description__TypeSource sources[1];
  static const rosidl_runtime_c__type_description__TypeSource__Sequence source_sequence = {sources, 1, 1};
  static bool constructed = false;
  if (!constructed) {
    sources[0] = *px4__msg__VehicleCommandAck__get_individual_type_description_source(NULL),
    constructed = true;
  }
  return &source_sequence;
}
