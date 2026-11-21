-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T22:30:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameTile = script:FindFirstAncestor("GameTile")
local GameTileParent = GameTile.Parent

local _Style = require(GameTileParent.Style)

local _Foundation = require(GameTileParent.Foundation)

local memoize = require(GameTileParent.AppCommonLib).memoize
local _GameTileTypes = require(GameTile.GameTileTypes)

local FFlagLuaAppUnifyPlayButtonTile = require(GameTileParent.SharedFlags).FFlagLuaAppUnifyPlayButtonTile
local FFlagLuaAppUnifyPlayButtonTileIxp = require(GameTileParent.SharedFlags).FFlagLuaAppUnifyPlayButtonTileIxp

local GameTileExperimentation = require(GameTile.GameTileExperimentation)

local function getInverseImageAspectRatio(arg1): number -- Luacid: Inlined by compiler; 1 call site recovered
    return if arg1 == "Wide" or arg1 == "Event" then 0.5625 else 1
end

local getElementSizes = memoize(function(arg1, num1: number?, num2: number?, arg2, bool1: boolean?, num3: number?)
    local isPlayButtonMigrationEnabled = if FFlagLuaAppUnifyPlayButtonTileIxp then GameTileExperimentation.getIsPlayButtonMigrationEnabled() else nil

    if arg2 and bool1 then
        return {
            footerTopPadding = arg2.Gap.Medium,
            titleHeight = (num2 or 1) * (arg2.Size.Size_500 + (num1 or 0)),
            paddingAboveMetadata = 0,
            metadataHeight = (num3 or 1) * (arg2.Size.Size_500 + (num1 or 0)),
            footerBottomPadding = arg2.Gap.Medium,
            playButtonHeight = if FFlagLuaAppUnifyPlayButtonTile and (not FFlagLuaAppUnifyPlayButtonTileIxp or isPlayButtonMigrationEnabled) then arg2.Size.Size_1000 else arg2.Size.Size_900
        }
    end

    return {
        footerTopPadding = arg1.Size.Size_300,
        titleHeight = (num2 or 1) * (arg1.Size.Size_500 + (num1 or 0)),
        paddingAboveMetadata = 0,
        metadataHeight = (num3 or 1) * (arg1.Size.Size_500 + (num1 or 0)),
        footerBottomPadding = arg1.Size.Size_300,
        playButtonHeight = if FFlagLuaAppUnifyPlayButtonTile and (not FFlagLuaAppUnifyPlayButtonTileIxp or isPlayButtonMigrationEnabled) then arg1.Size.Size_1000 else arg1.Size.Size_900
    }
end)

return {
    getTileHeight = function(arg1, num1: number, arg2, bool1: boolean?, bool2: boolean?, bool3: boolean?, num2: number?, num3: number?, num4: number?, num5: number?, arg3, bool4: boolean?)
        local num6 = num1 * getInverseImageAspectRatio(arg2)
        local var2 = getElementSizes(arg1, num2, num4, arg3, bool4, num5)

        local footerTopPadding = var2.footerTopPadding
        if not bool3 then
            footerTopPadding += var2.titleHeight
        end
        if not bool2 then
            footerTopPadding += var2.paddingAboveMetadata + var2.metadataHeight
        end
        if bool1 then
            footerTopPadding += var2.footerBottomPadding
        end
        if num3 then
            footerTopPadding += num3
        end
        return num6 + footerTopPadding
    end,
    getFooterHeight = function(arg1, bool1: boolean?, bool2: boolean?, bool3: boolean?, num1: number?, num2: number?, num3: number?, arg2, bool4: boolean?, num4: number?)
        local var2 = getElementSizes(arg1, num1, num3, arg2, bool4, num4)

        local footerTopPadding = var2.footerTopPadding
        if not bool3 then
            footerTopPadding += var2.titleHeight
        end
        if not bool2 then
            footerTopPadding += var2.paddingAboveMetadata + var2.metadataHeight
        end
        if bool1 then
            footerTopPadding += var2.footerBottomPadding
        end
        if num2 then
            footerTopPadding += num2
        end
        return footerTopPadding
    end,
    getImageAspectRatio = function(arg1): number
        return if arg1 == "Wide" or arg1 == "Event" then 16 / 9 else 1
    end,
    getInverseImageAspectRatio = getInverseImageAspectRatio,
    getElementSizes = getElementSizes,
    getContainmentSidePadding = function(arg1, arg2, arg3)
        if arg3 then
            if arg2 == "Wide" or arg2 == "Event" then
                return arg3.Padding.Medium
            end

            return arg3.Size.Size_150
        end

        if arg2 == "Wide" or arg2 == "Event" then
            return arg1.Size.Size_300
        end

        return arg1.Size.Size_150
    end
}
