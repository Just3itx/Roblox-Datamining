-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:50:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local Roact = require(scriptParentParentParentParent.Roact)
local t = require(scriptParentParentParentParent.t)
local Cryo = require(scriptParentParentParentParent.Cryo)
local StatusIndicator = require(scriptParentParentParentParent.Foundation).StatusIndicator
local withStyle = require(scriptParentParentParent.Core.Style.withStyle)
local ControlState = require(scriptParentParentParent.Core.Control.Enum.ControlState)
local ImageSetComponent = require(scriptParentParentParent.Core.ImageSet.ImageSetComponent)
local validateImageSetData = require(scriptParentParentParent.Core.ImageSet.Validator.validateImageSetData)
local BadgeVariant = require(scriptParentParentParent.App.Indicator.Enum.BadgeVariant)
local BadgeStates = require(scriptParentParentParent.App.Indicator.Enum.BadgeStates)
local IconSize = require(scriptParentParentParent.App.ImageSet.Enum.IconSize)
local getIconSize = require(scriptParentParentParent.App.ImageSet.getIconSize)

local InteractableList = require(scriptParentParentParent.Core.Control.InteractableList)
local withAnimation = require(scriptParentParentParent.Core.Animation.withAnimation)

local migrateBadgeVariant = require(scriptParentParentParent.Utility.migrateBadgeVariant)

local Placement = require(script.Parent.Enum.Placement)

local tbl1 = { frequency = 3 }

local iconSize = getIconSize(IconSize.Medium)

local var1 = iconSize + 8

local var2 = (var1 - iconSize) / 2
local var3 = (var1 - iconSize) / 2
local var4 = var2 + 4
local var5 = var3 - 4

local offset = 12 + (64 - var1) / 2
local Offset = 4 + (64 - var1)

local var6 = Roact.PureComponent:extend("SystemBar")

var6.validateProps = t.strictInterface({
    itemList = t.array(
        t.strictInterface({
            iconOn = t.optional(validateImageSetData),
            iconOff = t.optional(validateImageSetData),
            iconImageComponent = t.optional(t.union(t.table, t.callback)),
            iconComponent = t.optional(t.union(t.table, t.callback)),
            onActivated = t.callback,
            badgeValue = t.optional(t.union(t.integer, t.string, BadgeStates.isEnumValue)),
            itemSize = t.optional(t.UDim2),
            bottomAligned = t.optional(t.boolean)
        })
    ),
    selection = t.optional(t.integer),
    placement = t.optional(Placement.isEnumValue),
    hidden = t.optional(t.boolean),
    onSafeAreaChanged = t.optional(t.callback),
    size = t.optional(t.UDim2),
    position = t.optional(t.UDim2),
    layoutOrder = t.optional(t.integer),
    layoutPaddingOffset = t.optional(t.UDim),
    firstItemPaddingOffset = t.optional(t.UDim),
    lastItemPaddingOffset = t.optional(t.UDim),
    [Roact.Children] = t.optional(t.any),
    roundCorners = t.optional(t.boolean),
    buttonStroke = t.optional(t.boolean),
    bgTransparency = t.optional(t.integer),
    sortOrder = t.optional(t.enum(Enum.SortOrder)),
    clipsDescendants = t.optional(t.boolean),
    experimentalTabSizePortraitY = t.optional(t.number)
})

var6.defaultProps = {
    placement = Placement.Auto,
    layoutPaddingOffset = UDim.new(0, 0),
    firstItemPaddingOffset = UDim.new(0, 0),
    lastItemPaddingOffset = UDim.new(0, 0),
    clipsDescendants = true,
    experimentalTabSizePortraitY = 48
}

function var6.isPortrait(arg1)
    return not (arg1.props.placement == Placement.Left) and (arg1.props.placement == Placement.Bottom or arg1.state.portrait)
end

