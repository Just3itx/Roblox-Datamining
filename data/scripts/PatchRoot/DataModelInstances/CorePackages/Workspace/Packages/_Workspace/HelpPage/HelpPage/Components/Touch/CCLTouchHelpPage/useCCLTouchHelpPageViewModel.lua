-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T18:11:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HelpPage = script:FindFirstAncestor("HelpPage")
local HelpPageParent = HelpPage.Parent
local React = require(HelpPageParent.React)
local Foundation = require(HelpPageParent.Foundation)
local Display = require(HelpPageParent.Display)
local SignalsReact = require(HelpPageParent.SignalsReact)
local RobloxAppHooks = require(HelpPageParent.RobloxAppHooks)
local RobloxAppEnums = require(HelpPageParent.RobloxAppEnums)
local Constants = require(HelpPage.Constants)
local BindingConfigs = require(HelpPage.Configs.BindingConfigs)
local _ConfigTypes = require(HelpPage.Configs.ConfigTypes)
local useKeybinds = require(HelpPage.Hooks.useKeybinds)
local _TouchControlList = require(HelpPage.Components.Touch.TouchControlList)

local _CCLTouchHelpPageView = require(script.Parent.CCLTouchHelpPageView)

local DeviceOrientationMode = RobloxAppEnums.DeviceOrientationMode

local function createMockLayout(arg1, smallButtonSize: number)
    local var1 = smallButtonSize / arg1.Size.Size_400
    local var2 = arg1.Size.Size_700 * var1
    local var3 = var2 / math.sqrt(2)
    local x = smallButtonSize * 20
    local vector2 = Vector2.new(x, x / (80 / 37))
    local inset = arg1.Gap.XSmall * var1
    local var5 = vector2 - Vector2.new(inset, inset)

    return {
        size = vector2,
        smallButtonSize = smallButtonSize,
        centerButtonSize = smallButtonSize * 1.625,
        inset = inset,
        cornerRadius = arg1.Radius.Large * var1,
        centerButtonPosition = var5 - Vector2.new(
            arg1.Padding.XLarge * var1 + smallButtonSize / 2 + var3,
            arg1.Padding.Medium * var1 + smallButtonSize / 2 + var3
        ),
        slotOffsets = {
            Vector2.new(-var3, -var3),
            Vector2.new(-var3, var3),
            Vector2.new(var3, -var3),
            Vector2.new(-var2, 0),
            Vector2.new(0, -var2),
            Vector2.new(var3, var3)
        },
        topPadding = arg1.Padding.Medium * var1,
        sidePadding = arg1.Padding.XLarge * var1,
        topGap = arg1.Gap.XSmall * var1
    }
end

local function createAbilityControl(id: string, arg1)
    local disabled = arg1 == nil or arg1.disabled == true
    return {
        id = id,
        label = if arg1 then arg1.label else "InGame.HelpMenu.GenericAction",
        icon = Foundation.Enums.IconName.DiamondSimplified,
        assetId = if arg1 then arg1.actionAssetId else nil,
        disabled = disabled
    }
end

local function useCCLTouchHelpPageViewModel()
    local var1 = useKeybinds()
    local var2 = Foundation.Hooks.useTokens()
    local var3 = RobloxAppHooks.useDeviceOrientation()
    local var4 = SignalsReact.useSignalState(Display.GetDisplayStore)
    local var5 = SignalsReact.useSignalState(var4.getViewportSize)
    local x, var6 = React.useState(0)
    local var7, var8 = React.useState(0)
    local var9, var10 = React.useState(0)
    local onSizeChanged = React.useCallback(function(arg1)
        var6(arg1.AbsoluteSize.X)
    end, {})
    local onLeftSizeChanged = React.useCallback(function(arg1)
        var8(arg1.AbsoluteSize.Y)
    end, {})
    local onRightSizeChanged = React.useCallback(function(arg1)
        var10(arg1.AbsoluteSize.Y)
    end, {})

    local var14 = var1.controls or {}
    local leftControls = {}
    for _, value in ipairs({
        {
            id = "UseTool",
            icon = Constants.HELP_PAGE.TOUCH_ICONS.TAP
        },
        {
            id = "RotateCamera",
            icon = Constants.HELP_PAGE.TOUCH_ICONS.ROTATE
        },
        {
            id = "ZoomInOut",
            icon = Constants.HELP_PAGE.TOUCH_ICONS.ZOOM
        },
        {
            id = "Move",
            icon = Constants.HELP_PAGE.TOUCH_ICONS.ROTATE
        }
    }) do
        local var15 = var14[value.id] or BindingConfigs.Controls[value.id]
        if not var15 then
            continue
        end

        table.insert(leftControls, { id = value.id, label = var15.label, icon = value.icon, disabled = var15.disabled })
    end

    local centerControl = createAbilityControl("AbilityAction1", var14.AbilityAction1)

    local slots = {}
    for i = 2, 7 do
        local str1 = "AbilityAction" .. i
        local var15 = var14[str1]
        table.insert(slots, (createAbilityControl(str1, var15)))
    end
    local rightControls = { centerControl }
    for _, value in ipairs(slots) do
        table.insert(rightControls, value)
    end
    table.insert(
        rightControls,
        {
            id = "MoreActions",
            label = "InGame.HelpMenu.GenericAction",
            icon = Foundation.Enums.IconName.DiamondSimplified
        }
    )
    local size500 = var2.Size.Size_500
    local mockLayout = createMockLayout(var2, size500)
    local bool1 = var3 == DeviceOrientationMode.Portrait
        and (var5.X < Constants.HELP_PAGE.TOUCH_OFFSETS.SMALL_SCREEN_CUTOFF_X
            or var5.Y < Constants.HELP_PAGE.TOUCH_OFFSETS.SMALL_SCREEN_CUTOFF_Y)

    if not bool1 then
        x = math.max(0, x * 0.5 - 2 * var2.Gap.Large)
    end

    local y = x / (80 / 37)
    local num1 = math.max(y, var7, var9)
    local yOffset = y + var2.Gap.Large

    return {
        abilitiesAvailable = var1.abilitiesAvailable == true,
        leftControls = leftControls,
        rightControls = rightControls,
        centerControl = centerControl,
        slots = slots,
        layout = {
            leftAnchor = if bool1 then Vector2.zero else Vector2.new(1, 0),
            leftPosition = if bool1 then UDim2.fromOffset(0, yOffset) else UDim2.new(0.25, 0, 0, (num1 - var7) / 2),
            rightAnchor = if bool1 then Vector2.new(1, 0) else Vector2.zero,
            rightPosition = if bool1 then UDim2.new(1, 0, 0, yOffset) else UDim2.new(0.75, 0, 0, (num1 - var9) / 2),
            columnWidth = if bool1 then 0.5 else 0.25,
            columnScale = 1,
            diagramSize = Vector2.new(x, y),
            diagramOffsetY = if bool1 then 0 else (num1 - y) / 2,
            topPadding = UDim.new(0, var2.Padding.Small),
            bottomPadding = UDim.new(0, var2.Padding.XXLarge)
        },
        onSizeChanged = onSizeChanged,
        onLeftSizeChanged = onLeftSizeChanged,
        onRightSizeChanged = onRightSizeChanged,
        mockLayout = mockLayout
    }
end

return useCCLTouchHelpPageViewModel
