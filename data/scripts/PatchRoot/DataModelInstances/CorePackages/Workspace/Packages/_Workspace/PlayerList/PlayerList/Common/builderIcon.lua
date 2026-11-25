-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T02:51:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function builderIcon(name: string, variant: string?)
    return {
        isFoundationIcon = true,
        name = name,
        variant = variant or "Regular"
    }
end
return builderIcon
