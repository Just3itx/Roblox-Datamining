-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T09:11:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ScreenTimeParent = script:FindFirstAncestor("ScreenTime").Parent
local ArgCheck = require(ScreenTimeParent.ArgCheck)
local Logging = require(ScreenTimeParent.AppCommonLib).Logging

local module = { globalGetter = nil, globalSetter = nil }

function module.new(arg1, arg2)
    ArgCheck.isType(arg2.globalGetter, "function", "globalGetter")
    ArgCheck.isType(arg2.globalSetter, "function", "globalSetter")
    local tbl1 = {
        globalGetter = arg2.globalGetter,
        globalSetter = arg2.globalSetter
    }
    setmetatable(tbl1, arg1)
    arg1.__index = arg1
    return tbl1
end

function module.isLockedOut(arg1): boolean
    ArgCheck.isType(arg1.globalGetter, "function", "globalGetter")
    return arg1.globalGetter("ScreenTime.lockedOut") == "true"
end

function module.setLockedOut(arg1)
    Logging.warn("Utils setLockedOut")
    ArgCheck.isType(arg1.globalSetter, "function", "globalSetter")
    arg1.globalSetter("ScreenTime.lockedOut", "true")
end

return module
