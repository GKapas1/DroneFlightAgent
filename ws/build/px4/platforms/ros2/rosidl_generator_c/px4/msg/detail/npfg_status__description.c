// generated from rosidl_generator_c/resource/idl__description.c.em
// with input from px4:msg/NpfgStatus.idl
// generated code does not contain a copyright notice

#include "px4/msg/detail/npfg_status__functions.h"

ROSIDL_GENERATOR_C_PUBLIC_px4
const rosidl_type_hash_t *
px4__msg__NpfgStatus__get_type_hash(
  const rosidl_message_type_support_t * type_support)
{
  (void)type_support;
  static rosidl_type_hash_t hash = {1, {
      0x52, 0x7a, 0x1b, 0x2d, 0x3d, 0x7c, 0x34, 0xb4,
      0x1d, 0x8b, 0x3b, 0x57, 0x8f, 0x33, 0xad, 0x5b,
      0x89, 0x88, 0xd2, 0x9b, 0xed, 0xba, 0xb1, 0xe1,
      0x1f, 0xe9, 0x3b, 0xb0, 0x4a, 0xae, 0x59, 0x85,
    }};
  return &hash;
}

#include <assert.h>
#include <string.h>

// Include directives for referenced types

// Hashes for external referenced types
#ifndef NDEBUG
#endif

static char px4__msg__NpfgStatus__TYPE_NAME[] = "px4/msg/NpfgStatus";

// Define type names, field names, and default values
static char px4__msg__NpfgStatus__FIELD_NAME__timestamp[] = "timestamp";
static char px4__msg__NpfgStatus__FIELD_NAME__wind_est_valid[] = "wind_est_valid";
static char px4__msg__NpfgStatus__FIELD_NAME__lat_accel[] = "lat_accel";
static char px4__msg__NpfgStatus__FIELD_NAME__lat_accel_ff[] = "lat_accel_ff";
static char px4__msg__NpfgStatus__FIELD_NAME__bearing_feas[] = "bearing_feas";
static char px4__msg__NpfgStatus__FIELD_NAME__bearing_feas_on_track[] = "bearing_feas_on_track";
static char px4__msg__NpfgStatus__FIELD_NAME__signed_track_error[] = "signed_track_error";
static char px4__msg__NpfgStatus__FIELD_NAME__track_error_bound[] = "track_error_bound";
static char px4__msg__NpfgStatus__FIELD_NAME__airspeed_ref[] = "airspeed_ref";
static char px4__msg__NpfgStatus__FIELD_NAME__bearing[] = "bearing";
static char px4__msg__NpfgStatus__FIELD_NAME__heading_ref[] = "heading_ref";
static char px4__msg__NpfgStatus__FIELD_NAME__min_ground_speed_ref[] = "min_ground_speed_ref";
static char px4__msg__NpfgStatus__FIELD_NAME__adapted_period[] = "adapted_period";
static char px4__msg__NpfgStatus__FIELD_NAME__p_gain[] = "p_gain";
static char px4__msg__NpfgStatus__FIELD_NAME__time_const[] = "time_const";

