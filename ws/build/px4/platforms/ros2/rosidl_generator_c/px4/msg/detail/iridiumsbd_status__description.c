// generated from rosidl_generator_c/resource/idl__description.c.em
// with input from px4:msg/IridiumsbdStatus.idl
// generated code does not contain a copyright notice

#include "px4/msg/detail/iridiumsbd_status__functions.h"

ROSIDL_GENERATOR_C_PUBLIC_px4
const rosidl_type_hash_t *
px4__msg__IridiumsbdStatus__get_type_hash(
  const rosidl_message_type_support_t * type_support)
{
  (void)type_support;
  static rosidl_type_hash_t hash = {1, {
      0x50, 0xb6, 0xb1, 0x30, 0x8f, 0xa1, 0x68, 0x71,
      0x43, 0xb5, 0x17, 0x0f, 0x88, 0x2c, 0x9a, 0x4b,
      0xa0, 0x1a, 0xee, 0xc8, 0xc6, 0x2d, 0xcc, 0x86,
      0xc8, 0x56, 0x0e, 0x27, 0x58, 0xa7, 0xf4, 0xae,
    }};
  return &hash;
}

#include <assert.h>
#include <string.h>

// Include directives for referenced types

// Hashes for external referenced types
#ifndef NDEBUG
#endif

static char px4__msg__IridiumsbdStatus__TYPE_NAME[] = "px4/msg/IridiumsbdStatus";

// Define type names, field names, and default values
static char px4__msg__IridiumsbdStatus__FIELD_NAME__timestamp[] = "timestamp";
static char px4__msg__IridiumsbdStatus__FIELD_NAME__last_heartbeat[] = "last_heartbeat";
static char px4__msg__IridiumsbdStatus__FIELD_NAME__tx_buf_write_index[] = "tx_buf_write_index";
static char px4__msg__IridiumsbdStatus__FIELD_NAME__rx_buf_read_index[] = "rx_buf_read_index";
static char px4__msg__IridiumsbdStatus__FIELD_NAME__rx_buf_end_index[] = "rx_buf_end_index";
static char px4__msg__IridiumsbdStatus__FIELD_NAME__failed_sbd_sessions[] = "failed_sbd_sessions";
static char px4__msg__IridiumsbdStatus__FIELD_NAME__successful_sbd_sessions[] = "successful_sbd_sessions";
static char px4__msg__IridiumsbdStatus__FIELD_NAME__num_tx_buf_reset[] = "num_tx_buf_reset";
static char px4__msg__IridiumsbdStatus__FIELD_NAME__signal_quality[] = "signal_quality";
static char px4__msg__IridiumsbdStatus__FIELD_NAME__state[] = "state";
static char px4__msg__IridiumsbdStatus__FIELD_NAME__ring_pending[] = "ring_pending";
static char px4__msg__IridiumsbdStatus__FIELD_NAME__tx_buf_write_pending[] = "tx_buf_write_pending";
static char px4__msg__IridiumsbdStatus__FIELD_NAME__tx_session_pending[] = "tx_session_pending";
static char px4__msg__IridiumsbdStatus__FIELD_NAME__rx_read_pending[] = "rx_read_pending";
static char px4__msg__IridiumsbdStatus__FIELD_NAME__rx_session_pending[] = "rx_session_pending";

