// generated from rosidl_generator_c/resource/idl__description.c.em
// with input from px4:msg/GeofenceResult.idl
// generated code does not contain a copyright notice

#include "px4/msg/detail/geofence_result__functions.h"

ROSIDL_GENERATOR_C_PUBLIC_px4
const rosidl_type_hash_t *
px4__msg__GeofenceResult__get_type_hash(
  const rosidl_message_type_support_t * type_support)
{
  (void)type_support;
  static rosidl_type_hash_t hash = {1, {
      0x30, 0xc4, 0xdb, 0x12, 0x05, 0x63, 0xc5, 0xd2,
      0x0e, 0x28, 0x8a, 0xbe, 0x30, 0x61, 0xeb, 0xca,
      0x01, 0x39, 0x7e, 0xe7, 0x1a, 0x84, 0x1f, 0x2b,
      0x5d, 0x59, 0xe5, 0x2f, 0x95, 0xe9, 0x96, 0x25,
    }};
  return &hash;
}

#include <assert.h>
#include <string.h>

// Include directives for referenced types

// Hashes for external referenced types
#ifndef NDEBUG
#endif

static char px4__msg__GeofenceResult__TYPE_NAME[] = "px4/msg/GeofenceResult";

// Define type names, field names, and default values
static char px4__msg__GeofenceResult__FIELD_NAME__timestamp[] = "timestamp";
static char px4__msg__GeofenceResult__FIELD_NAME__geofence_violation_reason[] = "geofence_violation_reason";
static char px4__msg__GeofenceResult__FIELD_NAME__primary_geofence_breached[] = "primary_geofence_breached";
static char px4__msg__GeofenceResult__FIELD_NAME__primary_geofence_action[] = "primary_geofence_action";
static char px4__msg__GeofenceResult__FIELD_NAME__home_required[] = "home_required";

static rosidl_runtime_c__type_description__Field px4__msg__GeofenceResult__FIELDS[] = {
  {
    {px4__msg__GeofenceResult__FIELD_NAME__timestamp, 9, 9},
    {
      rosidl_runtime_c__type_description__FieldType__FIELD_TYPE_UINT64,
      0,
      0,
      {NULL, 0, 0},
    },
    {NULL, 0, 0},
  },
  {
    {px4__msg__GeofenceResult__FIELD_NAME__geofence_violation_reason, 25, 25},
    {
      rosidl_runtime_c__type_description__FieldType__FIELD_TYPE_UINT8,
      0,
      0,
      {NULL, 0, 0},
    },
    {NULL, 0, 0},
  },
  {
    {px4__msg__GeofenceResult__FIELD_NAME__primary_geofence_breached, 25, 25},
    {
      rosidl_runtime_c__type_description__FieldType__FIELD_TYPE_BOOLEAN,
      0,
      0,
      {NULL, 0, 0},
    },
    {NULL, 0, 0},
  },
  {
    {px4__msg__GeofenceResult__FIELD_NAME__primary_geofence_action, 23, 23},
    {
      rosidl_runtime_c__type_description__FieldType__FIELD_TYPE_UINT8,
      0,
      0,
      {NULL, 0, 0},
    },
    {NULL, 0, 0},
  },
  {
    {px4__msg__GeofenceResult__FIELD_NAME__home_required, 13, 13},
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
px4__msg__GeofenceResult__get_type_description(
  const rosidl_message_type_support_t * type_support)
{
  (void)type_support;
  static bool constructed = false;
  static const rosidl_runtime_c__type_description__TypeDescription description = {
    {
      {px4__msg__GeofenceResult__TYPE_NAME, 22, 22},
      {px4__msg__GeofenceResult__FIELDS, 5, 5},
    },
    {NULL, 0, 0},
  };
  if (!constructed) {
    constructed = true;
  }
  return &description;
}

static char toplevel_type_raw_source[] =
  "uint64 timestamp                        # time since system start (microseconds)\n"
  "uint8 GF_ACTION_NONE = 0                # no action on geofence violation\n"
  "uint8 GF_ACTION_WARN = 1                # critical mavlink message\n"
  "uint8 GF_ACTION_LOITER = 2              # switch to AUTO|LOITER\n"
  "uint8 GF_ACTION_RTL = 3                 # switch to AUTO|RTL\n"
  "uint8 GF_ACTION_TERMINATE = 4           # flight termination\n"
  "uint8 GF_ACTION_LAND = 5                # switch to AUTO|LAND\n"
  "\n"
  "uint8 geofence_violation_reason         # one of geofence_violation_reason_t::*\n"
  "\n"
  "bool primary_geofence_breached          # true if the primary geofence is breached\n"
  "uint8 primary_geofence_action           # action to take when the primary geofence is breached\n"
  "\n"
  "bool home_required                      # true if the geofence requires a valid home position";

static char msg_encoding[] = "msg";

// Define all individual source functions

const rosidl_runtime_c__type_description__TypeSource *
px4__msg__GeofenceResult__get_individual_type_description_source(
  const rosidl_message_type_support_t * type_support)
{
  (void)type_support;
  static const rosidl_runtime_c__type_description__TypeSource source = {
    {px4__msg__GeofenceResult__TYPE_NAME, 22, 22},
    {msg_encoding, 3, 3},
    {toplevel_type_raw_source, 825, 825},
  };
  return &source;
}

const rosidl_runtime_c__type_description__TypeSource__Sequence *
px4__msg__GeofenceResult__get_type_description_sources(
  const rosidl_message_type_support_t * type_support)
{
  (void)type_support;
  static rosidl_runtime_c__type_description__TypeSource sources[1];
  static const rosidl_runtime_c__type_description__TypeSource__Sequence source_sequence = {sources, 1, 1};
  static bool constructed = false;
  if (!constructed) {
    sources[0] = *px4__msg__GeofenceResult__get_individual_type_description_source(NULL),
    constructed = true;
  }
  return &source_sequence;
}
