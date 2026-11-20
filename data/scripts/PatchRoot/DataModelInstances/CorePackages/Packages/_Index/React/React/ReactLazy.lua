-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:11:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local ReactGlobals = require(scriptParentParent.ReactGlobals)

local console = require(scriptParentParent.Shared).console
local inspect = require(scriptParentParent.LuauPolyfill).util.inspect

local _Shared = require(scriptParentParent.Shared)

local REACT_LAZY_TYPE = require(scriptParentParent.Shared).ReactSymbols.REACT_LAZY_TYPE

function lazyInitializer(tbl1)
    if tbl1._status == -1 then
        local _result = tbl1._result()

        tbl1._status = 0
        tbl1._result = _result
        _result:andThen(function(arg1)
            if tbl1._status ~= 0 then
                return
            end

            local default = arg1.default
            if ReactGlobals.__DEV__ and default == nil then
                console.error(
                    "lazy: Expected the result of a dynamic import() call. Instead received: `%s`\n\nYour code should look like: \n  local MyComponent = lazy(function() return reqquire(script.Parent.MyComponent) end)",
                    inspect(arg1)
                )
            end

            local tbl2 = tbl1
            tbl2._status = 1
            tbl2._result = default
        end, function(_result2)
            if tbl1._status == 0 then
                local tbl2 = tbl1
                tbl2._status = 2
                tbl2._result = _result2
            end
        end)
    end
    if tbl1._status == 1 then
        return tbl1._result
    end
    error(tbl1._result)
end

local module = {}

function module.lazy(_result: (...any) -> (...any))
    local tbl1 = {
        ["$$typeof"] = REACT_LAZY_TYPE,
        _payload = { _status = -1, _result = _result },
        _init = lazyInitializer
    }

    if ReactGlobals.__DEV__ then
        local var1 = nil
        local var2 = nil

        setmetatable(tbl1, {
            __index = function(_, arg1)
                if arg1 == "defaultProps" then
                    return var1
                elseif arg1 == "propTypes" then
                    return var2
                end
            end,
            __newindex = function(arg1, arg2, arg3)
                if arg2 == "defaultProps" then
                    console.error(
                        "React.lazy(...): It is not supported to assign `defaultProps` to a lazy component import. Either specify them where the component is defined, or create a wrapping component around it."
                    )

                    var1 = arg3

                    setmetatable(arg1, {
                        __index = function() end,
                        __newindex = function() end
                    })
                end
                if arg2 ~= "propTypes" then
                    return
                end

                console.error(
                    "React.lazy(...): It is not supported to assign `propTypes` to a lazy component import. Either specify them where the component is defined, or create a wrapping component around it."
                )

                var2 = arg3

                setmetatable(arg1, {
                    __index = function() end,
                    __newindex = function() end
                })
            end
        })
    end

    return tbl1
end

return module