static rosidl_runtime_c__type_description__Field px4__msg__NpfgStatus__FIELDS[] = {
  {
    {px4__msg__NpfgStatus__FIELD_NAME__timestamp, 9, 9},
    {
      rosidl_runtime_c__type_description__FieldType__FIELD_TYPE_UINT64,
      0,
      0,
      {NULL, 0, 0},
    },
    {NULL, 0, 0},
  },
  {
    {px4__msg__NpfgStatus__FIELD_NAME__wind_est_valid, 14, 14},
    {
      rosidl_runtime_c__type_description__FieldType__FIELD_TYPE_UINT8,
      0,
      0,
      {NULL, 0, 0},
    },
    {NULL, 0, 0},
  },
  {
    {px4__msg__NpfgStatus__FIELD_NAME__lat_accel, 9, 9},
    {
      rosidl_runtime_c__type_description__FieldType__FIELD_TYPE_FLOAT,
      0,
      0,
      {NULL, 0, 0},
    },
    {NULL, 0, 0},
  },
  {
    {px4__msg__NpfgStatus__FIELD_NAME__lat_accel_ff, 12, 12},
    {
      rosidl_runtime_c__type_description__FieldType__FIELD_TYPE_FLOAT,
      0,
      0,
      {NULL, 0, 0},
    },
    {NULL, 0, 0},
  },
  {
    {px4__msg__NpfgStatus__FIELD_NAME__bearing_feas, 12, 12},
    {
      rosidl_runtime_c__type_description__FieldType__FIELD_TYPE_FLOAT,
      0,
      0,
      {NULL, 0, 0},
    },
    {NULL, 0, 0},
  },
  {
    {px4__msg__NpfgStatus__FIELD_NAME__bearing_feas_on_track, 21, 21},
    {
      rosidl_runtime_c__type_description__FieldType__FIELD_TYPE_FLOAT,
      0,
      0,
      {NULL, 0, 0},
    },
    {NULL, 0, 0},
  },
  {
    {px4__msg__NpfgStatus__FIELD_NAME__signed_track_error, 18, 18},
    {
      rosidl_runtime_c__type_description__FieldType__FIELD_TYPE_FLOAT,
      0,
      0,
      {NULL, 0, 0},
    },
    {NULL, 0, 0},
  },
  {
    {px4__msg__NpfgStatus__FIELD_NAME__track_error_bound, 17, 17},
    {
      rosidl_runtime_c__type_description__FieldType__FIELD_TYPE_FLOAT,
      0,
      0,
      {NULL, 0, 0},
    },
    {NULL, 0, 0},
  },
  {
    {px4__msg__NpfgStatus__FIELD_NAME__airspeed_ref, 12, 12},
    {
      rosidl_runtime_c__type_description__FieldType__FIELD_TYPE_FLOAT,
      0,
      0,
      {NULL, 0, 0},
    },
    {NULL, 0, 0},
  },
  {
    {px4__msg__NpfgStatus__FIELD_NAME__bearing, 7, 7},
    {
      rosidl_runtime_c__type_description__FieldType__FIELD_TYPE_FLOAT,
      0,
      0,
      {NULL, 0, 0},
    },
    {NULL, 0, 0},
  },
  {
    {px4__msg__NpfgStatus__FIELD_NAME__heading_ref, 11, 11},
    {
      rosidl_runtime_c__type_description__FieldType__FIELD_TYPE_FLOAT,
      0,
      0,
      {NULL, 0, 0},
    },
    {NULL, 0, 0},
  },
  {
    {px4__msg__NpfgStatus__FIELD_NAME__min_ground_speed_ref, 20, 20},
    {
      rosidl_runtime_c__type_description__FieldType__FIELD_TYPE_FLOAT,
      0,
      0,
      {NULL, 0, 0},
    },
    {NULL, 0, 0},
  },
  {
    {px4__msg__NpfgStatus__FIELD_NAME__adapted_period, 14, 14},
    {
      rosidl_runtime_c__type_description__FieldType__FIELD_TYPE_FLOAT,
      0,
      0,
      {NULL, 0, 0},
    },
    {NULL, 0, 0},
  },
  {
    {px4__msg__NpfgStatus__FIELD_NAME__p_gain, 6, 6},
    {
      rosidl_runtime_c__type_description__FieldType__FIELD_TYPE_FLOAT,
      0,
      0,
      {NULL, 0, 0},
    },
    {NULL, 0, 0},
  },
  {
    {px4__msg__NpfgStatus__FIELD_NAME__time_const, 10, 10},
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
px4__msg__NpfgStatus__get_type_description(
  const rosidl_message_type_support_t * type_support)
{
  (void)type_support;
  static bool constructed = false;
  static const rosidl_runtime_c__type_description__TypeDescription description = {
    {
      {px4__msg__NpfgStatus__TYPE_NAME, 18, 18},
      {px4__msg__NpfgStatus__FIELDS, 15, 15},
    },
    {NULL, 0, 0},
  };
  if (!constructed) {
    constructed = true;
  }
  return &description;
}

static char toplevel_type_raw_source[] =
  "uint64 timestamp                # time since system start (microseconds)\n"
  "\n"
  "uint8 wind_est_valid            # (boolean) true = wind estimate is valid and/or being used by controller (also indicates if wind est usage is disabled despite being valid)\n"
  "float32 lat_accel               # resultant lateral acceleration reference [m/s^2]\n"
  "float32 lat_accel_ff            # lateral acceleration demand only for maintaining curvature [m/s^2]\n"
  "float32 bearing_feas            # bearing feasibility [0,1]\n"
  "float32 bearing_feas_on_track   # on-track bearing feasibility [0,1]\n"
  "float32 signed_track_error      # signed track error [m]\n"
  "float32 track_error_bound       # track error bound [m]\n"
  "float32 airspeed_ref            # (true) airspeed reference [m/s]\n"
  "float32 bearing                 # bearing angle [rad]\n"
  "float32 heading_ref             # heading angle reference [rad]\n"
  "float32 min_ground_speed_ref    # minimum forward ground speed reference [m/s]\n"
  "float32 adapted_period          # adapted period (if auto-tuning enabled) [s]\n"
  "float32 p_gain                  # controller proportional gain [rad/s]\n"
  "float32 time_const              # controller time constant [s]";

static char msg_encoding[] = "msg";

// Define all individual source functions

const rosidl_runtime_c__type_description__TypeSource *
px4__msg__NpfgStatus__get_individual_type_description_source(
  const rosidl_message_type_support_t * type_support)
{
  (void)type_support;
  static const rosidl_runtime_c__type_description__TypeSource source = {
    {px4__msg__NpfgStatus__TYPE_NAME, 18, 18},
    {msg_encoding, 3, 3},
    {toplevel_type_raw_source, 1148, 1148},
  };
  return &source;
}

const rosidl_runtime_c__type_description__TypeSource__Sequence *
px4__msg__NpfgStatus__get_type_description_sources(
  const rosidl_message_type_support_t * type_support)
{
  (void)type_support;
  static rosidl_runtime_c__type_description__TypeSource sources[1];
  static const rosidl_runtime_c__type_description__TypeSource__Sequence source_sequence = {sources, 1, 1};
  static bool constructed = false;
  if (!constructed) {
    sources[0] = *px4__msg__NpfgStatus__get_individual_type_description_source(NULL),
    constructed = true;
  }
  return &source_sequence;
}
