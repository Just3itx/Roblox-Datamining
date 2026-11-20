-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T03:30:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local Error = require(scriptParent.Error)
local format = require(scriptParent.format)

local error = Error.new("ReadonlyKey", "Attempted to write to readonly key {key:?} of frozen object {objectName:?}")
local error2 = Error.new("MissingKey", "Attempted to read missing key {key:?} of frozen object {objectName:?}")

local function freeze(objectName: string, arg1, bool1: boolean?)
    local result = {}

    assert(
        type(arg1) == "table",
        `Attempted to call Dash.freeze with argument #2 of type {type(arg1)}, but it should be table `
    )
    setmetatable(result, {
        __index = function(_, key)
            local var1 = arg1[key]
            if var1 == nil and bool1 then
                error2:throw({ key = key, objectName = objectName })
            end

            return var1
        end,
        __newindex = function(_, key)
            error:throw({ key = key, objectName = objectName })
        end,
        __len = function(): number
            return #arg1
        end,
        __tostring = function()
            return format("Frozen({})", objectName)
        end,
        __call = function(_, ...)
            return arg1(...)
        end
    })

    return result
end

return freeze
