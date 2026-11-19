-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:21:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local CoreGui = game:GetService("CoreGui")
local RobloxGui = CoreGui:WaitForChild("RobloxGui")
local Packages = CorePackages.Packages
local useLocalization = require(CorePackages.Workspace.Packages.Localization).Hooks.useLocalization
local React = require(Packages.React)
local RoactUtils = require(CorePackages.Workspace.Packages.RoactUtils)
local useAppPolicy = require(CorePackages.Workspace.Packages.UniversalAppPolicy).useAppPolicy
local useSelector = RoactUtils.Hooks.RoactRodux.useSelector
local LuauPolyfill = require(Packages.LuauPolyfill)
local setTimeout = LuauPolyfill.setTimeout
local clearTimeout = LuauPolyfill.clearTimeout
local _WindowSizeSignal = require(script.Parent.Parent.Parent.Chrome.ChromeShared.Service.WindowSizeSignal)
local useWindowSizeIsLarge = require(script.Parent.Parent.Parent.Chrome.ChromeShared.Hooks.useWindowSizeIsLarge)

local UIBlox = require(Packages.UIBlox)
local Interactable = UIBlox.Core.Control.Interactable
local StyledTextLabel = UIBlox.App.Text.StyledTextLabel
local useStyle = UIBlox.Core.Style.useStyle
local withTooltip = UIBlox.App.Dialog.TooltipV2.withTooltip
local TooltipOrientation = UIBlox.App.Dialog.Enum.TooltipOrientation
local ControlState = UIBlox.Core.Control.Enum.ControlState
local Images = UIBlox.App.ImageSet.Images
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel

local CameraStatusIcon = require(script.Parent.CameraStatusIcon)
local CameraStatusDot = require(script.Parent.CameraStatusDot)
local SizingUtils = require(script.Parent.Parent.Utils.SizingUtils)
local FaceChatUtils = require(script.Parent.Parent.Utils.FaceChatUtils)
local ModelUtils = require(script.Parent.Parent.Utils.ModelUtils)
local useCameraOn = require(script.Parent.Parent.Hooks.useCameraOn)
local useLocalPlayer = require(script.Parent.Parent.Hooks.useLocalPlayer)
local useTrackerMessage = require(script.Parent.Parent.Hooks.useTrackerMessage)
local useTooltipDismissal = require(script.Parent.Parent.Hooks.useTooltipDismissal)
local useScreenSize = require(CoreGui.RobloxGui.Modules.Common.Hooks.useScreenSize)
local Constants = require(script.Parent.Parent.Parent.Chrome.ChromeShared.Unibar.Constants)
local Chrome = script.Parent.Parent.Parent.Chrome
local Service = if require(CorePackages.Workspace.Packages.Chrome).Enabled() then require(Chrome.Service) else nil
local UnibarStyle = require(CorePackages.Workspace.Packages.Chrome).UnibarStyle

local FFlagTokenizeUnibarConstantsWithStyleProvider = require(Chrome.ChromeShared.Flags).FFlagTokenizeUnibarConstantsWithStyleProvider

local FFlagTopBarSignalizeScreenSize = require(CorePackages.Workspace.Packages.CoreGuiCommon).Flags.FFlagTopBarSignalizeScreenSize
local bool1 = game:DefineFastFlag("ReactDevtoolsFixTopbar", true)

local var1 = require(RobloxGui.Modules.SelfView.Analytics).new()

local iconsActionsPreviewShrink = Images["icons/actions/previewShrink"]
local iconsActionsPreviewExpand = Images["icons/actions/previewExpand"]

local FaceClone = require(script.Parent.FaceClone)

