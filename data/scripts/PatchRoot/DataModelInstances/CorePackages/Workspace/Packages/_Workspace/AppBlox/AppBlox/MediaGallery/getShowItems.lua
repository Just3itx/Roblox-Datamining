-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T06:30:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppBloxParent = script:FindFirstAncestor("AppBlox").Parent
local Cryo = require(AppBloxParent.Cryo)

local function getShowItems(arg1)
    local tbl1 = {}
    local tbl2 = {}

    for originalIndex, item in ipairs(arg1.items) do
        if item.isYouTubeVideo then
            table.insert(tbl1, Cryo.Dictionary.join(item, { originalIndex = originalIndex }))
        else
            table.insert(tbl2, Cryo.Dictionary.join(item, { originalIndex = originalIndex }))
        end
    end

    local var1 = Cryo.List.join(tbl1, tbl2)

    local numberOfThumbnails = arg1.numberOfThumbnails
    if numberOfThumbnails then
        for i = #var1 + 1, numberOfThumbnails do
            var1[i] = {}
        end
    end

    return var1, #tbl1, #tbl2
end

return getShowItems