function var6.renderItem(arg1, arg2, arg3, selected, layoutOrder)
    assert(
        arg2.iconOn ~= nil and arg2.iconOff ~= nil or arg2.iconImageComponent ~= nil or arg2.iconComponent ~= nil,
        "items must define either iconOn and iconOff or iconImageComponent or iconComponent"
    )

    local pressed = arg3 == ControlState.Pressed
    local hovered = pressed or arg3 == ControlState.Hover

    if arg2.iconComponent then
        local placement = if arg1:isPortrait() then Placement.Bottom else Placement.Left
        return Roact.createElement(
            arg2.iconComponent,
            {
                placement = placement,
                hovered = hovered,
                selected = selected,
                pressed = pressed,
                badgeValue = arg2.badgeValue
            }
        ), { LayoutOrder = layoutOrder }
    end

    local bool3 = if arg2.badgeValue then arg2.badgeValue == BadgeStates.isEmpty or (if t.string(arg2.badgeValue) then true else arg2.badgeValue > 0) else false
    local var7 = var2
    local var8 = var3
    if hovered then
        if arg1:isPortrait() then
            var8 = var5
        else
            var7 = var4
        end
    end
    return withAnimation({ positionX = var7, positionY = var8 }, function(arg4)
        return withStyle(function(arg5)
            local theme = arg5.Theme
            local createElement = Roact.createElement
            local var9 = arg2.iconImageComponent or ImageSetComponent.Label
            local tbl2 = {
                Position = UDim2.fromOffset(math.floor(arg4.positionX + 0.5), math.floor(arg4.positionY + 0.5)),
                Size = UDim2.fromOffset(iconSize, iconSize),
                BackgroundTransparency = if arg1.props.buttonStroke then 0.99 else 1,
                Image = selected and arg2.iconOn or arg2.iconOff,
                ImageColor3 = theme.IconDefault.Color,
                ImageTransparency = if pressed then 0.5 else 0
            }
            local tbl3 = { Badge = 0, UICorner = 0, UIStroke = 0 }
            local bool4 = bool3

            if bool4 then
                bool4 = Roact.createElement(StatusIndicator, {
                    position = if arg2.badgeValue == BadgeStates.isEmpty then UDim2.fromOffset(22, 2) else UDim2.fromOffset(18, -2),
                    value = tonumber(arg2.badgeValue),
                    variant = migrateBadgeVariant(BadgeVariant.Default),
                    max = if tonumber(arg2.badgeValue) then 99 else nil
                })
            end

            tbl3.Badge = bool4

            tbl3.UICorner = arg1.props.roundCorners and Roact.createElement("UICorner", { CornerRadius = UDim.new(0.15, 0) }) or nil

            tbl3.UIStroke = arg1.props.buttonStroke
                and Roact.createElement("UIStroke", { Color = Color3.new(0.4, 0.4, 0.4), Transparency = 0, Thickness = 1 })
                or nil
            return createElement(var9, tbl2, tbl3)
        end)
    end, tbl1), { LayoutOrder = layoutOrder }
end

