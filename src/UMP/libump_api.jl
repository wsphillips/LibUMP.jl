
function open(udp_target_address::String, timeout::UInt32, group::Cint)
    ccall((:ump_open, :libump), StateHandle, (Cstring, UInt32, Cint), udp_target_address, timeout, group)
end

function close(hndl::StateHandle)
    ccall((:ump_close, :libump), Cint, (StateHandle,), hndl)
end

function last_error(hndl::StateHandle)
    ccall((:ump_last_error, :libump), Cint, (StateHandle,), hndl)
end

function last_os_errno(hndl::StateHandle)
    ccall((:ump_last_os_errno, :libump), Cint, (StateHandle,), hndl)
end

function errorstr(error_code::Cint)
    ccall((:Cintstr, :libump), Cint, (Cint,), error_code)
end

function last_errorstr(hndl::StateHandle)
    ccall((:ump_last_errorstr, :libump), Cint, (StateHandle,), hndl)
end

function get_version()
    ccall((:ump_get_version, :libump), Cint, ())
end

function read_version(hndl::StateHandle, version::Ref{Cint}, size::Cint)
    ccall((:ump_read_version, :libump), Cint, (StateHandle, Ref{Cint}, Cint), hndl, version, size)
end

function get_axis_count(hndl::StateHandle, dev::Cint)
    ccall((:ump_get_axis_count, :libump), Cint, (StateHandle, Cint), hndl, dev)
end

function select_dev(hndl::StateHandle, dev::Cint)
    ccall((:ump_select_dev, :libump), Cint, (StateHandle, Cint), hndl, dev)
end

function set_refresh_time_limit(hndl::StateHandle, value::Cint)
    ccall((:ump_set_refresh_time_limit, :libump), Cint, (StateHandle, Cint), hndl, value)
end

function set_timeout(hndl::StateHandle, value::Cint)
    ccall((:ump_set_timeout, :libump), Cint, (StateHandle, Cint), hndl, value)
end

function get_status(hndl::StateHandle)
    ccall((:ump_get_status, :libump), Cint, (StateHandle,), hndl)
end

function is_busy(hndl::StateHandle)
    ccall((:ump_is_busy, :libump), Cint, (StateHandle,), hndl)
end

function is_busy_status(status::Status)
    ccall((:ump_is_busy_status, :libump), Cint, (Status,), status)
end

function get_drive_status(hndl::StateHandle)
    ccall((:ump_get_drive_status, :libump), Cint, (StateHandle,), hndl)
end

function take_step(hndl::StateHandle, x::Cint, y::Cint, z::Cint, w::Cint, speed::Cint)
    ccall((:ump_take_step, :libump), Cint, (StateHandle, Cint, Cint, Cint, Cint, Cint), hndl, x, y, z, w, speed)
end

function cmd_get_axis_angle(hndl::StateHandle, dev::Cint, axis::Cint, layer::Cint)
    ccall((:ump_cmd_get_axis_angle, :libump), Cint, (StateHandle, Cint, Cint, Cint), hndl, dev, axis, layer)
end

function take_jackhammer_step(hndl::StateHandle, axis::Cint, iterations::Cint, pulse1_step_count::Cint, pulse1_step_size::Cint, pulse2_step_count::Cint, pulse2_step_size::Cint)
    ccall((:ump_take_jackhammer_step, :libump), Cint, (StateHandle, Cint, Cint, Cint, Cint, Cint, Cint), hndl, axis, iterations, pulse1_step_count, pulse1_step_size, pulse2_step_count, pulse2_step_size)
end

function get_positions(hndl::StateHandle, x::Ref{Cint}, y::Ref{Cint}, z::Ref{Cint}, w::Ref{Cint})
    ccall((:ump_get_positions, :libump), Cint, (StateHandle, Ref{Cint}, Ref{Cint}, Ref{Cint}, Ref{Cint}), hndl, x, y, z, w)
end

function get_speeds(hndl::StateHandle, x::Ref{Cfloat}, y::Ref{Cfloat}, z::Ref{Cfloat}, w::Ref{Cfloat})
    ccall((:ump_get_speeds, :libump), Cint, (StateHandle, Ref{Cfloat}, Ref{Cfloat}, Ref{Cfloat}, Ref{Cfloat}), hndl, x, y, z, w)
end

function read_positions(hndl::StateHandle)
    ccall((:ump_read_positions, :libump), Cint, (StateHandle,), hndl)
end

function get_x_position(hndl::StateHandle)
    ccall((:ump_get_x_position, :libump), Cint, (StateHandle,), hndl)
