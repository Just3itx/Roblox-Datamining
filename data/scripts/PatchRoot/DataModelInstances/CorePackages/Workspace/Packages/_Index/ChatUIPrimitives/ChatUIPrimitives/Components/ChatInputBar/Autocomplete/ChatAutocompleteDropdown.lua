-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:01:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatUIPrimitivesParent = script:FindFirstAncestor("ChatUIPrimitives").Parent
local React = require(ChatUIPrimitivesParent.React)
local Foundation = require(ChatUIPrimitivesParent.Foundation)

local useMenuItemCursor = require(script.Parent.useMenuItemCursor)

local num1 = game:DefineFastInt("ChatAutocompleteMaxVisibleEntries", 3)

return (React.memo(function(tbl1) -- name: ChatAutocompleteDropdown
    local var1 = Foundation.Hooks.useTokens()
    local cursor = useMenuItemCursor()
    local scrollingFrameRef = React.useRef(nil)

    local var4, var5 = React.useState(0)
    React.useEffect(function()
        local current = tbl1.anchorRef.current
        if not current or not current:IsA("GuiObject") then
            return
        end

        var5(current.AbsoluteSize.X)
        local connection = current:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
            var5(current.AbsoluteSize.X)
        end)
        return function()
            connection:Disconnect()
        end
    end, { tbl1.anchorRef })

    local xxSmall = var1.Padding.XXSmall
    React.useEffect(function()
        local current = scrollingFrameRef.current
        if not current or not tbl1.isOpen or tbl1.keyboardIndex < 1 then
            return
        end
        local y = (tbl1.keyboardIndex - 1) * (40 + xxSmall)
        local var6 = y + 40
        local absoluteWindowSizeY = current.AbsoluteWindowSize.Y
        local canvasPositionY = current.CanvasPosition.Y
        if canvasPositionY + absoluteWindowSizeY < var6 then
            current.CanvasPosition = Vector2.new(0, var6 - absoluteWindowSizeY)
        elseif y < canvasPositionY then
            current.CanvasPosition = Vector2.new(0, y)
        end
    end, { tbl1.keyboardIndex, tbl1.isOpen, xxSmall })

    local var6 = React.useMemo(function()
        local result = ({})
        if not (tbl1.isOpen and tbl1.renderEntry) then
            return result
        end
        local renderEntry = tbl1.renderEntry
        for layoutOrder, result2 in tbl1.results do
            local bool1 = layoutOrder == tbl1.selectedIndex

            local str1 = "entry_" .. tostring(layoutOrder)
            local createElement = React.createElement
            local view = Foundation.View
            local tbl2 = {
                Size = UDim2.new(1, 0, 0, 40),
                LayoutOrder = layoutOrder,
                cornerRadius = UDim.new(0, var1.Radius.Medium),
                backgroundStyle = if bool1 then var1.Color.ActionSoftEmphasis.Background else nil,
                stateLayer = {
                    affordance = Foundation.Enums.StateLayerAffordance.None
                },
                selection = { Selectable = true },
                cursor = cursor,
                padding = {
                    left = UDim.new(0, 12),
                    right = UDim.new(0, 12),
                    top = UDim.new(0, 10),
                    bottom = UDim.new(0, 10)
                },
                onActivated = 0,
                onStateChanged = 0
            }
            function tbl2.onActivated()
                tbl1.onSelect(layoutOrder)
            end
            function tbl2.onStateChanged(arg1)
                if arg1 == "Hover" then
                    tbl1.onHover(layoutOrder)
                end
            end

            result[str1] = createElement(view, tbl2, { content = renderEntry(result2, bool1) })
        end

        return result
    end, {
        tbl1.isOpen,
        tbl1.results,
        tbl1.selectedIndex,
        tbl1.renderEntry,
        tbl1.onSelect,
        tbl1.onHover,
        cursor,
        var1
    })

    local num2 = num1
    local num3 = math.min(#tbl1.results, num2)
    local bool1 = num2 < #tbl1.results
    local yOffset = if tbl1.isOpen then if bool1 then num3 * 40 + num3 * xxSmall + 20 else num3 * 40 + math.max(0, num3 - 1) * xxSmall else 0
    local xOffset = if var4 > 0 then var4 else 280

    return React.createElement(Foundation.Popover.Root, {
        isOpen = tbl1.isOpen
    }, {
        Anchor = React.createElement(Foundation.Popover.Anchor, { anchorRef = tbl1.anchorRef }),
        Content = React.createElement(
            Foundation.Popover.Content,
            {
                side = {
                    position = tbl1.side or Foundation.Enums.PopoverSide.Top,
                    offset = 0
                },
                align = Foundation.Enums.PopoverAlign.Center,
                hasArrow = false,
                backgroundStyle = var1.Color.Surface.Surface_200,
                radius = Foundation.Enums.Radius.Medium,
                onPressedOutside = tbl1.onDismiss
            },
            React.createElement(Foundation.View, {
                tag = "padding-small",
                Size = UDim2.fromOffset(xOffset, yOffset + 16)
            }, {
                scrollView = React.createElement(
                    Foundation.ScrollView,
                    {
                        Size = UDim2.new(1, 0, 0, yOffset),
                        scrollingFrameRef = scrollingFrameRef,
                        scroll = {
                            AutomaticCanvasSize = Enum.AutomaticSize.Y,
                            CanvasSize = UDim2.fromScale(0, 0),
                            scrollBarVisibility = Foundation.Enums.Visibility.Always,
                            VerticalScrollBarInset = Enum.ScrollBarInset.Always
                        }
                    },
                    {
                        list = React.createElement(Foundation.View, { tag = "col gap-xxsmall auto-y", Size = UDim2.fromScale(1, 0) }, var6)
                    }
                )
            })
        )
    })
end))
