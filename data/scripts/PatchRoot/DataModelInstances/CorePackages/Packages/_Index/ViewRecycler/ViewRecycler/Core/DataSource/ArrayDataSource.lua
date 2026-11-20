-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:11:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ViewRecycler = script:FindFirstAncestor("ViewRecycler")

local _Types = require(ViewRecycler.Core.Types)

local KeyUtils = require(script.Parent.KeyUtils)

local function subscribe() end

local function createArrayDataSource(tbl1, func2: ((...any) -> (...any))?)
    local var1 = table.clone(tbl1)
    local var2 = KeyUtils.keysFor(var1, func2)
    return {
        getItemCount = function(): number
            return #var1
        end,
        getItem = function(arg1)
            return var1[arg1]
        end,
        getItemKey = function(arg1)
            return var2[arg1]
        end,
        getItems = function(num1: number, num2: number)
            return table.move(var1, num1, num2, 1, {})
        end,
        subscribe = function(_)
            return subscribe
        end
    }
end

return createArrayDataSource
