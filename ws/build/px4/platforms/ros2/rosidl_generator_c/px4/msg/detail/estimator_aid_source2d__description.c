// generated from rosidl_generator_c/resource/idl__description.c.em
// with input from px4:msg/EstimatorAidSource2d.idl
// generated code does not contain a copyright notice

#include "px4/msg/detail/estimator_aid_source2d__functions.h"

ROSIDL_GENERATOR_C_PUBLIC_px4
const rosidl_type_hash_t *
px4__msg__EstimatorAidSource2d__get_type_hash(
  const rosidl_message_type_support_t * type_support)
{
  (void)type_support;
  static rosidl_type_hash_t hash = {1, {
      0xb9, 0x83, 0x6c, 0xdd, 0xda, 0x90, 0x7f, 0x95,
      0x3f, 0x2c, 0x79, 0x3e, 0x5e, 0x19, 0x8c, 0x5b,
      0xe8, 0xf2, 0x6a, 0x3b, 0x53, 0x8d, 0x3f, 0xf4,
      0xcc, 0x59, 0xfd, 0xa5, 0x06, 0xd0, 0xb2, 0x93,
    }};
  return &hash;
}

#include <assert.h>
#include <string.h>

// Include directives for referenced types

// Hashes for external referenced types
#ifndef NDEBUG
#endif

static char px4__msg__EstimatorAidSource2d__TYPE_NAME[] = "px4/msg/EstimatorAidSource2d";

// Define type names, field names, and default values
static char px4__msg__EstimatorAidSource2d__FIELD_NAME__timestamp[] = "timestamp";
static char px4__msg__EstimatorAidSource2d__FIELD_NAME__timestamp_sample[] = "timestamp_sample";
static char px4__msg__EstimatorAidSource2d__FIELD_NAME__estimator_instance[] = "estimator_instance";
static char px4__msg__EstimatorAidSource2d__FIELD_NAME__device_id[] = "device_id";
static char px4__msg__EstimatorAidSource2d__FIELD_NAME__time_last_fuse[] = "time_last_fuse";
static char px4__msg__EstimatorAidSource2d__FIELD_NAME__observation[] = "observation";
static char px4__msg__EstimatorAidSource2d__FIELD_NAME__observation_variance[] = "observation_variance";
static char px4__msg__EstimatorAidSource2d__FIELD_NAME__innovation[] = "innovation";
static char px4__msg__EstimatorAidSource2d__FIELD_NAME__innovation_variance[] = "innovation_variance";
static char px4__msg__EstimatorAidSource2d__FIELD_NAME__test_ratio[] = "test_ratio";
static char px4__msg__EstimatorAidSource2d__FIELD_NAME__fusion_enabled[] = "fusion_enabled";
static char px4__msg__EstimatorAidSource2d__FIELD_NAME__innovation_rejected[] = "innovation_rejected";
static char px4__msg__EstimatorAidSource2d__FIELD_NAME__fused[] = "fused";

