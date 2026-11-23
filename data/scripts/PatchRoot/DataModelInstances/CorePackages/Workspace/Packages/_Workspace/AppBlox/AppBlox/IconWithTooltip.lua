-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T06:21:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local AppBloxParent = script:FindFirstAncestor("AppBlox").Parent
local React = require(AppBloxParent.React)
local UIBlox = require(AppBloxParent.UIBlox)
local Images = UIBlox.App.ImageSet.Images
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local Interactable = UIBlox.Core.Control.Interactable
local withHoverTooltip = UIBlox.App.Dialog.TooltipV2.withHoverTooltip
local ControlState = UIBlox.Core.Control.Enum.ControlState
local useCursor = UIBlox.App.SelectionCursor.useCursor
local useDesignTokens = require(AppBloxParent.Style).useDesignTokens
local useTokens = require(AppBloxParent.Foundation).Hooks.useTokens
local useUiModeInfo = require(AppBloxParent.RobloxAppHooks).useUiModeInfo
local UiMode = require(AppBloxParent.RobloxAppEnums).UiMode

local GetFFlagTenFootUiSupportSortHeaderTooltip = require(AppBloxParent.SharedFlags).GetFFlagTenFootUiSupportSortHeaderTooltip
local FFlagSduiComponentsUseFoundationTokens = require(AppBloxParent.SharedFlags).FFlagSduiComponentsUseFoundationTokens

game:DefineFastInt("TooltipHitboxMinSize", 26)

local bool1 = game:DefineFastFlag("LuaAppGateTooltipPositionTracking", false)

local iconsActionsInfo = Images["icons/actions/info"]
local vector2 = Vector2.new(game:GetFastInt("TooltipHitboxMinSize"), game:GetFastInt("TooltipHitboxMinSize"))

local function IconWithTooltip(tbl1)
    local var1 = useUiModeInfo()
    local var2 = if FFlagSduiComponentsUseFoundationTokens then useTokens() else useDesignTokens()
    local var3 = if bool1 then React.useRef(false) else nil
    local var4 = if bool1 then React.useRef(nil) else nil
    local color3 = var2.Color.Content.Emphasis.Color3
    local size600 = var2.Size.Size_600
    local circle, size0

    if GetFFlagTenFootUiSupportSortHeaderTooltip() then
        circle = var2.Radius.Circle
        size0 = var2.Size.Size_0
    else
        circle = nil
        size0 = nil
    end

    local var5 = if GetFFlagTenFootUiSupportSortHeaderTooltip() then useCursor(UDim.new(0, circle), size0) else nil
    local disabled = var1.uiMode == UiMode.VR

    if var1.uiMode == UiMode.VR and not tbl1.supportVR then
        return nil
    end

    if var1.uiMode == UiMode.TenFoot and not tbl1.supportTenFootUi then
        return nil
    end

    local tbl2 = {
        bodyText = tbl1.hoverText,
        useLargeDropShadow = true
    }

    local tbl3 = {
        preferredOrientation = tbl1.tooltipOrientation,
        guiTarget = CoreGui,
        DisplayOrder = 10,
        delayTime = 0.2,
        triggerPointName = tbl1.triggerPointName,
        disabled = disabled
    }

    local var6 = tbl1.size or UDim2.new(0, size600, 0, size600)
    return withHoverTooltip(tbl2, tbl3, function(callback, callback2)
        local func1, func2

        if bool1 then
            func1 = function(arg1)
                if var3.current then
                    callback(arg1)
                end
            end
            func2 = function(arg1, arg2)
                var3.current = arg2 == ControlState.Hover or arg2 == ControlState.Selected

                if var3.current and var4.current then
                    callback(var4.current)
                end
                callback2(arg1, arg2)
            end
        else
            func2 = callback2
            func1 = callback
        end

        local createElement = React.createElement
        local str1 = "Frame"
        local tbl4 = {
            Size = var6,
            BackgroundTransparency = 1,
            LayoutOrder = tbl1.layoutOrder,
            AnchorPoint = tbl1.anchorPoint,
            Position = tbl1.position,
            ref = if bool1 then var4 else nil,
            SelectionImageObject = if GetFFlagTenFootUiSupportSortHeaderTooltip() then var5 else nil,
            [React.Change.AbsolutePosition] = func1,
            [React.Change.AbsoluteSize] = func1
        }
        local tbl5 = {
            TooltipIcon = React.createElement(ImageSetLabel, {
                Size = var6,
                BackgroundTransparency = 1,
                Image = tbl1.icon or iconsActionsInfo,
                ImageColor3 = tbl1.color or color3,
                ZIndex = 0
            }),
            Hitbox = React.createElement(
                Interactable,
                {
                    Size = UDim2.fromScale(1, 1),
                    BackgroundTransparency = 1,
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    Position = UDim2.fromScale(0.5, 0.5),
                    onStateChanged = func2,
                    [React.Event.Activated] = tbl1.onActivateTooltip,
                    ZIndex = 1,
                    Selectable = tbl1.selectable
                },
                {
                    UISizeConstraint = React.createElement("UISizeConstraint", { MinSize = vector2 })
                }
            )
        }
        return createElement(str1, tbl4, tbl5)
    end)
end

return IconWithTooltip
