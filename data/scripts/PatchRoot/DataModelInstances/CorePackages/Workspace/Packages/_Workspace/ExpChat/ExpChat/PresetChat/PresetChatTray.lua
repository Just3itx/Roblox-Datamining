-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:11:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GuiService = game:GetService("GuiService")
local UserInputService = game:GetService("UserInputService")

local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent
local Foundation = require(ExpChatParent.Foundation)
local React = require(ExpChatParent.React)
local Otter = require(ExpChatParent.Otter)
local SignalsReact = require(ExpChatParent.SignalsReact)

local FFlagExpChatPresetTrayDismissAnalytics = require(ExpChat.Flags.FFlagExpChatPresetTrayDismissAnalytics)
local Config = require(ExpChat.Config)
local GetPresetChatStore = require(ExpChat.Stores.GetPresetChatStore)
local PresetChatContainer = require(script.Parent.PresetChatContainer)
local useAutoTrayHeight = require(script.Parent.useAutoTrayHeight)
local setIsPresetTrayOpen = require(script.Parent.Thunks.setIsPresetTrayOpen)
local CompactWidthThreshold = Config.PresetTray.CompactWidthThreshold
local SlideSpring = Config.PresetTray.SlideSpring

local function isCompactMode(): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    local currentCamera = workspace.CurrentCamera
    return if currentCamera then currentCamera.ViewportSize.X < CompactWidthThreshold else false
end

return React.memo(function(tbl1) -- name: PresetChatTray
    local presetChatStore = GetPresetChatStore(false)
    local var1 = SignalsReact.useSignalState(presetChatStore.getIsTrayOpen)
    local compact = isCompactMode()
    local var2 = Foundation.Hooks.useTokens()

    local yOffset, var3 = useAutoTrayHeight()

    local var4, var5 = React.useState(false)
    local var6, var7 = React.useBinding(1)
    local var8 = React.useRef(nil)
    local var9, var10 = React.useState(0)
    local var11, var12 = React.useState(0)
    local var13, var14 = React.useState(GuiService.TopbarInset.Height)
    local var15 = var9 - var11 - var13
    local yOffset2 = yOffset + math.max(0, var15)

    React.useEffect(function()
        local connection = GuiService:GetPropertyChangedSignal("TopbarInset"):Connect(function()
            var14(GuiService.TopbarInset.Height)
        end)
        return function()
            connection:Disconnect()
        end
    end, {})

    local var16, var17 = React.useState(false)

    local var18 = React.useCallback(function(arg1)
        var10(arg1.AbsoluteSize.Y)
        var17(arg1.AbsoluteSize.Y > arg1.AbsoluteSize.X)
    end, {})

    local var19 = React.useCallback(function(arg1)
        var12(arg1.AbsoluteSize.Y)
        var3(arg1)
    end, { var3 })

    local var20 = React.useCallback(function()
        setIsPresetTrayOpen(presetChatStore, false)
    end, { presetChatStore })

    React.useEffect(function()
        if not var1 then
            if var8.current then
                var8.current:setGoal(Otter.spring(1, SlideSpring))
                var8.current:onComplete(function()
                    var5(false)
                end)
            end

            return
        end

        var5(true)
        if var8.current then
            var8.current:destroy()
        end
        local current = Otter.createSingleMotor(1)
        var8.current = current
        current:onStep(function(arg1)
            var7(arg1)
        end)
        current:setGoal(Otter.spring(0, SlideSpring))
    end, { var1 })

    React.useEffect(function()
        return function()
            if var8.current then
                var8.current:destroy()
                var8.current = nil
            end
        end
    end, {})

    React.useEffect(function()
        if not var1 then
            return
        end

        local connection = UserInputService.InputBegan:Connect(function(input: InputObject, _: boolean)
            if input.KeyCode == Enum.KeyCode.Escape or input.KeyCode == Enum.KeyCode.ButtonB then
                setIsPresetTrayOpen(presetChatStore, false)
            end
        end)

        local connection2 = GuiService.MenuOpened:Connect(function()
            if FFlagExpChatPresetTrayDismissAnalytics then
                setIsPresetTrayOpen(presetChatStore, false)
                return
            end
            presetChatStore.setIsTrayOpen(false)
        end)

        return function()
            connection:Disconnect()
            connection2:Disconnect()
        end
    end, { var1, presetChatStore, setIsPresetTrayOpen })

    if not var4 then
        return nil
    end

    local createElement = React.createElement
    local fragment = React.Fragment
    local var21 = nil
    local tbl2 = { OuterScreenGui = 0, InnerScreenGui = 0 }
    local createElement2 = React.createElement
    local str1 = "ScreenGui"
    local tbl3 = {
        DisplayOrder = 9,
        ScreenInsets = Enum.ScreenInsets.None,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    }

    local tbl4 = {
        SizeTracker = React.createElement(
            "Frame",
            {
                Size = UDim2.fromScale(1, 1),
                BackgroundTransparency = 1,
                [React.Change.AbsoluteSize] = var18
            }
        ),
        FullFrame = if var16 then nil else React.createElement(Foundation.View, {
            AnchorPoint = Vector2.new(0, 1),
            Position = var6:map(function(arg1)
                return UDim2.new(0, 0, 1, math.round(arg1 * yOffset2))
            end),
            Size = UDim2.new(1, 0, 0, yOffset2),
            tag = "bg-surface-200"
        })
    }

    tbl2.OuterScreenGui = createElement2(str1, tbl3, tbl4)

    local createElement3 = React.createElement
    local tbl5 = {
        DisplayOrder = 10,
        ScreenInsets = Enum.ScreenInsets.CoreUISafeInsets,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    }

    local tbl6 = {
        Backdrop = React.createElement("TextButton", {
            AutoButtonColor = false,
            BackgroundTransparency = 1,
            Position = UDim2.fromScale(0, 0),
            Size = UDim2.fromScale(1, 1),
            Text = "",
            ZIndex = 1,
            [React.Event.Activated] = var20,
            [React.Change.AbsoluteSize] = var19
        }),
        Tray = React.createElement(Foundation.View, {
            AnchorPoint = Vector2.new(0, 1),
            Position = var6:map(function(arg1)
                return UDim2.new(0, 0, 1, math.round(arg1 * yOffset))
            end),
            Size = UDim2.new(1, 0, 0, yOffset),
            tag = "stroke-standard stroke-default bg-surface-200",
            ClipsDescendants = true,
            ZIndex = 1
        }, {
            Handle = React.createElement(Foundation.View, {
                Size = UDim2.new(0, Config.PresetTray.HandleWidth, 0, var2.Padding.XSmall),
                AnchorPoint = Vector2.new(0.5, 0),
                Position = UDim2.new(0.5, 0, 0, var2.Padding.XSmall),
                ZIndex = 2,
                tag = "bg-divider radius-full"
            }),
            Content = React.createElement(
                Foundation.View,
                {
                    Size = UDim2.fromScale(1, 1),
                    Position = UDim2.fromScale(0, 0),
                    tag = "auto-xy"
                },
                {
                    Container = React.createElement(PresetChatContainer, {
                        textChannel = tbl1.textChannel,
                        compact = compact,
                        shouldShowKeyboardButton = true,
                        onSendChat = tbl1.onSendChat,
                        onSendGlobalChat = tbl1.onSendGlobalChat
                    })
                }
            )
        })
    }

    tbl2.InnerScreenGui = createElement3("ScreenGui", tbl5, tbl6)
    return createElement(fragment, var21, tbl2)
end)
