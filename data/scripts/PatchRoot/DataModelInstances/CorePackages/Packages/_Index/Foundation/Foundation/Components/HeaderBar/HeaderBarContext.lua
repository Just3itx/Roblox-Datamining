-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T08:00:55Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local _HeaderBarSlot = require(Foundation.Enums.HeaderBarSlot)

local Context = React.createContext({ testId = "" })

return {
    Context = Context,
    Provider = function(tbl1) -- name: HeaderBarProvider
        local value = React.useMemo(function()
            return {
                testId = tbl1.testId,
                slot = tbl1.slot
            }
        end, { tbl1.testId, tbl1.slot })

        return React.createElement(Context.Provider, { value = value }, tbl1.children)
    end
}