static rosidl_runtime_c__type_description__Field px4__msg__EstimatorAidSource2d__FIELDS[] = {
  {
    {px4__msg__EstimatorAidSource2d__FIELD_NAME__timestamp, 9, 9},
    {
      rosidl_runtime_c__type_description__FieldType__FIELD_TYPE_UINT64,
      0,
      0,
      {NULL, 0, 0},
    },
    {NULL, 0, 0},
  },
  {
    {px4__msg__EstimatorAidSource2d__FIELD_NAME__timestamp_sample, 16, 16},
    {
      rosidl_runtime_c__type_description__FieldType__FIELD_TYPE_UINT64,
      0,
      0,
      {NULL, 0, 0},
    },
    {NULL, 0, 0},
  },
  {
    {px4__msg__EstimatorAidSource2d__FIELD_NAME__estimator_instance, 18, 18},
    {
      rosidl_runtime_c__type_description__FieldType__FIELD_TYPE_UINT8,
      0,
      0,
      {NULL, 0, 0},
    },
    {NULL, 0, 0},
  },
  {
    {px4__msg__EstimatorAidSource2d__FIELD_NAME__device_id, 9, 9},
    {
      rosidl_runtime_c__type_description__FieldType__FIELD_TYPE_UINT32,
      0,
      0,
      {NULL, 0, 0},
    },
    {NULL, 0, 0},
  },
  {
    {px4__msg__EstimatorAidSource2d__FIELD_NAME__time_last_fuse, 14, 14},
    {
      rosidl_runtime_c__type_description__FieldType__FIELD_TYPE_UINT64,
      0,
      0,
      {NULL, 0, 0},
    },
    {NULL, 0, 0},
  },
  {
    {px4__msg__EstimatorAidSource2d__FIELD_NAME__observation, 11, 11},
    {
      rosidl_runtime_c__type_description__FieldType__FIELD_TYPE_FLOAT_ARRAY,
      2,
      0,
      {NULL, 0, 0},
    },
    {NULL, 0, 0},
  },
  {
    {px4__msg__EstimatorAidSource2d__FIELD_NAME__observation_variance, 20, 20},
    {
      rosidl_runtime_c__type_description__FieldType__FIELD_TYPE_FLOAT_ARRAY,
      2,
      0,
      {NULL, 0, 0},
    },
    {NULL, 0, 0},
  },
  {
    {px4__msg__EstimatorAidSource2d__FIELD_NAME__innovation, 10, 10},
    {
      rosidl_runtime_c__type_description__FieldType__FIELD_TYPE_FLOAT_ARRAY,
      2,
      0,
      {NULL, 0, 0},
    },
    {NULL, 0, 0},
  },
  {
    {px4__msg__EstimatorAidSource2d__FIELD_NAME__innovation_variance, 19, 19},
    {
      rosidl_runtime_c__type_description__FieldType__FIELD_TYPE_FLOAT_ARRAY,
      2,
      0,
      {NULL, 0, 0},
    },
    {NULL, 0, 0},
  },
  {
    {px4__msg__EstimatorAidSource2d__FIELD_NAME__test_ratio, 10, 10},
    {
      rosidl_runtime_c__type_description__FieldType__FIELD_TYPE_FLOAT_ARRAY,
      2,
      0,
      {NULL, 0, 0},
    },
    {NULL, 0, 0},
  },
  {
    {px4__msg__EstimatorAidSource2d__FIELD_NAME__fusion_enabled, 14, 14},
    {
      rosidl_runtime_c__type_description__FieldType__FIELD_TYPE_BOOLEAN,
      0,
      0,
      {NULL, 0, 0},
    },
    {NULL, 0, 0},
  },
  {
    {px4__msg__EstimatorAidSource2d__FIELD_NAME__innovation_rejected, 19, 19},
    {
      rosidl_runtime_c__type_description__FieldType__FIELD_TYPE_BOOLEAN,
      0,
      0,
      {NULL, 0, 0},
    },
    {NULL, 0, 0},
  },
  {
    {px4__msg__EstimatorAidSource2d__FIELD_NAME__fused, 5, 5},
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
px4__msg__EstimatorAidSource2d__get_type_description(
  const rosidl_message_type_support_t * type_support)
{
  (void)type_support;
  static bool constructed = false;
  static const rosidl_runtime_c__type_description__TypeDescription description = {
    {
      {px4__msg__EstimatorAidSource2d__TYPE_NAME, 28, 28},
      {px4__msg__EstimatorAidSource2d__FIELDS, 13, 13},
    },
    {NULL, 0, 0},
  };
  if (!constructed) {
    constructed = true;
  }
  return &description;
}

static char toplevel_type_raw_source[] =
  "uint64 timestamp             # time since system start (microseconds)\n"
  "uint64 timestamp_sample      # the timestamp of the raw data (microseconds)\n"
  "\n"
  "uint8 estimator_instance\n"
  "\n"
  "uint32 device_id\n"
  "\n"
  "uint64 time_last_fuse\n"
  "\n"
  "float32[2] observation\n"
  "float32[2] observation_variance\n"
  "\n"
  "float32[2] innovation\n"
  "float32[2] innovation_variance\n"
  "float32[2] test_ratio\n"
  "\n"
  "bool fusion_enabled          # true when measurements are being fused\n"
  "bool innovation_rejected     # true if the observation has been rejected\n"
  "bool fused                   # true if the sample was successfully fused\n"
  "\n"
  "# TOPICS estimator_aid_src_ev_pos estimator_aid_src_fake_pos estimator_aid_src_gnss_pos\n"
  "# TOPICS estimator_aid_src_aux_vel estimator_aid_src_optical_flow estimator_aid_src_terrain_optical_flow";

static char msg_encoding[] = "msg";

// Define all individual source functions

const rosidl_runtime_c__type_description__TypeSource *
px4__msg__EstimatorAidSource2d__get_individual_type_description_source(
  const rosidl_message_type_support_t * type_support)
{
  (void)type_support;
  static const rosidl_runtime_c__type_description__TypeSource source = {
    {px4__msg__EstimatorAidSource2d__TYPE_NAME, 28, 28},
    {msg_encoding, 3, 3},
    {toplevel_type_raw_source, 756, 756},
  };
  return &source;
}

const rosidl_runtime_c__type_description__TypeSource__Sequence *
px4__msg__EstimatorAidSource2d__get_type_description_sources(
  const rosidl_message_type_support_t * type_support)
{
  (void)type_support;
  static rosidl_runtime_c__type_description__TypeSource sources[1];
  static const rosidl_runtime_c__type_description__TypeSource__Sequence source_sequence = {sources, 1, 1};
  static bool constructed = false;
  if (!constructed) {
    sources[0] = *px4__msg__EstimatorAidSource2d__get_individual_type_description_source(NULL),
    constructed = true;
  }
  return &source_sequence;
}
