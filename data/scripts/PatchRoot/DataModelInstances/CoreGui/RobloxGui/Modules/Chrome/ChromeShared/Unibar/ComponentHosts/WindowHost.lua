-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:31:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChromeShared = script:FindFirstAncestor("ChromeShared")

local CorePackages = game:GetService("CorePackages")
local React = require(CorePackages.Packages.React)
local ReactRoblox = require(CorePackages.Packages.ReactRoblox)
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local VRService = game:GetService("VRService")

local ReactOtter = require(CorePackages.Packages.ReactOtter)
local Signals = require(CorePackages.Packages.Signals)
local getUIScale = require(CorePackages.Workspace.Packages.Display).GetDisplayStore(false).getUIScale

local UIBlox = require(CorePackages.Packages.UIBlox)
local Foundation = require(CorePackages.Packages.Foundation)
local Interactable = UIBlox.Core.Control.Interactable
local useStyleSheet = Foundation.Hooks.useStyleSheet

local MouseIconOverrideService = require(CorePackages.Workspace.Packages.CoreScriptsCommon).MouseIconOverrideService
local var1 = require(CorePackages.Workspace.Packages.AppCommonLib).Symbol.named("SelfieViewCursorOverride")

local debounce = require(ChromeShared.Utility.debounce)
local Service = require(ChromeShared.Service)
local Constants = require(ChromeShared.Unibar.Constants)
local _Chrome = require(CorePackages.Workspace.Packages.Chrome)
local ChromeAnalytics = require(ChromeShared.Analytics.ChromeAnalytics)
local shouldRejectMultiTouch = require(ChromeShared.Utility.shouldRejectMultiTouch)

local SettingsShowSignal = require(CorePackages.Workspace.Packages.CoreScriptsCommon).SettingsShowSignal
local CoreGuiCommon = require(CorePackages.Workspace.Packages.CoreGuiCommon)
local FFlagTopBarSignalizeMenuOpen = CoreGuiCommon.Flags.FFlagTopBarSignalizeMenuOpen

local useSelector = require(CorePackages.Workspace.Packages.RoactUtils).Hooks.RoactRodux.useSelector

local num1 = game:DefineFastInt("ChromeWindowLayoutOrder", 2)

local bool1 = game:DefineFastFlag("FixWindowDragError", false)
local bool2 = game:DefineFastFlag("FixWindowDragStaleConnection", false)

local FFlagTokenizeUnibarConstantsWithStyleProvider = require(ChromeShared.Flags).FFlagTokenizeUnibarConstantsWithStyleProvider

local useWindowSize = require(ChromeShared.Hooks.useWindowSize)

local tbl1 = { dampingRatio = 1, frequency = 3 }

local bool3 = false

