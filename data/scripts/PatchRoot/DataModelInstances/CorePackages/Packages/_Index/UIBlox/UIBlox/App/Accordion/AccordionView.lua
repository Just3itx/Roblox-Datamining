-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:21:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local Roact = require(scriptParentParentParentParent.Roact)
local t = require(scriptParentParentParentParent.t)
local SpringAnimatedItem = require(scriptParentParentParent.Utility.SpringAnimatedItem)

local springOptions = { dampingRatio = 1, frequency = 3.5 }

local var1 = Roact.PureComponent:extend("AccordionView")

var1.validateProps = t.strictInterface({
    items = t.table,
    itemWidth = t.number,
    itemHeight = t.number,
    renderItem = t.callback,
    placeholderColor = t.Color3,
    placeholderBaseTransparency = t.number,
    collapseButtonSize = t.number,
    renderCollapseButton = t.callback,
    LayoutOrder = t.optional(t.integer),
    maxItemsInCompactView = t.numberPositive,
    onExpand = t.optional(t.callback),
    onCollapse = t.optional(t.callback)
})

var1.defaultProps = { maxItemsInCompactView = 3 }

function var1.init(arg1)
    arg1.state = { expanded = false, isExpandButtonPressed = false }

    function arg1.onExpandButtonActivated()
        if arg1.props.onExpand then
            arg1.props.onExpand()
        end
        arg1:setState({ expanded = true, isExpandButtonPressed = false })
    end

    function arg1.onCollapseButtonActivated()
        if arg1.props.onCollapse then
            arg1.props.onCollapse()
        end
        arg1:setState({ expanded = false })
    end

    function arg1.onExpandButtonInputBegan(_, arg2)
        if arg2.UserInputState == Enum.UserInputState.Begin
            and (arg2.UserInputType == Enum.UserInputType.Touch or arg2.UserInputType == Enum.UserInputType.MouseButton1)
        then
            arg1:setState({ isExpandButtonPressed = true })
        end
    end

    function arg1.onExpandButtonInputEnded()
        if arg1.state.isExpandButtonPressed then
            arg1:setState({ isExpandButtonPressed = false })
        end
    end

    arg1.rootFrameRef = Roact.createRef()

    function arg1.onListLayoutAbsoluteContentSizeChanged(arg2)
        if arg1.rootFrameRef.current then
            local itemWidth = arg1.props.itemWidth
            local compactTotalHeight = arg1:getCompactTotalHeight()

            local current = arg1.rootFrameRef.current
            current.Size = UDim2.new(0, itemWidth, 0, math.max(arg2.AbsoluteContentSize.Y, compactTotalHeight))
        end
    end
end

function var1.getCompactTotalHeight(arg1): number
    local items = arg1.props.items
    local itemHeight = arg1.props.itemHeight
    local maxItemsInCompactView = arg1.props.maxItemsInCompactView
    local itemsLen = #items

    if itemsLen == 0 then
        return 0
    end

    return itemHeight + (math.min(maxItemsInCompactView, itemsLen) - 1) * 10
end

function var1.getLayoutInfo(arg1)
    local items = arg1.props.items
    local itemWidth = arg1.props.itemWidth
    local itemHeight = arg1.props.itemHeight
    local placeholderBaseTransparency = arg1.props.placeholderBaseTransparency
    local maxItemsInCompactView = arg1.props.maxItemsInCompactView
    local expanded = arg1.state.expanded

    local layoutInfo = ({})
    local itemsLen = #items
    local num1 = math.min(maxItemsInCompactView, itemsLen)

    local var2 = if num1 > 1 then (1 - placeholderBaseTransparency) / (num1 - 1) else 0

    for i = 1, itemsLen do
        if expanded or i == 1 then
            layoutInfo[i] = {
                width = itemWidth,
                height = itemHeight,
                placeholderTransparency = 1,
                itemTransparency = 0
            }
        elseif i <= maxItemsInCompactView then
            local tbl2 = {
                width = itemWidth - (i - 1) * 20,
                height = 10,
                placeholderTransparency = placeholderBaseTransparency + var2 * (i - 2),
                itemTransparency = 1
            }
            layoutInfo[i] = tbl2
        else
            local tbl2 = {
                width = itemWidth - (i - 1) * 20,
                height = 0,
                placeholderTransparency = 1,
                itemTransparency = 1
            }
            layoutInfo[i] = tbl2
        end
    end

    return layoutInfo
end

