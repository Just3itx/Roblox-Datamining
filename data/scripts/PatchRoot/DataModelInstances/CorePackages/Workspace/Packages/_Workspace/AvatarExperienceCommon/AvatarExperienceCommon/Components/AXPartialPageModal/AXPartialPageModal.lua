-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:11:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommonParent = script:FindFirstAncestor("AvatarExperienceCommon").Parent

local React = require(AvatarExperienceCommonParent.React)
local Responsive = require(AvatarExperienceCommonParent.Responsive)
local ModalWindow = require(AvatarExperienceCommonParent.UIBlox).App.Dialog.Modal.ModalWindow
local Foundation = require(AvatarExperienceCommonParent.Foundation)
local Button = Foundation.Button
local View = Foundation.View
local useTokens = Foundation.Hooks.useTokens
local FillBehavior = Foundation.Enums.FillBehavior
local useSelector = require(AvatarExperienceCommonParent.RoactUtils).Hooks.RoactRodux.useSelector
local wrapForReactPortal = require(script.Parent.Parent.Wrappers.wrapForReactPortal)
local useIsSpatial = Responsive.useIsSpatial

local useAXPartialPageModalFocusHandler = require(script.Parent.useAXPartialPageModalFocusHandler)

local AvatarExperienceFlags = require(AvatarExperienceCommonParent.AvatarExperienceFlags)
local bool1 = game:DefineFastFlag("AXPartialPageModalDockedPadding", false)
local FFlagAXFixAvatarScreenVR = AvatarExperienceFlags.FFlagAXFixAvatarScreenVR
local FFlagAXPartialPageModalBackgroundShim = AvatarExperienceFlags.FFlagAXPartialPageModalBackgroundShim

local num1 = game:DefineFastInt("AXCatalogPartialPageModalBottomInsetMultiplier", 25)

local function selectDeviceOrientation(arg1)
    return arg1.DeviceOrientation
end

local function func1(arg1)
    return arg1.ScreenSize
end

local function func2(arg1)
    return arg1.GlobalGuiInset and arg1.GlobalGuiInset.bottom or 0
end

