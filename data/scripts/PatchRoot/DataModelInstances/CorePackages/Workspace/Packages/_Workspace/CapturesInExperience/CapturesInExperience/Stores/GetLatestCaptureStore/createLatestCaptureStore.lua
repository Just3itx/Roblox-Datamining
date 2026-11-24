-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:01:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local Signals = require(scriptParentParentParentParent.Signals)

local _Types = require(scriptParentParentParent.Types)

local function createLatestCaptureStore()
    local getLatestCapture, var2 = Signals.createSignal(nil)
    local getLatestCaptureFilePath, var4 = Signals.createSignal(nil)

    return {
        getLatestCapture = getLatestCapture,
        getLatestCaptureFilePath = getLatestCaptureFilePath,
        setLatestCapture = function(arg1, str1: string?)
            var4(str1)
            var2(arg1)
        end,
        clearLatestCapture = function()
            var4(nil)
            var2(nil)
        end
    }
end

return createLatestCaptureStore
