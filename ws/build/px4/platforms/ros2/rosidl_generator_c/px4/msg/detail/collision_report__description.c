// generated from rosidl_generator_c/resource/idl__description.c.em
// with input from px4:msg/CollisionReport.idl
// generated code does not contain a copyright notice

#include "px4/msg/detail/collision_report__functions.h"

ROSIDL_GENERATOR_C_PUBLIC_px4
const rosidl_type_hash_t *
px4__msg__CollisionReport__get_type_hash(
  const rosidl_message_type_support_t * type_support)
{
  (void)type_support;
  static rosidl_type_hash_t hash = {1, {
      0x25, 0xc6, 0x68, 0x0f, 0x43, 0x7d, 0xa8, 0xec,
      0x90, 0x71, 0x12, 0x0c, 0x26, 0x71, 0xfa, 0x3e,
      0x86, 0x68, 0xf8, 0x62, 0xb3, 0x29, 0x9d, 0xbc,
      0xd0, 0x74, 0x12, 0xcb, 0x77, 0xe5, 0xb8, 0xfa,
    }};
  return &hash;
}

#include <assert.h>
#include <string.h>

// Include directives for referenced types

// Hashes for external referenced types
#ifndef NDEBUG
#endif

static char px4__msg__CollisionReport__TYPE_NAME[] = "px4/msg/CollisionReport";

// Define type names, field names, and default values
static char px4__msg__CollisionReport__FIELD_NAME__timestamp[] = "timestamp";
static char px4__msg__CollisionReport__FIELD_NAME__src[] = "src";
static char px4__msg__CollisionReport__FIELD_NAME__id[] = "id";
static char px4__msg__CollisionReport__FIELD_NAME__action[] = "action";
static char px4__msg__CollisionReport__FIELD_NAME__threat_level[] = "threat_level";
static char px4__msg__CollisionReport__FIELD_NAME__time_to_minimum_delta[] = "time_to_minimum_delta";
static char px4__msg__CollisionReport__FIELD_NAME__altitude_minimum_delta[] = "altitude_minimum_delta";
static char px4__msg__CollisionReport__FIELD_NAME__horizontal_minimum_delta[] = "horizontal_minimum_delta";

static rosidl_runtime_c__type_description__Field px4__msg__CollisionReport__FIELDS[] = {
  {
    {px4__msg__CollisionReport__FIELD_NAME__timestamp, 9, 9},
    {
      rosidl_runtime_c__type_description__FieldType__FIELD_TYPE_UINT64,
      0,
      0,
      {NULL, 0, 0},
    },
    {NULL, 0, 0},
  },
  {
    {px4__msg__CollisionReport__FIELD_NAME__src, 3, 3},
    {
      rosidl_runtime_c__type_description__FieldType__FIELD_TYPE_UINT8,
      0,
      0,
      {NULL, 0, 0},
    },
    {NULL, 0, 0},
  },
  {
    {px4__msg__CollisionReport__FIELD_NAME__id, 2, 2},
    {
      rosidl_runtime_c__type_description__FieldType__FIELD_TYPE_UINT32,
      0,
      0,
      {NULL, 0, 0},
    },
    {NULL, 0, 0},
  },
  {
    {px4__msg__CollisionReport__FIELD_NAME__action, 6, 6},
    {
      rosidl_runtime_c__type_description__FieldType__FIELD_TYPE_UINT8,
      0,
      0,
      {NULL, 0, 0},
    },
    {NULL, 0, 0},
  },
  {
    {px4__msg__CollisionReport__FIELD_NAME__threat_level, 12, 12},
    {
      rosidl_runtime_c__type_description__FieldType__FIELD_TYPE_UINT8,
      0,
      0,
      {NULL, 0, 0},
    },
    {NULL, 0, 0},
  },
  {
    {px4__msg__CollisionReport__FIELD_NAME__time_to_minimum_delta, 21, 21},
    {
      rosidl_runtime_c__type_description__FieldType__FIELD_TYPE_FLOAT,
      0,
      0,
      {NULL, 0, 0},
    },
    {NULL, 0, 0},
  },
  {
    {px4__msg__CollisionReport__FIELD_NAME__altitude_minimum_delta, 22, 22},
    {
      rosidl_runtime_c__type_description__FieldType__FIELD_TYPE_FLOAT,
      0,
      0,
      {NULL, 0, 0},
    },
    {NULL, 0, 0},
  },
  {
    {px4__msg__CollisionReport__FIELD_NAME__horizontal_minimum_delta, 24, 24},
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
px4__msg__CollisionReport__get_type_description(
  const rosidl_message_type_support_t * type_support)
{
  (void)type_support;
  static bool constructed = false;
  static const rosidl_runtime_c__type_description__TypeDescription description = {
    {
      {px4__msg__CollisionReport__TYPE_NAME, 23, 23},
      {px4__msg__CollisionReport__FIELDS, 8, 8},
    },
    {NULL, 0, 0},
  };
  if (!constructed) {
    constructed = true;
  }
  return &description;
}

static char toplevel_type_raw_source[] =
  "uint64 timestamp\\t\\t# time since system start (microseconds)\n"
  "uint8 src\n"
  "uint32 id\n"
  "uint8 action\n"
  "uint8 threat_level\n"
  "float32 time_to_minimum_delta\n"
  "float32 altitude_minimum_delta\n"
  "float32 horizontal_minimum_delta";

static char msg_encoding[] = "msg";

// Define all individual source functions

const rosidl_runtime_c__type_description__TypeSource *
px4__msg__CollisionReport__get_individual_type_description_source(
  const rosidl_message_type_support_t * type_support)
{
  (void)type_support;
  static const rosidl_runtime_c__type_description__TypeSource source = {
    {px4__msg__CollisionReport__TYPE_NAME, 23, 23},
    {msg_encoding, 3, 3},
    {toplevel_type_raw_source, 205, 205},
  };
  return &source;
}

const rosidl_runtime_c__type_description__TypeSource__Sequence *
px4__msg__CollisionReport__get_type_description_sources(
  const rosidl_message_type_support_t * type_support)
{
  (void)type_support;
  static rosidl_runtime_c__type_description__TypeSource sources[1];
  static const rosidl_runtime_c__type_description__TypeSource__Sequence source_sequence = {sources, 1, 1};
  static bool constructed = false;
  if (!constructed) {
    sources[0] = *px4__msg__CollisionReport__get_individual_type_description_source(NULL),
    constructed = true;
  }
  return &source_sequence;
}
