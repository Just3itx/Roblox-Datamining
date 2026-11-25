-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T08:41:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RoactUtilsParent = script:FindFirstAncestor("RoactUtils").Parent
local Signal = require(RoactUtilsParent.AppCommonLib).Signal

local _types = require(script.Parent.types)

local function createReactProfilerContext()
    return {
        onRender = Signal.new(),
        onCommit = Signal.new()
    }
end

return createReactProfilerContext
