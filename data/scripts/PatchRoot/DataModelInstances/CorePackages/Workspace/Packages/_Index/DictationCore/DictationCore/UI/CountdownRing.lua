-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T10:01:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DictationCoreParent = script:FindFirstAncestor("DictationCore").Parent

local React = require(DictationCoreParent.React)
local Foundation = require(DictationCoreParent.Foundation)

local function toPercent(num1: number): number
    return math.clamp(num1, 0, 1) * 100
end

return React.memo(function(tbl1) -- name: CountdownRing
    local value = React.useMemo(function()
        return tbl1.countdownProgress:map(toPercent)
    end, { tbl1.countdownProgress })

    return React.createElement(Foundation.Progress, {
        tag = "position-center-center anchor-center-center",
        shape = Foundation.Enums.ProgressShape.Circle,
        size = Foundation.Enums.ProgressSize.Medium,
        value = value,
        ZIndex = 2
    })
end)
