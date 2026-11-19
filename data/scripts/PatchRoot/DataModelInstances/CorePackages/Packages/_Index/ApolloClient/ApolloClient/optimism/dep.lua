-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T05:31:09Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local LuauPolyfill = require(scriptParentParentParent.LuauPolyfill)

local Set = LuauPolyfill.Set
local Array = LuauPolyfill.Array

local module = {}

local _anyEntryTypes = require(script.Parent.anyEntryTypes)

local _initTypes = require(script.Parent.initTypes)

local parentEntrySlot = require(script.Parent.context).parentEntrySlot
local helpers = require(script.Parent.helpers)
local hasOwnProperty = helpers.hasOwnProperty

local maybeUnsubscribe = helpers.maybeUnsubscribe
local toArray = helpers.toArray

local tbl1 = { setDirty = true, dispose = true, forget = true }

local _depTypes = require(script.Parent.depTypes)

function module.dep(tbl2)
    local tbl3 = ({})

    if tbl2 ~= nil then
        tbl2 = tbl2.subscribe
    end
    local var1 = setmetatable({}, {
        __call = function(_, arg1)
            local value = parentEntrySlot:getValue()
            if value == nil then
                return
            end
            local var1 = tbl3[arg1]

            if not var1 then
                var1 = Set.new()

                tbl3[arg1] = var1
            end

            value:dependOn(var1)

            if type(tbl2) == "function" then
                maybeUnsubscribe(var1)

                var1.unsubscribe = tbl2(arg1)
            end
        end
    })

    function var1.dirty(_, arg1, str1: string?)
        local var2 = tbl3[arg1]

        if not var2 then
            return
        end

        local str2 = str1 and hasOwnProperty(tbl1, str1) and str1 or "setDirty"

        Array.forEach(toArray(var2), function(arg2)
            arg2[str2](arg2)
        end)

        tbl3[arg1] = nil

        maybeUnsubscribe(var2)
    end

    return var1
end
return module
