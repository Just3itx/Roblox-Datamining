-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:50:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}

function module.getter(callback: (...any) -> (...any))
    return { type = "getter", callback = callback }
end

function module.consistentSize(size: number)
    return { type = "consistentSize", size = size }
end

function module.consistentUDim2(uDim2: UDim2)
    return { type = "consistentUDim2", udim2 = uDim2 }
end

function module.withSpacing(inner, spacing: number)
    assert(
        inner.type ~= "getter",
        "withSpacing does not support getter. Instead, include your padding as part of your returned position."
    )

    if inner.type == "spaced" then
        return module.withSpacing(inner.inner, spacing)
    end

    return { type = "spaced", spacing = spacing, inner = inner }
end

return module
