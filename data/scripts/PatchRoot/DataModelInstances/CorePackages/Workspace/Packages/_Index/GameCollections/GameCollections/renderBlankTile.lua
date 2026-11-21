-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T17:21:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameCollectionsParent = script:FindFirstAncestor("GameCollections").Parent

local GameCollectionItemTypes = require(GameCollectionsParent.DiscoveryTypes).GameCollectionItemTypes

local React = require(GameCollectionsParent.React)

local var1 = React.memo(function(tbl1)
    return React.createElement("Frame", { BackgroundTransparency = 1, LayoutOrder = tbl1.index })
end)
return function(tbl1)
    return React.createElement(var1, tbl1), GameCollectionItemTypes.GameCollectionItemType.Blank
end
