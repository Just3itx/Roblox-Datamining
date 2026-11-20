-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T23:10:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppShortcutBar = script:FindFirstAncestor("AppShortcutBar")
local AppShortcutBarParent = AppShortcutBar.Parent

local React = require(AppShortcutBarParent.React)
local Foundation = require(AppShortcutBarParent.Foundation)
local UIBlox = require(AppShortcutBarParent.UIBlox)
local ReactFocusNavigation = require(AppShortcutBarParent.ReactFocusNavigation)
local GetTextSize = require(AppShortcutBarParent.Style).GetTextSize

local useStyle = UIBlox.Core.Style.useStyle
local useTokens = Foundation.Hooks.useTokens
local Icon = Foundation.Icon
local Image = Foundation.Image
local KeyLabel = UIBlox.App.Menu.KeyLabel
local KeyLabelUtilities = UIBlox.App.Menu.KeyLabelUtilities
local StateLayer = UIBlox.Core.Control.StateLayer
local Shortcut = UIBlox.App.Navigation.Shortcut

local IconWithHoldAnimation = require(script.Parent.IconWithHoldAnimation)

local FFlagShortcutBarPlatformGamepadIcons = require(AppShortcutBar.Flags).FFlagShortcutBarPlatformGamepadIcons
local bool1 = game:DefineFastFlag("ShortcutUseDispatchSyntheticEvent", false)

local function getKeyLabelsWidth(icon, font) -- Luacid: Inlined by compiler; 1 call site recovered
    local num1 = 0
    for _, value in icon do
        num1 += KeyLabelUtilities.getKeyLabelWidth(value, font)
    end
    return num1
end

local function useOnShortcutActivated(item)
    if not bool1 then
        local var1 = React.useContext(ReactFocusNavigation.FocusNavigationContext)
        return (React.useMemo(function()
            return function()
                local selection = var1._engineInterface.getSelection()
                if not selection then
                    return
                end
                local var2 = var1.activeEventMap:getValue()[item.inputKeyCode]
                if var2 ~= item.eventName then
                    return
                end
                var1._eventPropagationService:propagateEvent(
                    selection,
                    var2,
                    {
                        KeyCode = item.inputKeyCode,
                        UserInputState = Enum.UserInputState.Begin
                    },
                    false
                )
                task.wait(0.1)
                var1._eventPropagationService:propagateEvent(
                    selection,
                    var2,
                    {
                        KeyCode = item.inputKeyCode,
                        UserInputState = Enum.UserInputState.End
                    },
                    false
                )
            end
        end, { var1, item.inputKeyCode, item.eventName }))
    end

    local var1 = React.useContext(ReactFocusNavigation.FocusNavigationContext)
    local var2 = ReactFocusNavigation.useDispatchSyntheticEvent()

    return (React.useCallback(function()
        if item.hasProgress then
            var2(item.eventName, var1.focusedGuiObject:getValue(), {
                UserInputState = Enum.UserInputState.Begin,
                KeyCode = item.inputKeyCode,
                UserInputType = Enum.UserInputType.None,
                immediateDispatch = true
            })
            return
        end

        var2(item.eventName, var1.focusedGuiObject:getValue(), {
            UserInputState = Enum.UserInputState.End,
            KeyCode = item.inputKeyCode,
            UserInputType = Enum.UserInputType.None,
            immediateDispatch = true
        })
    end, {
        item.hasProgress,
        item.eventName,
        item.inputKeyCode,
        var1,
        var2
    }))
end

