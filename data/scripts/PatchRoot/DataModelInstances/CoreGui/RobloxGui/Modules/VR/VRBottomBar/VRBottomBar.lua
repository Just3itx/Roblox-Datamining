-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:21:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")
local _TelemetryService = game:GetService("TelemetryService")
local CorePackages = game:GetService("CorePackages")
local CoreGui = game:GetService("CoreGui")
local GuiService = game:GetService("GuiService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local VRService = game:GetService("VRService")

local Cryo = require(CorePackages.Packages.Cryo)
local Otter = require(CorePackages.Packages.Otter)
local React = require(CorePackages.Packages.React)
local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)
local UIBlox = require(CorePackages.Packages.UIBlox)
local BaseMenu = UIBlox.App.Menu.BaseMenu
local SystemBar = UIBlox.App.Navigation.SystemBar
local Placement = UIBlox.App.Navigation.Enum.Placement
local Panel3D = UIBlox.Core.VR.Panel3D
local Constants = UIBlox.Core.VR.Constants
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local withStyle = UIBlox.Core.Style.withStyle
local Images = UIBlox.App.ImageSet.Images

local RobloxGui = CoreGui:WaitForChild("RobloxGui")
local RobloxTranslator = require(CorePackages.Workspace.Packages.RobloxTranslator)
local VRHub = require(CorePackages.Workspace.Packages.VrCommon).VRHub
local VRUtil = require(CorePackages.Workspace.Packages.VrCommon).VRUtil
local default = require(RobloxGui.Modules.VoiceChat.VoiceChatServiceManager).default
local Constants2 = require(RobloxGui.Modules.VoiceChat.Constants)

local ExternalEventConnection = require(CorePackages.Workspace.Packages.RoactUtils).ExternalEventConnection
local Constants3, PanelType, registerRoactPanel, UIManager

if require(CorePackages.Workspace.Packages.SharedFlags).FFlagEnableUIManagerPackgify then
    local vrSpatialUi = require(CorePackages.Workspace.Packages.VrSpatialUi)
    Constants3 = vrSpatialUi.Constants
    PanelType = Constants3.PanelType
    registerRoactPanel = vrSpatialUi.registerRoactPanel
    UIManager = vrSpatialUi.UIManager
else
    local uiManager = RobloxGui:WaitForChild("Modules"):WaitForChild("UIManager")
    PanelType = require(uiManager.Constants).PanelType
    registerRoactPanel = require(uiManager.registerRoactPanel)
    UIManager = require(uiManager.UIManager)
    Constants3 = require(uiManager.Constants)
end

local InGameMenuConstants = require(RobloxGui.Modules.InGameMenuConstants)
local GameSettings = UserSettings().GameSettings
local InGameMenuInit = require(RobloxGui.Modules.InGameMenuInit)
local ChatSelector = require(RobloxGui.Modules.ChatSelector)

local var1 = Roact.PureComponent:extend("TopBarApp")
local VRBarSeparator = require(script.Parent.VRBarSeparator)
local VRBarVoiceIcon = require(script.Parent.VRBarVoiceIcon)
local VRBottomBarAnalytics = require(script.Parent.VRBottomBarAnalytics)
local VRBottomBarType = require(script.Parent.VRBottomBarType)

local EmotesMenuMaster = require(RobloxGui.Modules.EmotesMenu.EmotesMenuMaster)
local FFlagEnableNewBackpack = require(CorePackages.Workspace.Packages.SharedFlags).FFlagEnableNewBackpack
local Features = if FFlagEnableNewBackpack then require(CorePackages.Workspace.Packages.System).Features else nil
local var2 = if FFlagEnableNewBackpack then require(CorePackages.Workspace.Packages.Backpack) else require(RobloxGui.Modules.BackpackScript)
local PlayerListManager = require(RobloxGui.Modules.PlayerList.PlayerListManager)
local StarterPlayer = game:GetService("StarterPlayer")

local engineFeature = game:GetEngineFeature("EnableVRBottomBarWorksBehindObjects")

local FFlagVRBottomBarDebugPositionConfig = require(RobloxGui.Modules.Flags.FFlagVRBottomBarDebugPositionConfig)

local FIntVRBottomBarPositionOffsetVerticalNumber = require(RobloxGui.Modules.Flags.FIntVRBottomBarPositionOffsetVerticalNumber)

local FIntVRBottomBarPositionOffsetDepthNumber = require(RobloxGui.Modules.Flags.FIntVRBottomBarPositionOffsetDepthNumber)
local IsSpatialRobloxGuiEnabled = require(RobloxGui.Modules.VR.IsSpatialRobloxGuiEnabled)

local SplashScreenManager = require(CorePackages.Workspace.Packages.SplashScreenManager).SplashScreenManager

local var3 = (require(RobloxGui.Modules.Flags.GetFIntVRScaleGuiDistance) or 100)() * 0.01

