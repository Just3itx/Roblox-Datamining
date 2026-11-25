-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:31:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUiParent = script:FindFirstAncestor("ServerDrivenUi").Parent

local flaggedMutedError = require(ServerDrivenUiParent.Loggers).flaggedMutedError

local function func1(arg1, arg2, capacity, sortIndex)
    arg1[arg2] = {
        gridApportioningMetadata = {{ sortIndex = sortIndex, capacity = capacity }}
    }
end

local function func2(arg1, capacity, sortIndex)
    for value, value2 in arg1.gridApportioningMetadata do
        if value2.sortIndex == sortIndex then
            flaggedMutedError("ApportioningSameSortIndex", `Multiple collections at sort index {sortIndex}`)
        elseif sortIndex < value2.sortIndex then
            table.insert(arg1.gridApportioningMetadata, value, { sortIndex = sortIndex, capacity = capacity })

            return
        end
    end

    table.insert(arg1.gridApportioningMetadata, { sortIndex = sortIndex, capacity = capacity })
end

return {
    addToApportioningData = function(arg1, arg2, capacity, sortIndex)
        local var1 = arg1[arg2]

        if var1 then
            func2(var1, capacity, sortIndex)
            return
        end
        func1(arg1, arg2, capacity, sortIndex)
    end,
    populateStartingItemIndices = function(arg1)
        for _, value in arg1 do
            local num1 = 1
            for _, value2 in value.gridApportioningMetadata do
                value2.startingItemIndex = num1
                num1 += value2.capacity
            end
        end
    end
}