end

function get_y_position(hndl::StateHandle)
    ccall((:ump_get_y_position, :libump), Cint, (StateHandle,), hndl)
end

function get_z_position(hndl::StateHandle)
    ccall((:ump_get_z_position, :libump), Cint, (StateHandle,), hndl)
end

function get_w_position(hndl::StateHandle)
    ccall((:ump_get_w_position, :libump), Cint, (StateHandle,), hndl)
end

function store_mem_current_position(hndl::StateHandle)
    ccall((:ump_store_mem_current_position, :libump), Cint, (StateHandle,), hndl)
end

function goto_position(hndl::StateHandle, x::Cint, y::Cint, z::Cint, w::Cint, speed::Cint)
    ccall((:ump_goto_position, :libump), Cint, (StateHandle, Cint, Cint, Cint, Cint, Cint), hndl, x, y, z, w, speed)
end

# Alternate dispatch for 3-axis manipulators
function goto_position(hndl::StateHandle, x::Cint, y::Cint, z::Cint, speed::Cint)
    ccall((:ump_goto_position, :libump), Cint, (StateHandle, Cint, Cint, Cint, Ptr{Cvoid}, Cint), hndl, x, y, z, C_NULL, speed)
end

function goto_virtual_axis_position(hndl::StateHandle, x_position::Cint, speed::Cint)
    ccall((:ump_goto_virtual_axis_position, :libump), Cint, (StateHandle, Cint, Cint), hndl, x_position, speed)
end

function goto_mem_position(hndl::StateHandle, speed::Cint, storage_id::Cint)
    ccall((:ump_goto_mem_position, :libump), Cint, (StateHandle, Cint, Cint), hndl, speed, storage_id)
end

function stop(hndl::StateHandle)
    ccall((:ump_stop, :libump), Cint, (StateHandle,), hndl)
end

function stop_all(hndl::StateHandle)
    ccall((:ump_stop_all, :libump), Cint, (StateHandle,), hndl)
end

function ping(hndl::StateHandle, dev::Cint)
    ccall((:ump_ping, :libump), Cint, (StateHandle, Cint), hndl, dev)
end

function is_busy_ext(hndl::StateHandle, dev::Cint)
    ccall((:ump_is_busy_ext, :libump), Cint, (StateHandle, Cint), hndl, dev)
end

function get_status_ext(hndl::StateHandle, dev::Cint)
    ccall((:ump_get_status_ext, :libump), Cint, (StateHandle, Cint), hndl, dev)
end

function get_drive_status_ext(hndl::StateHandle, dev::Cint)
    ccall((:ump_get_drive_status_ext, :libump), Cint, (StateHandle, Cint), hndl, dev)
end

function read_version_ext(hndl::StateHandle, dev::Cint, version::Ref{Cint}, size::Cint)
    ccall((:ump_read_version_ext, :libump), Cint, (StateHandle, Cint, Ref{Cint}, Cint), hndl, dev, version, size)
end

function get_axis_count_ext(hndl::StateHandle, dev::Cint)
    ccall((:ump_get_axis_count_ext, :libump), Cint, (StateHandle, Cint), hndl, dev)
end

function store_mem_current_position_ext(hndl::StateHandle, dev::Cint, storage_id::Cint)
    ccall((:ump_store_mem_current_position_ext, :libump), Cint, (StateHandle, Cint, Cint), hndl, dev, storage_id)
end

function goto_position_ext(hndl::StateHandle, dev::Cint, x::Cint, y::Cint, z::Cint, w::Cint, speed::Cint, mode::Cint, max_acc::Cint)
    ccall((:ump_goto_position_ext, :libump), Cint, (StateHandle, Cint, Cint, Cint, Cint, Cint, Cint, Cint, Cint), hndl, dev, x, y, z, w, speed, mode, max_acc)
end

function goto_position_ext2(hndl::StateHandle, dev::Cint, x::Cint, y::Cint, z::Cint, w::Cint, speedX::Cint, speedY::Cint, speedZ::Cint, speedW::Cint, mode::Cint, max_acc::Cint)
    ccall((:ump_goto_position_ext2, :libump), Cint, (StateHandle, Cint, Cint, Cint, Cint, Cint, Cint, Cint, Cint, Cint, Cint, Cint), hndl, dev, x, y, z, w, speedX, speedY, speedZ, speedW, mode, max_acc)
end

function goto_virtual_axis_position_ext(hndl::StateHandle, dev::Cint, x_position::Cint, speed::Cint)
    ccall((:ump_goto_virtual_axis_position_ext, :libump), Cint, (StateHandle, Cint, Cint, Cint), hndl, dev, x_position, speed)