local bool1 = game:DefineFastFlag("FixVRBottomBarAnalytics", false)

local function safeRequire(userGui: Instance) -- Luacid: Inlined by compiler; 2 call sites recovered
    local success, result = pcall(require, userGui)
    if success then
        return result
    end
    warn("Failure to Start CoreScript module " .. userGui.Name .. ".\n" .. result)
end

local tbl1 = {
    Y = FIntVRBottomBarPositionOffsetVerticalNumber / 100,
    Z = FIntVRBottomBarPositionOffsetDepthNumber / 100
}

local _ = 0.2 + tbl1.Z / 10

local tbl2 = {
    Default = { dampingRatio = 1, frequency = 4.5 },
    Slower = { dampingRatio = 1, frequency = 0.66 }
}

local tbl3 = {
    iconOn = "rbxasset://textures/ui/MenuBar/icon_menu.png",
    iconOff = "rbxasset://textures/ui/MenuBar/icon_menu.png",
    onActivated = function()
        VRHub:SetShowTopBar(true)
        if not InGameMenuInit.getOpen() then
            InGameMenuInit.openInGameMenu(InGameMenuConstants.MainPagePageKey)
            VRHub:SetShowMoreMenu(false)
        else
            InGameMenuInit.closeInGameMenu()
        end

        if bool1 then
            local isToggleOn = InGameMenuInit.getOpen()
            VRBottomBarAnalytics.sendEventToTelemetryV2({
                integrationId = VRBottomBarType.ButtomName.MainMenu,
                isToggleOn = isToggleOn,
                source = VRBottomBarType.Source.VRBottomBar
            })
        end
        RbxAnalyticsService:ReportCounter("VR-BottomBar-MainMenu")
    end
}

local tbl4 = {
    iconOn = "rbxasset://textures/ui/MenuBar/icon_maximize.png",
    iconOff = "rbxasset://textures/ui/MenuBar/icon_minimize.png",
    onActivated = function()
        if not VRHub.ShowTopBar then
            VRHub:SetShowTopBar(false)
            VRHub:SetShowTopBar(true)
        else
            VRHub:SetShowTopBar(false)
            InGameMenuInit.closeInGameMenu()
        end

        if bool1 then
            local showTopBar = VRHub.ShowTopBar
            VRBottomBarAnalytics.sendEventToTelemetryV2({
                integrationId = VRBottomBarType.ButtomName.ToggleGui,
                isToggleOn = showTopBar,
                source = VRBottomBarType.Source.VRBottomBar
            })
        end
        RbxAnalyticsService:ReportCounter("VR-BottomBar-ToggleGui")
    end
}

local tbl5 = {
    iconOn = "rbxasset://textures/ui/MenuBar/icon__backpack.png",
    iconOff = "rbxasset://textures/ui/MenuBar/icon__backpack.png",
    onActivated = function()
        if FFlagEnableNewBackpack then
            if not VRHub.ShowTopBar then
                VRHub:SetShowTopBar(true)
                Features.setVisibility(Features.FeatureName.Backpack, true)
            else
                Features.toggleVisibility(Features.FeatureName.Backpack)
            end
            if bool1 then
                VRBottomBarAnalytics.sendEventToTelemetryV2({
                    integrationId = VRBottomBarType.ButtomName.Inventory,
                    isToggleOn = Features.getVisibility(Features.FeatureName.Backpack),
                    source = VRBottomBarType.Source.MoreSubMenu
                })
            end
        else
            if not VRHub.ShowTopBar then
                VRHub:SetShowTopBar(true)
                if not var2.IsOpen then
                    var2.OpenClose()
                end
            else
                var2.OpenClose()
            end
            if bool1 then
                local isOpen = var2.IsOpen
                VRBottomBarAnalytics.sendEventToTelemetryV2({
                    integrationId = VRBottomBarType.ButtomName.Inventory,
                    isToggleOn = isOpen,
                    source = VRBottomBarType.Source.MoreSubMenu
                })
            end
        end
        RbxAnalyticsService:ReportCounter("VR-BottomBar-Backpack")
    end
}

local tbl6 = {
    iconOn = "rbxasset://textures/ui/MenuBar/icon_leaderboard.png",
    iconOff = "rbxasset://textures/ui/MenuBar/icon_leaderboard.png",
    onActivated = function()
        if not VRHub.ShowTopBar then
            VRHub:SetShowTopBar(true)
            if not PlayerListManager:GetSetVisible() then
                PlayerListManager:SetVisibility(true)
            end
        else
            PlayerListManager:SetVisibility(not PlayerListManager:GetSetVisible())
        end

        if bool1 then
            local isToggleOn = PlayerListManager:GetSetVisible()
            VRBottomBarAnalytics.sendEventToTelemetryV2({
                integrationId = VRBottomBarType.ButtomName.Leaderboard,
                isToggleOn = isToggleOn,
                source = VRBottomBarType.Source.MoreSubMenu
            })
        end
        RbxAnalyticsService:ReportCounter("VR-BottomBar-PlayerList")
    end
}