function var1.render(arg1)
    local items = arg1.props.items
    local itemsLen = #items

    if itemsLen == 0 then
        return nil
    end

    local layoutOrder = arg1.props.LayoutOrder
    local itemWidth = arg1.props.itemWidth
    local renderItem = arg1.props.renderItem
    local placeholderColor = arg1.props.placeholderColor
    local collapseButtonSize = arg1.props.collapseButtonSize
    local renderCollapseButton = arg1.props.renderCollapseButton

    local expanded = arg1.state.expanded
    local isExpandButtonPressed = arg1.state.isExpandButtonPressed

    local layoutInfo = arg1:getLayoutInfo()

    local tbl2 = {
        Layout = Roact.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, if expanded then 10 else 0),
            [Roact.Change.AbsoluteContentSize] = arg1.onListLayoutAbsoluteContentSizeChanged
        }),
        Scaler = Roact.createElement(SpringAnimatedItem.AnimatedUIScale, {
            springOptions = springOptions,
            animatedValues = {
                scale = if isExpandButtonPressed then 0.9 else 1
            },
            mapValuesToProps = function(arg2)
                return {
                    Scale = arg2.scale
                }
            end
        }),
        CollapseButton = 0
    }

    local createElement = Roact.createElement
    local animatedFrame = SpringAnimatedItem.AnimatedFrame

    local tbl3 = {
        springOptions = springOptions,
        animatedValues = {
            sizeOffsetY = expanded and collapseButtonSize + 1 or 0
        },
        mapValuesToProps = function(arg2)
            return {
                Size = UDim2.new(0, collapseButtonSize, 0, arg2.sizeOffsetY)
            }
        end,
        regularProps = 0
    }

    local regularProps = { BackgroundTransparency = 1, ClipsDescendants = true }
    local children = Roact.Children

    local tbl5 = {
        ButtonMoveContainer = Roact.createElement(SpringAnimatedItem.AnimatedFrame, {
            springOptions = springOptions,
            animatedValues = {
                positionOffsetY = if expanded then 0 else collapseButtonSize / 2
            },
            mapValuesToProps = function(arg2)
                return {
                    Position = UDim2.new(0, 0, 0, arg2.positionOffsetY)
                }
            end,
            regularProps = {
                Size = UDim2.new(0, collapseButtonSize, 0, collapseButtonSize),
                BackgroundTransparency = 1,
                [Roact.Children] = {
                    Button = renderCollapseButton(arg1.onCollapseButtonActivated)
                }
            }
        })
    }

    regularProps[children] = tbl5
    tbl3.regularProps = regularProps
    tbl2.CollapseButton = createElement(animatedFrame, tbl3)

    for i, _ in ipairs(items) do
        local var2 = layoutInfo[i]

        local str1 = "Item" .. tostring(i)
        local createElement2 = Roact.createElement
        local animatedFrame2 = SpringAnimatedItem.AnimatedFrame
        local tbl6 = {
            springOptions = springOptions,
            animatedValues = {
                width = var2.width,
                height = var2.height
            },
            mapValuesToProps = 0,
            regularProps = 0
        }
        function tbl6.mapValuesToProps(arg2)
            return {
                Size = UDim2.new(0, arg2.width, 0, arg2.height)
            }
        end
        local tbl1 = {
            Size = UDim2.new(1, 0, 0, 0),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            LayoutOrder = i + 1,
            ZIndex = itemsLen + 1 - i,
            ClipsDescendants = true
        }
        local children2 = Roact.Children
        local tbl8 = {
            Item = renderItem(items[i], var2.itemTransparency, springOptions),
            Placeholder = 0
        }
        local createElement3 = Roact.createElement
        local animatedFrame3 = SpringAnimatedItem.AnimatedFrame
        local tbl9 = {
            key = "Placeholder",
            springOptions = springOptions,
            animatedValues = {
                transparency = var2.placeholderTransparency
            },
            mapValuesToProps = 0,
            regularProps = 0
        }
        function tbl9.mapValuesToProps(arg2)
            return {
                BackgroundTransparency = arg2.transparency
            }
        end
        tbl9.regularProps = {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundColor3 = placeholderColor,
            BorderSizePixel = 0
        }
        tbl8.Placeholder = createElement3(animatedFrame3, tbl9)
        tbl1[children2] = tbl8
        tbl6.regularProps = tbl1
        tbl2[str1] = createElement2(animatedFrame2, tbl6)
    end

    local bool1 = itemsLen > 1 and not expanded

    local createElement2 = Roact.createElement
    local str1 = "Frame"
    local tbl6 = {
        Size = UDim2.new(0, itemWidth, 0, 0),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        LayoutOrder = layoutOrder,
        [Roact.Ref] = arg1.rootFrameRef
    }
    local tbl7 = {
        ContentFrame = Roact.createElement("Frame", {
            Size = UDim2.new(1, 0, 1, 0),
            Position = UDim2.new(0.5, 0, 0.5, 0),
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundTransparency = 1
        }, tbl2),
        ClickToExpandButton = 0
    }

    if bool1 then
        bool1 = Roact.createElement("TextButton", {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            ZIndex = itemsLen + 1,
            Text = "",
            [Roact.Event.Activated] = arg1.onExpandButtonActivated,
            [Roact.Event.InputBegan] = arg1.onExpandButtonInputBegan,
            [Roact.Event.InputEnded] = arg1.onExpandButtonInputEnded
        })
    end

    tbl7.ClickToExpandButton = bool1
    return createElement2(str1, tbl6, tbl7)
end

return var1
