-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T22:11:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local StarterGui = game:GetService("StarterGui")
local InExperienceTopBarParent = script:FindFirstAncestor("InExperienceTopBar").Parent
local createSignal = require(InExperienceTopBarParent.Signals).createSignal

return function()
    local getTopBarCoreGuiEnabled, var2 = createSignal(true)

    StarterGui:RegisterSetCore("TopbarEnabled", function(arg1)
        if type(arg1) == "boolean" then
            var2(arg1)
            return
        end
        error("SetCore TopbarEnabled argument must be a boolean", 2)
    end)

    StarterGui:RegisterGetCore("TopbarEnabled", function()
        return getTopBarCoreGuiEnabled(false)
    end)

    return { getTopBarCoreGuiEnabled = getTopBarCoreGuiEnabled }
end
