-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:00:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UnifiedEventLogEnums = require(script.Parent.Parent.UnifiedEventLogEnums)

local tbl1 = {
    [0] = UnifiedEventLogEnums.MarketplaceTimedOption.PERMANENT,
    [3] = UnifiedEventLogEnums.MarketplaceTimedOption.DAYS_3,
    [7] = UnifiedEventLogEnums.MarketplaceTimedOption.DAYS_7,
    [14] = UnifiedEventLogEnums.MarketplaceTimedOption.DAYS_14
}

function getTimedOptionForItemData(arg1)
    if not (arg1 and arg1.timedOptions) then
        return UnifiedEventLogEnums.MarketplaceTimedOption.PERMANENT
    end

    for _, timedOption in arg1.timedOptions do
        if timedOption.selected then
            return tbl1[timedOption.days]
        end
    end

    return UnifiedEventLogEnums.MarketplaceTimedOption.PERMANENT
end

return getTimedOptionForItemData