local function Window(tbl1)
    local id = tbl1.id
    local var2 = useStyle()

    local theme = var2.Theme
    local font = var2.Font
    local closeButtonFrame = if FFlagTokenizeUnibarConstantsWithStyleProvider then UnibarStyle.use().CLOSE_BUTTON_FRAME else Constants.CLOSE_BUTTON_FRAME

    local var3 = useAppPolicy(function(arg1)
        return arg1.getShowUpdatedCameraPath()
    end)

    local var4 = useLocalization({
        robloxPermissionErrorHeader = "CoreScripts.TopBar.RobloxPermissionErrorHeader",
        robloxPermissionErrorBody = if var3 then "CoreScripts.TopBar.RobloxPermissionErrorBodyTwo" else "CoreScripts.TopBar.RobloxPermissionErrorBody",
        dynamicAvatarMissingErrorHeader = "CoreScripts.TopBar.DynamicAvatarMissingErrorHeader",
        dynamicAvatarMissingErrorBody = "CoreScripts.TopBar.DynamicAvatarMissingErrorBody"
    })

    local var5 = useCameraOn()
    local var6 = useTrackerMessage()

    local var7 = useWindowSizeIsLarge(tbl1.windowSize)

    local var8 = useScreenSize()

    local var9 = if FFlagTopBarSignalizeScreenSize then SizingUtils.getSize(var8, var7) else useSelector(function(arg1)
        return SizingUtils.getSize(arg1.displayOptions.screenSize, var7)
    end)
    React.useEffect(function()
        tbl1.windowSize:requestSize(var9.X, var9.Y)
    end, { var9 })

    local var10 = useLocalPlayer()

    local var11 = React.useMemo(function()
        return FaceChatUtils.getPermissions().userCamEligible and FaceChatUtils.getPermissions().placeCamEnabled
    end)

    local headerText, bodyText, active, var15 = useTooltipDismissal(2000)

    local var16, var17 = React.useState(true)
    local var18, var19 = React.useState(false)
    local var20, var21 = React.useState(false)
    local var22, var23 = React.useState(false)
    local var24 = React.useRef(nil)
    local function func1() -- Luacid: Inlined by compiler; 3 call sites recovered
        if var24.current then
            clearTimeout(var24.current)
        end
        var17(true)
        var24.current = setTimeout(function()
            var17(false)
        end, 2000)
    end
    React.useEffect(function()
        func1()

        return function()
            if var24.current then
                clearTimeout(var24.current)
            end
        end
    end, { var24 })

    local function func2(bool2: boolean)
        func1()

        if not (FaceChatUtils.getPermissions().userCamEnabled or bool2) then
            var15(var4.robloxPermissionErrorHeader, var4.robloxPermissionErrorBody)
            return
        end

        if var10.Character and not (ModelUtils.hasDynamicHead(var10.Character) or FaceChatUtils.isCameraOn() or bool2) then
            var15(var4.dynamicAvatarMissingErrorHeader, var4.dynamicAvatarMissingErrorBody)
        end

        var1:setLastCtx("SelfView")
        FaceChatUtils.toggleVideoAnimation()
    end

    local var25 = React.useCallback(function()
        func2(false)
    end, {
        FaceChatUtils,
        ModelUtils,
        var4,
        var10
    })
    local var26 = React.useCallback(function()
        func1()
    end, { func1, var16, tbl1.windowSize })

    local ref = React.useRef(nil)
    React.useEffect(function()
        if _G.__TESTEZ_RUNNING_TEST__ then
            return
        end

        local var28 = FaceClone(var10, ref.current)

        return function()
            if var28 then
                var28()
            end
        end
    end, { var10, ref })

    local onStateChanged = React.useCallback(function(_, hover)
        var21(hover == ControlState.Hover)
    end, { var21 })

    local var12 = React.useCallback(function(_, hover)
        var19(hover == ControlState.Hover)
    end, { var19 })

    local var13 = React.useCallback(function(_, hover)
        var23(hover == ControlState.Hover)
    end, { var23 })

    local var31 = React.useCallback(function(arg1)
        return React.createElement(Interactable, {
            Size = UDim2.fromOffset(36, 36),
            BackgroundColor3 = if var20 and FaceChatUtils.getPermissions().userCamEnabled then var2.Theme.BackgroundOnHover.Color else var2.Theme.BackgroundUIContrast.Color,
            BackgroundTransparency = var2.Theme.Overlay.Transparency,
            onStateChanged = onStateChanged,
            Position = UDim2.fromScale(0.5, 0.5),
            AnchorPoint = Vector2.new(0.5, 0.5),
            [React.Change.AbsoluteSize] = arg1,
            [React.Change.AbsolutePosition] = arg1,
            [React.Event.Activated] = var25
        }, {
            Corner = React.createElement("UICorner", { CornerRadius = UDim.new(1, 0) }),
            CameraStatusIcon = React.createElement(
                CameraStatusIcon,
                {
                    iconSize = UDim2.fromOffset(28, 28),
                    transparency = if FaceChatUtils.getPermissions().userCamEnabled then 0 else 0.5
                }
            )
        })
    end, { onStateChanged, var25 })

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {
        Name = "SelfieViewFrame",
        Active = true,
        Size = UDim2.fromScale(1, 1),
        BackgroundColor3 = var2.Theme.BackgroundUIDefault.Color,
        BackgroundTransparency = 0,
        [React.Event.MouseEnter] = func1,
        [React.Event.MouseMoved] = func1,
        ref = ref
    }
    local tbl3 = {}
    local tbl4 = {
        CloseButtonWrapper = 0,
        ExpandButtonWrapper = 0,
        Corners = 0,
        ControlMessage = 0,
        IconFrame = 0,
        CameraStatusDot = 0,
        Interactable = 0
    }
    local var32

    if var16 then
        local createElement2 = React.createElement
        local str2 = "Frame"
        local tbl5 = { ZIndex = 2, BackgroundTransparency = 1, Size = closeButtonFrame }
        local tbl6 = {
            CloseButtonLayout = React.createElement("UIListLayout", {
                FillDirection = Enum.FillDirection.Horizontal,
                SortOrder = Enum.SortOrder.LayoutOrder,
                VerticalAlignment = Enum.VerticalAlignment.Center,
                HorizontalAlignment = Enum.HorizontalAlignment.Center
            }),
            CloseButtonInteractable = 0
        }
        local createElement3 = React.createElement
        local var33 = Interactable

        local tbl7 = {
            Size = UDim2.fromOffset(36, 36),
            BackgroundColor3 = if var18 then var2.Theme.BackgroundOnHover.Color else var2.Theme.BackgroundUIContrast.Color,
            BackgroundTransparency = 0.8,
            onStateChanged = var12,
            [React.Event.Activated] = Service and function()
                Service:toggleWindow(id)
            end or nil
        }

        tbl6.CloseButtonInteractable = createElement3(var33, tbl7, {
            Corner = React.createElement("UICorner", { CornerRadius = UDim.new(1, 0) }),
            Fragment = React.createElement(React.Fragment, nil, { React.createElement(
                    "Frame",
                    {
                        Name = "X1",
                        Position = UDim2.new(0.5, 0, 0.5, 0),
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        Size = UDim2.new(0, 16, 0, 2),
                        BorderSizePixel = 0,
                        BackgroundColor3 = var2.Theme.IconEmphasis.Color,
                        BackgroundTransparency = 0,
                        Rotation = 45
                    },
                    {
                        Corner = React.createElement("UICorner", { CornerRadius = UDim.new(1, 0) })
                    }
                ), (React.createElement("Frame", {
                    Name = "X2",
                    Position = UDim2.new(0.5, 0, 0.5, 0),
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    Size = UDim2.new(0, 16, 0, 2),
                    BorderSizePixel = 0,
                    BackgroundColor3 = var2.Theme.IconEmphasis.Color,
                    BackgroundTransparency = 0,
                    Rotation = -45
                }, {
                    Corner = React.createElement("UICorner", { CornerRadius = UDim.new(1, 0) })
                })) })
        })
        var32 = createElement2(str2, tbl5, tbl6)
    else
        var32 = var16
    end

    tbl4.CloseButtonWrapper = var32
    local var33

    if var16 then
        local createElement2 = React.createElement
        local str2 = "Frame"
        local tbl5 = {
            ZIndex = 2,
            BackgroundTransparency = 1,
            Size = closeButtonFrame,
            AnchorPoint = Vector2.new(1, 0),
            Position = UDim2.new(1, 0, 0, 0)
        }
        local tbl6 = {
            ExpandButtonLayout = React.createElement("UIListLayout", {
                FillDirection = Enum.FillDirection.Horizontal,
                SortOrder = Enum.SortOrder.LayoutOrder,
                VerticalAlignment = Enum.VerticalAlignment.Center,
                HorizontalAlignment = Enum.HorizontalAlignment.Center
            }),
            ExpandButtonPadding = React.createElement("UIPadding", {
                PaddingTop = UDim.new(0, 4),
                PaddingLeft = UDim.new(0, 4),
                PaddingRight = UDim.new(0, 4),
                PaddingBottom = UDim.new(0, 4)
            }),
            ExpandButtonInteractable = 0
        }
        local createElement3 = React.createElement
        local var34 = Interactable

        local tbl7 = {
            Size = UDim2.fromOffset(36, 36),
            BackgroundColor3 = if var22 then var2.Theme.BackgroundOnHover.Color else var2.Theme.BackgroundUIContrast.Color,
            BackgroundTransparency = 0.8,
            onStateChanged = var13,
            [React.Event.Activated] = Service and function()
                tbl1.windowSize:toggleIsLarge()
            end or nil
        }

        local tbl8 = {
            Corner = React.createElement("UICorner", { CornerRadius = UDim.new(1, 0) }),
            ExpandImage = React.createElement(ImageSetLabel, {
                AnchorPoint = Vector2.new(0.5, 0.5),
                BackgroundTransparency = 1,
                Size = UDim2.fromOffset(28, 28),
                Position = UDim2.new(0.5, 0, 0.5, 0),
                Image = if var7 then iconsActionsPreviewShrink else iconsActionsPreviewExpand,
                ImageColor3 = theme.TextEmphasis.Color,
                ImageTransparency = theme.TextEmphasis.Transparency
            })
        }
        tbl6.ExpandButtonInteractable = createElement3(var34, tbl7, tbl8)
        var33 = createElement2(str2, tbl5, tbl6)
    else
        var33 = nil
    end

    tbl4.ExpandButtonWrapper = var33

    tbl4.Corners = React.createElement("UICorner", { CornerRadius = UDim.new(0, 8) })

    tbl4.ControlMessage = React.createElement("Frame", {
        AnchorPoint = Vector2.new(0.5, 1),
        Position = UDim2.new(0.5, 0, 1, -44),
        BackgroundColor3 = theme.BackgroundUIDefault.Color,
        AutomaticSize = Enum.AutomaticSize.XY,
        ZIndex = 2,
        BorderSizePixel = 0,
        Visible = var6.visible
    }, {
        Corners = React.createElement("UICorner", {}),
        UIPadding = React.createElement("UIPadding", {
            PaddingTop = UDim.new(0, 4),
            PaddingRight = UDim.new(0, 8),
            PaddingBottom = UDim.new(0, 4),
            PaddingLeft = UDim.new(0, 8)
        }),
        UIListLayout = React.createElement("UIListLayout", { FillDirection = Enum.FillDirection.Vertical }),
        Line1 = React.createElement(StyledTextLabel, {
            text = var6.text,
            fontStyle = font.Footer,
            colorStyle = theme.TextDefault,
            textXAlignment = Enum.TextXAlignment.Center,
            layoutOrder = 1,
            size = UDim2.fromOffset(46, 36),
            TextWrapped = not bool1 or nil,
            textWrapped = if bool1 then true else nil
        }),
        Line2 = React.createElement(StyledTextLabel, {
            text = var6.status,
            fontStyle = font.Footer,
            colorStyle = theme.ContextualPrimaryContent,
            textXAlignment = Enum.TextXAlignment.Center,
            layoutOrder = 2,
            size = UDim2.fromOffset(46, 12),
            automaticSize = Enum.AutomaticSize.Y
        })
    })
    local element

    if var16 and var11 then
        element = React.createElement("Frame", {
            BackgroundTransparency = 1,
            Size = closeButtonFrame,
            Position = UDim2.fromScale(0.5, 1),
            AnchorPoint = Vector2.new(0.5, 1),
            ZIndex = 2
        }, {
            Tooltip = withTooltip(
                {
                    headerText = headerText,
                    bodyText = bodyText,
                    textXAlignment = Enum.TextXAlignment.Left
                },
                {
                    guiTarget = CoreGui,
                    active = active,
                    DisplayOrder = 101,
                    preferredOrientation = TooltipOrientation.Bottom
                },
                var31
            ),
            Hover = React.createElement("Frame", {
                Size = UDim2.fromOffset(32, 32),
                AnchorPoint = Vector2.new(0.5, 0.5),
                Position = UDim2.fromScale(0.5, 0.5),
                BackgroundTransparency = var2.Theme.BackgroundOnHover.Transparency,
                BackgroundColor3 = var2.Theme.BackgroundOnHover.Color
            }, {
                Corner = React.createElement("UICorner", { CornerRadius = UDim.new(0, 8) })
            })
        })
            or nil
    else
        element = nil
    end

    tbl4.IconFrame = element

    tbl4.CameraStatusDot = if var5 then React.createElement(
        CameraStatusDot,
        {
            Position = UDim2.new(1, -12, 1, -12),
            ZIndex = 2,
            Size = UDim2.fromOffset(8, 8)
        }
    ) else nil

    tbl4.Interactable = React.createElement(
        Interactable,
        {
            Size = UDim2.fromScale(1, 1),
            BackgroundTransparency = 1,
            [React.Event.Activated] = var26
        }
    )
    return createElement(str1, tbl2, tbl3, tbl4)
end

return Window
