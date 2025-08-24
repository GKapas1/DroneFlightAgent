// generated from rosidl_generator_c/resource/idl__description.c.em
// with input from px4:msg/Rpm.idl
// generated code does not contain a copyright notice

#include "px4/msg/detail/rpm__functions.h"

ROSIDL_GENERATOR_C_PUBLIC_px4
const rosidl_type_hash_t *
px4__msg__Rpm__get_type_hash(
  const rosidl_message_type_support_t * type_support)
{
  (void)type_support;
  static rosidl_type_hash_t hash = {1, {
      0x4f, 0x40, 0x9e, 0x26, 0xd7, 0x27, 0xf7, 0x7b,
      0xf9, 0x08, 0xfe, 0xc9, 0xf4, 0x16, 0x5d, 0xfc,
      0x6c, 0x09, 0x4c, 0x68, 0x65, 0x36, 0x9e, 0x8a,
      0x83, 0x7f, 0x96, 0x89, 0x12, 0xc4, 0x82, 0x79,
    }};
  return &hash;
}

#include <assert.h>
#include <string.h>

// Include directives for referenced types

// Hashes for external referenced types
#ifndef NDEBUG
#endif

static char px4__msg__Rpm__TYPE_NAME[] = "px4/msg/Rpm";

// Define type names, field names, and default values
static char px4__msg__Rpm__FIELD_NAME__timestamp[] = "timestamp";
static char px4__msg__Rpm__FIELD_NAME__indicated_frequency_rpm[] = "indicated_frequency_rpm";
static char px4__msg__Rpm__FIELD_NAME__estimated_accurancy_rpm[] = "estimated_accurancy_rpm";

static rosidl_runtime_c__type_description__Field px4__msg__Rpm__FIELDS[] = {
  {
    {px4__msg__Rpm__FIELD_NAME__timestamp, 9, 9},
    {
      rosidl_runtime_c__type_description__FieldType__FIELD_TYPE_UINT64,
      0,
      0,
      {NULL, 0, 0},
    },
    {NULL, 0, 0},
  },
  {
    {px4__msg__Rpm__FIELD_NAME__indicated_frequency_rpm, 23, 23},
    {
      rosidl_runtime_c__type_description__FieldType__FIELD_TYPE_FLOAT,
      0,
      0,
      {NULL, 0, 0},
    },
    {NULL, 0, 0},
  },
  {
    {px4__msg__Rpm__FIELD_NAME__estimated_accurancy_rpm, 23, 23},
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
px4__msg__Rpm__get_type_description(
  const rosidl_message_type_support_t * type_support)
{
  (void)type_support;
  static bool constructed = false;
  static const rosidl_runtime_c__type_description__TypeDescription description = {
    {
      {px4__msg__Rpm__TYPE_NAME, 11, 11},
      {px4__msg__Rpm__FIELDS, 3, 3},
    },
    {NULL, 0, 0},
  };
  if (!constructed) {
    constructed = true;
  }
  return &description;
}

static char toplevel_type_raw_source[] =
  "uint64 timestamp                      # time since system start (microseconds)\n"
  "\n"
  "float32 indicated_frequency_rpm       # indicated rotor Frequency in Revolution per minute\n"
  "float32 estimated_accurancy_rpm       # estimated accuracy in Revolution per minute";

static char msg_encoding[] = "msg";

// Define all individual source functions

const rosidl_runtime_c__type_description__TypeSource *
px4__msg__Rpm__get_individual_type_description_source(
  const rosidl_message_type_support_t * type_support)
{
  (void)type_support;
  static const rosidl_runtime_c__type_description__TypeSource source = {
    {px4__msg__Rpm__TYPE_NAME, 11, 11},
    {msg_encoding, 3, 3},
    {toplevel_type_raw_source, 255, 255},
  };
  return &source;
}

const rosidl_runtime_c__type_description__TypeSource__Sequence *
px4__msg__Rpm__get_type_description_sources(
  const rosidl_message_type_support_t * type_support)
{
  (void)type_support;
  static rosidl_runtime_c__type_description__TypeSource sources[1];
  static const rosidl_runtime_c__type_description__TypeSource__Sequence source_sequence = {sources, 1, 1};
  static bool constructed = false;
  if (!constructed) {
    sources[0] = *px4__msg__Rpm__get_individual_type_description_source(NULL),
    constructed = true;
  }
  return &source_sequence;
}
