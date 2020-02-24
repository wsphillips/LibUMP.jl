using Clang, Clang.LibClang
using CEnum

include("clanghelpers.jl")

ctx = DefaultContext()
const libump_header = joinpath(
    homedir(),
    "git",
    "LibUMP",
    "deps",
    "include",
    "libump.h",
)
trans_unit = parse_header(
    libump_header,
    flags = CXTranslationUnit_DetailedPreprocessingRecord,
)

ctx.libname = "libump"

push!(ctx.trans_units, trans_unit)
root_cursor = getcursor(trans_unit)
header = spelling(root_cursor)
ctx.children = children(root_cursor)

ctx.options["is_function_strictly_typed"] = true

for (i, child) in enumerate(ctx.children)
    # Cursor properties
    child_name = name(child)
    child_kind = kind(child)
    (child_kind == CXCursor_FunctionDecl && startswith(child_name, "ump_")) && wrap_fun!(ctx, child)
end


api_file = joinpath(@__DIR__, "libump_api.jl")
api_stream = open(api_file, "w")

println(api_stream, "# Julia wrapper for header: $(basename(header))")
println(api_stream, "# Automatically generated using Clang.jl\n")
print_buffer(api_stream, ctx.api_buffer)
empty!(ctx.api_buffer)
close(api_stream)