end

function goto_mem_position_ext(hndl::StateHandle, dev::Cint, speed::Cint, storage_id::Cint, mode::Cint)
    ccall((:ump_goto_mem_position_ext, :libump), Cint, (StateHandle, Cint, Cint, Cint, Cint), hndl, dev, speed, storage_id, mode)
end

function stop_ext(hndl::StateHandle, dev::Cint)
    ccall((:ump_stop_ext, :libump), Cint, (StateHandle, Cint), hndl, dev)
end

function receive(hndl::StateHandle, timelimit::Cint)
    ccall((:ump_receive, :libump), Cint, (StateHandle, Cint), hndl, timelimit)
end

function get_positions_ext(hndl::StateHandle, dev::Cint, time_limit::Cint, x::Ref{Cint}, y::Ref{Cint}, z::Ref{Cint}, w::Ref{Cint}, elapsed::Ref{Cint})
    ccall((:ump_get_positions_ext, :libump), Cint, (StateHandle, Cint, Cint, Ref{Cint}, Ref{Cint}, Ref{Cint}, Ref{Cint}, Ref{Cint}), hndl, dev, time_limit, x, y, z, w, elapsed)
end

function get_speeds_ext(hndl::StateHandle, dev::Cint, x::Ref{Cfloat}, y::Ref{Cfloat}, z::Ref{Cfloat}, w::Ref{Cfloat}, elapsedptr::Ref{Cint})
    ccall((:ump_get_speeds_ext, :libump), Cint, (StateHandle, Cint, Ref{Cfloat}, Ref{Cfloat}, Ref{Cfloat}, Ref{Cfloat}, Ref{Cint}), hndl, dev, x, y, z, w, elapsedptr)
end

function read_positions_ext(hndl::StateHandle, dev::Cint, time_limit::Cint)
    ccall((:ump_read_positions_ext, :libump), Cint, (StateHandle, Cint, Cint), hndl, dev, time_limit)
end

function get_position_ext(hndl::StateHandle, dev::Cint, axis::UInt8)
    ccall((:ump_get_position_ext, :libump), Cint, (StateHandle, Cint, UInt8), hndl, dev, axis)
end

function get_speed_ext(hndl::StateHandle, dev::Cint, axis::UInt8)
    ccall((:ump_get_speed_ext, :libump), Cint, (StateHandle, Cint, UInt8), hndl, dev, axis)
end

function take_step_ext(hndl::StateHandle, dev::Cint, step_x::Cint, step_y::Cint, step_z::Cint, step_w::Cint, speed_x::Cint, speed_y::Cint, speed_z::Cint, speed_w::Cint)
    ccall((:ump_take_step_ext, :libump), Cint, (StateHandle, Cint, Cint, Cint, Cint, Cint, Cint, Cint, Cint, Cint), hndl, dev, step_x, step_y, step_z, step_w, speed_x, speed_y, speed_z, speed_w)
end

function take_jackhammer_step_ext(hndl::StateHandle, dev::Cint, axis::Cint, iterations::Cint, pulse1_step_count::Cint, pulse1_step_size::Cint, pulse2_step_count::Cint, pulse2_step_size::Cint)
    ccall((:ump_take_jackhammer_step_ext, :libump), Cint, (StateHandle, Cint, Cint, Cint, Cint, Cint, Cint, Cint), hndl, dev, axis, iterations, pulse1_step_count, pulse1_step_size, pulse2_step_count, pulse2_step_size)
end

function cmd_options(hndl::StateHandle, optionbits::Cint)
    ccall((:ump_cmd_options, :libump), Cint, (StateHandle, Cint), hndl, optionbits)
end

function cmd(hndl::StateHandle, dev::Cint, cmd::Cint, argc::Cint, argv::Ref{Cint})
    ccall((:ump_cmd, :libump), Cint, (StateHandle, Cint, Cint, Cint, Ref{Cint}), hndl, dev, cmd, argc, argv)
end

function cmd_ext(hndl::StateHandle, dev::Cint, cmd::Cint, argc::Cint, argv::Ref{Cint}, respsize::Cint, response::Ref{Cint})
    ccall((:ump_cmd_ext, :libump), Cint, (StateHandle, Cint, Cint, Cint, Ref{Cint}, Cint, Ref{Cint}), hndl, dev, cmd, argc, argv, respsize, response)
end

