-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:51:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)

local LibraryTile = require(script.Parent.Parent.LibraryTile)
local _LibraryTypes = require(script.Parent.Parent.LibraryTypes)
local useHardwareInsets = require(BuildExperience.Components.ChatSheet.useHardwareInsets)

local ScrollView = Foundation.ScrollView
local Skeleton = Foundation.Skeleton
local View = Foundation.View

local Radius = Foundation.Enums.Radius
local ScrollBarVisibility = Foundation.Enums.ScrollBarVisibility

local function LibraryGridView(tbl1)
    local var1 = Foundation.Hooks.useTokens()
    local bottom = useHardwareInsets().bottom
    local medium = var1.Gap.Medium
    local var2 = Foundation.Hooks.useScaledValue(180)
    local size1200 = var1.Size.Size_1200
    local var3, var4 = React.useState(Vector2.zero)

    local num1 = math.max(3, math.ceil((var3.X + medium) / (var2 + medium)))
    local xOffset = math.floor(math.max(0, var3.X - medium * (num1 - 1)) / num1)
    local yOffset = xOffset + size1200
    local num2 = math.ceil((not tbl1.isLoading and #tbl1.items or num1) / num1)
    local yOffset2 = math.max(0, num2 * yOffset + math.max(0, num2 - 1) * medium)

    local var5 = React.useCallback(function()
        if tbl1.hasMore then
            tbl1.onLoadMore()
        end
    end, { tbl1.hasMore, tbl1.onLoadMore })

    React.useEffect(function()
        if tbl1.hasMore and var3.Y > 0 and yOffset2 <= var3.Y then
            var5()
        end
    end, {
        var3.Y,
        yOffset2,
        tbl1.hasMore,
        var5
    })
    local onCanvasPositionChanged = React.useCallback(function(arg1)
        if not tbl1.hasMore or yOffset <= 0 then
            return
        end
        if arg1.CanvasPosition.Y + arg1.AbsoluteWindowSize.Y >= arg1.AbsoluteCanvasSize.Y - yOffset then
            var5()
        end
    end, { yOffset, tbl1.hasMore, var5 })

    local tbl2 = ({})
    if tbl1.isLoading then
        for layoutOrder = 1, num1 do
            local str1 = tostring(layoutOrder)
            local createElement = React.createElement
            local var7 = View
            local tbl3 = {
                LayoutOrder = layoutOrder,
                Size = UDim2.fromOffset(xOffset, yOffset),
                tag = "col gap-small",
                testId = `Library.Category.Skeleton.{layoutOrder}`
            }
            local tbl4 = {
                Thumbnail = React.createElement(Skeleton, { LayoutOrder = 1, Size = UDim2.new(1, 0, 1, -size1200), radius = Radius.Medium }),
                Title = React.createElement(
                    Skeleton,
                    {
                        LayoutOrder = 2,
                        Size = UDim2.new(0.75, 0, 0, var1.Size.Size_500),
                        radius = Radius.Small
                    }
                )
            }
            tbl2[str1] = createElement(var7, tbl3, tbl4)
        end
    else
        for layoutOrder, item in tbl1.items do
            local var7 = item.tileKey or item.itemId or item.displayName
            local createElement = React.createElement
            local var8 = View
            local tbl3 = {
                LayoutOrder = layoutOrder,
                Size = UDim2.fromOffset(xOffset, yOffset)
            }
            local tbl4 = {
                Tile = React.createElement(LibraryTile, {
                    tileKey = item.tileKey,
                    itemId = item.itemId,
                    itemKind = item.itemKind,
                    isFolder = item.isFolder,
                    folderPreview = item.folderPreview,
                    displayName = item.displayName,
                    unavailableText = item.unavailableText,
                    thumbnail = item.thumbnail,
                    model = item.model,
                    onActivated = item.onActivated,
                    Size = UDim2.fromScale(1, 1),
                    mediaSize = UDim2.new(1, 0, 1, -size1200)
                })
            }
            tbl2[var7] = createElement(var8, tbl3, tbl4)
        end
    end

    return React.createElement(View, {
        LayoutOrder = tbl1.LayoutOrder,
        onAbsoluteSizeChanged = function(arg1)
            var4(arg1.AbsoluteSize)
        end,
        tag = "size-full",
        testId = "Library.Category.Grid"
    }, {
        Scroll = React.createElement(ScrollView, {
            BorderSizePixel = 0,
            onCanvasPositionChanged = onCanvasPositionChanged,
            scrollingFrameRef = tbl1.scrollingFrameRef,
            scroll = {
                AutomaticCanvasSize = Enum.AutomaticSize.Y,
                CanvasSize = UDim2.new(1, 0, 0, yOffset2),
                ScrollingDirection = Enum.ScrollingDirection.Y,
                scrollBarVisibility = ScrollBarVisibility.None
            },
            tag = "size-full",
            testId = "Library.Category.Grid.Scroll"
        }, {
            Content = React.createElement(
                View,
                {
                    padding = {
                        bottom = UDim.new(0, bottom)
                    },
                    tag = "size-full-0 auto-y",
                    testId = "Library.Category.Grid.Content"
                },
                {
                    Layout = React.createElement("UIGridLayout", {
                        CellPadding = UDim2.fromOffset(medium, medium),
                        CellSize = UDim2.fromOffset(xOffset, yOffset),
                        FillDirection = Enum.FillDirection.Horizontal,
                        HorizontalAlignment = Enum.HorizontalAlignment.Left,
                        SortOrder = Enum.SortOrder.LayoutOrder
                    }),
                    Items = React.createElement(React.Fragment, nil, tbl2)
                }
            )
        })
    })
end
return LibraryGridView
