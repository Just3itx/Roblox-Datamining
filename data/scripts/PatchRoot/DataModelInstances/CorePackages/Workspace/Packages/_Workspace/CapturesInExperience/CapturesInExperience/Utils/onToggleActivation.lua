-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:20:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local CapturesActivated = require(scriptParentParent.Actions.CapturesActivated)
local CapturesDeactivated = require(scriptParentParent.Actions.CapturesDeactivated)
local CapturesToastType = require(scriptParentParent.Enums.CapturesToastType)
local ToastDismissed = require(scriptParentParent.Actions.ToastDismissed)
local ToastTriggered = require(scriptParentParent.Actions.ToastTriggered)

return function(bool1: boolean, num1: number?, callback, callback2, arg1, arg2)
    if (not num1 or num1 == 1) and not bool1 then
        callback(arg1)
        callback2(CapturesActivated())
        callback2(ToastTriggered(CapturesToastType.CapturesActivated))
    elseif bool1 then
        callback(arg2)
        callback2(CapturesDeactivated())
        callback2(ToastDismissed())
    end
end