function var6.renderPortrait(arg1, arg2, arg3)
    return withAnimation({
        offset = if arg1.props.hidden then 0 else -arg1.props.experimentalTabSizePortraitY
    }, function(arg4)
        return Roact.createElement(
            "Frame",
            Cryo.Dictionary.join(arg2, {
                Position = UDim2.new(0, 0, 1, math.floor(arg4.offset + 0.5)),
                Size = UDim2.new(1, 0, 0, arg1.props.experimentalTabSizePortraitY),
                ZIndex = 99
            }),
            {
                Layout = Roact.createElement("UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center }),
                InnerFrame = Roact.createElement(
                    "Frame",
                    {
                        Size = UDim2.new(1, 0, 1, 0),
                        BackgroundTransparency = 1
                    },
                    Cryo.Dictionary.join({
                        Constraint = Roact.createElement("UISizeConstraint", { MaxSize = Vector2.new(600, arg1.props.experimentalTabSizePortraitY) }),
                        Layout = Roact.createElement("UIListLayout", {
                            FillDirection = Enum.FillDirection.Horizontal,
                            HorizontalAlignment = Enum.HorizontalAlignment.Center,
                            VerticalAlignment = Enum.VerticalAlignment.Center,
                            Padding = arg1.props.layoutPaddingOffset + UDim.new(1 / #arg1.props.itemList, -var1),
                            SortOrder = arg1.props.sortOrder
                        }, {})
                    }, arg3)
                )
            }
        )
    end, tbl1)
end

function var6.renderLandscape(arg1, arg2, arg3, arg4)
    return withAnimation({
        offset = if arg1.props.hidden then -64 else 0
    }, function(arg5)
        local createElement = Roact.createElement
        local str1 = "Frame"
        local var7 = Cryo.Dictionary.join(arg2, {
            Position = UDim2.new(0, math.floor(arg5.offset + 0.5), 0, 0),
            Size = UDim2.new(0, 64, 1, 0),
            ZIndex = 99,
            BackgroundTransparency = if arg4 then 1 else nil
        })
        local join = Cryo.Dictionary.join
        local tbl2 = {
            Padding = Roact.createElement("UIPadding", {
                PaddingTop = if arg4 then nil else arg1.props.firstItemPaddingOffset + UDim.new(0, offset),
                PaddingBottom = if arg4 then arg1.props.lastItemPaddingOffset + UDim.new(0, Offset) else nil
            }),
            Layout = Roact.createElement("UIListLayout", {
                FillDirection = Enum.FillDirection.Vertical,
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                VerticalAlignment = if arg4 then Enum.VerticalAlignment.Bottom else nil,
                Padding = arg1.props.layoutPaddingOffset + UDim.new(0, Offset),
                SortOrder = arg1.props.sortOrder
            })
        }
        return createElement(str1, var7, join(tbl2, arg3))
    end, tbl1)
end

function var6.renderBackground(arg1, arg2, arg3)
    if arg1:isPortrait() then
        return arg1:renderPortrait(arg2, arg3)
    end
    local var7 = Cryo.List.filter(arg3, function(_, arg4): boolean
        return not arg1.props.itemList[arg4].bottomAligned
    end)
    local var8 = Cryo.List.filter(arg3, function(_, arg4)
        return arg1.props.itemList[arg4].bottomAligned
    end)
    local var9 = arg1:renderLandscape(arg2, var7)
    if #var8 > 0 then
        var9 = Roact.createFragment({ NavBar = var9, BottomAlignedNavBar = arg1:renderLandscape(arg2, var8, true) })
    end

    return var9
end

function var6.renderSafeArea(arg1)
    local var7, var8

    if arg1.props.hidden then
        var7 = UDim2.new(0, 0, 0, 0)
        var8 = UDim2.new(1, 0, 1, 0)
    elseif arg1:isPortrait() then
        var7 = UDim2.new(0, 0, 0, 0)
        var8 = UDim2.new(1, 0, 1, -arg1.props.experimentalTabSizePortraitY)
    else
        var7 = UDim2.new(0, 64, 0, 0)
        var8 = UDim2.new(1, -64, 1, 0)
    end
    return Roact.createElement("Frame", {
        Position = var7,
        Size = var8,
        BackgroundTransparency = 1,
        [Roact.Change.AbsoluteSize] = arg1.onSafeAreaEvent,
        [Roact.Change.AbsolutePosition] = arg1.onSafeAreaEvent
    }, arg1.props[Roact.Children])
end

function var6.renderList(arg1, arg2, arg3)
    return withStyle(function(arg4)
        local theme = arg4.Theme
        local var7 = Cryo.List.map(arg2, function(_, arg5)
            return arg3(arg5)
        end)
        local createElement = Roact.createElement
        local tbl2 = {
            Position = arg1.props.position or UDim2.new(0, 0, 0, 0),
            Size = arg1.props.size or UDim2.new(1, 0, 1, 0),
            BackgroundColor3 = Color3.new(0, 0, 0),
            ClipsDescendants = arg1.props.clipsDescendants,
            LayoutOrder = arg1.props.layoutOrder,
            BackgroundTransparency = arg1.props.bgTransparency or 1
        }

        tbl2[Roact.Change.AbsoluteSize] = function(arg5)
            if arg1.state.portrait and arg5.AbsoluteSize.X > arg5.AbsoluteSize.Y then
                arg1:setState({ portrait = false })
            elseif not arg1.state.portrait and arg5.AbsoluteSize.X < arg5.AbsoluteSize.Y then
                arg1:setState({ portrait = true })
            end
        end

        return createElement("Frame", tbl2, {
            NavBar = arg1:renderBackground({
                BackgroundColor3 = theme.NavigationBar.Color,
                BackgroundTransparency = if arg1.props.roundCorners then 1 else theme.NavigationBar.Transparency,
                BorderSizePixel = 0
            }, var7),
            SafeArea = arg1:renderSafeArea()
        }, {
            UICorner = arg1.props.roundCorners and Roact.createElement("UICorner", { CornerRadius = UDim.new(0.15, 0) or nil }) or nil
        })
    end)
end

function var6.init(arg1)
    arg1:setState({ portrait = true })

    function arg1.onSelectionChanged(arg2)
        if not (#arg2 > 0) then
            return
        end

        local var7 = arg1.props.itemList[arg2[1]]
        if var7 and var7.onActivated then
            var7.onActivated()
        end
    end

    function arg1.onSafeAreaEvent(arg2)
        if not arg1.props.onSafeAreaChanged then
            return
        end

        arg1.props.onSafeAreaChanged({
            Position = arg2.Position,
            AbsolutePosition = arg2.AbsolutePosition,
            Size = arg2.Size,
            AbsoluteSize = arg2.AbsoluteSize
        })
    end
end

function var6.render(arg1)
    local itemList = arg1.props.itemList
    local selection = arg1.props.selection
    local var7 = selection and (itemList[selection] ~= nil and { selection } or nil)

    return Roact.createElement(InteractableList, {
        itemList = itemList,
        selection = var7,
        itemSize = UDim2.fromOffset(var1, var1),
        renderList = function(...)
            return arg1:renderList(...)
        end,
        renderItem = function(...)
            return arg1:renderItem(...)
        end,
        sortOrder = arg1.props.sortOrder,
        onSelectionChanged = arg1.onSelectionChanged
    })
end

return var6
