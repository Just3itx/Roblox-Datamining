-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T22:31:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameTile = script:FindFirstAncestor("GameTile")

local GameTileParent = GameTile.Parent
local flaggedMutedError = require(GameTileParent.Loggers).flaggedMutedError
local useTokens = require(GameTileParent.Foundation).Hooks.useTokens
local React = require(GameTileParent.React)

local GameTileConstants = require(GameTile.GameTileConstants)
local GameTileOverlayBadge = require(GameTile.Overlays.GameTileOverlayBadge)
local _GameTileTypes = require(GameTile.GameTileTypes)
local TileBadgeIconNamesByType = GameTileConstants.TileBadgeIconNamesByType
local TileBadgeComponentTypeValues = GameTileConstants.TileBadgeComponentTypeValues

local function getBadgeStyleOptions(arg1, tileBadgeComponentType)
    local tbl1 = {
        [TileBadgeComponentTypeValues.Pill] = {
            backgroundColorStyle = arg1.Color.Extended.White.White_90,
            contentColorStyle = arg1.LightMode.Content.Emphasis,
            cornerRadius = UDim.new(1, 0),
            verticalPadding = arg1.Size.Size_150
        },
        [TileBadgeComponentTypeValues.RoundedRectangle] = {
            backgroundColorStyle = arg1.Color.Extended.Black.Black_90,
            contentColorStyle = arg1.DarkMode.Content.Emphasis,
            cornerRadius = UDim.new(0.2, 0),
            verticalPadding = arg1.Size.Size_100
        }
    }

    local var1 = tileBadgeComponentType and tbl1[tileBadgeComponentType]

    if tileBadgeComponentType ~= nil and not var1 then
        flaggedMutedError(
            "GameTileOverlayBadgeInvalidComponentTypeError",
            `Unsupported game tile badge component type: {tileBadgeComponentType}`
        )
    end

    return var1 or tbl1[TileBadgeComponentTypeValues.Pill]
end

return React.memo(function(tbl1) -- name: GameTileThumbnailBadges
    local var1 = useTokens()
    local var2 = tbl1.padding or var1.Padding.Medium

    local maxWidthBinding, var4 = React.useBinding(0)

    local var5 = React.useCallback(function(arg1)
        local absoluteSizeX = arg1.AbsoluteSize.X
        var4(absoluteSizeX - var2 * 2)
    end, { var2 })

    local tbl2 = ({})

    for value, value2 in tbl1.tileBadgesByPosition do
        local var6 = nil
        local var7 = nil
        local tileBadgePositionCalculator = GameTileConstants.TileBadgePositionCalculators[value]
        if tileBadgePositionCalculator then
            var6, var7 = tileBadgePositionCalculator(var2)
        else
            flaggedMutedError(
                "GameTileOverlayBadgeInvalidPositionError",
                `Unsupported game tile badge position: {value}`
            )
        end

        if not (#value2 > 0) then
            continue
        end
        local var8 = value2[1]
        local tbl3

        if var8.icons and #var8.icons > 0 then
            tbl3 = {}
            for _, icon in var8.icons do
                local var9 = TileBadgeIconNamesByType[icon]

                if var9 then
                    table.insert(tbl3, var9)
                else
                    warn(`Unsupported game tile badge icon type: {icon}`)
                end
            end
        else
            tbl3 = nil
        end

        local var9 = value .. "TileBadge"
        tbl2[var9] = React.createElement(GameTileOverlayBadge, {
            Position = var6,
            AnchorPoint = var7,
            maxWidthBinding = maxWidthBinding,
            icons = tbl3,
            text = var8.text,
            styleOptions = getBadgeStyleOptions(var1, var8.tileBadgeComponentType)
        })
    end

    return React.createElement(
        "Frame",
        {
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 1, 0),
            [React.Change.AbsoluteSize] = var5
        },
        tbl2
    )
end)
