// generated from rosidl_generator_c/resource/idl__struct.h.em
// with input from px4:msg/AckermannVelocitySetpoint.idl
// generated code does not contain a copyright notice

// IWYU pragma: private, include "px4/msg/ackermann_velocity_setpoint.h"


#ifndef PX4__MSG__DETAIL__ACKERMANN_VELOCITY_SETPOINT__STRUCT_H_
#define PX4__MSG__DETAIL__ACKERMANN_VELOCITY_SETPOINT__STRUCT_H_

#ifdef __cplusplus
extern "C"
{
#endif

#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>

// Constants defined in the message

/// Struct defined in msg/AckermannVelocitySetpoint in the package px4.
typedef struct px4__msg__AckermannVelocitySetpoint
{
  /// time since system start (microseconds)
  uint64_t timestamp;
  /// 2-dimensional velocity setpoint in NED frame
  float velocity_ned[2];
  /// Flag for backwards driving
  bool backwards;
} px4__msg__AckermannVelocitySetpoint;

// Struct for a sequence of px4__msg__AckermannVelocitySetpoint.
typedef struct px4__msg__AckermannVelocitySetpoint__Sequence
{
  px4__msg__AckermannVelocitySetpoint * data;
  /// The number of valid items in data
  size_t size;
  /// The number of allocated items in data
  size_t capacity;
} px4__msg__AckermannVelocitySetpoint__Sequence;

#ifdef __cplusplus
}
#endif

#endif  // PX4__MSG__DETAIL__ACKERMANN_VELOCITY_SETPOINT__STRUCT_H_
