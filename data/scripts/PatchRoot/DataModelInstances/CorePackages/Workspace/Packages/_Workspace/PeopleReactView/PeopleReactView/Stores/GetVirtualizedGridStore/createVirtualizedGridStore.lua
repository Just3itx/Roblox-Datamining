-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T01:40:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PeopleReactViewParent = script:FindFirstAncestor("PeopleReactView").Parent

local Signals = require(PeopleReactViewParent.Signals)

local FFlagFixVirtualizedGridNumItems = require(PeopleReactViewParent.PeopleService).getService("Flags").FFlagFixVirtualizedGridNumItems

local num1 = game:DefineFastInt("PeoplePageVirtualizedGridBuffer", 200)

local function createVirtualizedGridStore()
    local getMinVirtualizedIndex, var2 = Signals.createSignal(1)
    local getMaxVirtualizedIndex, var4 = Signals.createSignal(0)

    return {
        getMinVirtualizedIndex = getMinVirtualizedIndex,
        getMaxVirtualizedIndex = getMaxVirtualizedIndex,
        getNumVirtualizedItems = Signals.createComputed(function(arg1)
            return getMaxVirtualizedIndex(arg1) - getMinVirtualizedIndex(arg1) + 1
        end),
        calculateVirtualizedGridLimits = function(num2: number, num3: number, _: number, num4: number, num5: number, num6: number)
            local num7 = math.floor((num2 - num1) / (num4 + num6)) * num5 + 1

            if not FFlagFixVirtualizedGridNumItems then
                num7 = math.max(1, num7)
            end

            local num8 = num7 + math.ceil((num3 + 2 * num1) / (num4 + num6)) * num5 - 1

            if FFlagFixVirtualizedGridNumItems then
                num7 = math.max(1, num7)
            end

            var2(num7)
            var4(num8)
        end
    }
end
return createVirtualizedGridStore
