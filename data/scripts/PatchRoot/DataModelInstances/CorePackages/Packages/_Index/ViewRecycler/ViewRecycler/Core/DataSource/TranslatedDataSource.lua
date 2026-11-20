-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:11:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ViewRecycler = script:FindFirstAncestor("ViewRecycler")

local _Types = require(ViewRecycler.Core.Types)
local createEvent = require(ViewRecycler.Internal.createEvent)
local readDenseRange = require(script.Parent.readDenseRange)

local function createTranslatedDataSource(getItemCount: (...any) -> (...any), getItem: (...any) -> (...any), getItemKey: (...any) -> (...any), func1: (...any) -> (...any))
    local event = createEvent()
    local num1 = 0
    local var1 = nil

    return {
        getItemCount = getItemCount,
        getItem = getItem,
        getItemKey = getItemKey,
        getItems = function(arg1, arg2)
            return readDenseRange(getItemCount(), getItem, arg1, arg2)
        end,
        subscribe = function(func2: (...any) -> (...any))
            if num1 == 0 then
                var1 = func1(event.fire)
            end
            num1 += 1
            local var2 = event.connect(func2)
            local bool1 = true
            return function()
                if not bool1 then
                    return
                end
                bool1 = false
                var2()
                num1 -= 1
                if num1 == 0 and var1 ~= nil then
                    var1()
                    var1 = nil
                end
            end
        end
    }
end

return createTranslatedDataSource
