-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T10:11:05Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local Constants = require(Foundation.Constants)
local _Types = require(Foundation.Components.Types)

return function(arg1, bool1: boolean?)
    if bool1 then
        return {
            Color3 = arg1.Color3,
            Transparency = 1 - (1 - (arg1.Transparency or 0)) * Constants.DISABLED_TRANSPARENCY
        }
    end

    return arg1
end