local tbl7 = {
    iconOn = "rbxasset://textures/ui/MenuBar/icon_emote.png",
    iconOff = "rbxasset://textures/ui/MenuBar/icon_emote.png",
    onActivated = function()
        if not VRHub.ShowTopBar then
            VRHub:SetShowTopBar(true)
            if not EmotesMenuMaster:isOpen() then
                EmotesMenuMaster:open()
            end
        elseif EmotesMenuMaster:isOpen() then
            EmotesMenuMaster:close()
        else
            EmotesMenuMaster:open()
        end

        if bool1 then
            local isToggleOn = EmotesMenuMaster:isOpen()
            VRBottomBarAnalytics.sendEventToTelemetryV2({
                integrationId = VRBottomBarType.ButtomName.Emotes,
                isToggleOn = isToggleOn,
                source = VRBottomBarType.Source.MoreSubMenu
            })
        end
        RbxAnalyticsService:ReportCounter("VR-BottomBar-Emotes")
    end
}

local tbl8 = {
    iconOn = "rbxasset://textures/ui/MenuBar/icon_chat.png",
    iconOff = "rbxasset://textures/ui/MenuBar/icon_chat.png",
    onActivated = function()
        if not VRHub.ShowTopBar then
            VRHub:SetShowTopBar(true)
            if not ChatSelector:GetVisibility() then
                ChatSelector:ToggleVisibility()
                GameSettings.ChatVisible = ChatSelector:GetVisibility()
            end
        else
            ChatSelector:ToggleVisibility()
            GameSettings.ChatVisible = ChatSelector:GetVisibility()
        end

        if bool1 then
            local chatVisible = GameSettings.ChatVisible
            VRBottomBarAnalytics.sendEventToTelemetryV2({
                integrationId = VRBottomBarType.ButtomName.Chat,
                isToggleOn = chatVisible,
                source = VRBottomBarType.Source.VRBottomBar
            })
        end
        RbxAnalyticsService:ReportCounter("VR-BottomBar-Chat")
    end
}

local tbl9 = {
    iconOn = "rbxasset://textures/ui/MenuBar/icon_safety_on.png",
    iconOff = "rbxasset://textures/ui/MenuBar/icon_safety_on.png",
    onActivated = function()
        VRHub:ToggleSafetyBubble()

        if bool1 then
            local enabled = VRHub.SafetyBubble.enabled
            VRBottomBarAnalytics.sendEventToTelemetryV2(
                {
                    integrationId = VRBottomBarType.ButtomName.Safety,
                    isToggleOn = enabled,
                    source = VRBottomBarType.Source.VRBottomBar
                }
            )
        end

        RbxAnalyticsService:ReportCounter("VR-BottomBar-Safety")
    end
}

local tbl10 = {
    iconOn = "rbxasset://textures/ui/MenuBar/icon_safety_off.png",
    iconOff = "rbxasset://textures/ui/MenuBar/icon_safety_off.png",
    onActivated = function()
        VRHub:ToggleSafetyBubble()

        if bool1 then
            local enabled = VRHub.SafetyBubble.enabled
            VRBottomBarAnalytics.sendEventToTelemetryV2(
                {
                    integrationId = VRBottomBarType.ButtomName.Safety,
                    isToggleOn = enabled,
                    source = VRBottomBarType.Source.VRBottomBar
                }
            )
        end

        RbxAnalyticsService:ReportCounter("VR-BottomBar-Safety")
    end
}

local tbl11 = {
    iconOn = "rbxasset://textures/ui/MenuBar/icon_leave.png",
    iconOff = "rbxasset://textures/ui/MenuBar/icon_leave.png",
    onActivated = function()
        VRHub:SetShowTopBar(true)
        VRHub:SetShowMoreMenu(false)
        if InGameMenuInit then
            if not InGameMenuInit.getOpen() then
                InGameMenuInit.openInGameMenu(InGameMenuConstants.MainPagePageKey)
            end
            InGameMenuInit.openGameLeavePage()
        end

        if bool1 then
            local isToggleOn = InGameMenuInit.getOpen()
            VRBottomBarAnalytics.sendEventToTelemetryV2({
                integrationId = VRBottomBarType.ButtomName.Leave,
                isToggleOn = isToggleOn,
                source = VRBottomBarType.Source.VRBottomBar
            })
        end
        RbxAnalyticsService:ReportCounter("VR-BottomBar-LeaveGame")
    end
}

local tbl12 = {
    iconOn = "rbxasset://textures/ui/MenuBar/icon_leave_highlighted.png",
    iconOff = "rbxasset://textures/ui/MenuBar/icon_leave_highlighted.png",
    onActivated = tbl11.onActivated
}

