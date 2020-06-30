module LibUMP

include("UMP/UMP.jl")

using .UMP
export UMP

export get_position

export move_X_by, move_Y_by, move_Z_by, move_VX_by, move_3D_by

const DEF_IP = "169.254.255.255"
global DEF_HANDLE = C_NULL
const DEF_DEVICE = Cint(1)
const MAX_TIMEOUT = Cuint(999)
global DefaultUMP
global UMP_STATE
global UMP_NUMAXES
const AXIS_ANGLE = 23.8

mutable struct Position
    x::Cint
    y::Cint
    z::Cint
    w::Union{Cint, Nothing}
end

function __init__()
    global DEF_HANDLE = UMP.open(DEF_IP, MAX_TIMEOUT, UMP.DEF_GROUP)
    UMP.select_dev(DEF_HANDLE, DEF_DEVICE)
    global UMP_NUMAXES = UMP.get_axis_count(DEF_HANDLE, DEF_DEVICE)
end

function flooraxis(val)
    if val < 0
        return 0
    else
        return val
    end
end

function error_check(x)
    if x < 0
        @warn "Error return value: $x"
    end
end

function get_position(num_axes = UMP_NUMAXES)
    UMP.read_positions(DEF_HANDLE)
    x = UMP.get_x_position(DEF_HANDLE) |> flooraxis
    y = UMP.get_y_position(DEF_HANDLE) |> flooraxis
    z = UMP.get_z_position(DEF_HANDLE) |> flooraxis

    if num_axes > 3
        w = UMP.get_w_position(DEF_HANDLE) |> flooraxis
        return Position(x, y, z, w)
    else
        return Position(x, y, z, nothing)
    end
end 

function poll_status(handle = DEF_HANDLE, timeout = 200)
    UMP.receive(handle, Cint(timeout))
    status::Cint = UMP.get_status(handle)
    return status
end

function isbusy(handle = DEF_HANDLE)
    return Bool(UMP.is_busy_status(poll_status(DEF_HANDLE)))
end

function moveto(pos::Position, speed::Integer = 5000)
    if pos.w !== nothing
        UMP.goto_position(DEF_HANDLE, pos.x, pos.y, pos.z, pos.w, Cint(speed))
    else
        UMP.goto_position(DEF_HANDLE, pos.x, pos.y, pos.z, Cint(typemax(Cint)), Cint(speed))
    end
end

function moveto(pos::Position, xspeed, yspeed, zspeed, mode, accel, dev = DEF_DEVICE, handle = DEF_HANDLE)

    UMP.goto_position_ext2(handle, dev, pos.x, pos.y, pos.z, Cint(typemax(Cint)), Cint(xspeed), Cint(yspeed), Cint(zspeed),
                           Cint(0), Cint(mode), Cint(accel))
end

function take_step(xstep, ystep, zstep, xvel, yvel, zvel, dev = DEF_DEVICE, handle = DEF_HANDLE) end

function move_3D_by(xstep, ystep, zstep, speed, handle = DEF_HANDLE)
   
    UMP.take_step(handle, Cint(xstep), Cint(ystep), Cint(zstep), Cint(0), Cint(speed)) |> error_check
end

function move_X_by(xstep, speed, dev = DEF_DEVICE, handle = DEF_HANDLE)

    UMP.take_step(handle, Cint(xstep), Cint(0), Cint(0), Cint(0), Cint(speed))
end

function move_Y_by(ystep, speed, dev = DEF_DEVICE, handle = DEF_HANDLE)

    UMP.take_step(handle, Cint(0), Cint(ystep), Cint(0), Cint(0), Cint(speed))
end

function move_Z_by(zstep, speed, dev = DEF_DEVICE, handle = DEF_HANDLE)

    UMP.take_step(handle, Cint(0), Cint(0), Cint(zstep), Cint(0), Cint(speed))
end

# mutable struct Speed
#     vx::Cint
#     vy::Cint
#     vz::Cint
#     vw::Cint
# end
# 
# 
# mutable struct Manipulator
#     id::Cint
#     current::Position
# end
# 
# mutable struct UMPState
#     handle::StateHandle
#     active_device::Manipulator
# end


end # module
