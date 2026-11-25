-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T03:04:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local ContextActionService = game:GetService("ContextActionService")
local GuiService = game:GetService("GuiService")
local UserInputService = game:GetService("UserInputService")

local React = require(scriptParentParentParentParent.React)
local SignalsReact = require(scriptParentParentParentParent.SignalsReact)
local Foundation = require(scriptParentParentParentParent.Foundation)

local View = Foundation.View
local Divider = Foundation.Divider
local useTokens = Foundation.Hooks.useTokens
local StateLayerAffordance = Foundation.Enums.StateLayerAffordance

local PlayerContextualMenuStore = require(scriptParentParentParent.Common.PlayerContextualMenuStore)
local PlayerContextMenuHeader = require(scriptParentParentParent.Components.Presentation.PlayerContextMenuHeader)
local MenuActionRow = require(scriptParentParentParent.Components.Presentation.MenuActionRow)
local usePreferredBackgroundStyle = require(scriptParentParentParent.Hooks.usePreferredBackgroundStyle)
local Constants = require(scriptParentParentParent.Common.Constants)

local useSlideOpenCloseAnimation = require(scriptParentParentParent.Hooks.useSlideOpenCloseAnimation)
local useSlideOpenCloseAnimation2 = useSlideOpenCloseAnimation.useSlideOpenCloseAnimation
local MENU_SLIDE_CONFIG = useSlideOpenCloseAnimation.MENU_SLIDE_CONFIG
local MENU_ZOOM_CLOSED_SCALE = useSlideOpenCloseAnimation.MENU_ZOOM_CLOSED_SCALE

local backgroundStyle = {
    Color3 = Color3.new(0, 0, 0),
    Transparency = 1
}
local stateLayer = {
    affordance = StateLayerAffordance.None
}
local function func1() end

local function isPositionInsideGuiObject(arg1, position: vector): boolean -- Luacid: Inlined by compiler; 4 call sites recovered
    local absolutePosition = arg1.AbsolutePosition
    local absoluteSize = arg1.AbsoluteSize

    return position.X >= absolutePosition.X
        and position.X <= absolutePosition.X + absoluteSize.X
        and position.Y >= absolutePosition.Y
        and position.Y <= absolutePosition.Y + absoluteSize.Y
end

local function isPositionOnMenu(current, position: vector)
    if isPositionInsideGuiObject(current, position) then
        return true
    end
    for _, descendant in current:GetDescendants() do
        if descendant:IsA("GuiObject") and descendant.Visible and isPositionInsideGuiObject(descendant, position) then
            return true
        end
    end

    return false
end

local function isPositionOnRow(anchorRow, position: vector)
    if not isPositionInsideGuiObject(anchorRow, position) then
        return false
    end
    local anchorRowParent = anchorRow.Parent

    while anchorRowParent ~= nil and anchorRowParent:IsA("GuiObject") do
        if anchorRowParent.ClipsDescendants and not isPositionInsideGuiObject(anchorRowParent, position) then
            return false
        end
        anchorRowParent = anchorRowParent.Parent
    end
    return true
end

local function isGamepad(): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return UserInputService:GetLastInputType().Name:find("Gamepad") ~= nil
end