static rosidl_runtime_c__type_description__Field px4__msg__IridiumsbdStatus__FIELDS[] = {
  {
    {px4__msg__IridiumsbdStatus__FIELD_NAME__timestamp, 9, 9},
    {
      rosidl_runtime_c__type_description__FieldType__FIELD_TYPE_UINT64,
      0,
      0,
      {NULL, 0, 0},
    },
    {NULL, 0, 0},
  },
  {
    {px4__msg__IridiumsbdStatus__FIELD_NAME__last_heartbeat, 14, 14},
    {
      rosidl_runtime_c__type_description__FieldType__FIELD_TYPE_UINT64,
      0,
      0,
      {NULL, 0, 0},
    },
    {NULL, 0, 0},
  },
  {
    {px4__msg__IridiumsbdStatus__FIELD_NAME__tx_buf_write_index, 18, 18},
    {
      rosidl_runtime_c__type_description__FieldType__FIELD_TYPE_UINT16,
      0,
      0,
      {NULL, 0, 0},
    },
    {NULL, 0, 0},
  },
  {
    {px4__msg__IridiumsbdStatus__FIELD_NAME__rx_buf_read_index, 17, 17},
    {
      rosidl_runtime_c__type_description__FieldType__FIELD_TYPE_UINT16,
      0,
      0,
      {NULL, 0, 0},
    },
    {NULL, 0, 0},
  },
  {
    {px4__msg__IridiumsbdStatus__FIELD_NAME__rx_buf_end_index, 16, 16},
    {
      rosidl_runtime_c__type_description__FieldType__FIELD_TYPE_UINT16,
      0,
      0,
      {NULL, 0, 0},
    },
    {NULL, 0, 0},
  },
  {
    {px4__msg__IridiumsbdStatus__FIELD_NAME__failed_sbd_sessions, 19, 19},
    {
      rosidl_runtime_c__type_description__FieldType__FIELD_TYPE_UINT16,
      0,
      0,
      {NULL, 0, 0},
    },
    {NULL, 0, 0},
  },
  {
    {px4__msg__IridiumsbdStatus__FIELD_NAME__successful_sbd_sessions, 23, 23},
    {
      rosidl_runtime_c__type_description__FieldType__FIELD_TYPE_UINT16,
      0,
      0,
      {NULL, 0, 0},
    },
    {NULL, 0, 0},
  },
  {
    {px4__msg__IridiumsbdStatus__FIELD_NAME__num_tx_buf_reset, 16, 16},
    {
      rosidl_runtime_c__type_description__FieldType__FIELD_TYPE_UINT16,
      0,
      0,
      {NULL, 0, 0},
    },
    {NULL, 0, 0},
  },
  {
    {px4__msg__IridiumsbdStatus__FIELD_NAME__signal_quality, 14, 14},
    {
      rosidl_runtime_c__type_description__FieldType__FIELD_TYPE_UINT8,
      0,
      0,
      {NULL, 0, 0},
    },
    {NULL, 0, 0},
  },
  {
    {px4__msg__IridiumsbdStatus__FIELD_NAME__state, 5, 5},
    {
      rosidl_runtime_c__type_description__FieldType__FIELD_TYPE_UINT8,
      0,
      0,
      {NULL, 0, 0},
    },
    {NULL, 0, 0},
  },
  {
    {px4__msg__IridiumsbdStatus__FIELD_NAME__ring_pending, 12, 12},
    {
      rosidl_runtime_c__type_description__FieldType__FIELD_TYPE_BOOLEAN,
      0,
      0,
      {NULL, 0, 0},
    },
    {NULL, 0, 0},
  },
  {
    {px4__msg__IridiumsbdStatus__FIELD_NAME__tx_buf_write_pending, 20, 20},
    {
      rosidl_runtime_c__type_description__FieldType__FIELD_TYPE_BOOLEAN,
      0,
      0,
      {NULL, 0, 0},
    },
    {NULL, 0, 0},
  },
  {
    {px4__msg__IridiumsbdStatus__FIELD_NAME__tx_session_pending, 18, 18},
    {
      rosidl_runtime_c__type_description__FieldType__FIELD_TYPE_BOOLEAN,
      0,
      0,
      {NULL, 0, 0},
    },
    {NULL, 0, 0},
  },
  {
    {px4__msg__IridiumsbdStatus__FIELD_NAME__rx_read_pending, 15, 15},
    {
      rosidl_runtime_c__type_description__FieldType__FIELD_TYPE_BOOLEAN,
      0,
      0,
      {NULL, 0, 0},
    },
    {NULL, 0, 0},
  },
  {
    {px4__msg__IridiumsbdStatus__FIELD_NAME__rx_session_pending, 18, 18},
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
px4__msg__IridiumsbdStatus__get_type_description(
  const rosidl_message_type_support_t * type_support)
{
  (void)type_support;
  static bool constructed = false;
  static const rosidl_runtime_c__type_description__TypeDescription description = {
    {
      {px4__msg__IridiumsbdStatus__TYPE_NAME, 24, 24},
      {px4__msg__IridiumsbdStatus__FIELDS, 15, 15},
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
  "uint64 last_heartbeat\\t\\t\\t\\t# timestamp of the last successful sbd session\n"
  "uint16 tx_buf_write_index\\t\\t\\t# current size of the tx buffer\n"
  "uint16 rx_buf_read_index\\t\\t\\t# the rx buffer is parsed up to that index\n"
  "uint16 rx_buf_end_index\\t\\t\\t\\t# current size of the rx buffer\n"
  "uint16 failed_sbd_sessions\\t\\t\\t# number of failed sbd sessions\n"
  "uint16 successful_sbd_sessions      # number of successful sbd sessions\n"
  "uint16 num_tx_buf_reset             # number of times the tx buffer was reset\n"
  "uint8 signal_quality                # current signal quality, 0 is no signal, 5 the best\n"
  "uint8 state                         # current state of the driver, see the satcom_state of IridiumSBD.h for the definition\n"
  "bool ring_pending                   # indicates if a ring call is pending\n"
  "bool tx_buf_write_pending           # indicates if a tx buffer write is pending\n"
  "bool tx_session_pending             # indicates if a tx session is pending\n"
  "bool rx_read_pending                # indicates if a rx read is pending\n"
  "bool rx_session_pending             # indicates if a rx session is pending";

static char msg_encoding[] = "msg";

// Define all individual source functions

const rosidl_runtime_c__type_description__TypeSource *
px4__msg__IridiumsbdStatus__get_individual_type_description_source(
  const rosidl_message_type_support_t * type_support)
{
  (void)type_support;
  static const rosidl_runtime_c__type_description__TypeSource source = {
    {px4__msg__IridiumsbdStatus__TYPE_NAME, 24, 24},
    {msg_encoding, 3, 3},
    {toplevel_type_raw_source, 1121, 1121},
  };
  return &source;
}

const rosidl_runtime_c__type_description__TypeSource__Sequence *
px4__msg__IridiumsbdStatus__get_type_description_sources(
  const rosidl_message_type_support_t * type_support)
{
  (void)type_support;
  static rosidl_runtime_c__type_description__TypeSource sources[1];
  static const rosidl_runtime_c__type_description__TypeSource__Sequence source_sequence = {sources, 1, 1};
  static bool constructed = false;
  if (!constructed) {
    sources[0] = *px4__msg__IridiumsbdStatus__get_individual_type_description_source(NULL),
    constructed = true;
  }
  return &source_sequence;
}
