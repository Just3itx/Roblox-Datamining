-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:01:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local Otter = require(CorePackages.Packages.Otter)

local function getTransparencySpringFromSettings(arg1)
    local transparencyAnimation = arg1.TransparencyAnimation
    if not transparencyAnimation.Enabled then
        return Otter.instant
    end

    local tbl1 = {
        dampingRatio = transparencyAnimation.SpringDampingRatio,
        frequency = transparencyAnimation.SpringFrequency
    }
    return function(arg2)
        return Otter.spring(arg2, tbl1)
    end
end

return getTransparencySpringFromSettings
