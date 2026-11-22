-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:50:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MusicPicker = script:FindFirstAncestor("MusicPicker")
local MusicPickerParent = MusicPicker.Parent

local Foundation = require(MusicPickerParent.Foundation)
local React = require(MusicPickerParent.React)

local Button = Foundation.Button
local Icon = Foundation.Icon
local Radius = Foundation.Enums.Radius
local ScrollBarVisibility = Foundation.Enums.ScrollBarVisibility
local ScrollView = Foundation.ScrollView
local Skeleton = Foundation.Skeleton
local FoundationText = Foundation.Text
local View = Foundation.View
local useTokens = Foundation.Hooks.useTokens

local MusicPickerRow = require(MusicPicker.Components.MusicPickerRow)
local _MusicPickerTypes = require(MusicPicker.Types.MusicPickerTypes)

local function MusicPickerList(tbl1)
    local var1 = useTokens()
    local content = tbl1.content
    local emptyState = content.emptyState
    local onLoadMore = content.onLoadMore
    local bool1 = content.isLoadingMore == true

    local scrollingFrameRef = React.useRef(nil)
    local var3 = React.useCallback(function(arg1)
        if onLoadMore == nil or bool1 then
            return
        end
        local absoluteCanvasSizeY = arg1.AbsoluteCanvasSize.Y
        local absoluteWindowSizeY = arg1.AbsoluteWindowSize.Y

        if absoluteCanvasSizeY <= 0 or absoluteWindowSizeY <= 0 then
            return
        end
        if arg1.CanvasPosition.Y + absoluteWindowSizeY >= absoluteCanvasSizeY - 128 then
            onLoadMore()
        end
    end, { onLoadMore, bool1 })

    React.useEffect(function()
        local current = scrollingFrameRef.current
        if current ~= nil then
            var3(current)
        end
    end, { var3, #content.items })

    if content.status == "success" and #content.items == 0 and emptyState ~= nil then
        return React.createElement(View, {
            LayoutOrder = tbl1.LayoutOrder,
            flexItem = {
                FlexMode = Enum.UIFlexMode.Shrink
            },
            testId = "saved-empty-state",
            tag = "col align-x-center align-y-center gap-xxlarge size-full padding-bottom-xxlarge"
        }, {
            Graphic = React.createElement(View, { LayoutOrder = 1, tag = "size-3000" }, {
                Tile = React.createElement(View, {
                    Rotation = -15,
                    testId = "saved-empty-state-tile",
                    tag = "position-center-center anchor-center-center size-2400 stroke-thick stroke-muted radius-medium"
                }),
                Icon = React.createElement(Icon, {
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    Position = UDim2.fromScale(0.5, 0.5),
                    name = emptyState.icon,
                    size = var1.Size.Size_1200,
                    style = var1.Color.Content.Emphasis,
                    testId = "saved-empty-state-icon"
                })
            }),
            Copy = React.createElement(View, {
                LayoutOrder = 2,
                tag = "col align-x-center gap-small size-full-0 auto-y"
            }, {
                Title = React.createElement(FoundationText, {
                    LayoutOrder = 1,
                    Text = emptyState.title,
                    tag = "size-full-0 auto-y text-heading-small text-wrap text-align-x-center content-emphasis"
                }),
                Subtitle = React.createElement(FoundationText, {
                    LayoutOrder = 2,
                    Text = emptyState.subtitle,
                    tag = "size-full-0 auto-y text-body-medium text-wrap text-align-x-center content-default"
                })
            })
        })
    end

    local tbl2

    if content.status == "loading" then
        tbl2 = {}
        for layoutOrder = 1, 6 do
            local str1 = `Skeleton{layoutOrder}`
            local createElement = React.createElement
            local var4 = Skeleton
            local tbl3 = {
                LayoutOrder = layoutOrder,
                radius = Radius.Medium,
                Size = UDim2.new(1, 0, 0, 64)
            }
            tbl2[str1] = createElement(var4, tbl3)
        end
    elseif content.status == "error" then
        tbl2 = {
            Error = React.createElement(FoundationText, {
                LayoutOrder = 1,
                Text = content.errorText or "",
                tag = "size-full-0 auto-y padding-top-large text-body-medium text-align-x-center content-default"
            }),
            Retry = if content.onRetry == nil then nil else React.createElement(Button, {
                LayoutOrder = 2,
                onActivated = content.onRetry,
                size = Foundation.Enums.InputSize.Small,
                text = content.retryText or "",
                variant = Foundation.Enums.ButtonVariant.Standard
            })
        }
    elseif content.status == "success" and #content.items == 0 then
        tbl2 = {
            Empty = React.createElement(FoundationText, {
                LayoutOrder = 1,
                Text = content.emptyText or "",
                tag = "size-full-0 auto-y padding-top-large text-body-medium text-align-x-center content-default"
            })
        }
    elseif #content.items > 0 then
        tbl2 = {}
        for layoutOrder, item in content.items do
            local str1 = tostring(item.id)
            local createElement = React.createElement
            local var4 = MusicPickerRow
            local tbl3 = {
                item = item,
                layoutOrder = layoutOrder,
                onSelect = tbl1.onSelect
            }
            tbl2[str1] = createElement(var4, tbl3)
        end

        if bool1 then
            tbl2.LoadingMore = React.createElement(
                Skeleton,
                {
                    LayoutOrder = #content.items + 1,
                    radius = Radius.Medium,
                    Size = UDim2.new(1, 0, 0, 64)
                }
            )
            tbl2.LoadingMoreSpacer = React.createElement(View, { LayoutOrder = #content.items + 2, Size = UDim2.new(1, 0, 0, var1.Padding.Large) })
        end
    else
        tbl2 = nil
    end

    return React.createElement(ScrollView, {
        LayoutOrder = tbl1.LayoutOrder,
        flexItem = {
            FlexMode = Enum.UIFlexMode.Shrink
        },
        layout = {
            FillDirection = Enum.FillDirection.Vertical,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            VerticalAlignment = Enum.VerticalAlignment.Top,
            Padding = UDim.new(0, if content.status == "loading" then var1.Gap.Small else var1.Gap.XXSmall),
            SortOrder = Enum.SortOrder.LayoutOrder
        },
        scroll = {
            AutomaticCanvasSize = Enum.AutomaticSize.Y,
            CanvasSize = if onLoadMore == nil then nil else UDim2.new(),
            ScrollingDirection = Enum.ScrollingDirection.Y,
            scrollBarVisibility = ScrollBarVisibility.None
        },
        tag = "col align-x-left align-y-top size-full",
        scrollingFrameRef = scrollingFrameRef,
        onCanvasPositionChanged = if onLoadMore == nil then nil else var3,
        onAbsoluteCanvasSizeChanged = if onLoadMore == nil then nil else var3,
        onAbsoluteWindowSizeChanged = if onLoadMore == nil then nil else var3
    }, tbl2)
end

return MusicPickerList
