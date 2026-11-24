-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T05:51:05Z
-- Luau bytecode version: 14 | Luau type version: 3
local DiscoveryTypesParent = script:FindFirstAncestor("DiscoveryTypes").Parent
local _React = require(DiscoveryTypesParent.React)
local FFlagLuaAppEnableNxMRoduxApportioning = require(DiscoveryTypesParent.SharedFlags).FFlagLuaAppEnableNxMRoduxApportioning

return {
    GameCollectionItemType = {
        GameTile = "GameTile",
        SeeAllTile = "SeeAllTile",
        EmphasisTile = "EmphasisTile",
        TwoByOneTile = "TwoByOneTile",
        OneByTwoTile = if FFlagLuaAppEnableNxMRoduxApportioning then "OneByTwoTile" else nil,
        Blank = "Blank"
    },
    AlignmentType = { RightPin = "RightPin", LeftPin = "LeftPin", Default = "Default" },
    SpanForItemType = FFlagLuaAppEnableNxMRoduxApportioning
        and {
            EmphasisTile = { colSpan = 2, rowSpan = 2 },
            TwoByOneTile = { colSpan = 2, rowSpan = 1 },
            OneByTwoTile = { colSpan = 1, rowSpan = 2 }
        }
        or nil
}
