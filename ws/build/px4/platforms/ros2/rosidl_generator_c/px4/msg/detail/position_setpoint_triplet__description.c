// generated from rosidl_generator_c/resource/idl__description.c.em
// with input from px4:msg/PositionSetpointTriplet.idl
// generated code does not contain a copyright notice

#include "px4/msg/detail/position_setpoint_triplet__functions.h"

ROSIDL_GENERATOR_C_PUBLIC_px4
const rosidl_type_hash_t *
px4__msg__PositionSetpointTriplet__get_type_hash(
  const rosidl_message_type_support_t * type_support)
{
  (void)type_support;
  static rosidl_type_hash_t hash = {1, {
      0x95, 0x70, 0x8f, 0x33, 0x4a, 0x6f, 0x04, 0xc3,
      0x38, 0x47, 0x96, 0x50, 0x29, 0xbb, 0xbe, 0x25,
      0x11, 0x5f, 0xb7, 0xb8, 0xf2, 0x95, 0x31, 0x88,
      0xaf, 0xd5, 0xcf, 0x47, 0x34, 0x3c, 0xb8, 0xc1,
    }};
  return &hash;
}

#include <assert.h>
#include <string.h>

// Include directives for referenced types
#include "px4/msg/detail/position_setpoint__functions.h"

// Hashes for external referenced types
#ifndef NDEBUG
static const rosidl_type_hash_t px4__msg__PositionSetpoint__EXPECTED_HASH = {1, {
    0x86, 0xa1, 0x2d, 0xd6, 0xb8, 0x45, 0x3b, 0x9a,
    0xb2, 0xa0, 0x7e, 0x63, 0x22, 0x3d, 0x6c, 0xe8,
    0x17, 0x6b, 0xac, 0x0c, 0xd6, 0xa4, 0x2c, 0x32,
    0x51, 0x22, 0x99, 0x69, 0x7b, 0x74, 0x6e, 0xd2,
  }};
#endif

static char px4__msg__PositionSetpointTriplet__TYPE_NAME[] = "px4/msg/PositionSetpointTriplet";
static char px4__msg__PositionSetpoint__TYPE_NAME[] = "px4/msg/PositionSetpoint";

// Define type names, field names, and default values
static char px4__msg__PositionSetpointTriplet__FIELD_NAME__timestamp[] = "timestamp";
static char px4__msg__PositionSetpointTriplet__FIELD_NAME__previous[] = "previous";
static char px4__msg__PositionSetpointTriplet__FIELD_NAME__current[] = "current";
static char px4__msg__PositionSetpointTriplet__FIELD_NAME__next[] = "next";

static rosidl_runtime_c__type_description__Field px4__msg__PositionSetpointTriplet__FIELDS[] = {
  {
    {px4__msg__PositionSetpointTriplet__FIELD_NAME__timestamp, 9, 9},
    {
      rosidl_runtime_c__type_description__FieldType__FIELD_TYPE_UINT64,
      0,
      0,
      {NULL, 0, 0},
    },
    {NULL, 0, 0},
  },
  {
    {px4__msg__PositionSetpointTriplet__FIELD_NAME__previous, 8, 8},
    {
      rosidl_runtime_c__type_description__FieldType__FIELD_TYPE_NESTED_TYPE,
      0,
      0,
      {px4__msg__PositionSetpoint__TYPE_NAME, 24, 24},
    },
    {NULL, 0, 0},
  },
  {
    {px4__msg__PositionSetpointTriplet__FIELD_NAME__current, 7, 7},
    {
      rosidl_runtime_c__type_description__FieldType__FIELD_TYPE_NESTED_TYPE,
      0,
      0,
      {px4__msg__PositionSetpoint__TYPE_NAME, 24, 24},
    },
    {NULL, 0, 0},
  },
  {
    {px4__msg__PositionSetpointTriplet__FIELD_NAME__next, 4, 4},
    {
      rosidl_runtime_c__type_description__FieldType__FIELD_TYPE_NESTED_TYPE,
      0,
      0,
      {px4__msg__PositionSetpoint__TYPE_NAME, 24, 24},
    },
    {NULL, 0, 0},
  },
};

static rosidl_runtime_c__type_description__IndividualTypeDescription px4__msg__PositionSetpointTriplet__REFERENCED_TYPE_DESCRIPTIONS[] = {
  {
    {px4__msg__PositionSetpoint__TYPE_NAME, 24, 24},
    {NULL, 0, 0},
  },
};

const rosidl_runtime_c__type_description__TypeDescription *
px4__msg__PositionSetpointTriplet__get_type_description(
  const rosidl_message_type_support_t * type_support)
{
  (void)type_support;
  static bool constructed = false;
  static const rosidl_runtime_c__type_description__TypeDescription description = {
    {
      {px4__msg__PositionSetpointTriplet__TYPE_NAME, 31, 31},
      {px4__msg__PositionSetpointTriplet__FIELDS, 4, 4},
    },
    {px4__msg__PositionSetpointTriplet__REFERENCED_TYPE_DESCRIPTIONS, 1, 1},
  };
  if (!constructed) {
    assert(0 == memcmp(&px4__msg__PositionSetpoint__EXPECTED_HASH, px4__msg__PositionSetpoint__get_type_hash(NULL), sizeof(rosidl_type_hash_t)));
    description.referenced_type_descriptions.data[0].fields = px4__msg__PositionSetpoint__get_type_description(NULL)->type_description.fields;
    constructed = true;
  }
  return &description;
}

static char toplevel_type_raw_source[] =
  "# Global position setpoint triplet in WGS84 coordinates.\n"
  "# This are the three next waypoints (or just the next two or one).\n"
  "\n"
  "uint64 timestamp\\t\\t# time since system start (microseconds)\n"
  "\n"
  "PositionSetpoint previous\n"
  "PositionSetpoint current\n"
  "PositionSetpoint next";

static char msg_encoding[] = "msg";

// Define all individual source functions

const rosidl_runtime_c__type_description__TypeSource *
px4__msg__PositionSetpointTriplet__get_individual_type_description_source(
  const rosidl_message_type_support_t * type_support)
{
  (void)type_support;
  static const rosidl_runtime_c__type_description__TypeSource source = {
    {px4__msg__PositionSetpointTriplet__TYPE_NAME, 31, 31},
    {msg_encoding, 3, 3},
    {toplevel_type_raw_source, 258, 258},
  };
  return &source;
}

const rosidl_runtime_c__type_description__TypeSource__Sequence *
px4__msg__PositionSetpointTriplet__get_type_description_sources(
  const rosidl_message_type_support_t * type_support)
{
  (void)type_support;
  static rosidl_runtime_c__type_description__TypeSource sources[2];
  static const rosidl_runtime_c__type_description__TypeSource__Sequence source_sequence = {sources, 2, 2};
  static bool constructed = false;
  if (!constructed) {
    sources[0] = *px4__msg__PositionSetpointTriplet__get_individual_type_description_source(NULL),
    sources[1] = *px4__msg__PositionSetpoint__get_individual_type_description_source(NULL);
    constructed = true;
  }
  return &source_sequence;
}
