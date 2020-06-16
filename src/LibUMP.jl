module LibUMP

include("UMP/UMP.jl")

using .UMP
export UMP
#=
mutable struct Position
    x::Cint
    y::Cint
    z::Cint
    w::Cint
    function Position()
        x, y, z, w = Cint(0), Cint(0), Cint(0), Cint(0)
        new(x,y,z,w)
    end
end

mutable struct Speed
    vx::Cint
    vy::Cint
    vz::Cint
    vw::Cint
end

mutable struct Manipulator
    id::Cint
    current::Position
    target::Position
    speeds::Speed
end

mutable struct UMPState
    handle::StateHandle
    active_device::Manipulator
    manipulators::Vector{Manipulator}
end

function goto!(pos::Position) end
=#
end # module
