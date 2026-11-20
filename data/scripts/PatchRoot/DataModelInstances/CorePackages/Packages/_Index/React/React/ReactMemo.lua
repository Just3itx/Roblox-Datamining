-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:11:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local ReactGlobals = require(scriptParentParent.ReactGlobals)

local Shared = require(scriptParentParent.Shared)
local console = Shared.console
local LuauPolyfill = require(scriptParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Object = LuauPolyfill.Object
local inspect = LuauPolyfill.util.inspect

local ReactSymbols = Shared.ReactSymbols
local REACT_MEMO_TYPE = ReactSymbols.REACT_MEMO_TYPE
local REACT_ELEMENT_TYPE = ReactSymbols.REACT_ELEMENT_TYPE
local isValidElementType = Shared.isValidElementType
local getComponentName = Shared.getComponentName

local module = {}

function module.memo(type, compare: ((...any) -> (...any))?)
    if ReactGlobals.__DEV__ and not isValidElementType(type) then
        local str1 = ""
        if type == nil or typeof(type) == "table" and #Object.keys(type) == 0 then
            str1 ..= " You likely forgot to export your component from the file it's defined in, or you might have mixed up default and named imports."
        end

        local var1

        if type == nil then
            var1 = "nil"
        elseif Array.isArray(type) then
            var1 = "array"
        elseif type ~= nil and typeof(type) == "table" and type["$$typeof"] == REACT_ELEMENT_TYPE then
            var1 = string.format("<%s />", getComponentName(type.type) or "UNKNOWN")
            str1 = " Did you accidentally export a JSX literal or Element instead of a component?"
        else
            var1 = typeof(type)
            if type ~= nil then
                str1 = "\n" .. inspect(type)
            end
        end
        console.error("memo: The first argument must be a component. Instead received: `%s`.%s", var1, str1)
    end

    local tbl1 = {
        ["$$typeof"] = REACT_MEMO_TYPE,
        type = type,
        compare = compare or nil
    }

    if ReactGlobals.__DEV__ then
        local var1 = nil

        setmetatable(tbl1, {
            __index = function(arg1, arg2)
                if arg2 == "displayName" then
                    return var1
                end
                return rawget(arg1, arg2)
            end,
            __newindex = function(arg1, arg2, arg3)
                if arg2 == "displayName" then
                    var1 = arg3

                    if typeof(type) == "table" and type.displayName == nil then
                        type.displayName = var1
                    end
                else
                    rawset(arg1, arg2, arg3)
                end
            end
        })
    end

    return tbl1
end

return module
