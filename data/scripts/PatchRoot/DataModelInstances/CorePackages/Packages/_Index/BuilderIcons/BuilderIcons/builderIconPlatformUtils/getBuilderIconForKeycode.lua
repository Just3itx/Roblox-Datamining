-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T05:51:20Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local KeycodeMappings = require(script.Parent.KeycodeMappings)
local Platform = require(script.Parent.Platform)
local getInputPlatform = require(script.Parent.getInputPlatform)

local function getBuilderIconForKeycode(arg1)
    local inputPlatform = getInputPlatform()
    local name = arg1.Name
    local var1 = KeycodeMappings[inputPlatform][name]
    if var1 then
        return var1
    end

    assert(KeycodeMappings[Platform.Default][name], `{name} has no associated BuilderIcon`)
    return KeycodeMappings[Platform.Default][name]
end

return getBuilderIconForKeycode