function get_param(hndl::StateHandle, dev::Cint, param_id::Cint, value::Ref{Cint})
    ccall((:ump_get_param, :libump), Cint, (StateHandle, Cint, Cint, Ref{Cint}), hndl, dev, param_id, value)
end

function set_param(hndl::StateHandle, dev::Cint, param_id::Cint, value::Cint)
    ccall((:ump_set_param, :libump), Cint, (StateHandle, Cint, Cint, Cint), hndl, dev, param_id, value)
end

function get_feature(hndl::StateHandle, dev::Cint, feature_id::Cint)
    ccall((:ump_get_feature, :libump), Cint, (StateHandle, Cint, Cint), hndl, dev, feature_id)
end

function get_ext_feature(hndl::StateHandle, dev::Cint, feature_id::Cint)
    ccall((:ump_get_ext_feature, :libump), Cint, (StateHandle, Cint, Cint), hndl, dev, feature_id)
end

function set_feature(hndl::StateHandle, dev::Cint, feature_id::Cint, value::Cint)
    ccall((:ump_set_feature, :libump), Cint, (StateHandle, Cint, Cint, Cint), hndl, dev, feature_id, value)
end

function set_ext_feature(hndl::StateHandle, dev::Cint, feature_id::Cint, value::Cint)
    ccall((:ump_set_ext_feature, :libump), Cint, (StateHandle, Cint, Cint, Cint), hndl, dev, feature_id, value)
end

function get_feature_functionality(hndl::StateHandle, dev::Cint, feature_id::Cint)
    ccall((:ump_get_feature_functionality, :libump), Cint, (StateHandle, Cint, Cint), hndl, dev, feature_id)
end

function umv_set_pressure(hndl::StateHandle, dev::Cint, channel::Cint, value::Cint)
    ccall((:ump_umv_set_pressure, :libump), Cint, (StateHandle, Cint, Cint, Cint), hndl, dev, channel, value)
end

function get_feature_mask(hndl::StateHandle, dev::Cint, feature_id::Cint)
    ccall((:ump_get_feature_mask, :libump), Cint, (StateHandle, Cint, Cint), hndl, dev, feature_id)
end

function cu_select_manipulator(hndl::StateHandle, dev::Cint)
    ccall((:ump_cu_select_manipulator, :libump), Cint, (StateHandle, Cint), hndl, dev)
end

function cu_set_speed_mode(hndl::StateHandle, speed_mode::Cint, pen_step_size::Cint)
    ccall((:ump_cu_set_speed_mode, :libump), Cint, (StateHandle, Cint, Cint), hndl, speed_mode, pen_step_size)
end

function cu_set_active(hndl::StateHandle, active::Cint)
    ccall((:ump_cu_set_active, :libump), Cint, (StateHandle, Cint), hndl, active)
end

function cu_read_version(hndl::StateHandle, version::Ref{Cint}, size::Cint)
    ccall((:ump_cu_read_version, :libump), Cint, (StateHandle, Ref{Cint}, Cint), hndl, version, size)
end

function cu_read_rwx_version(hndl::StateHandle, version::Ref{Cint}, size::Cint)
    ccall((:ump_cu_read_rwx_version, :libump), Cint, (StateHandle, Ref{Cint}, Cint), hndl, version, size)
end

function get_device_list(hndl::StateHandle, devs::Ref{Cint})
    ccall((:ump_get_device_list, :libump), Cint, (StateHandle, Ref{Cint}), hndl, devs)
end

function clear_device_list(hndl::StateHandle)
    ccall((:ump_clear_device_list, :libump), Cint, (StateHandle,), hndl)
end

function set_slow_speed_mode(hndl::StateHandle, dev::Cint, activated::Cint)
    ccall((:ump_set_slow_speed_mode, :libump), Cint, (StateHandle, Cint, Cint), hndl, dev, activated)
end

function get_slow_speed_mode(hndl::StateHandle, dev::Cint)
    ccall((:ump_get_slow_speed_mode, :libump), Cint, (StateHandle, Cint), hndl, dev)
end

function get_piezo_voltage(hndl::StateHandle, dev::Cint, actuator::Cint)
    ccall((:ump_get_piezo_voltage, :libump), Cint, (StateHandle, Cint, Cint), hndl, dev, actuator)
end
#=
function set_log_func(hndl::StateHandle, verbose_level::Cint, func::ump_log_print_func, arg::Ref{Cvoid})
    ccall((:ump_set_log_func, :libump), Cint, (StateHandle, Cint, ump_log_print_func, Ref{Cvoid}), hndl, verbose_level, func, arg)
end
=#

