-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:11:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local ReactGlobals = require(scriptParentParent.ReactGlobals)

local console = require(scriptParentParent.Shared).console

local ReactSymbols = require(scriptParentParent.Shared).ReactSymbols
local _Shared = require(scriptParentParent.Shared)

local REACT_FORWARD_REF_TYPE = ReactSymbols.REACT_FORWARD_REF_TYPE
local REACT_MEMO_TYPE = ReactSymbols.REACT_MEMO_TYPE

local module = {}

function module.forwardRef(render: (...any) -> (...any))
    if ReactGlobals.__DEV__ then
        if typeof(render) == "table" and render["$$typeof"] == REACT_MEMO_TYPE then
            console.error(
                "forwardRef requires a render function but received a `memo` component. Instead of forwardRef(memo(...)), use memo(forwardRef(...))."
            )
        elseif typeof(render) ~= "function" then
            console.error("forwardRef requires a render function but was given %s.", typeof(render))
        else
            local var1, _ = debug.info(render, "a")
            if var1 ~= 0 and var1 ~= 2 then
                console.error(
                    "forwardRef render functions accept exactly two parameters: props and ref. %s",
                    if var1 == 1 then "Did you forget to use the ref parameter?" else "Any additional parameter will be undefined."
                )
            end
        end
    end

    local tbl1 = { ["$$typeof"] = REACT_FORWARD_REF_TYPE, render = render }

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
                    return
                end

                rawset(arg1, arg2, arg3)
            end
        })
    end

    return tbl1
end

return module
