// generated from rosidl_generator_c/resource/idl__struct.h.em
// with input from px4:msg/GeofenceResult.idl
// generated code does not contain a copyright notice

// IWYU pragma: private, include "px4/msg/geofence_result.h"


#ifndef PX4__MSG__DETAIL__GEOFENCE_RESULT__STRUCT_H_
#define PX4__MSG__DETAIL__GEOFENCE_RESULT__STRUCT_H_

#ifdef __cplusplus
extern "C"
{
#endif

#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>

// Constants defined in the message

/// Constant 'GF_ACTION_NONE'.
/**
  * no action on geofence violation
 */
enum
{
  px4__msg__GeofenceResult__GF_ACTION_NONE = 0
};

/// Constant 'GF_ACTION_WARN'.
/**
  * critical mavlink message
 */
enum
{
  px4__msg__GeofenceResult__GF_ACTION_WARN = 1
};

/// Constant 'GF_ACTION_LOITER'.
/**
  * switch to AUTO|LOITER
 */
enum
{
  px4__msg__GeofenceResult__GF_ACTION_LOITER = 2
};

/// Constant 'GF_ACTION_RTL'.
/**
  * switch to AUTO|RTL
 */
enum
{
  px4__msg__GeofenceResult__GF_ACTION_RTL = 3
};

/// Constant 'GF_ACTION_TERMINATE'.
/**
  * flight termination
 */
enum
{
  px4__msg__GeofenceResult__GF_ACTION_TERMINATE = 4
};

/// Constant 'GF_ACTION_LAND'.
/**
  * switch to AUTO|LAND
 */
enum
{
  px4__msg__GeofenceResult__GF_ACTION_LAND = 5
};

/// Struct defined in msg/GeofenceResult in the package px4.
typedef struct px4__msg__GeofenceResult
{
  /// time since system start (microseconds)
  uint64_t timestamp;
  /// one of geofence_violation_reason_t::*
  uint8_t geofence_violation_reason;
  /// true if the primary geofence is breached
  bool primary_geofence_breached;
  /// action to take when the primary geofence is breached
  uint8_t primary_geofence_action;
  /// true if the geofence requires a valid home position
  bool home_required;
} px4__msg__GeofenceResult;

// Struct for a sequence of px4__msg__GeofenceResult.
typedef struct px4__msg__GeofenceResult__Sequence
{
  px4__msg__GeofenceResult * data;
  /// The number of valid items in data
  size_t size;
  /// The number of allocated items in data
  size_t capacity;
} px4__msg__GeofenceResult__Sequence;

#ifdef __cplusplus
}
#endif

#endif  // PX4__MSG__DETAIL__GEOFENCE_RESULT__STRUCT_H_