local function AXPartialPageModal(tbl1)
    local var1 = useTokens()
    local var2 = useSelector(func1)
    local medium = var1.Margin.Medium
    local uDim = UDim.new(0, var1.Margin.Medium)
    local var3 = React.useRef(nil)
    local var4 = if FFlagAXFixAvatarScreenVR then React.useRef(nil) else nil
    local var5 = nil
    local var6 = nil

    if FFlagAXFixAvatarScreenVR then
        local var7
        var5, var7 = React.useState(Vector2.new(360, 700))
        var6 = var7
    end

    local var7 = useSelector(func2)
    local var8 = if FFlagAXFixAvatarScreenVR then useIsSpatial() else nil
    local var9 = useAXPartialPageModalFocusHandler(var3)

    if FFlagAXFixAvatarScreenVR then
        React.useLayoutEffect(function()
            if not var8 then
                return
            end

            local current = var4.current
            if current == nil then
                return
            end

            local surfaceGui = current:FindFirstAncestorOfClass("SurfaceGui")
            if surfaceGui == nil then
                return
            end
            local function syncSize() -- Luacid: Inlined by compiler; 1 call site recovered
                var6(surfaceGui.AbsoluteSize)
            end

            syncSize()
            local connection = surfaceGui:GetPropertyChangedSignal("AbsoluteSize"):Connect(syncSize)

            return function()
                connection:Disconnect()
            end
        end, { var8, var9, var6 })
    end

    if FFlagAXFixAvatarScreenVR and var8 then
        var2 = var5
    end
    if bool1 then
        if var2.X < 540 then
            uDim = UDim.new(0, var1.Margin.Large + var7 * num1 / 100)
        end
    elseif useSelector(selectDeviceOrientation) == Responsive.Keys.Portrait then
        uDim = UDim.new(0, var1.Margin.Large + var7 * num1 / 100)
    end

    local position = if tbl1.position then tbl1.position else nil

    local function func3()
        local result = ({})
        if tbl1.buttonStackProps == nil then
            return {}
        end

        local buttons = tbl1.buttonStackProps.buttons

        for i, _ in ipairs(buttons) do
            local props = buttons[i].props
            local createElement = React.createElement
            local var10 = View
            local tbl2 = {
                tag = "row gap-small wrap auto-y size-full-0 fill-x",
                key = props.text or i
            }
            local createElement2 = React.createElement
            local var11 = Button
            local tbl3 = {
                text = props.text,
                variant = props.variant,
                onActivated = props.onActivated,
                LayoutOrder = props.layoutOrder or i,
                fillBehavior = FillBehavior.Fill,
                size = props.size
            }
            result[i] = createElement(var10, tbl2, createElement2(var11, tbl3))
        end

        return result
    end

    local function func4()
        local result = ({})
        if tbl1.buttonStackProps == nil then
            return {}
        end

        local buttons = tbl1.buttonStackProps.buttons

        for i, _ in ipairs(buttons) do
            local props = buttons[i].props
            local createElement = React.createElement
            local var10 = Button
            local tbl2 = {
                text = props.text,
                key = props.text or i,
                variant = props.variant,
                width = UDim.new(1, 0),
                onActivated = props.onActivated,
                LayoutOrder = props.layoutOrder or i,
                fillBehavior = FillBehavior.Fill,
                size = props.size
            }
            result[i] = createElement(var10, tbl2)
        end

        return result
    end

    local var10 = tbl1.visible == nil or tbl1.visible
    local element

    if FFlagAXPartialPageModalBackgroundShim then
        local createElement = React.createElement
        local var11 = ModalWindow
        local tbl2 = {
            isFullHeight = false,
            screenSize = var2,
            position = position,
            anchorPoint = tbl1.anchorPoint
        }
        local tbl3 = { ContentContainer = 0 }
        local createElement2 = React.createElement
        local var12 = View
        local tbl4 = {
            tag = "auto-y col size-full-0 align-x-left padding-x-xxlarge padding-top-xxlarge radius-medium",
            Position = UDim2.new(0, 0, 0, medium),
            backgroundStyle = var1.Color.Surface.Surface_100,
            padding = { bottom = uDim },
            ref = if var9 == nil then var3 else nil,
            selectionGroup = var9 == nil
                and {
                    SelectionBehaviorUp = Enum.SelectionBehavior.Stop,
                    SelectionBehaviorDown = Enum.SelectionBehavior.Stop,
                    SelectionBehaviorLeft = Enum.SelectionBehavior.Stop,
                    SelectionBehaviorRight = Enum.SelectionBehavior.Stop
                }
                or nil
        }

        local tbl5 = {
            Content = React.createElement(View, { tag = "auto-y size-full-0" }, tbl1.children),
            Buttons = tbl1.buttonStackProps
                and React.createElement(View, {
                    tag = {
                        ["col gap-medium auto-y size-full-0 fill-x"] = not tbl1.buttonStackProps.rowLayout,
                        ["row gap-small auto-y size-full-0 fill-x"] = tbl1.buttonStackProps.rowLayout
                    }
                }, if tbl1.buttonStackProps.rowLayout then func4() else func3())
        }
        tbl3.ContentContainer = createElement2(var12, tbl4, tbl5)
        local partialPageModal = createElement(var11, tbl2, tbl3)

        if tbl1.hasBackgroundShim == true then
            local createElement3 = React.createElement
            local str1 = "Frame"
            local tbl6 = {
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Size = UDim2.fromScale(1, 1),
                ZIndex = 5,
                Visible = var10,
                ref = if FFlagAXFixAvatarScreenVR then var4 else nil
            }
            local tbl7 = {
                Scrim = React.createElement("TextButton", {
                    Text = "",
                    AutoButtonColor = false,
                    Selectable = false,
                    Size = UDim2.fromScale(1, 1),
                    BackgroundColor3 = Color3.new(0, 0, 0),
                    BackgroundTransparency = 0.45,
                    BorderSizePixel = 0,
                    ZIndex = 1,
                    [React.Event.Activated] = tbl1.onBackgroundPress
                }),
                SheetLayer = React.createElement(
                    "Frame",
                    {
                        BackgroundTransparency = 1,
                        BorderSizePixel = 0,
                        Size = UDim2.fromScale(1, 1),
                        ZIndex = 2
                    },
                    { PartialPageModal = partialPageModal }
                )
            }
            element = createElement3(str1, tbl6, tbl7)
        else
            element = React.createElement("TextButton", {
                Text = "",
                AutoButtonColor = false,
                Selectable = false,
                Size = UDim2.fromScale(1, 1),
                BackgroundTransparency = 1,
                [React.Event.Activated] = tbl1.onBackgroundPress,
                ZIndex = 5,
                Visible = var10,
                ref = if FFlagAXFixAvatarScreenVR then var4 else nil
            }, { PartialPageModal = partialPageModal })
        end
    else
        local createElement = React.createElement
        local str1 = "TextButton"
        local tbl2 = {
            Text = "",
            AutoButtonColor = false,
            Selectable = false,
            Size = UDim2.fromScale(1, 1),
            BackgroundTransparency = 1,
            [React.Event.Activated] = tbl1.onBackgroundPress,
            ZIndex = 5,
            Visible = var10,
            ref = if FFlagAXFixAvatarScreenVR then var4 else nil
        }
        local tbl3 = { PartialPageModal = 0 }
        local createElement2 = React.createElement
        local var11 = ModalWindow
        local tbl4 = {
            isFullHeight = false,
            screenSize = var2,
            position = position,
            anchorPoint = tbl1.anchorPoint
        }
        local tbl5 = { ContentContainer = 0 }
        local createElement3 = React.createElement
        local var12 = View
        local tbl6 = {
            tag = "auto-y col size-full-0 align-x-left padding-x-xxlarge padding-top-xxlarge radius-medium",
            Position = UDim2.new(0, 0, 0, medium),
            backgroundStyle = var1.Color.Surface.Surface_100,
            padding = { bottom = uDim },
            ref = if var9 == nil then var3 else nil,
            selectionGroup = var9 == nil
                and {
                    SelectionBehaviorUp = Enum.SelectionBehavior.Stop,
                    SelectionBehaviorDown = Enum.SelectionBehavior.Stop,
                    SelectionBehaviorLeft = Enum.SelectionBehavior.Stop,
                    SelectionBehaviorRight = Enum.SelectionBehavior.Stop
                }
                or nil
        }

        local tbl7 = {
            Content = React.createElement(View, { tag = "auto-y size-full-0" }, tbl1.children),
            Buttons = tbl1.buttonStackProps
                and React.createElement(View, {
                    tag = {
                        ["col gap-medium auto-y size-full-0 fill-x"] = not tbl1.buttonStackProps.rowLayout,
                        ["row gap-small auto-y size-full-0 fill-x"] = tbl1.buttonStackProps.rowLayout
                    }
                }, if tbl1.buttonStackProps.rowLayout then func4() else func3())
        }
        tbl5.ContentContainer = createElement3(var12, tbl6, tbl7)
        tbl3.PartialPageModal = createElement2(var11, tbl4, tbl5)
        element = createElement(str1, tbl2, tbl3)
    end

    if var9 ~= nil then
        return wrapForReactPortal(element, var9, var3)
    end

    return element
end

return AXPartialPageModal
