-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T11:50:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedUtilities = script:FindFirstAncestor("SduiSharedUtilities")
local SduiSharedUtilitiesParent = SduiSharedUtilities.Parent
local React = require(SduiSharedUtilitiesParent.React)
local _SduiLoadTimer = require(SduiSharedUtilities.SduiLoadTimer)

local function useComponentLifecycleTiming(bool1: boolean, bool2: boolean)
    React.useEffect(function()
        if bool1 then
            bool1.logComponentMounted()
        end
    end, { bool1 })

    React.useEffect(function()
        if bool1 and bool2 then
            bool1.logComponentReady()
        end
    end, { bool1, bool2 })
end

return useComponentLifecycleTiming