local tbl13 = {
    iconOn = "rbxasset://textures/ui/MenuBar/icon_more.png",
    iconOff = "rbxasset://textures/ui/MenuBar/icon_more.png",
    onActivated = function()
        VRHub:SetShowTopBar(true)
        VRHub:SetShowMoreMenu(not VRHub.ShowMoreMenu)

        if bool1 then
            local showMoreMenu = VRHub.ShowMoreMenu
            VRBottomBarAnalytics.sendEventToTelemetryV2({
                integrationId = VRBottomBarType.ButtomName.MoreSubMenu,
                isToggleOn = showMoreMenu,
                source = VRBottomBarType.Source.VRBottomBar
            })
        end
        RbxAnalyticsService:ReportCounter("VR-BottomBar-More")
    end
}

local tbl14 = {
    iconComponent = VRBarSeparator,
    itemSize = UDim2.new(0, 28, 0, 44)
}

local tbl15 = {
    icon = "rbxasset://textures/ui/MenuBar/icon_emote.png",
    text = RobloxTranslator:FormatByKey("CoreScripts.TopBar.Emotes"),
    onActivated = function()
        tbl7.onActivated()
        RbxAnalyticsService:ReportCounter("VR-BottomBar-MoreMenu-Emotes")
    end
}

local tbl16 = {
    icon = "rbxasset://textures/ui/MenuBar/icon_leaderboard.png",
    text = RobloxTranslator:FormatByKey("CoreScripts.TopBar.Leaderboard"),
    onActivated = function()
        tbl6.onActivated()
        RbxAnalyticsService:ReportCounter("VR-BottomBar-MoreMenu-PlayerList")
    end
}

local tbl17 = {
    icon = "rbxasset://textures/ui/MenuBar/icon__backpack.png",
    text = RobloxTranslator:FormatByKey("CoreScripts.TopBar.Inventory"),
    onActivated = function()
        tbl5.onActivated()
        RbxAnalyticsService:ReportCounter("VR-BottomBar-MoreMenu-Backpack")
    end
}

local tbl18 = {
    iconOn = Images["icons/controls/publicAudioJoin"],
    iconOff = Images["icons/controls/publicAudioJoin"],
    text = "Join Voice",
    onActivated = function()
        default.pendingConnectionSource = Constants2.VOICE_CONNECTION_SOURCE.IN_EXPERIENCE
        default:JoinVoice()
        local isToggleOn = default:ShouldShowJoinVoice()
        VRBottomBarAnalytics.sendEventToTelemetryV2({
            integrationId = VRBottomBarType.ButtomName.JoinVoice,
            isToggleOn = isToggleOn,
            source = VRBottomBarType.Source.VRBottomBar
        })
    end
}

local function roundOffset(arg1): boolean | number -- Luacid: Inlined by compiler; 2 call sites recovered
    return arg1 >= 0 and math.floor(arg1 * 10 + 0.5) / 10 or math.ceil(arg1 * 10 - 0.5) / 10
end

