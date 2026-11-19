-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:01:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local Otter = require(CorePackages.Packages.Otter)

local function getSizeSpringFromSettings(arg1)
    local sizeAnimation = arg1.SizeAnimation
    if not sizeAnimation.Enabled then
        return Otter.instant
    end

    local tbl1 = {
        dampingRatio = sizeAnimation.SpringDampingRatio,
        frequency = sizeAnimation.SpringFrequency
    }
    return function(arg2)
        return Otter.spring(arg2, tbl1)
    end
end

return getSizeSpringFromSettings