return React.memo(function(tbl3) -- name: PlayerContextualMenuView
    local var1 = SignalsReact.useSignalState(PlayerContextualMenuStore.getMenuData)
    local var2 = useTokens()
    local var3 = usePreferredBackgroundStyle(var2.Color.OverMedia.OverMedia_100)

    local var4 = React.useRef(var1)
    if var1 ~= nil then
        var4.current = var1
    end

    local var5 = useSlideOpenCloseAnimation2(var1 ~= nil, MENU_SLIDE_CONFIG, if var1 then var1.player.UserId else nil)

    local isInteractable = var1 ~= nil
    local ref = React.useRef(nil)
    local var7 = React.useRef(nil)
    local contextActionServiceOverride = tbl3.contextActionServiceOverride
    local bool2 = if tbl3.isGamepadOverride ~= nil then tbl3.isGamepadOverride else not not isGamepad()

    React.useEffect(function()
        if not (tbl3.isSmallTouchDevice and isInteractable) then
            return function() end
        end
        local var8 = contextActionServiceOverride or ContextActionService
        var8:BindCoreAction("RbxPlayerListReskinGamepadMenuClose", function(_, userInputState, _)
            if userInputState ~= Enum.UserInputState.Begin then
                return Enum.ContextActionResult.Pass
            end
            PlayerContextualMenuStore.closeContextMenu()
            return Enum.ContextActionResult.Sink
        end, false, Enum.KeyCode.ButtonB)
        return function()
            var8:UnbindCoreAction("RbxPlayerListReskinGamepadMenuClose")
        end
    end, { isInteractable, tbl3.isSmallTouchDevice, contextActionServiceOverride })

    local userInputServiceOverride = tbl3.userInputServiceOverride
    React.useEffect(function()
        if not isInteractable then
            return function() end
        end
        local connection = (userInputServiceOverride or UserInputService).InputBegan:Connect(function(input: InputObject)
            local userInputType = input.UserInputType
            if userInputType ~= Enum.UserInputType.Touch and userInputType ~= Enum.UserInputType.MouseButton1 then
                return
            end
            local current = ref.current
            if current ~= nil and isPositionOnMenu(current, input.Position) then
                return
            end

            if not tbl3.isSmallTouchDevice then
                local anchorRow = PlayerContextualMenuStore.getAnchorRow()
                if anchorRow ~= nil and isPositionOnRow(anchorRow, input.Position) then
                    return
                end
            end
            PlayerContextualMenuStore.closeContextMenu()
        end)
        return function()
            connection:Disconnect()
        end
    end, { isInteractable, userInputServiceOverride, tbl3.isSmallTouchDevice })

    React.useEffect(function()
        if not (tbl3.isSmallTouchDevice and isInteractable and bool2) then
            return function() end
        end
        if var7.current then
            GuiService.SelectedCoreObject = var7.current
        end
        return function() end
    end, { isInteractable, tbl3.isSmallTouchDevice, bool2 })

    local scale = React.useMemo(function()
        if not tbl3.isSmallTouchDevice then
            return nil
        end
        return var5.offset:map(function(num1: number): number
            return 1 + (MENU_ZOOM_CLOSED_SCALE - 1) * num1
        end)
    end, { tbl3.isSmallTouchDevice, var5.offset })

    local var9 = React.useMemo(function()
        if not tbl3.isSmallTouchDevice then
            return nil
        end
        local defaultTransparency = var2.Color.Stroke.Default.Transparency
        return var5.offset:map(function(num1: number): number
            return defaultTransparency + (1 - defaultTransparency) * num1
        end)
    end, { tbl3.isSmallTouchDevice, var5.offset, var2.Color.Stroke.Default.Transparency })

    if not var5.shouldMount then
        return nil
    end
    local current = var4.current
    if current == nil then
        return nil
    end

    local anchorPosition = current.anchorPosition
    local vector2 = Vector2.new(0.5, 0.5)
    local uDim2 = UDim2.fromScale(0.5, 0.5)
    if not tbl3.isSmallTouchDevice and anchorPosition ~= nil then
        vector2 = Vector2.new(1, 0)
        uDim2 = UDim2.fromOffset(anchorPosition.X - 8, anchorPosition.Y)
    end

    local tbl4 = {
        Header = React.createElement(PlayerContextMenuHeader, { header = current.header, player = current.player, layoutOrder = 1 }),
        HeaderDivider = React.createElement(Divider, { LayoutOrder = 2 })
    }

    for i, item in ipairs(current.items) do
        local key = item.key
        local str1 = `Action_{tostring(key)}`
        tbl4[str1] = React.createElement(
            MenuActionRow,
            {
                item = item,
                layoutOrder = 2 + i,
                isInteractable = isInteractable,
                rowRef = if i == 1 then var7 else nil
            }
        )
    end
    local xOffset = Constants.CONTEXT_MENU_WIDTH * var2.Config.UI.Scale
    local tbl5

    if not tbl3.isSmallTouchDevice then
        tbl5 = {
            SlideOffset = React.createElement(View, {
                Position = var5.position,
                Size = UDim2.fromOffset(xOffset, 0),
                tag = "col align-x-left gap-xxsmall auto-y padding-small stroke-standard stroke-default radius-large",
                backgroundStyle = var3
            }, tbl4)
        }
    else
        tbl5 = table.clone(tbl4)
        tbl5.UIScale = React.createElement("UIScale", { Scale = scale })

        tbl5.UIStroke = React.createElement("UIStroke", {
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
            Color = var2.Color.Stroke.Default.Color3,
            Transparency = var9,
            Thickness = var2.Stroke.Standard
        })
    end

    local createElement = React.createElement
    local var10 = View
    local tbl6 = {
        ZIndex = 10,
        tag = "size-full",
        backgroundStyle = backgroundStyle,
        selection = Constants.NOT_SELECTABLE
    }
    local tbl7 = {
        Backdrop = React.createElement(View, {
            tag = "size-full",
            ZIndex = 1,
            backgroundStyle = backgroundStyle,
            onActivated = if tbl3.isSmallTouchDevice and isInteractable then func1 else nil,
            stateLayer = stateLayer,
            selection = Constants.NOT_SELECTABLE
        }),
        Menu = 0
    }

    local createElement2 = React.createElement
    local var11 = View
    local tbl8 = {
        AnchorPoint = vector2,
        Position = uDim2,
        Size = UDim2.fromOffset(xOffset, 0),
        ZIndex = 2,
        Visible = true,
        ref = ref,
        GroupTransparency = if tbl3.isSmallTouchDevice then var5.offset else nil,
        selectionGroup = if tbl3.isSmallTouchDevice and isInteractable then Constants.CONSOLE_FOCUS_ISOLATE else nil,
        selection = Constants.NOT_SELECTABLE,
        tag = {
            ["auto-y clip"] = not tbl3.isSmallTouchDevice,
            ["col align-x-left gap-xxsmall auto-y padding-small radius-large"] = tbl3.isSmallTouchDevice
        },
        backgroundStyle = 0,
        onActivated = 0,
        stateLayer = 0,
        testId = "player-context-menu"
    }
    if not tbl3.isSmallTouchDevice then
        var3 = nil
    end

    tbl8.backgroundStyle = var3
    tbl8.onActivated = if tbl3.isSmallTouchDevice then nil else func1
    tbl8.stateLayer = if tbl3.isSmallTouchDevice then nil else stateLayer
    tbl7.Menu = createElement2(var11, tbl8, tbl5)
    return createElement(var10, tbl6, tbl7)
end)