function AppShortcut(arg1)
    local layoutOrder = arg1.layoutOrder
    local item = arg1.item

    local var1 = useStyle()
    local var2 = useTokens()

    local bool2 = typeof(item.icon) == "table"
    local xOffset, yOffset

    if item.hasProgress then
        xOffset = var2.Size.Size_1300 / 2
        yOffset = var2.Size.Size_1300 / 2
    elseif bool2 then
        xOffset = getKeyLabelsWidth(item.icon, var1.Font)
        yOffset = var2.Size.Size_900
    else
        xOffset = var2.Size.Size_600
        yOffset = var2.Size.Size_600
    end

    local var3 = React.useMemo(function(): UDim2
        local xSmall = var2.Gap.XSmall
        local labelMedium = var2.Typography.LabelMedium
        local vector2 = Vector2.new(math.huge, math.huge)

        local textSize = GetTextSize(item.text, math.floor(labelMedium.FontSize), labelMedium.Font, vector2, { addTemporaryPadding = false })

        local xOffset2 = xOffset + xSmall + textSize.X
        return UDim2.new(0, xOffset2, 1, 0)
    end, { var2, xOffset, item.text })

    local size = React.useMemo(function()
        return var3 + UDim2.fromOffset(var2.Size.Size_100 * 2, 0)
    end, { var3, var2 })

    local var5 = React.useMemo(function(): {ListLayout: any}?
        if not bool2 then
            return nil
        end

        local tbl1 = {
            ListLayout = React.createElement("UIListLayout", {
                SortOrder = Enum.SortOrder.LayoutOrder,
                FillDirection = Enum.FillDirection.Horizontal,
                VerticalAlignment = Enum.VerticalAlignment.Center
            })
        }
        for value, keyCode in item.icon do
            tbl1["KeyLabel_" .. tostring(value)] = React.createElement(KeyLabel, { LayoutOrder = value, keyCode = keyCode, iconThemeKey = "IconEmphasis" })
        end

        return tbl1
    end, { bool2, item.icon, var2 })

    local renderIcon = React.useCallback(function(arg2)
        if item.hasProgress then
            return React.createElement(IconWithHoldAnimation, {
                layoutOrder = arg2.layoutOrder,
                size = UDim2.fromOffset(xOffset, yOffset),
                progress = item.progress,
                icon = item.icon,
                iconSize = var2.Size.Size_900 / 2
            })
        end
        local createElement = React.createElement
        local str1 = "Frame"
        local tbl1 = {
            LayoutOrder = arg2.layoutOrder,
            BackgroundTransparency = 1,
            Size = UDim2.fromOffset(xOffset, yOffset)
        }
        local var6

        if bool2 then
            var6 = var5
        else
            var6 = FFlagShortcutBarPlatformGamepadIcons
                and item.isPlatformIcon
                and {
                    Icon = React.createElement(Image, { Image = item.icon, imageStyle = var2.Color.Content.Default, tag = "size-full" })
                }
                or {
                    Icon = React.createElement(
                        Icon,
                        {
                            name = item.icon,
                            AnchorPoint = Vector2.new(0.5, 0.5),
                            Position = UDim2.fromScale(0.5, 0.5)
                        }
                    )
                }
        end

        return createElement(str1, tbl1, var6)
    end, {
        item.hasProgress,
        item.progress,
        item.icon,
        if FFlagShortcutBarPlatformGamepadIcons then item.isPlatformIcon else nil,
        if FFlagShortcutBarPlatformGamepadIcons then var2 else nil,
        xOffset,
        yOffset,
        bool2,
        var5,
        var2.Size.Size_900
    })

    local onActivated = useOnShortcutActivated(item)

    return React.createElement("Frame", {
        LayoutOrder = layoutOrder,
        BackgroundTransparency = 1,
        Size = var3
    }, {
        ShortcutFrame = React.createElement(
            "Frame",
            {
                Size = UDim2.fromScale(1, 1),
                BackgroundTransparency = 1,
                ZIndex = 2
            },
            {
                Shortcut = React.createElement(Shortcut, {
                    size = UDim2.fromScale(1, 1),
                    automaticSize = Enum.AutomaticSize.None,
                    iconLabelGap = var2.Gap.XSmall,
                    publicProps = item,
                    labelTextSize = var2.Typography.LabelMedium.FontSize,
                    labelColorStyle = var2.Color.Label,
                    labelFontStyle = var2.Typography.LabelMedium,
                    renderIcon = renderIcon
                })
            }
        ),
        StateLayer = React.createElement(StateLayer, {
            selectable = false,
            cornerRadius = UDim.new(0, var2.Radius.Medium),
            size = size,
            zIndex = 1,
            onActivated = onActivated
        })
    })
end

return React.memo(AppShortcut)
