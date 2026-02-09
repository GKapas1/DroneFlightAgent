// generated from rosidl_generator_c/resource/idl__description.c.em
// with input from px4:msg/DifferentialVelocitySetpoint.idl
// generated code does not contain a copyright notice

#include "px4/msg/detail/differential_velocity_setpoint__functions.h"

ROSIDL_GENERATOR_C_PUBLIC_px4
const rosidl_type_hash_t *
px4__msg__DifferentialVelocitySetpoint__get_type_hash(
  const rosidl_message_type_support_t * type_support)
{
  (void)type_support;
  static rosidl_type_hash_t hash = {1, {
      0xc1, 0x7d, 0x5b, 0xb6, 0x81, 0x1e, 0x11, 0xfb,
      0x92, 0xee, 0x28, 0xef, 0x2d, 0xb0, 0xd3, 0xb6,
      0xa3, 0x2e, 0xb7, 0x66, 0x9a, 0xa5, 0x47, 0x49,
      0x18, 0x21, 0xbb, 0x33, 0x0a, 0x65, 0x7f, 0x11,
    }};
  return &hash;
}

#include <assert.h>
#include <string.h>

// Include directives for referenced types

// Hashes for external referenced types
#ifndef NDEBUG
#endif

static char px4__msg__DifferentialVelocitySetpoint__TYPE_NAME[] = "px4/msg/DifferentialVelocitySetpoint";

// Define type names, field names, and default values
static char px4__msg__DifferentialVelocitySetpoint__FIELD_NAME__timestamp[] = "timestamp";
static char px4__msg__DifferentialVelocitySetpoint__FIELD_NAME__speed[] = "speed";
static char px4__msg__DifferentialVelocitySetpoint__FIELD_NAME__bearing[] = "bearing";

static rosidl_runtime_c__type_description__Field px4__msg__DifferentialVelocitySetpoint__FIELDS[] = {
  {
    {px4__msg__DifferentialVelocitySetpoint__FIELD_NAME__timestamp, 9, 9},
    {
      rosidl_runtime_c__type_description__FieldType__FIELD_TYPE_UINT64,
      0,
      0,
      {NULL, 0, 0},
    },
    {NULL, 0, 0},
  },
  {
    {px4__msg__DifferentialVelocitySetpoint__FIELD_NAME__speed, 5, 5},
    {
      rosidl_runtime_c__type_description__FieldType__FIELD_TYPE_FLOAT,
      0,
      0,
      {NULL, 0, 0},
    },
    {NULL, 0, 0},
  },
  {
    {px4__msg__DifferentialVelocitySetpoint__FIELD_NAME__bearing, 7, 7},
    {
      rosidl_runtime_c__type_description__FieldType__FIELD_TYPE_FLOAT,
      0,
      0,
      {NULL, 0, 0},
    },
    {NULL, 0, 0},
  },
};

const rosidl_runtime_c__type_description__TypeDescription *
px4__msg__DifferentialVelocitySetpoint__get_type_description(
  const rosidl_message_type_support_t * type_support)
{
  (void)type_support;
  static bool constructed = false;
  static const rosidl_runtime_c__type_description__TypeDescription description = {
    {
      {px4__msg__DifferentialVelocitySetpoint__TYPE_NAME, 36, 36},
      {px4__msg__DifferentialVelocitySetpoint__FIELDS, 3, 3},
    },
    {NULL, 0, 0},
  };
  if (!constructed) {
    constructed = true;
  }
  return &description;
}

static char toplevel_type_raw_source[] =
  "uint64 timestamp # time since system start (microseconds)\n"
  "\n"
  "float32 speed   # [m/s] [-inf, inf] Speed setpoint (Backwards driving if negative)\n"
  "float32 bearing # [rad] [-pi,pi] from North.";

static char msg_encoding[] = "msg";

// Define all individual source functions

const rosidl_runtime_c__type_description__TypeSource *
px4__msg__DifferentialVelocitySetpoint__get_individual_type_description_source(
  const rosidl_message_type_support_t * type_support)
{
  (void)type_support;
  static const rosidl_runtime_c__type_description__TypeSource source = {
    {px4__msg__DifferentialVelocitySetpoint__TYPE_NAME, 36, 36},
    {msg_encoding, 3, 3},
    {toplevel_type_raw_source, 187, 187},
  };
  return &source;
}

const rosidl_runtime_c__type_description__TypeSource__Sequence *
px4__msg__DifferentialVelocitySetpoint__get_type_description_sources(
  const rosidl_message_type_support_t * type_support)
{
  (void)type_support;
  static rosidl_runtime_c__type_description__TypeSource sources[1];
  static const rosidl_runtime_c__type_description__TypeSource__Sequence source_sequence = {sources, 1, 1};
  static bool constructed = false;
  if (!constructed) {
    sources[0] = *px4__msg__DifferentialVelocitySetpoint__get_individual_type_description_source(NULL),
    constructed = true;
  }
  return &source_sequence;
}
