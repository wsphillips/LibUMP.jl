module LibUMP

include("UMP/UMP.jl")

using .UMP

export UMP

mutable struct UMPState
    handle::StateHandle
end

end # module