function var1.init(arg1)
    arg1:setState({
        yOffset = tbl1.Y * var3,
        zOffset = tbl1.Z * var3,
        moreMenuOpen = false,
        vrMenuOpen = true,
        lookAway = false,
        userGui = VRService.VREnabled and safeRequire(RobloxGui.Modules.VR.UserGui) or Roact.None,
        hidden = not SplashScreenManager.isFPSAtTarget()
    })

    arg1.backpackHasItems = false
    arg1.emotesLoaded = false

    function arg1.onTargetFPSSTateChange(arg2)
        arg1:setState({ hidden = not arg2 })
    end
    SplashScreenManager.addStatusChangeListener(arg1.onTargetFPSSTateChange)

    function arg1.getVoiceIcon()
        return {
            iconImageComponent = function(arg2)
                return React.createElement(
                    VRBarVoiceIcon,
                    Cryo.Dictionary.join(arg2, { userId = tostring(Players.LocalPlayer.UserId), iconStyle = "MicLight" })
                )
            end,
            onActivated = function()
                if arg1.props.voiceState == Enum.VoiceChatState.Failed then
                    arg1.props.voiceChatServiceManager:RejoinPreviousChannel()
                else
                    arg1.props.voiceChatServiceManager:ToggleMic("VRBottomBar")
                end

                if bool1 then
                    local isToggleOn = arg1.props.voiceState == Enum.VoiceChatState.Joined

                    VRBottomBarAnalytics.sendEventToTelemetryV2({
                        integrationId = VRBottomBarType.ButtomName.Voice,
                        isToggleOn = isToggleOn,
                        source = VRBottomBarType.Source.VRBottomBar
                    })
                end
                RbxAnalyticsService:ReportCounter("VR-BottomBar-Voice")
            end
        }
    end

    function arg1.getDebugYOffsetUp()
        return {
            iconOn = "rbxasset://textures/ui/MenuBar/arrow_up.png",
            iconOff = "rbxasset://textures/ui/MenuBar/arrow_up.png",
            onActivated = function()
                arg1:setState({ yOffset = arg1.state.yOffset + 0.1 })
            end
        }
    end

    function arg1.getDebugYOffsetDown()
        return {
            iconOn = "rbxasset://textures/ui/MenuBar/arrow_down.png",
            iconOff = "rbxasset://textures/ui/MenuBar/arrow_down.png",
            onActivated = function()
                arg1:setState({ yOffset = arg1.state.yOffset - 0.1 })
            end
        }
    end

    function arg1.getDebugZOffsetUp()
        return {
            iconOn = "rbxasset://textures/ui/MenuBar/arrow_left.png",
            iconOff = "rbxasset://textures/ui/MenuBar/arrow_left.png",
            onActivated = function()
                arg1:setState({ zOffset = arg1.state.zOffset + 0.1 })
            end
        }
    end

    function arg1.getDebugZOffsetDown()
        return {
            iconOn = "rbxasset://textures/ui/MenuBar/arrow_right.png",
            iconOff = "rbxasset://textures/ui/MenuBar/arrow_right.png",
            onActivated = function()
                arg1:setState({ zOffset = arg1.state.zOffset - 0.1 })
            end
        }
    end

    function arg1.getDebugTextLabel()
        return {
            iconComponent = function(arg2)
                local var4 = "Y " .. roundOffset(arg1.state.yOffset) .. ", Z " .. roundOffset(arg1.state.zOffset)
                return Roact.createElement("TextLabel", {
                    BackgroundTransparency = 1,
                    Text = var4,
                    TextColor3 = Color3.new(1, 1, 1),
                    TextWrapped = true,
                    TextScaled = true,
                    Size = UDim2.fromScale(1, 1),
                    [Roact.Children] = arg2[Roact.Children]
                })
            end,
            itemSize = UDim2.new(0, 44, 0, 44)
        }
    end

    arg1:setState({ itemList = { tbl3, tbl14, tbl4, tbl14, tbl11 }, moreItemList = {} })

    function arg1.onShowTopBarChanged()
        if IsSpatialRobloxGuiEnabled then
            return
        end
        if not VRHub.ShowTopBar then
            VRHub:SetShowMoreMenu(false)
        end
        arg1:setState({ vrMenuOpen = VRHub.ShowTopBar })
    end

    function arg1.onShowMoreMenuChanged()
        arg1:setState({ moreMenuOpen = VRHub.ShowMoreMenu })
    end

    function arg1.updateItemListState()
        local itemList, moreItemList = arg1:updateItems()
        arg1:setState({ itemList = itemList, moreItemList = moreItemList })
    end

    function arg1.onBackpackItemAdded()
        if not arg1.backpackHasItems then
            arg1.backpackHasItems = true
            arg1.updateItemListState()
        end
    end

    function arg1.onBackpackEmpty()
        if arg1.backpackHasItems then
            arg1.backpackHasItems = false
            arg1.updateItemListState()
        end
    end

    function arg1.onEmotesLoaded(emotesLoaded)
        if emotesLoaded ~= arg1.emotesLoaded then
            arg1.emotesLoaded = emotesLoaded
            arg1.updateItemListState()
        end
    end

    function arg1.onVREnabledChanged()
        arg1:setState({ userGui = VRService.VREnabled and safeRequire(RobloxGui.Modules.VR.UserGui) or Roact.None })
    end

    function arg1.onRenderStepped()
        local lookAway = VRUtil.GetUserCFrameWorldSpace(Enum.UserCFrame.Head).LookVector.Y > -0.2
        if arg1.state.lookAway ~= lookAway then
            arg1:setState({ lookAway = lookAway })
        end
    end

    local fadeTransparency, setFadeTransparency = Roact.createBinding(0)
    arg1.fadeTransparency = fadeTransparency
    arg1.setFadeTransparency = setFadeTransparency
    arg1.fadeTransparencyMotor = Otter.createSingleMotor(arg1.fadeTransparency:getValue())
    arg1.fadeTransparencyMotor:onStep(arg1.setFadeTransparency)
    arg1.fadeTransparencyMotor:setGoal(Otter.spring(0, tbl2.Default))

    function arg1.getAlignedPanelPart()
        local panel = if arg1.state.userGui then arg1.state.userGui:getPanel() else nil
        local part = panel and panel:GetPart()
        if part
            and (panel:IsPositionLockedType() or panel:IsUIManagerManagedType())
            and (panel:IsVisible() or panel.alwaysUpdatePosition)
        then
            return part
        end
    end

    function arg1.bottomBarPanelOffsetCallback(arg2)
        local finalPosition = arg2.finalPosition
        local cameraHeadScale = arg2.cameraHeadScale
        local alignedPanelPart = arg1.getAlignedPanelPart()

        if alignedPanelPart then
            local yOffset = arg1.state.yOffset
            local zOffset = arg1.state.zOffset

            local userCFrameWorldSpace = VRUtil.GetUserCFrameWorldSpace(Enum.UserCFrame.Head)
            local cFrame = CFrame.new(0, 0, zOffset * cameraHeadScale - alignedPanelPart.Size.Z * 0.5)
            local var6 = alignedPanelPart.CFrame:ToWorldSpace(cFrame)

            finalPosition = Vector3.new(var6.Position.X, userCFrameWorldSpace.Position.Y + yOffset * cameraHeadScale, var6.Position.Z)
        end

        return finalPosition
    end

    function arg1.moreMenuPanelOffsetCallback(arg2)
        local finalPosition = arg2.finalPosition
        local cameraHeadScale = arg2.cameraHeadScale
        local alignedPanelPart = arg1.getAlignedPanelPart()
        if alignedPanelPart then
            local pos = arg1.bottomBarPanelOffsetCallback(arg2)
            local userCFrameWorldSpace = VRUtil.GetUserCFrameWorldSpace(Enum.UserCFrame.Head)
            local cFrame = CFrame.new(pos, userCFrameWorldSpace.Position)

            local var6 = (0.2 + arg1.state.zOffset / 10) * var3

            local var7 = FFlagVRBottomBarDebugPositionConfig and (#arg1.state.itemList - 3) / 2 * var6
                or (#arg1.state.itemList - 2.5) / 2 * var6

            local cFrame2 = cFrame:ToWorldSpace(CFrame.new(-var7 * cameraHeadScale, var6 / 2 * cameraHeadScale, -0.025))

            finalPosition = (CFrame.new(cFrame2.Position) * alignedPanelPart.CFrame.Rotation):ToWorldSpace(
                CFrame.new(0, #arg1.state.moreItemList * var6 / 2 * cameraHeadScale, 0.025)
            ).Position
        end

        return finalPosition
    end

    function arg1.moreMenuPanelTiltCallback(arg2)
        local panelCFrame = arg2.panelCFrame
        local alignedPanelPart = arg1.getAlignedPanelPart()

        if alignedPanelPart then
            panelCFrame = CFrame.new(panelCFrame.Position) * alignedPanelPart.CFrame.Rotation
        end
        return panelCFrame
    end
end

function var1.didMount(arg1)
    arg1.emotesLoaded = EmotesMenuMaster:isEmotesLoaded()
    arg1.backpackHasItems = var2.IsInventoryEmpty()
    arg1.updateItemListState()
end

function var1.updateItems(arg1)
    local coreGuiEnabled = StarterGui:GetCoreGuiEnabled(Enum.CoreGuiType.Backpack)
    local coreGuiEnabled2 = StarterGui:GetCoreGuiEnabled(Enum.CoreGuiType.EmotesMenu)
    local coreGuiEnabled3 = StarterGui:GetCoreGuiEnabled(Enum.CoreGuiType.Chat)
    local coreGuiEnabled4 = StarterGui:GetCoreGuiEnabled(Enum.CoreGuiType.PlayerList)
    local var4

    if IsSpatialRobloxGuiEnabled then
        local tbl19 = { tbl3, tbl14 }

        var4 = FFlagVRBottomBarDebugPositionConfig
            and {
                arg1.getDebugYOffsetUp(),
                arg1.getDebugYOffsetDown(),
                arg1.getDebugZOffsetUp(),
                arg1.getDebugZOffsetDown(),
                arg1.getDebugTextLabel(),
                tbl14,
                tbl3,
                tbl14
            }
            or tbl19
    else
        local tbl19 = { tbl3, tbl14, tbl4 }

        var4 = FFlagVRBottomBarDebugPositionConfig
            and {
                arg1.getDebugYOffsetUp(),
                arg1.getDebugYOffsetDown(),
                arg1.getDebugZOffsetUp(),
                arg1.getDebugZOffsetDown(),
                arg1.getDebugTextLabel(),
                tbl14,
                tbl3,
                tbl14,
                tbl4
            }
            or tbl19
    end

    coreGuiEnabled2 = coreGuiEnabled2 and not (StarterPlayer.UserEmotesEnabled and arg1.emotesLoaded == false)
    local backpackHasItems = coreGuiEnabled and arg1.backpackHasItems

    if coreGuiEnabled3 then
        table.insert(var4, tbl8)
    end

    if default:ShouldShowJoinVoiceOnDisconnect() or default:ShouldShowJoinVoice() then
        table.insert(var4, tbl18)
    end

    if arg1.props.voiceEnabled then
        table.insert(var4, arg1.getVoiceIcon())
    end

    table.insert(var4, tbl14)

    if VRHub.SafetyBubble and VRHub.SafetyBubble.enabled then
        table.insert(var4, tbl9)
    else
        table.insert(var4, tbl10)
    end

    if VRHub.ShowHighlightedLeaveGameIcon then
        table.insert(var4, tbl12)
    else
        table.insert(var4, tbl11)
    end

    local tbl19 = {}
    if coreGuiEnabled2 then
        table.insert(tbl19, tbl15)
    end
    if coreGuiEnabled4 then
        table.insert(tbl19, tbl16)
    end
    if backpackHasItems then
        table.insert(tbl19, tbl17)
    end
    if #tbl19 > 0 then
        table.insert(var4, tbl13)
    end

    return var4, tbl19
end

function var1.renderWithStyle(arg1, arg2)
    local y = (0.2 + arg1.state.zOffset / 10) * var3

    local itemList = arg1.state.itemList
    local moreItemList = arg1.state.moreItemList

    local num1 = if FFlagVRBottomBarDebugPositionConfig then 7 else 1
    if not arg1.state.vrMenuOpen then
        num1 = if FFlagVRBottomBarDebugPositionConfig then 9 else 3
    elseif arg1.state.moreMenuOpen then
        num1 = #moreItemList > 0 and #itemList or num1
    end

    local createFragment = Roact.createFragment
    local tbl19 = {
        BottomBarPanel3D = 0,
        MoreMenuPanel3D = 0,
        ShowHighlightedLeaveGameIconToggled = 0,
        ShowTopBarChanged = 0,
        ShowMoreMenuChanged = 0,
        CoreGuiChanged = 0,
        SafetyBubbleToggled = 0,
        BackpackItemAdded = 0,
        BackpackEmpty = 0,
        EmotesLoaded = 0,
        RenderStepped = 0,
        VREnabled = 0
    }
    local createElement = Roact.createElement
    local var4 = Panel3D

    local tbl20 = {
        panelName = "BottomBar",
        partSize = if IsSpatialRobloxGuiEnabled then Vector2.new(
            (#itemList - 1) * Constants3.BOTTOM_BAR_BASE_PART_SIZE * workspace.CurrentCamera.HeadScale,
            Constants3.BOTTOM_BAR_BASE_PART_SIZE * workspace.CurrentCamera.HeadScale
        ) else Vector2.new((#itemList - 1) * y, y),
        virtualScreenSize = Vector2.new((#itemList - 1) * 50, 50),
        offset = arg1.state.vrMenuOpen and CFrame.new(0, 0, 0) or CFrame.new(0, -0.5, 0),
        offsetCallback = arg1.bottomBarPanelOffsetCallback,
        lerp = true,
        tilt = 0,
        anchoring = if IsSpatialRobloxGuiEnabled then Constants.AnchoringTypes.PanelManaged else Constants.AnchoringTypes.Head,
        faceCamera = true,
        curvature = 0,
        alwaysOnTop = if engineFeature then true else nil,
        parent = if engineFeature then GuiService.CoreGuiFolder or nil else nil,
        zOffset = 1,
        connectPanelManagerFunction = IsSpatialRobloxGuiEnabled and function(arg3)
            if arg3 then
                registerRoactPanel(arg3, PanelType.BottomBar)
                return
            end
            UIManager.getInstance():removeRoactPanel(PanelType.BottomBar)
        end or nil
    }

    tbl19.BottomBarPanel3D = createElement(var4, tbl20, {
        CanvasGroup = Roact.createElement("CanvasGroup", {
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            GroupTransparency = arg1.fadeTransparency,
            Size = UDim2.new(1, 0, 1, 0)
        }, {
            SystemBar = Roact.createElement(SystemBar, {
                itemList = itemList,
                selection = num1,
                placement = Placement.Bottom,
                hidden = arg1.state.hidden,
                onSafeAreaChanged = function() end,
                size = UDim2.new(1, 0, 1, 0),
                position = UDim2.new(),
                layoutOrder = 1,
                roundCorners = true,
                buttonStroke = true,
                bgTransparency = 0,
                sortOrder = Enum.SortOrder.LayoutOrder
            })
        })
    })
    local moreMenuOpen = arg1.state.moreMenuOpen

    if moreMenuOpen then
        local createElement2 = Roact.createElement
        local var5 = Panel3D

        local tbl21 = {
            panelName = "MoreMenu",
            partSize = if IsSpatialRobloxGuiEnabled then Vector2.new(
                5 * Constants3.BOTTOM_BAR_BASE_PART_SIZE * workspace.CurrentCamera.HeadScale,
                #moreItemList * Constants3.BOTTOM_BAR_BASE_PART_SIZE * workspace.CurrentCamera.HeadScale
            ) else Vector2.new(5 * y, #moreItemList * y),
            virtualScreenSize = Vector2.new(250, #moreItemList * 56 + 8),
            offset = arg1.state.vrMenuOpen and CFrame.new(0, 0, 0) or CFrame.new(0, -0.5, 0),
            offsetCallback = arg1.moreMenuPanelOffsetCallback,
            lerp = true,
            tilt = 0,
            tiltCallback = arg1.moreMenuPanelTiltCallback,
            anchoring = if IsSpatialRobloxGuiEnabled then Constants.AnchoringTypes.PanelManaged else Constants.AnchoringTypes.Head,
            faceCamera = true,
            alwaysOnTop = if engineFeature then true else nil,
            parent = if engineFeature then GuiService.CoreGuiFolder or nil else nil,
            connectPanelManagerFunction = IsSpatialRobloxGuiEnabled and function(arg3)
                if arg3 then
                    registerRoactPanel(arg3, PanelType.MoreMenu)
                    return
                end
                UIManager.getInstance():removeRoactPanel(PanelType.MoreMenu)
            end or nil,
            zOffset = 2
        }

        moreMenuOpen = createElement2(var5, tbl21, {
            Content = Roact.createElement("Frame", {
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 1, 0)
            }, {
                MoreMenu = Roact.createElement(BaseMenu, {
                    anchorPoint = Vector2.new(0.5, 1),
                    buttonProps = moreItemList,
                    position = UDim2.new(0.5, 0, 1, -8),
                    background = arg2.Theme.BackgroundContrast
                }),
                Caret = Roact.createElement(ImageSetLabel, {
                    AnchorPoint = Vector2.new(0.5, 1),
                    BackgroundTransparency = 1,
                    Image = "rbxasset://textures/ui/MenuBar/dropdown-arrow.png",
                    ImageColor3 = Color3.fromRGB(25, 27, 29),
                    Position = UDim2.new(0.5, 0, 1, 0),
                    Size = UDim2.new(0, 24, 0, 10)
                })
            })
        })
    end

    tbl19.MoreMenuPanel3D = moreMenuOpen

    tbl19.ShowHighlightedLeaveGameIconToggled = Roact.createElement(
        ExternalEventConnection,
        {
            event = VRHub.ShowHighlightedLeaveGameIconToggled.Event,
            callback = arg1.updateItemListState
        }
    )
    tbl19.ShowTopBarChanged = Roact.createElement(
        ExternalEventConnection,
        {
            event = VRHub.ShowTopBarChanged.Event,
            callback = arg1.onShowTopBarChanged
        }
    )
    tbl19.ShowMoreMenuChanged = Roact.createElement(
        ExternalEventConnection,
        {
            event = VRHub.ShowMoreMenuChanged.Event,
            callback = arg1.onShowMoreMenuChanged
        }
    )
    tbl19.CoreGuiChanged = Roact.createElement(
        ExternalEventConnection,
        {
            event = StarterGui.CoreGuiChangedSignal,
            callback = arg1.updateItemListState
        }
    )
    tbl19.SafetyBubbleToggled = VRHub.SafetyBubble
        and Roact.createElement(
            ExternalEventConnection,
            {
                event = VRHub.SafetyBubble.Toggled.Event,
                callback = arg1.updateItemListState
            }
        )
    tbl19.BackpackItemAdded = Roact.createElement(
        ExternalEventConnection,
        {
            event = var2.BackpackItemAdded.Event,
            callback = arg1.onBackpackItemAdded
        }
    )
    tbl19.BackpackEmpty = Roact.createElement(ExternalEventConnection, { event = var2.BackpackEmpty.Event, callback = arg1.onBackpackEmpty })

    tbl19.EmotesLoaded = Roact.createElement(
        ExternalEventConnection,
        {
            event = EmotesMenuMaster.EmotesLoaded.Event,
            callback = arg1.onEmotesLoaded
        }
    )
    tbl19.RenderStepped = Roact.createElement(ExternalEventConnection, { event = RunService.RenderStepped, callback = arg1.onRenderStepped })

    tbl19.VREnabled = Roact.createElement(
        ExternalEventConnection,
        {
            event = VRService:GetPropertyChangedSignal("VREnabled"),
            callback = arg1.onVREnabledChanged
        }
    )
    return createFragment(tbl19)
end

function var1.render(arg1)
    return withStyle(function(arg2)
        return arg1:renderWithStyle(arg2)
    end)
end

function var1.didUpdate(arg1, arg2, arg3)
    if arg3.lookAway ~= arg1.state.lookAway or arg3.vrMenuOpen ~= arg1.state.vrMenuOpen then
        if not arg1.state.vrMenuOpen and arg1.state.lookAway then
            arg1.fadeTransparencyMotor:setGoal(Otter.spring(1, tbl2.Slower))
        else
            arg1.fadeTransparencyMotor:setGoal(Otter.spring(0, tbl2.Default))
        end
    end

    if arg1.state.moreMenuOpen and #arg1.state.moreItemList == 0 then
        VRHub:SetShowMoreMenu(false)
    end

    if arg2.voiceEnabled ~= arg1.props.voiceEnabled
        or arg3.yOffset ~= arg1.state.yOffset
        or arg3.zOffset ~= arg1.state.zOffset
    then
        arg1.updateItemListState()
    end
end

function var1.willUnmount(arg1)
    arg1.fadeTransparencyMotor:stop()
end

return RoactRodux.UNSTABLE_connect2(nil, nil)(var1)
