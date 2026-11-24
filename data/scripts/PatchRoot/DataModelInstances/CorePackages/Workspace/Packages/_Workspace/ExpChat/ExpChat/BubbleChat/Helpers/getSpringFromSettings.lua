-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T07:40:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChatParent = script:FindFirstAncestor("ExpChat").Parent
local Otter = require(ExpChatParent.Otter)

local function getSpringFromSettings(arg1, str1: string)
    local var1 = if str1 == "size" then arg1.SizeAnimation else arg1.TransparencyAnimation

    if var1.Enabled == false then
        return Otter.instant
    end

    local tbl1 = {
        dampingRatio = var1.SpringDampingRatio,
        frequency = var1.SpringFrequency
    }

    return function(arg2)
        return Otter.spring(arg2, tbl1)
    end
end

return getSpringFromSettings
