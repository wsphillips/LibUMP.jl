# Automatically generated using Clang.jl


struct ump_state_s
    last_received_time::Culong
    socket::SOCKET
    own_id::Cint
    message_id::UInt16
    last_device_sent::Cint
    last_device_received::Cint
    retransmit_count::Cint
    refresh_time_limit::Cint
    last_error::Cint
    last_os_errno::Cint
    timeout::Cint
    udp_port::Cint
    last_status::NTuple{254, Cint}
    drive_status::NTuple{254, Cint}
    drive_status_id::NTuple{254, UInt16}
    addresses::NTuple{254, IPADDR}
    cu_address::IPADDR
    last_positions::NTuple{254, ump_positions}
    laddr::IPADDR
    raddr::IPADDR
    errorstr_buffer::NTuple{256, UInt8}
    verbose::Cint
    log_func_ptr::ump_log_print_func
    log_print_arg::Ptr{Cvoid}
    next_cmd_options::Cint
    drive_status_ts::NTuple{254, Culonglong}
end
