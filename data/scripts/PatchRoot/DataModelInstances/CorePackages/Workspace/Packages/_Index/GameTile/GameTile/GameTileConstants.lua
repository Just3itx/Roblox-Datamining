-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T22:21:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameTileParent = script:FindFirstAncestor("GameTile").Parent
local Foundation = require(GameTileParent.Foundation)
local GameTileLayoutType = require(script.Parent.GameTileTypes).GameTileLayoutType

local SharedFlags = require(GameTileParent.SharedFlags)
local FFlagLuaAppContinueSortInstantPlay = SharedFlags.FFlagLuaAppContinueSortInstantPlay
local FFlagLuaAppEnableReportExperience = SharedFlags.FFlagLuaAppEnableReportExperience

return {
    TileOverlay = {
        BottomRightPosition = UDim2.new(0.96, 0, 0.93, 0)
    },
    PlayButtonStyleValues = { Enabled = "Enabled", Disabled = "Disabled" },
    PlayerCountStyleValues = { Hover = "Hover", Always = "Always", Footer = "Footer" },
    TileBadgeComponentTypeValues = { Pill = "Pill", RoundedRectangle = "RoundedRectangle" },
    TileBadgePositionValues = {
        ImageTopLeft = "ImageTopLeft",
        ImageBottomLeft = "ImageBottomLeft",
        ImageTopRight = "ImageTopRight",
        ImageBottomRight = "ImageBottomRight"
    },
    TileBadgePositionCalculators = {
        ImageTopLeft = function(num1: number): (UDim2, Vector2)
            return UDim2.new(0, num1, 0, num1), Vector2.new(0, 0)
        end,
        ImageBottomLeft = function(xOffset: number): (UDim2, Vector2)
            return UDim2.new(0, xOffset, 1, -xOffset), Vector2.new(0, 1)
        end,
        ImageTopRight = function(yOffset: number): (UDim2, Vector2)
            return UDim2.new(1, -yOffset, 0, yOffset), Vector2.new(1, 0)
        end,
        ImageBottomRight = function(num1: number): (UDim2, Vector2)
            return UDim2.new(1, -num1, 1, -num1), Vector2.new(1, 1)
        end
    },
    TileBadgeIconNamesByType = {
        PaidAccess = "icons/menu/gem_small",
        ["icons/menu/lock_closed"] = Foundation.Enums.IconName.LockClosed
    },
    TileTextLines = {
        [GameTileLayoutType.Narrow] = {
            titleTextLines = 2,
            metadataTextLines = 1,
            largeMetadataTextLines = 2
        },
        [GameTileLayoutType.Wide] = {
            titleTextLines = 1,
            metadataTextLines = 1,
            largeMetadataTextLines = 1
        },
        [GameTileLayoutType.Event] = {
            titleTextLines = 1,
            metadataTextLines = 1,
            largeMetadataTextLines = 1
        }
    },
    TileOverflowMenuItems = {
        GameDetails = if FFlagLuaAppContinueSortInstantPlay then "GameDetails" else nil,
        NotInterested = "NotInterested",
        WhyThisAd = "WhyThisAd",
        ReportAd = "ReportAd",
        ReportExperience = if FFlagLuaAppEnableReportExperience then "ReportExperience" else nil
    }
}
