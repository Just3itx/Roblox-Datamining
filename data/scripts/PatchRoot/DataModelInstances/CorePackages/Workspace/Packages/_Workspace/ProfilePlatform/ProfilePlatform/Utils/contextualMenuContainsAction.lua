-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T06:10:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local _Types = require(ProfilePlatform.Components.CTARow.Types)
local _Enums = require(ProfilePlatform.Common.Enums)

local function contextualMenuContainsAction(arg1, id)
    if not arg1 then
        return false
    end
    for _, value in arg1 do
        for _, item in value.items do
            if item.id == id then
                return true
            end
        end
    end
    return false
end

return contextualMenuContainsAction
