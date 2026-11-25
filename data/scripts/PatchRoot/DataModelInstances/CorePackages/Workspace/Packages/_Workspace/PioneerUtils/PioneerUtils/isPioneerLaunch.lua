-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T02:30:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PioneerUtilsParent = script:FindFirstAncestor("PioneerUtils").Parent

local FFlagDebugEnablePioneerUX = require(PioneerUtilsParent.SharedFlags).FFlagDebugEnablePioneerUX
local PioneerInfo = require(script.Parent.PioneerInfo)

local bool1 = game:DefineFastFlag("EnablePioneerUX", false)

local function isPioneerLaunch()
    return FFlagDebugEnablePioneerUX or bool1 and PioneerInfo.isPioneerApp()
end

return isPioneerLaunch
