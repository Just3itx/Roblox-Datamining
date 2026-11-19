-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T05:40:44Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent
local WeakMap = require(scriptParentParentParentParent.LuauPolyfill).WeakMap

local React = require(scriptParentParentParentParent.React)
local _core = require(script.Parent.Parent.Parent.core)

local weakMap = WeakMap.new()

return {
    getApolloContext = function()
        local var1 = weakMap:get(React.createContext)
        if var1 == nil then
            var1 = React.createContext({})
            var1.displayName = "ApolloContext"
            weakMap:set(React.createContext, var1)
        end
        return var1
    end,
    resetApolloContext = function()
        weakMap = WeakMap.new()
    end
}
