// generated from rosidl_generator_c/resource/idl__description.c.em
// with input from px4:msg/Mission.idl
// generated code does not contain a copyright notice

#include "px4/msg/detail/mission__functions.h"

ROSIDL_GENERATOR_C_PUBLIC_px4
const rosidl_type_hash_t *
px4__msg__Mission__get_type_hash(
  const rosidl_message_type_support_t * type_support)
{
  (void)type_support;
  static rosidl_type_hash_t hash = {1, {
      0x1f, 0x2a, 0xa5, 0xb2, 0x28, 0xc5, 0xe2, 0xb7,
      0x33, 0x39, 0x0f, 0x24, 0x48, 0x9d, 0x79, 0x28,
      0x74, 0xf2, 0xc7, 0xa8, 0x70, 0x0a, 0x5c, 0xec,
      0x54, 0x71, 0xb4, 0xc6, 0xba, 0x86, 0x34, 0xda,
    }};
  return &hash;
}

#include <assert.h>
#include <string.h>

// Include directives for referenced types

// Hashes for external referenced types
#ifndef NDEBUG
#endif

static char px4__msg__Mission__TYPE_NAME[] = "px4/msg/Mission";

// Define type names, field names, and default values
static char px4__msg__Mission__FIELD_NAME__timestamp[] = "timestamp";
static char px4__msg__Mission__FIELD_NAME__dataman_id[] = "dataman_id";
static char px4__msg__Mission__FIELD_NAME__count[] = "count";
static char px4__msg__Mission__FIELD_NAME__current_seq[] = "current_seq";

static rosidl_runtime_c__type_description__Field px4__msg__Mission__FIELDS[] = {
  {
    {px4__msg__Mission__FIELD_NAME__timestamp, 9, 9},
    {
      rosidl_runtime_c__type_description__FieldType__FIELD_TYPE_UINT64,
      0,
      0,
      {NULL, 0, 0},
    },
    {NULL, 0, 0},
  },
  {
    {px4__msg__Mission__FIELD_NAME__dataman_id, 10, 10},
    {
      rosidl_runtime_c__type_description__FieldType__FIELD_TYPE_UINT8,
      0,
      0,
      {NULL, 0, 0},
    },
    {NULL, 0, 0},
  },
  {
    {px4__msg__Mission__FIELD_NAME__count, 5, 5},
    {
      rosidl_runtime_c__type_description__FieldType__FIELD_TYPE_UINT16,
      0,
      0,
      {NULL, 0, 0},
    },
    {NULL, 0, 0},
  },
  {
    {px4__msg__Mission__FIELD_NAME__current_seq, 11, 11},
    {
      rosidl_runtime_c__type_description__FieldType__FIELD_TYPE_INT32,
      0,
      0,
      {NULL, 0, 0},
    },
    {NULL, 0, 0},
  },
};

const rosidl_runtime_c__type_description__TypeDescription *
px4__msg__Mission__get_type_description(
  const rosidl_message_type_support_t * type_support)
{
  (void)type_support;
  static bool constructed = false;
  static const rosidl_runtime_c__type_description__TypeDescription description = {
    {
      {px4__msg__Mission__TYPE_NAME, 15, 15},
      {px4__msg__Mission__FIELDS, 4, 4},
    },
    {NULL, 0, 0},
  };
  if (!constructed) {
    constructed = true;
  }
  return &description;
}

static char toplevel_type_raw_source[] =
  "uint64 timestamp\\t# time since system start (microseconds)\n"
  "uint8 dataman_id\\t# default 0, there are two offboard storage places in the dataman: 0 or 1\n"
  "\n"
  "uint16 count\\t\\t# count of the missions stored in the dataman\n"
  "int32 current_seq\\t# default -1, start at the one changed latest";

static char msg_encoding[] = "msg";

// Define all individual source functions

const rosidl_runtime_c__type_description__TypeSource *
px4__msg__Mission__get_individual_type_description_source(
  const rosidl_message_type_support_t * type_support)
{
  (void)type_support;
  static const rosidl_runtime_c__type_description__TypeSource source = {
    {px4__msg__Mission__TYPE_NAME, 15, 15},
    {msg_encoding, 3, 3},
    {toplevel_type_raw_source, 274, 274},
  };
  return &source;
}

const rosidl_runtime_c__type_description__TypeSource__Sequence *
px4__msg__Mission__get_type_description_sources(
  const rosidl_message_type_support_t * type_support)
{
  (void)type_support;
  static rosidl_runtime_c__type_description__TypeSource sources[1];
  static const rosidl_runtime_c__type_description__TypeSource__Sequence source_sequence = {sources, 1, 1};
  static bool constructed = false;
  if (!constructed) {
    sources[0] = *px4__msg__Mission__get_individual_type_description_source(NULL),
    constructed = true;
  }
  return &source_sequence;
}
