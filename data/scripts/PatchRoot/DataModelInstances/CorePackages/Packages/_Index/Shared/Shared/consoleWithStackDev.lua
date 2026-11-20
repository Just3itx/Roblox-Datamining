-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:11:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local ReactGlobals = require(scriptParentParent.ReactGlobals)
local LuauPolyfill = require(scriptParentParent.LuauPolyfill)
local console = LuauPolyfill.console
local Array = LuauPolyfill.Array

local ReactSharedInternals = require(script.Parent.ReactSharedInternals)

local printWarning = nil

local module = {}
function module.warn(arg1, ...)
    if ReactGlobals.__DEV__ then
        printWarning("warn", arg1, { ... })
    end
end

function module.error(arg1, ...)
    if ReactGlobals.__DEV__ then
        printWarning("error", arg1, { ... })
    end
end

printWarning = function(arg1, arg2, arg3)
    if not ReactGlobals.__DEV__ then
        return
    end

    local stackAddendum = ReactSharedInternals.ReactDebugCurrentFrame.getStackAddendum()

    if stackAddendum ~= "" then
        arg2 ..= "%s"

        arg3 = Array.slice(arg3, 1)
        table.insert(arg3, stackAddendum)
    end

    local var1 = Array.map(arg3, tostring)

    table.insert(var1, 1, "Warning: " .. arg2)

    console[arg1](unpack(var1))
end

return module
