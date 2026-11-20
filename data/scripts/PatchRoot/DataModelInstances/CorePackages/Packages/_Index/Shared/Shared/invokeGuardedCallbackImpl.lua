-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:11:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local ReactGlobals = require(scriptParentParent.ReactGlobals)

local describeError = require(script.Parent["ErrorHandling.roblox"]).describeError

local function invokeGuardedCallbackProd(arg1, _, callback, arg2, ...)
    local result = nil
    local success

    if ReactGlobals.__YOLO__ then
        success = true
        if arg2 == nil then
            callback(...)
        else
            callback(arg2, ...)
        end
    elseif arg2 == nil then
        success, result = xpcall(callback, describeError, ...)
    else
        success, result = xpcall(callback, describeError, arg2, ...)
    end

    if not success then
        arg1.onError(result)
    end
end

if ReactGlobals.__DEV__ then
end

return invokeGuardedCallbackProd
