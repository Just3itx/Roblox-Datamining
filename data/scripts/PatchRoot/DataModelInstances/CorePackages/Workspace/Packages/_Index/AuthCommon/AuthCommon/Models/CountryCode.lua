-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:40:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}

function module.new()
    return {}
end

function module.fromJSON(arg1)
    local module2 = module.new()

    module2.name = arg1.name
    module2.code = arg1.code
    module2.prefix = arg1.prefix
    module2.localizedName = arg1.localizedName
    module2.isDefault = arg1.isDefault

    return module2
end

return module
