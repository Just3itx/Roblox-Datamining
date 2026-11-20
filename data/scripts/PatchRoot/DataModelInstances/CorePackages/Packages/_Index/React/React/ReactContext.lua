-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:11:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local ReactGlobals = require(scriptParentParent.ReactGlobals)

local console = require(scriptParentParent.Shared).console

local ReactSymbols = require(scriptParentParent.Shared).ReactSymbols
local REACT_PROVIDER_TYPE = ReactSymbols.REACT_PROVIDER_TYPE
local REACT_CONTEXT_TYPE = ReactSymbols.REACT_CONTEXT_TYPE

local module = {}

function module.createContext(arg1, _calculateChangedBits: ((...any) -> (...any))?)
    local tbl1 = {
        ["$$typeof"] = REACT_CONTEXT_TYPE,
        _calculateChangedBits = _calculateChangedBits,
        _currentValue = arg1,
        _currentValue2 = arg1,
        _threadCount = 0,
        Provider = nil,
        Consumer = nil,
        displayName = nil,
        _currentRenderer = nil,
        _currentRenderer2 = nil
    }
    tbl1.Provider = { ["$$typeof"] = REACT_PROVIDER_TYPE, _context = tbl1 }

    local bool1 = false

    if ReactGlobals.__DEV__ then
        local consumer = {
            ["$$typeof"] = REACT_CONTEXT_TYPE,
            _context = tbl1,
            _calculateChangedBits = tbl1._calculateChangedBits
        }

        setmetatable(consumer, {
            __index = function(_, arg2)
                if arg2 == "_currentValue" then
                    return tbl1._currentValue
                elseif arg2 == "_currentValue2" then
                    return tbl1._currentValue2
                elseif arg2 == "_threadCount" then
                    return tbl1._threadCount
                elseif arg2 == "displayName" then
                    return tbl1.displayName
                end

                return nil
            end,
            __newindex = function(_, arg2, arg3)
                if arg2 == "_currentValue" then
                    tbl1._currentValue = arg3
                elseif arg2 == "_currentValue2" then
                    tbl1._currentValue2 = arg3
                elseif arg2 == "_threadCount" then
                    tbl1._threadCount = arg3
                elseif arg2 == "displayName" and not bool1 then
                    console.warn(
                        "Setting `displayName` on Context.Consumer has no effect. " .. "You should set it directly on the context with Context.displayName = " .. arg3 .. "."
                    )
                    bool1 = true
                end
            end
        })

        tbl1.Consumer = consumer
    else
        tbl1.Consumer = tbl1
    end

    if ReactGlobals.__DEV__ then
        tbl1._currentRenderer = nil
        tbl1._currentRenderer2 = nil
    end

    return tbl1
end

return module
