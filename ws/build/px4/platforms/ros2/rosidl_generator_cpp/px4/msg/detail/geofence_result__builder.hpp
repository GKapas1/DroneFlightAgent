// generated from rosidl_generator_cpp/resource/idl__builder.hpp.em
// with input from px4:msg/GeofenceResult.idl
// generated code does not contain a copyright notice

// IWYU pragma: private, include "px4/msg/geofence_result.hpp"


#ifndef PX4__MSG__DETAIL__GEOFENCE_RESULT__BUILDER_HPP_
#define PX4__MSG__DETAIL__GEOFENCE_RESULT__BUILDER_HPP_

#include <algorithm>
#include <utility>

#include "px4/msg/detail/geofence_result__struct.hpp"
#include "rosidl_runtime_cpp/message_initialization.hpp"


namespace px4
{

namespace msg
{

namespace builder
{

class Init_GeofenceResult_home_required
{
public:
  explicit Init_GeofenceResult_home_required(::px4::msg::GeofenceResult & msg)
  : msg_(msg)
  {}
  ::px4::msg::GeofenceResult home_required(::px4::msg::GeofenceResult::_home_required_type arg)
  {
    msg_.home_required = std::move(arg);
    return std::move(msg_);
  }

private:
  ::px4::msg::GeofenceResult msg_;
};

class Init_GeofenceResult_primary_geofence_action
{
public:
  explicit Init_GeofenceResult_primary_geofence_action(::px4::msg::GeofenceResult & msg)
  : msg_(msg)
  {}
  Init_GeofenceResult_home_required primary_geofence_action(::px4::msg::GeofenceResult::_primary_geofence_action_type arg)
  {
    msg_.primary_geofence_action = std::move(arg);
    return Init_GeofenceResult_home_required(msg_);
  }

private:
  ::px4::msg::GeofenceResult msg_;
};

class Init_GeofenceResult_primary_geofence_breached
{
public:
  explicit Init_GeofenceResult_primary_geofence_breached(::px4::msg::GeofenceResult & msg)
  : msg_(msg)
  {}
  Init_GeofenceResult_primary_geofence_action primary_geofence_breached(::px4::msg::GeofenceResult::_primary_geofence_breached_type arg)
  {
    msg_.primary_geofence_breached = std::move(arg);
    return Init_GeofenceResult_primary_geofence_action(msg_);
  }

private:
  ::px4::msg::GeofenceResult msg_;
};

class Init_GeofenceResult_geofence_violation_reason
{
public:
  explicit Init_GeofenceResult_geofence_violation_reason(::px4::msg::GeofenceResult & msg)
  : msg_(msg)
  {}
  Init_GeofenceResult_primary_geofence_breached geofence_violation_reason(::px4::msg::GeofenceResult::_geofence_violation_reason_type arg)
  {
    msg_.geofence_violation_reason = std::move(arg);
    return Init_GeofenceResult_primary_geofence_breached(msg_);
  }

private:
  ::px4::msg::GeofenceResult msg_;
};

class Init_GeofenceResult_timestamp
{
public:
  Init_GeofenceResult_timestamp()
  : msg_(::rosidl_runtime_cpp::MessageInitialization::SKIP)
  {}
  Init_GeofenceResult_geofence_violation_reason timestamp(::px4::msg::GeofenceResult::_timestamp_type arg)
  {
    msg_.timestamp = std::move(arg);
    return Init_GeofenceResult_geofence_violation_reason(msg_);
  }

private:
  ::px4::msg::GeofenceResult msg_;
};

}  // namespace builder

}  // namespace msg

template<typename MessageType>
auto build();

template<>
inline
auto build<::px4::msg::GeofenceResult>()
{
  return px4::msg::builder::Init_GeofenceResult_timestamp();
}

}  // namespace px4

#endif  // PX4__MSG__DETAIL__GEOFENCE_RESULT__BUILDER_HPP_
