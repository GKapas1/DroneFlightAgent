// generated from rosidl_generator_c/resource/idl__description.c.em
// with input from px4:msg/MissionResult.idl
// generated code does not contain a copyright notice

#include "px4/msg/detail/mission_result__functions.h"

ROSIDL_GENERATOR_C_PUBLIC_px4
const rosidl_type_hash_t *
px4__msg__MissionResult__get_type_hash(
  const rosidl_message_type_support_t * type_support)
{
  (void)type_support;
  static rosidl_type_hash_t hash = {1, {
      0xa3, 0x39, 0x67, 0xd2, 0x10, 0x70, 0x1b, 0xd8,
      0x02, 0xf2, 0xa0, 0xb4, 0xe5, 0x7f, 0x3f, 0x5b,
      0x2f, 0xa4, 0xd6, 0xe5, 0x4a, 0xa6, 0x21, 0xca,
      0x58, 0x9a, 0xb9, 0xfa, 0x4e, 0xce, 0x1b, 0xb7,
    }};
  return &hash;
}

#include <assert.h>
#include <string.h>

// Include directives for referenced types

// Hashes for external referenced types
#ifndef NDEBUG
#endif

static char px4__msg__MissionResult__TYPE_NAME[] = "px4/msg/MissionResult";

// Define type names, field names, and default values
static char px4__msg__MissionResult__FIELD_NAME__timestamp[] = "timestamp";
static char px4__msg__MissionResult__FIELD_NAME__instance_count[] = "instance_count";
static char px4__msg__MissionResult__FIELD_NAME__seq_reached[] = "seq_reached";
static char px4__msg__MissionResult__FIELD_NAME__seq_current[] = "seq_current";
static char px4__msg__MissionResult__FIELD_NAME__seq_total[] = "seq_total";
static char px4__msg__MissionResult__FIELD_NAME__valid[] = "valid";
static char px4__msg__MissionResult__FIELD_NAME__warning[] = "warning";
static char px4__msg__MissionResult__FIELD_NAME__finished[] = "finished";
static char px4__msg__MissionResult__FIELD_NAME__failure[] = "failure";
static char px4__msg__MissionResult__FIELD_NAME__item_do_jump_changed[] = "item_do_jump_changed";
static char px4__msg__MissionResult__FIELD_NAME__item_changed_index[] = "item_changed_index";
static char px4__msg__MissionResult__FIELD_NAME__item_do_jump_remaining[] = "item_do_jump_remaining";
static char px4__msg__MissionResult__FIELD_NAME__execution_mode[] = "execution_mode";

static rosidl_runtime_c__type_description__Field px4__msg__MissionResult__FIELDS[] = {
  {
    {px4__msg__MissionResult__FIELD_NAME__timestamp, 9, 9},
    {
      rosidl_runtime_c__type_description__FieldType__FIELD_TYPE_UINT64,
      0,
      0,
      {NULL, 0, 0},
    },
    {NULL, 0, 0},
  },
  {
    {px4__msg__MissionResult__FIELD_NAME__instance_count, 14, 14},
    {
      rosidl_runtime_c__type_description__FieldType__FIELD_TYPE_UINT32,
      0,
      0,
      {NULL, 0, 0},
    },
    {NULL, 0, 0},
  },
  {
    {px4__msg__MissionResult__FIELD_NAME__seq_reached, 11, 11},
    {
      rosidl_runtime_c__type_description__FieldType__FIELD_TYPE_INT32,
      0,
      0,
      {NULL, 0, 0},
    },
    {NULL, 0, 0},
  },
  {
    {px4__msg__MissionResult__FIELD_NAME__seq_current, 11, 11},
    {
      rosidl_runtime_c__type_description__FieldType__FIELD_TYPE_UINT16,
      0,
      0,
      {NULL, 0, 0},
    },
    {NULL, 0, 0},
  },
  {
    {px4__msg__MissionResult__FIELD_NAME__seq_total, 9, 9},
    {
      rosidl_runtime_c__type_description__FieldType__FIELD_TYPE_UINT16,
      0,
      0,
      {NULL, 0, 0},
    },
    {NULL, 0, 0},
  },
  {
    {px4__msg__MissionResult__FIELD_NAME__valid, 5, 5},
    {
      rosidl_runtime_c__type_description__FieldType__FIELD_TYPE_BOOLEAN,
      0,
      0,
      {NULL, 0, 0},
    },
    {NULL, 0, 0},
  },
  {
    {px4__msg__MissionResult__FIELD_NAME__warning, 7, 7},
    {
      rosidl_runtime_c__type_description__FieldType__FIELD_TYPE_BOOLEAN,
      0,
      0,
      {NULL, 0, 0},
    },
    {NULL, 0, 0},
  },
  {
    {px4__msg__MissionResult__FIELD_NAME__finished, 8, 8},
    {
      rosidl_runtime_c__type_description__FieldType__FIELD_TYPE_BOOLEAN,
      0,
      0,
      {NULL, 0, 0},
    },
    {NULL, 0, 0},
  },
  {
    {px4__msg__MissionResult__FIELD_NAME__failure, 7, 7},
    {
      rosidl_runtime_c__type_description__FieldType__FIELD_TYPE_BOOLEAN,
      0,
      0,
      {NULL, 0, 0},
    },
    {NULL, 0, 0},
  },
  {
    {px4__msg__MissionResult__FIELD_NAME__item_do_jump_changed, 20, 20},
    {
      rosidl_runtime_c__type_description__FieldType__FIELD_TYPE_BOOLEAN,
      0,
      0,
      {NULL, 0, 0},
    },
    {NULL, 0, 0},
  },
  {
    {px4__msg__MissionResult__FIELD_NAME__item_changed_index, 18, 18},
    {
      rosidl_runtime_c__type_description__FieldType__FIELD_TYPE_UINT16,
      0,
      0,
      {NULL, 0, 0},
    },
    {NULL, 0, 0},
  },
  {
    {px4__msg__MissionResult__FIELD_NAME__item_do_jump_remaining, 22, 22},
    {
      rosidl_runtime_c__type_description__FieldType__FIELD_TYPE_UINT16,
      0,
      0,
      {NULL, 0, 0},
    },
    {NULL, 0, 0},
  },
  {
    {px4__msg__MissionResult__FIELD_NAME__execution_mode, 14, 14},
    {
      rosidl_runtime_c__type_description__FieldType__FIELD_TYPE_UINT8,
      0,
      0,
      {NULL, 0, 0},
    },
    {NULL, 0, 0},
  },
};

