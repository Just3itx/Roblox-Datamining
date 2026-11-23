-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T17:30:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarSwitcher = script:FindFirstAncestor("AvatarSwitcher")
local AvatarSwitcherParent = AvatarSwitcher.Parent

local React = require(AvatarSwitcherParent.React)
local Foundation = require(AvatarSwitcherParent.Foundation)
local useTokens = Foundation.Hooks.useTokens
local FlatList = require(AvatarSwitcherParent.VirtualizedList).FlatList

local OutfitsRow = require(AvatarSwitcher.Components.OutfitsRow)
local _types = require(AvatarSwitcher.types)

local windowSize = game:DefineFastInt("AvatarSwitcherGridWindowSize", 10)
local initialNumToRender = game:DefineFastInt("AvatarSwitcherGridInitialNumToRender", 10)
local onEndReachedThreshold = game:DefineFastInt("AvatarSwitcherGridOnEndReachedThreshold", 200) / 100

local num4 = if require(AvatarSwitcherParent.AvatarExperienceFlags).FFlagAvatarSwitcherUiFixes then game:DefineFastInt("AvatarSwitcherTileSize", 98) else 108

local function OutfitsGrid(tbl1)
    local var1 = useTokens()

    local desiredItemsCount, var3 = React.useState(3)

    React.useEffect(function()
        task.spawn(function()
            tbl1.fetchNextOutfitsPage()
        end)
    end, {})

    local var4 = React.useMemo(function()
        local result = {}
        for i = 1, #tbl1.outfits, desiredItemsCount do
            local outfits = tbl1.outfits
            local var4 = i + desiredItemsCount - 1
            table.insert(result, { unpack(outfits, i, var4) })
        end
        return result
    end, { tbl1.outfits, desiredItemsCount })

    local renderItem = React.useCallback(function(arg1)
        return React.createElement(
            OutfitsRow,
            {
                outfits = arg1.item,
                desiredItemsCount = desiredItemsCount,
                rowNumber = arg1.index,
                disabled = tbl1.disabled
            }
        )
    end, { desiredItemsCount })

    local onAbsoluteSizeChanged = React.useCallback(function(arg1)
        local absoluteSizeX = arg1.AbsoluteSize.X
        var3(math.max(3, math.floor(absoluteSizeX / num4)))
    end, {})

    return (React.createElement(Foundation.View, {
        tag = "size-full-full",
        onAbsoluteSizeChanged = onAbsoluteSizeChanged,
        padding = {
            left = UDim.new(0, -var1.Padding.XXSmall),
            right = UDim.new(0, -var1.Padding.XXSmall)
        }
    }, {
        ClipFrame = React.createElement(Foundation.View, {
            tag = "size-full-full clip",
            padding = {
                top = UDim.new(0, var1.Padding.XXSmall),
                left = UDim.new(0, var1.Padding.XXSmall),
                right = UDim.new(0, var1.Padding.XXSmall)
            }
        }, {
            OutfitsList = React.createElement(FlatList, {
                renderItem = renderItem,
                data = var4,
                onEndReached = tbl1.fetchNextOutfitsPage,
                windowSize = windowSize,
                initialNumToRender = initialNumToRender,
                onEndReachedThreshold = onEndReachedThreshold,
                contentContainerStyle = { BackgroundTransparency = 1 },
                style = {
                    BackgroundTransparency = 1,
                    ScrollBarThickness = 0,
                    ClipsDescendants = false
                },
                ListFooterComponent = not tbl1.lastPageReached
                    and React.createElement(
                        Foundation.View,
                        { tag = "size-0-full position-top-center padding-small" },
                        { React.createElement(Foundation.Loading) }
                    )
            })
        })
    }))
end

return OutfitsGrid
