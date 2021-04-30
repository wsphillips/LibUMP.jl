module LibUMP

include("UMP/UMP.jl")

using .UMP
export UMP

export Position
export get_position, isbusy, moveto
export move_X_by, move_Y_by, move_Z_by, move_3D_by

const BROADCAST_IP = "169.254.255.255"
const DEF_HANDLE = Ref{Ptr{Cvoid}}(0)
const DEF_DEVICE = Cint(1)
const MAX_TIMEOUT = Cuint(999)
const UMP_NUMAXES = Ref{Int64}(0)

struct Position
    x::Cint
    y::Cint
    z::Cint
    w::Union{Cint, Nothing}
end

function __init__()
    DEF_HANDLE[] = UMP.open(BROADCAST_IP, MAX_TIMEOUT, UMP.DEF_GROUP)
    UMP.select_dev(DEF_HANDLE[], DEF_DEVICE)
    UMP.set_timeout(DEF_HANDLE[], Cint(10)) # set UDP receive timeout to 10ms
    UMP_NUMAXES[] = UMP.get_axis_count(DEF_HANDLE[], DEF_DEVICE)
end

function error_check(x)
    x < 0 && (@warn "Error return value: $x")
end

function get_position(handle = DEF_HANDLE[], num_axes = UMP_NUMAXES[])
    UMP.read_positions(handle)
    x = clamp(UMP.get_x_position(handle), zero(Cint), typemax(Cint))
    y = clamp(UMP.get_y_position(handle), zero(Cint), typemax(Cint))
    z = clamp(UMP.get_z_position(handle), zero(Cint), typemax(Cint))

    if num_axes > 3
        w = clamp(UMP.get_w_position(handle), zero(Cint), typemax(Cint))
        return Position(x, y, z, w)
    else
        return Position(x, y, z, nothing)
    end
end 

function poll_status(handle = DEF_HANDLE[], timeout = 10)
    UMP.receive(handle, Cint(timeout))
    status::Cint = UMP.get_status(handle)
    return status
end

function isbusy(handle = DEF_HANDLE[])
    return Bool(UMP.is_busy_status(poll_status(handle)))
end

function moveto(pos::Position, speed::Integer = 5000, handle = DEF_HANDLE[])
    if pos.w !== nothing
        UMP.goto_position(handle, pos.x, pos.y, pos.z, pos.w, Cint(speed))
    else
        UMP.goto_position(handle, pos.x, pos.y, pos.z, Cint(typemax(Cint)), Cint(speed))
    end
end

function moveto(pos::Position, xspeed, yspeed, zspeed, mode, accel; dev = DEF_DEVICE, handle = DEF_HANDLE[])
    UMP.goto_position_ext2(handle, dev, pos.x, pos.y, pos.z, Cint(typemax(Cint)), Cint(xspeed), Cint(yspeed), Cint(zspeed),
                           Cint(0), Cint(mode), Cint(accel))
end

function move_3D_by(xstep, ystep, zstep, speed; handle = DEF_HANDLE[])
    UMP.take_step(handle, Cint(xstep), Cint(ystep), Cint(zstep), Cint(0), Cint(speed)) |> error_check
end

function move_X_by(xstep, speed, handle = DEF_HANDLE[])
    UMP.take_step(handle, Cint(xstep), Cint(0), Cint(0), Cint(0), Cint(speed))
end

function move_Y_by(ystep, speed, handle = DEF_HANDLE[])
    UMP.take_step(handle, Cint(0), Cint(ystep), Cint(0), Cint(0), Cint(speed))
end

function move_Z_by(zstep, speed, handle = DEF_HANDLE[])
    UMP.take_step(handle, Cint(0), Cint(0), Cint(zstep), Cint(0), Cint(speed))
end

end # module