const rosidl_runtime_c__type_description__TypeDescription *
px4__msg__MissionResult__get_type_description(
  const rosidl_message_type_support_t * type_support)
{
  (void)type_support;
  static bool constructed = false;
  static const rosidl_runtime_c__type_description__TypeDescription description = {
    {
      {px4__msg__MissionResult__TYPE_NAME, 21, 21},
      {px4__msg__MissionResult__FIELDS, 13, 13},
    },
    {NULL, 0, 0},
  };
  if (!constructed) {
    constructed = true;
  }
  return &description;
}

static char toplevel_type_raw_source[] =
  "uint64 timestamp\\t\\t\\t\\t# time since system start (microseconds)\n"
  "uint8 MISSION_EXECUTION_MODE_NORMAL = 0\\t# Execute the mission according to the planned items\n"
  "uint8 MISSION_EXECUTION_MODE_REVERSE = 1\\t# Execute the mission in reverse order, ignoring commands and converting all waypoints to normal ones\n"
  "uint8 MISSION_EXECUTION_MODE_FAST_FORWARD = 2\\t# Execute the mission as fast as possible, for example converting loiter waypoints to normal ones\n"
  "\n"
  "uint32 instance_count\\t\\t# Instance count of this mission. Increments monotonically whenever the mission is modified\n"
  "\n"
  "int32 seq_reached\\t\\t# Sequence of the mission item which has been reached, default -1\n"
  "uint16 seq_current\\t\\t# Sequence of the current mission item\n"
  "uint16 seq_total\\t\\t# Total number of mission items\n"
  "\n"
  "bool valid\\t\\t\\t# true if mission is valid\n"
  "bool warning\\t\\t\\t# true if mission is valid, but has potentially problematic items leading to safety warnings\n"
  "bool finished\\t\\t\\t# true if mission has been completed\n"
  "bool failure\\t\\t\\t# true if the mission cannot continue or be completed for some reason\n"
  "\n"
  "bool item_do_jump_changed\\t# true if the number of do jumps remaining has changed\n"
  "uint16 item_changed_index\\t# indicate which item has changed\n"
  "uint16 item_do_jump_remaining\\t# set to the number of do jumps remaining for that item\n"
  "\n"
  "uint8 execution_mode\\t# indicates the mode in which the mission is executed";

static char msg_encoding[] = "msg";

// Define all individual source functions

const rosidl_runtime_c__type_description__TypeSource *
px4__msg__MissionResult__get_individual_type_description_source(
  const rosidl_message_type_support_t * type_support)
{
  (void)type_support;
  static const rosidl_runtime_c__type_description__TypeSource source = {
    {px4__msg__MissionResult__TYPE_NAME, 21, 21},
    {msg_encoding, 3, 3},
    {toplevel_type_raw_source, 1343, 1343},
  };
  return &source;
}

const rosidl_runtime_c__type_description__TypeSource__Sequence *
px4__msg__MissionResult__get_type_description_sources(
  const rosidl_message_type_support_t * type_support)
{
  (void)type_support;
  static rosidl_runtime_c__type_description__TypeSource sources[1];
  static const rosidl_runtime_c__type_description__TypeSource__Sequence source_sequence = {sources, 1, 1};
  static bool constructed = false;
  if (!constructed) {
    sources[0] = *px4__msg__MissionResult__get_individual_type_description_source(NULL),
    constructed = true;
  }
  return &source_sequence;
}
