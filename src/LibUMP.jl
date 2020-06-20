module LibUMP

include("UMP/UMP.jl")

using .UMP
export UMP

export get_position, goto

const DEF_IP = "169.254.244.0"
global DEF_HANDLE = C_NULL
const DEF_DEVICE = Cint(1)
const MAX_TIMEOUT = Cuint(999)
global DefaultUMP
global UMP_STATE

mutable struct Position
    x::Cint
    y::Cint
    z::Cint
    w::Cint
end

function __init__()
    global DEF_HANDLE = UMP.open(DEF_IP, MAX_TIMEOUT, UMP.DEF_GROUP)
    UMP.select_dev(DEF_HANDLE, DEF_DEVICE)
end

function get_position()
    UMP.read_positions(DEF_HANDLE)
    x = Ref{Cint}()
    y = Ref{Cint}()
    z = Ref{Cint}()
    w = Ref{Cint}()
    UMP.get_positions(DEF_HANDLE, x, y, z, w)
    return Position(x[], y[], z[], w[])
end 

function goto(pos::Position, speed::Integer = 5000)
    UMP.goto_position(DEF_HANDLE, pos.x, pos.y, pos.z, pos.w, Cint(speed))
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