return function(tbl2)
    local var2 = useWindowSize(tbl2.integration.integration)
    local ref = React.useRef(nil)
    local var4 = React.useRef(nil)
    local var5, var6 = React.useBinding(false)
    local num2 = 0
    local var7 = React.useMemo(function()
        return nil
    end, {})

    local var8, var9 = React.useBinding(false)
    local var10, var11 = React.useBinding(false)

    local var12 = if FFlagTopBarSignalizeMenuOpen then React.joinBindings({ var8, var10 }):map(function<T>(tbl3: {T}): T
        return tbl3[1] or tbl3[2]
    end) else nil

    local var13 = if FFlagTopBarSignalizeMenuOpen then nil else useSelector(function(arg1)
        return arg1.displayOptions.menuOpen or arg1.displayOptions.inspectMenuOpen
    end)

    local var14, var15 = React.useBinding(false)

    local var16, var17 = ReactOtter.useAnimatedBinding(var2.X.Offset)
    local var18, var19 = ReactOtter.useAnimatedBinding(var2.Y.Offset)

    local var20 = React.useCallback(function()
        return Vector2.new(var16:getValue(), var18:getValue()) * (tbl2.integration.integration.windowAnchorPoint or Vector2.zero)
    end, { var16, var18, tbl2.integration })

    React.useEffect(function()
        if var16:getValue() == 0 then
            var17((ReactOtter.instant(var2.X.Offset)))
            return
        end
        var17(ReactOtter.spring(var2.X.Offset, tbl1))
    end, { var2.X.Offset })

    React.useEffect(function()
        if var18:getValue() == 0 then
            var19((ReactOtter.instant(var2.Y.Offset)))
            return
        end
        var19(ReactOtter.spring(var2.Y.Offset, tbl1))
    end, { var2.Y.Offset })

    if FFlagTopBarSignalizeMenuOpen then
        React.useEffect(function()
            local effect = Signals.createEffect(function(arg1)
                local var21 = CoreGuiCommon.Stores.GetInspectAndBuyStore(arg1).getInspectAndBuyOpen(arg1)
                var11(var21)
            end)

            SettingsShowSignal:connect(function(arg1)
                var9(arg1)
            end)

            return function()
                effect()
            end
        end, {})
    end

    React.useEffect(function()
        local connection = nil
        local inputObject = nil
        local var21 = Service:dragConnection(tbl2.integration.id)

        if var21 then
            connection = var21.connection
            inputObject = var21.inputObject
        end
        assert(ref.current ~= nil)
        assert(ref.current.Parent ~= nil)

        local current = ref.current
        local absoluteSize = ref.current:FindFirstAncestorWhichIsA("ScreenGui").AbsoluteSize

        if connection == nil then
            local var22

            if FFlagTokenizeUnibarConstantsWithStyleProvider and tbl2.position then
                local uIScale = getUIScale(false)
                local xOffset = uIScale * tbl2.position.X.Offset
                local yOffset = uIScale * tbl2.position.Y.Offset

                var22 = UDim2.new(tbl2.position.X.Scale, xOffset, tbl2.position.Y.Scale, yOffset)
            else
                var22 = tbl2.position or UDim2.new()
            end
            if tbl2.integration.integration.cachePosition then
                local var23 = Service:windowPosition(tbl2.integration.id) or UDim2.new()
                local num3 = if var23.X.Scale ~= 1 then 0 else absoluteSize.X
                current.Position = UDim2.new(0, num3 + var23.X.Offset, 0, var23.Y.Offset)
            else
                local num3 = if var22.X.Scale ~= 1 then 0 else absoluteSize.X
                current.Position = UDim2.new(0, num3 + var22.X.Offset, 0, var22.Y.Offset)
            end

            return
        end

        var4 = connection
        var6(true)

        if not var4 then
            return
        end

        var17((ReactOtter.instant(Constants.WINDOW_ICON_SIZE)))
        var19((ReactOtter.instant(Constants.WINDOW_ICON_SIZE)))

        task.defer(var17, ReactOtter.spring(var2.X.Offset, tbl1))
        task.defer(var19, ReactOtter.spring(var2.Y.Offset, tbl1))

        local vec3 = Vector3.new(ref.current.AbsolutePosition.X, ref.current.AbsolutePosition.Y, 0)

        ChromeAnalytics.default:setWindowDefaultPosition(tbl2.integration.id, Vector2.new(vec3.X, vec3.Y))

        var4.current = UserInputService.InputChanged:Connect(function(input: InputObject, _: boolean)
            local inputPosition = input.Position

            if shouldRejectMultiTouch(inputObject, input) then
                return
            end

            local var22 = inputPosition - vec3
            local tbl3 = {
                X = math.clamp((var22 + vec3).X, 0, absoluteSize.X),
                Y = math.clamp((var22 + vec3).Y, 0, absoluteSize.Y)
            }

            current.Position = UDim2.fromOffset(tbl3.X, tbl3.Y)
        end)
    end, {})

    local var21 = React.useCallback(function(uDim2: UDim2)
        if tbl2.integration.integration.cachePosition then
            Service:updateWindowPosition(tbl2.integration.id, uDim2)
        end
    end, { tbl2.integration })

    local var22 = React.useCallback(function()
        if not VRService.VREnabled then
            bool3 = true
            MouseIconOverrideService.push(var1, Enum.OverrideMouseIconBehavior.ForceShow)
        end
    end)

    local var23 = React.useCallback(function()
        if bool3 then
            bool3 = false
            MouseIconOverrideService.pop(var1)
        end
    end)

    local var24 = React.useCallback(function(_, arg1)
        assert(ref.current ~= nil)
        assert(ref.current.Parent ~= nil)

        local current = ref.current
        local absoluteSize = ref.current:FindFirstAncestorWhichIsA("ScreenGui").AbsoluteSize

        local var24 = var20()

        local position = arg1.Position
        local vec3 = Vector3.new(ref.current.AbsolutePosition.X + var24.X, ref.current.AbsolutePosition.Y + var24.Y, 0)

        if arg1.UserInputType ~= Enum.UserInputType.MouseButton1 and arg1.UserInputType ~= Enum.UserInputType.Touch then
            return
        end
        ChromeAnalytics.default:onWindowTouchBegan(
            tbl2.integration.id,
            Vector2.new(ref.current.AbsolutePosition.X, ref.current.AbsolutePosition.Y)
        )

        if bool2 and var4.current then
            var4.current:Disconnect()
            var4.current = nil
            var6(false)
        end

        if not bool2 and var4.current or var14:getValue() then
            return
        end

        local tbl3 = { X = 0, Y = 0 }

        local x = vec3.X
        local num3 = 0
        local var25 = if bool1 then math.max(0, absoluteSize.X - (var16:getValue() - var24.X)) else absoluteSize.X - (var16:getValue() - var24.X)
        tbl3.X = math.clamp(x, num3, var25)

        local y = vec3.Y
        local num4 = 0
        local var26 = if bool1 then math.max(0, absoluteSize.Y - (var18:getValue() - var24.Y)) else absoluteSize.Y - (var18:getValue() - var24.Y)
        tbl3.Y = math.clamp(y, num4, var26)

        current.Position = UDim2.fromOffset(tbl3.X, tbl3.Y)
        var4.current = UserInputService.InputChanged:Connect(function(input: InputObject, _: boolean)
            if shouldRejectMultiTouch(arg1, input) then
                return
            end

            local inputPosition = input.Position
            local var27 = inputPosition - position

            num2 = if bool2 then var27.Magnitude else num2 + var27.Magnitude

            if not (num2 > Constants.WINDOW_MIN_DRAG_DISTANCE) then
                return
            end

            var6(true)

            local tbl4 = { X = 0, Y = 0 }

            local x2 = (var27 + vec3).X
            local x3 = var24.X
            local var28 = if bool1 then math.max(var24.X, absoluteSize.X - (var16:getValue() - var24.X)) else absoluteSize.X - (var16:getValue() - var24.X)
            tbl4.X = math.clamp(x2, x3, var28)

            local y2 = (var27 + vec3).Y
            local y3 = var24.Y
            local var29 = if bool1 then math.max(var24.Y, absoluteSize.Y - (var18:getValue() - var24.Y)) else absoluteSize.Y - (var18:getValue() - var24.Y)
            tbl4.Y = math.clamp(y2, y3, var29)

            current.Position = UDim2.fromOffset(tbl4.X, tbl4.Y)
            ChromeAnalytics.default:onWindowDrag(tbl2.integration.id, inputPosition)
        end)
    end, { var20 })

    local function func1(current): boolean
        local currentParent = current.Parent

        local offset = current.Position.X.Offset
        local offset2 = current.Position.Y.Offset

        local var25 = var20()

        local absoluteSize = currentParent.AbsoluteSize

        return offset < var25.X
            or absoluteSize.X - (var16:getValue() - var25.X) < offset
            or offset2 < var25.Y
            or absoluteSize.Y - (var18:getValue() - var25.Y) < offset2
    end

    local var25 = React.useCallback(function(bool4: boolean?)
        if ref == nil or ref.current == nil then
            return
        end
        assert(ref.current ~= nil)
        assert(ref.current.Parent ~= nil)

        local current = ref.current

        local offset = current.Position.X.Offset
        local offset2 = current.Position.Y.Offset

        if var7 and var7.PlaybackState == Enum.PlaybackState.Playing then
            var7:Cancel()
        end

        if not func1(current) then
            var21(UDim2.new(0, offset, 0, offset2))

            return
        end

        if current == nil then
            return
        end

        local currentParent = ref.current.Parent

        local var25 = var20()

        local absoluteSize = currentParent.AbsoluteSize

        local yOffset = 0
        local xOffset = if absoluteSize.X > var16:getValue() then math.clamp(offset, var25.X, absoluteSize.X - (var16:getValue() - var25.X)) else 0

        if absoluteSize.Y > var18:getValue() then
            yOffset = math.clamp(offset2, var25.Y, absoluteSize.Y - (var18:getValue() - var25.Y))
        end

        local uDim2 = UDim2.new(0, xOffset, 0, yOffset)

        var21(uDim2)
        if bool4 then
            current.Position = uDim2
            return
        end

        var15(true)

        local tweenInfo = TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
        var7 = TweenService:Create(current, tweenInfo, { Position = uDim2 })
        assert(var7 ~= nil)
        var7.Completed:Connect(function(_playbackState: Enum.PlaybackState)
            var15(false)
            var7 = nil
        end)
        var7:Play()
    end, { var20 })

    local var26 = React.useCallback(function(_, arg1)
        num2 = 0

        if arg1.UserInputType ~= Enum.UserInputType.MouseButton1 and arg1.UserInputType ~= Enum.UserInputType.Touch then
            return
        end
        if ref.current then
            ChromeAnalytics.default:onWindowTouchEnded(
                tbl2.integration.id,
                Vector2.new(ref.current.AbsolutePosition.X, ref.current.AbsolutePosition.Y),
                (func1(ref.current))
            )
        end

        if not var4.current then
            return
        end

        var4.current:Disconnect()
        var4.current = nil
        var6(false)
        Service:gesture(tbl2.integration.id, nil)
        var25()
    end, {})

    local num3 = num1

    local styleSheet = useStyleSheet()

    local createPortal = ReactRoblox.createPortal
    local tbl3 = { Name = 0 }
    local createElement = React.createElement
    local str1 = "ScreenGui"

    local tbl4 = {
        Name = Constants.WINDOW_HOST_GUI_NAME .. ":" .. tbl2.integration.id,
        [React.Change.AbsoluteSize] = debounce(function()
            var25()
        end, 0.2),
        DisplayOrder = if FFlagTopBarSignalizeMenuOpen and var12 then var12:map(function(arg1): number
            return if arg1 then -1 else num3
        end) elseif var13 then -1 else num3,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    }

    local tbl5 = { WindowFrame = 0, FoundationStyleLink = 0 }
    local createElement2 = React.createElement
    local str2 = "Frame"

    local tbl6 = {
        Size = React.joinBindings({ var16, var18 }):map(function(tbl6: {number}): UDim2
            var25(true)
            return UDim2.fromOffset(tbl6[1], tbl6[2])
        end),
        LayoutOrder = 1,
        ref = ref,
        BorderSizePixel = 0,
        AnchorPoint = if tbl2.integration.integration.windowAnchorPoint then tbl2.integration.integration.windowAnchorPoint else nil,
        BackgroundTransparency = 1
    }

    local tbl7 = { WindowWrapper = 0 }
    local createElement3 = React.createElement
    local tbl8 = {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        BorderSizePixel = 0
    }

    local tbl9 = {
        Integration = tbl2.integration.component(tbl2) or nil,
        InputShield = React.createElement(
            Interactable,
            {
                ZIndex = 3,
                Size = UDim2.fromScale(1, 1),
                BackgroundTransparency = 1,
                Visible = var5
            }
        ),
        InputWrapper = React.createElement("Frame", {
            ZIndex = 4,
            Size = UDim2.fromScale(1, 1),
            BackgroundTransparency = 1,
            [React.Event.InputBegan] = var24,
            [React.Event.InputEnded] = var26,
            [React.Event.MouseEnter] = var22,
            [React.Event.MouseLeave] = var23,
            [React.Event.Destroying] = var23
        })
    }
    tbl7.WindowWrapper = createElement3("Frame", tbl8, tbl9)
    tbl5.WindowFrame = createElement2(str2, tbl6, tbl7)

    tbl5.FoundationStyleLink = React.createElement("StyleLink", { StyleSheet = styleSheet })
    tbl3.Name = createElement(str1, tbl4, tbl5)
    return createPortal(tbl3, CoreGui)
end
