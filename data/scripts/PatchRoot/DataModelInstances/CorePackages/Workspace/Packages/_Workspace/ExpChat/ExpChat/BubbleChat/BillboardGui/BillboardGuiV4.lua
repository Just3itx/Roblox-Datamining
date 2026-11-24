-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T07:31:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent

local ExpChatShared = require(ExpChatParent.ExpChatShared)
local Roact = require(ExpChatParent.Roact)
local React = require(ExpChatParent.React)
local RoactRodux = require(ExpChatParent.RoactRodux)
local List = require(ExpChatParent.llama).List
local Otter = require(ExpChatParent.Otter)
local tutils = require(ExpChatParent.tutils)
local SharedFlags = require(ExpChatParent.SharedFlags)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local VRService = game:GetService("VRService")
local UserGameSettings = UserSettings():GetService("UserGameSettings")

local createEffect = require(ExpChatParent.Signals).createEffect
local var1 = ExpChatShared.Logger:new("ExpChat/" .. script.Name)

local BubbleChat = script:FindFirstAncestor("BubbleChat")
local VoiceIndicator = require(BubbleChat.VoiceIndicator)
local BlankBubble = require(BubbleChat.BlankBubble)
local BubbleChatList = require(BubbleChat.BubbleChatList)
local ChatBubbleDistant = require(BubbleChat.ChatBubbleDistant)
local GlobalFlags = require(ExpChat.GlobalFlags)
local Helpers = BubbleChat.Helpers

local GetMessagesStore = require(ExpChat.Stores.GetMessagesStore)
local GetChatConfigurationStore = require(ExpChat.Stores.GetChatConfigurationStore)
local getSettingsForMessage = require(Helpers.getSettingsForMessage)
local getDisplayedBubbleMessages = require(Helpers.getDisplayedBubbleMessages)
local getBubbleChatStartTimeMillis = require(Helpers.getBubbleChatStartTimeMillis)
local getServerTimeNowMillis = require(Helpers.getServerTimeNowMillis)
local getBubbleDurationInMillis = require(Helpers.getBubbleDurationInMillis)
local getBorderlessBubbleChatRenderDistance = require(Helpers.getBorderlessBubbleChatRenderDistance)
local isBorderlessBubbleChatMessage = require(Helpers.isBorderlessBubbleChatMessage)

local bool1 = game:DefineFastFlag("SelfViewNoApi", false)

local PlayerButtons = require(BubbleChat.PlayerButtons)

local FFlagEasierUnmuting = require(ExpChat.Flags.FFlagEasierUnmuting)
local bool2 = game:DefineFastFlag("ExpChatMemoBillboardGui", false)
local bool3 = game:DefineFastFlag("StopBubbleChatReactWarning", false)

local num1 = game:DefineFastInt("ExperienceChatHeartbeatIncrement", 5)
local FFlagExpChatUseAdorneeStore = SharedFlags.FFlagExpChatUseAdorneeStore

local FFlagExpChatUseProximityStore = SharedFlags.FFlagExpChatUseProximityStore

local num2 = game:DefineFastInt("ExpChatProximityStoreExtraRendersBeforeUnmount", 10)
local FFlagExpChatUseChatConfigStore = SharedFlags.FFlagExpChatUseChatConfigStore
local isBorderlessBubbleChatEnabled = require(ExpChat.isBorderlessBubbleChatEnabled)

local vector2 = Vector2.new(28, 28)

local function getRecentMessages(arg1, arg2, maxBubbles)
    local num3 = workspace:GetServerTimeNow() * 1000
    return List.filter(arg1 or {}, function(arg3, arg4): boolean
        if not arg3.isVisibleInBubbleChat then
            return false
        end

        return #arg1 - maxBubbles < arg4 and num3 - arg3.timestamp.UnixTimestampMillis < arg2
    end)
end

local var2 = (if bool3 then Roact.Component else Roact.PureComponent):extend("BubbleChatBillboard")

local tbl1 = { dampingRatio = 1, frequency = 4 }

local CurrentCamera = workspace.CurrentCamera
workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
    CurrentCamera = workspace.CurrentCamera
end)

function var2.init(arg1)
    local selfViewVisibility, var3

    if GlobalFlags.AvatarChatEnabled then
        selfViewVisibility = arg1.props.selfViewListenerChanged.getSelfViewVisibility()
        var3 = bool1 or StarterGui:GetCoreGuiEnabled(Enum.CoreGuiType.All) or StarterGui:GetCoreGuiEnabled(Enum.CoreGuiType.SelfView)
    else
        selfViewVisibility = nil
        var3 = nil
    end

    if FFlagExpChatUseProximityStore then
        local context = ExpChatShared.context
        arg1.ProximityStore = context and context.proximityStore
        local invisibleCount, setInvisibleCount = Roact.createBinding(100)
        arg1.invisibleCount = invisibleCount
        arg1.setInvisibleCount = setInvisibleCount

        local renderDistanceBinding, updateRenderDistanceBinding = Roact.createBinding(false)
        arg1.renderDistanceBinding = renderDistanceBinding
        arg1.updateRenderDistanceBinding = updateRenderDistanceBinding
        local maximizeDistanceBinding, updateMaximizeDistanceBinding = Roact.createBinding(false)
        arg1.maximizeDistanceBinding = maximizeDistanceBinding
        arg1.updateMaximizeDistanceBinding = updateMaximizeDistanceBinding
    end

    arg1:setState({
        isInsideRenderDistance = false,
        isInsideMaximizeDistance = false,
        savedChatSettings = arg1.props.chatSettings,
        selfViewOpen = selfViewVisibility,
        selfViewEnabled = var3,
        voiceTimedOut = false,
        voiceStateCounter = 0,
        lastVoiceState = nil,
        filteredMessages = {}
    })

    arg1.isMounted = false
    local offset, updateOffset = Roact.createBinding(Vector3.new())
    arg1.offset = offset
    arg1.updateOffset = updateOffset
    arg1.offsetMotor = Otter.createSingleMotor(0)
    arg1.offsetMotor:onStep(function(y: number?)
        arg1.updateOffset(Vector3.new(0, y, 0))
    end)
    arg1.offsetGoal = 0

    if isBorderlessBubbleChatEnabled() then
        local borderlessDistanceTransparency, updateBorderlessDistanceTransparency = Roact.createBinding(0)
        arg1.borderlessDistanceTransparency = borderlessDistanceTransparency
        arg1.updateBorderlessDistanceTransparency = updateBorderlessDistanceTransparency

        local borderlessBillboardMaxDistance, updateBorderlessBillboardMaxDistance = Roact.createBinding(getBorderlessBubbleChatRenderDistance(arg1.props.chatSettings))
        arg1.borderlessBillboardMaxDistance = borderlessBillboardMaxDistance
        arg1.updateBorderlessBillboardMaxDistance = updateBorderlessBillboardMaxDistance

        arg1.isInsideBorderlessRenderDistance = nil
        arg1.borderlessDistanceFadeConnection = nil
    end

    local adorneeBinding, updateAdorneeBinding = Roact.createBinding(nil)
    arg1.adorneeBinding = adorneeBinding
    arg1.updateAdorneeBinding = updateAdorneeBinding
    local localAdorneeBinding, updateLocalAdorneeBinding = Roact.createBinding(nil)
    arg1.localAdorneeBinding = localAdorneeBinding
    arg1.updateLocalAdorneeBinding = updateLocalAdorneeBinding

    if FFlagExpChatUseProximityStore then
        local voiceTimedOutBinding, setVoiceTimedOutBinding = Roact.createBinding(false)
        arg1.voiceTimedOutBinding = voiceTimedOutBinding
        arg1.setVoiceTimedOutBinding = setVoiceTimedOutBinding
    end

    arg1.heartbeatCount = 0

    arg1.lastDistanceUpdate = 0

    function arg1.onLastBubbleFadeOut()
        if isBorderlessBubbleChatEnabled() and arg1.isMounted and arg1.state.isShowingBorderlessBubbleChat then
            arg1:setState({ isShowingBorderlessBubbleChat = false })
        end

        if arg1.props.onFadeOut and not arg1.isFadingOut then
            arg1.isFadingOut = true
            arg1.props.onFadeOut(arg1.props.userId)
        end
    end

    function arg1.wrappedOnClickVoiceIndicator(arg2, arg3)
        return arg1.props.onClickedVoiceIndicator(arg2, arg3, "bubblechat")
    end

    local localPlayer = Players.LocalPlayer
    local var10 = if localPlayer then if arg1.props.userId == tostring(localPlayer.UserId) then "MicDark" else "SpeakerDark" else "SpeakerDark"

    function arg1.renderInsert()
        return Roact.createElement(VoiceIndicator, {
            userId = arg1.props.userId,
            getIcon = arg1.props.getIconVoiceIndicator,
            onClicked = arg1.wrappedOnClickVoiceIndicator,
            iconStyle = var10
        })
    end

    if GlobalFlags.AvatarChatEnabled then
        local selfViewVisibilityUpdatedSignal = arg1.props.selfViewListenerChanged.selfViewVisibilityUpdatedSignal
        local getSelfViewVisibility = arg1.props.selfViewListenerChanged.getSelfViewVisibility

        arg1.selfViewConnection = selfViewVisibilityUpdatedSignal:connect(function() -- name: callback
            arg1:setState({ selfViewOpen = getSelfViewVisibility() })
        end)
    end
    arg1.MessagesStore = GetMessagesStore(false)

    if FFlagExpChatUseChatConfigStore then
        arg1.ChatConfigurationStore = GetChatConfigurationStore(false)
    end
end

function var2.checkCounterForTimeout(arg1, voiceStateCounter)
    if not Players.LocalPlayer then
        return
    end

    local userId = arg1.props.userId

    if userId == tostring(Players.LocalPlayer.UserId)
        or arg1.state.lastVoiceState == "Talking"
        or arg1.state.voiceStateCounter == voiceStateCounter
    then
        return
    end
    local voiceStateCounter2 = arg1.state.voiceStateCounter
    delay(1, function()
        if arg1.state.voiceStateCounter ~= voiceStateCounter2 or not arg1.isMounted then
            return
        end

        if FFlagExpChatUseProximityStore then
            arg1.setVoiceTimedOutBinding(true)
            return
        end
        arg1:setState({ voiceTimedOut = true })
    end)
end

function var2.getVerticalOffset(arg1)
    local effectiveAdornee = arg1:getEffectiveAdornee(false)

    if not (effectiveAdornee and effectiveAdornee:IsA("Model")) then
        if effectiveAdornee and effectiveAdornee:IsA("BasePart") then
            return effectiveAdornee.Size.Y / 2
        end

        return 0
    end

    local var3, var4 = effectiveAdornee:GetBoundingBox()
    local adorneeInstance = getAdorneeInstance(effectiveAdornee, arg1.state.savedChatSettings.AdorneeName)
    if not adorneeInstance then
        return var4.Y / 2
    end

    if not adorneeInstance:IsA("BasePart") then
        return 0
    end

    local var5 = var3:PointToObjectSpace(adorneeInstance.Position)
    return var4.Y / 2 - var5.Y
end

function getAdorneeInstance(arg1, name: string)
    if not arg1 then
        return nil
    end

    if arg1:IsA("Model") then
        local var3 = arg1:FindFirstChild(name, true) or arg1.PrimaryPart

        if not var3 or var3:IsA("BasePart") or var3:IsA("Attachment") then
            return var3
        end
    elseif arg1:IsA("BasePart") or arg1:IsA("Attachment") then
        return arg1
    end

    return nil
end

function var2.getEffectiveAdornee(tbl2, bool4: boolean?)
    if not FFlagExpChatUseAdorneeStore then
        return tbl2.props.adornee
    end

    local context = ExpChatShared.context
    local adorneeStore = context and context.adorneeStore
    if adorneeStore and tbl2.props.userId then
        local adornee = adorneeStore.getAdornee(tbl2.props.userId)
        if adornee then
            local var3 = adornee(bool4 or false)
            if var3 then
                return var3
            end
        end
    end

    return tbl2.props.partOrModel
end

function var2.shouldRenderCaret(arg1)
    return (if FFlagExpChatUseChatConfigStore then arg1.ChatConfigurationStore.getBubbleChatSettings(false) else arg1.state.savedChatSettings).TailVisible
        and not arg1:shouldRenderPlayerButtons()
end

function var2.shouldRenderCaretNew(arg1, arg2)
    return arg1.state.savedChatSettings.TailVisible and not arg1:shouldRenderPlayerButtonsNew(arg2)
end

function var2.shouldRenderPlayerButtons(arg1)
    if not (arg1.props.voiceEnabled and arg1.props.isVoiceUIVisible) then
        return false
    end

    local bool4 = if Players.LocalPlayer then arg1.props.userId == tostring(Players.LocalPlayer.UserId) else false

    if FFlagExpChatUseProximityStore then
        if bool4 and not arg1.props.testMode then
            return not (VRService.VREnabled or GlobalFlags.ChromeEnabled) and not arg1.state.selfViewOpen
        end
    elseif bool4 then
        return not (VRService.VREnabled or GlobalFlags.ChromeEnabled) and not arg1.state.selfViewOpen
    end

    return arg1.props.voiceEnabled and not arg1.state.voiceTimedOut
end

function var2.shouldRenderPlayerButtonsNew(arg1, arg2)
    if not (arg1.props.voiceEnabled and arg1.props.isVoiceUIVisible) then
        return false
    end

    if Players.LocalPlayer and arg1.props.userId == tostring(Players.LocalPlayer.UserId) then
        if VRService.VREnabled or GlobalFlags.ChromeEnabled then
            return false
        end

        return not arg1.state.selfViewOpen
    end

    if arg2 == nil then
        return arg1.props.voiceEnabled and not arg1.state.voiceTimedOut
    end

    return arg1.props.voiceEnabled and not arg2
end

local function messagesHaveChanged(filteredMessages, filteredMessages2)
    local filteredMessagesLen = #filteredMessages
    local filteredMessages2Len = #filteredMessages2
    if filteredMessagesLen == 0 and filteredMessages2Len == 0 then
        return false
    end
    if filteredMessagesLen ~= filteredMessages2Len then
        return true
    end

    for value, value2 in filteredMessages do
        if value2.messageId ~= filteredMessages2[value].messageId then
            return true
        end

        if value2.text ~= filteredMessages2[value].text then
            return true
        end
    end
    return false
end

local tbl2 = { filteredMessages = true }
function var2.shouldComponentUpdate(arg1, arg2, arg3): boolean
    if FFlagExpChatUseProximityStore
        or arg1.state.isInsideRenderDistance == arg3.isInsideRenderDistance
        or arg3.isInsideRenderDistance
    then
        if messagesHaveChanged(arg1.state.filteredMessages, arg3.filteredMessages) then
            return true
        end

        return not (tutils.shallowEqual(arg2, arg1.props, tbl2) and tutils.shallowEqual(arg3, arg1.state, tbl2))
    end

    return false
end

function var2.cancelBorderlessDistanceFade(arg1)
    if arg1.borderlessDistanceFadeConnection then
        arg1.borderlessDistanceFadeConnection:Disconnect()
        arg1.borderlessDistanceFadeConnection = nil
    end
end

function var2.setBorderlessDistanceVisible(tbl3, isInsideBorderlessRenderDistance: boolean)
    if tbl3.isInsideBorderlessRenderDistance == isInsideBorderlessRenderDistance then
        return
    end

    tbl3.isInsideBorderlessRenderDistance = isInsideBorderlessRenderDistance
    tbl3:cancelBorderlessDistanceFade()

    local num3 = if isInsideBorderlessRenderDistance then 0 else 1
    if tbl3.borderlessBillboardMaxDistance:getValue() ~= math.huge then
        tbl3.updateBorderlessDistanceTransparency(num3)
        tbl3.updateBorderlessBillboardMaxDistance(math.huge)
        return
    end

    local value = tbl3.borderlessDistanceTransparency:getValue()
    if value == num3 then
        return
    end

    if not tbl3.state.isShowingBorderlessBubbleChat or UserGameSettings.ReducedMotion then
        tbl3.updateBorderlessDistanceTransparency(num3)
        return
    end

    local num4 = 0
    tbl3.borderlessDistanceFadeConnection = RunService.RenderStepped:Connect(function(deltaTime: number)
        num4 += deltaTime
        local num5 = math.min(num4 / 0.25, 1)
        tbl3.updateBorderlessDistanceTransparency(value + (num3 - value) * num5)

        if num5 == 1 then
            tbl3:cancelBorderlessDistanceFade()
        end
    end)
end

function var2.render(arg1)
    local chatSettings = if FFlagExpChatUseChatConfigStore then arg1.ChatConfigurationStore.getBubbleChatSettings(false) else arg1.state.savedChatSettings
    local var4 = if FFlagExpChatUseAdorneeStore then arg1.adorneeBinding else arg1.props.adornee or arg1.props.partOrModel

    local adornee = if FFlagExpChatUseAdorneeStore then arg1.adorneeBinding:map(function(arg2)
        return getAdorneeInstance(arg2, arg1.state.savedChatSettings.AdorneeName)
    end) else getAdorneeInstance(var4, arg1.state.savedChatSettings.AdorneeName)

    local bool4 = if Players.LocalPlayer then arg1.props.userId == tostring(Players.LocalPlayer.UserId) else false

    if not (FFlagExpChatUseAdorneeStore or adornee) then
        var1:trace("No adornee for {}", arg1.state.shortId)
        return
    end

    local var6 = isBorderlessBubbleChatEnabled() and arg1.state.isShowingBorderlessBubbleChat == true

    local var7 = var6 and arg1.borderlessDistanceTransparency:getValue() < 1

    if FFlagExpChatUseProximityStore then
        if arg1.renderDistanceBinding:getValue() or arg1.props.testMode or var7 then
            arg1.setInvisibleCount(0)
        else
            if arg1.invisibleCount:getValue() > num2 then
                return
            end

            arg1.setInvisibleCount(arg1.invisibleCount:getValue() + 1)
        end
    elseif not (arg1.state.isInsideRenderDistance or var7) then
        return
    end

    local var8 = if FFlagExpChatUseProximityStore then Roact.joinBindings({ renderDistance = arg1.renderDistanceBinding, maximizeDistance = arg1.maximizeDistanceBinding }):map(
        function(arg2)
            return {
                isInsideMaximizeDistance = arg2.maximizeDistance,
                isDistant = not arg2.maximizeDistance
            }
        end
    ) else nil

    local tbl3 = {}

    local var9 = arg1.state.filteredMessages and #arg1.state.filteredMessages > 0

    local var10 = arg1.props.voiceEnabled and not arg1.state.voiceTimedOut

    if GlobalFlags.AvatarChatEnabled and bool4 then
        var10 = var10 and not arg1.state.selfViewOpen
    end

    if GlobalFlags.ChromeEnabled and bool4 then
        var10 = false
    end

    local var11 = var10 and not (GlobalFlags.AvatarChatEnabled or GlobalFlags.ChromeEnabled)
    local renderInsert = if var10 then arg1.renderInsert else nil
    local vector2_2 = vector2

    local var12 = if FFlagExpChatUseProximityStore then arg1.voiceTimedOutBinding:map(function(arg2)
        local var12 = arg1.props.voiceEnabled and not arg2
        if GlobalFlags.AvatarChatEnabled and bool4 then
            var12 = var12 and not arg1.state.selfViewOpen
        end
        if GlobalFlags.ChromeEnabled and bool4 then
            var12 = false
        end

        return var12
    end) else nil

    local clientSettings = arg1.props.clientSettings

    if FFlagExpChatUseProximityStore then
        if arg1.props.testMode or GlobalFlags.AvatarChatEnabled or GlobalFlags.ChromeEnabled then
            local tbl4 = {
                Visible = if FFlagExpChatUseProximityStore and not arg1.props.testMode then arg1.voiceTimedOutBinding:map(function(arg2)
                    return arg1:shouldRenderPlayerButtonsNew(arg2)
                end) else arg1:shouldRenderPlayerButtons(),
                chatSettings = arg1.props.chatSettings,
                isInsideMaximizeDistance = var8:map(function(arg2)
                    return arg2.isInsideMaximizeDistance
                end),
                LayoutOrder = 2,
                isLocalPlayer = bool4,
                userId = arg1.props.userId,
                getIcon = arg1.props.getIconVoiceIndicator,
                hasCameraPermissions = arg1.props.hasCameraPermissions,
                hasMicPermissions = arg1.props.hasMicPermissions,
                onClickedVoiceIndicator = arg1.wrappedOnClickVoiceIndicator,
                onClickedCameraIndicator = arg1.props.onClickedCameraIndicator,
                voiceEnabled = arg1.props.voiceEnabled,
                displayCameraDeniedToast = arg1.props.displayCameraDeniedToast,
                isCamEnabledForUserAndPlace = arg1.props.isCamEnabledForUserAndPlace,
                setCameraPermissionStateFromControl = arg1.props.setCameraPermissionStateFromControl,
                getPermissions = arg1.props.getPermissions,
                isCameraOnlyUser = arg1.props.isCameraOnlyUser,
                isVoiceServiceInitialized = arg1.props.isVoiceServiceInitialized
            }

            tbl3.PlayerButtons = Roact.createElement(PlayerButtons, tbl4)

            tbl3.listLayout = Roact.createElement("UIListLayout", {
                SortOrder = Enum.SortOrder.LayoutOrder,
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                VerticalAlignment = Enum.VerticalAlignment.Bottom,
                Padding = UDim.new(0, 8)
            })
            tbl3.padding = Roact.createElement("UIPadding", { PaddingBottom = UDim.new(0, 8) })
        elseif var10 and var9 == false then
            tbl3.VoiceBubble = Roact.createElement(BlankBubble, {
                chatSettings = chatSettings,
                userId = arg1.props.userId,
                renderInsert = renderInsert,
                insertSize = vector2_2,
                isDistant = not arg1.state.isInsideMaximizeDistance,
                clientSettings = clientSettings
            })
        end
    elseif GlobalFlags.AvatarChatEnabled or GlobalFlags.ChromeEnabled then
        if arg1:shouldRenderPlayerButtons() then
            local tbl4 = {
                chatSettings = arg1.props.chatSettings,
                isInsideMaximizeDistance = arg1.state.isInsideMaximizeDistance,
                LayoutOrder = 2,
                isLocalPlayer = bool4,
                userId = arg1.props.userId,
                getIcon = arg1.props.getIconVoiceIndicator,
                hasCameraPermissions = arg1.props.hasCameraPermissions,
                hasMicPermissions = arg1.props.hasMicPermissions,
                onClickedVoiceIndicator = arg1.wrappedOnClickVoiceIndicator,
                onClickedCameraIndicator = arg1.props.onClickedCameraIndicator,
                voiceEnabled = arg1.props.voiceEnabled,
                displayCameraDeniedToast = arg1.props.displayCameraDeniedToast,
                isCamEnabledForUserAndPlace = arg1.props.isCamEnabledForUserAndPlace,
                setCameraPermissionStateFromControl = arg1.props.setCameraPermissionStateFromControl,
                getPermissions = arg1.props.getPermissions,
                isCameraOnlyUser = arg1.props.isCameraOnlyUser,
                isVoiceServiceInitialized = arg1.props.isVoiceServiceInitialized
            }

            tbl3.PlayerButtons = Roact.createElement(PlayerButtons, tbl4)

            tbl3.listLayout = Roact.createElement("UIListLayout", {
                SortOrder = Enum.SortOrder.LayoutOrder,
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                VerticalAlignment = Enum.VerticalAlignment.Bottom,
                Padding = UDim.new(0, 8)
            })
            tbl3.padding = Roact.createElement("UIPadding", { PaddingBottom = UDim.new(0, 8) })
        end
    elseif var10 and var9 == false then
        tbl3.VoiceBubble = Roact.createElement(BlankBubble, {
            chatSettings = chatSettings,
            userId = arg1.props.userId,
            renderInsert = renderInsert,
            insertSize = vector2_2,
            isDistant = not arg1.state.isInsideMaximizeDistance,
            clientSettings = clientSettings
        })
    end

    if var6 then
        tbl3.PlayerButtons = nil
    end

    local showCaret = arg1:shouldRenderCaret()

    if FFlagExpChatUseProximityStore then
        local createElement = Roact.createElement
        local str1 = "Frame"

        local tbl4 = {
            Size = UDim2.fromScale(1, 1),
            BackgroundTransparency = 1,
            Visible = var8:map(function(arg2)
                return arg2.isInsideMaximizeDistance or var6
            end)
        }

        local tbl5 = {
            BubbleChatList = Roact.createElement(BubbleChatList, {
                userId = arg1.props.userId,
                isVisible = var8:map(function(arg2)
                    return arg2.isInsideMaximizeDistance or var6
                end),
                onLastBubbleFadeOut = arg1.onLastBubbleFadeOut,
                chatSettings = chatSettings,
                renderFirstInsert = if var11 then renderInsert else nil,
                insertSize = vector2_2,
                messages = arg1.state.filteredMessages,
                clientSettings = clientSettings,
                isTextChatServiceOn = arg1.props.isTextChatServiceOn,
                showCaret = arg1.voiceTimedOutBinding:map(function(arg2)
                    return arg1:shouldRenderCaretNew(arg2)
                end),
                isDistant = if isBorderlessBubbleChatEnabled() then var8:map(function(arg2)
                    return arg2.isDistant
                end) else nil,
                borderlessDistanceTransparency = if isBorderlessBubbleChatEnabled() then arg1.borderlessDistanceTransparency else nil
            })
        }

        tbl3.BubbleChatListContainer = createElement(str1, tbl4, tbl5)

        if var9 and not var6 then
            local createElement2 = Roact.createElement
            local str2 = "Frame"

            local tbl6 = {
                Size = UDim2.fromScale(1, 1),
                BackgroundTransparency = 1,
                Visible = var8:map(function(arg2): boolean
                    return not arg2.isInsideMaximizeDistance
                end)
            }

            local tbl7 = { DistantBubble = 0 }
            local createElement3 = Roact.createElement
            local var14 = ChatBubbleDistant
            local tbl8 = {
                fadingOut = not arg1.state.filteredMessages or #arg1.state.filteredMessages == 0,
                onFadeOut = arg1.onLastBubbleFadeOut,
                chatSettings = chatSettings,
                renderInsert = 0,
                insertSize = 0,
                clientSettings = 0,
                showCaret = 0
            }

            if not var11 then
                renderInsert = nil
            end

            tbl8.renderInsert = renderInsert
            tbl8.insertSize = vector2_2
            tbl8.clientSettings = clientSettings
            tbl8.showCaret = arg1.voiceTimedOutBinding:map(function(arg2)
                return arg1:shouldRenderCaretNew(arg2)
            end)

            tbl7.DistantBubble = createElement3(var14, tbl8)
            tbl3.DistantBubbleContainer = createElement2(str2, tbl6, tbl7)
        end
    elseif arg1.state.isInsideMaximizeDistance or var6 then
        local createElement = Roact.createElement
        local var14 = BubbleChatList
        local tbl4 = {
            userId = arg1.props.userId,
            isVisible = arg1.state.isInsideMaximizeDistance or var6,
            onLastBubbleFadeOut = arg1.onLastBubbleFadeOut,
            chatSettings = chatSettings,
            renderFirstInsert = 0,
            insertSize = 0,
            messages = 0,
            clientSettings = 0,
            isTextChatServiceOn = 0,
            showCaret = 0,
            isDistant = 0,
            borderlessDistanceTransparency = 0
        }

        if not var11 then
            renderInsert = nil
        end

        tbl4.renderFirstInsert = renderInsert
        tbl4.insertSize = vector2_2
        tbl4.messages = arg1.state.filteredMessages
        tbl4.clientSettings = clientSettings
        tbl4.isTextChatServiceOn = arg1.props.isTextChatServiceOn
        tbl4.showCaret = showCaret
        tbl4.isDistant = if isBorderlessBubbleChatEnabled() then not arg1.state.isInsideMaximizeDistance else nil
        tbl4.borderlessDistanceTransparency = if isBorderlessBubbleChatEnabled() then arg1.borderlessDistanceTransparency else nil
        tbl3.BubbleChatList = createElement(var14, tbl4)
    elseif var9 then
        local createElement = Roact.createElement
        local var14 = ChatBubbleDistant
        local tbl4 = {
            fadingOut = not arg1.state.filteredMessages or #arg1.state.filteredMessages == 0,
            onFadeOut = arg1.onLastBubbleFadeOut,
            chatSettings = chatSettings,
            renderInsert = 0,
            insertSize = 0,
            clientSettings = 0,
            showCaret = 0
        }

        if not var11 then
            renderInsert = nil
        end

        tbl4.renderInsert = renderInsert
        tbl4.insertSize = vector2_2
        tbl4.clientSettings = clientSettings
        tbl4.showCaret = showCaret
        tbl3.DistantBubble = createElement(var14, tbl4)
    end

    local var14 = if bool4 then chatSettings.LocalPlayerStudsOffset or Vector3.new(0, 1, 0.1) else Vector3.new(0, 1, 0.1)

    if not FFlagExpChatUseProximityStore then
        local createElement = Roact.createElement
        local str1 = "BillboardGui"
        local tbl4 = {
            Adornee = adornee,
            Active = 0,
            Size = 0,
            SizeOffset = 0,
            StudsOffset = 0,
            StudsOffsetWorldSpace = 0,
            ResetOnSpawn = false,
            MaxDistance = 0
        }

        if GlobalFlags.AvatarChatEnabled then
            var10 = arg1:shouldRenderPlayerButtons()
        end

        tbl4.Active = var10
        tbl4.Size = UDim2.fromOffset(500, 200)
        tbl4.SizeOffset = Vector2.new(0, 0.5)
        tbl4.StudsOffset = var14 + Vector3.new(0, chatSettings.VerticalStudsOffset, 0)
        tbl4.StudsOffsetWorldSpace = arg1.offset

        tbl4.MaxDistance = if var6 then arg1.borderlessBillboardMaxDistance else nil
        return createElement(str1, tbl4, tbl3)
    end

    local createElement = Roact.createElement
    local str1 = "BillboardGui"

    local tbl4 = {
        Adornee = adornee,
        Active = if GlobalFlags.AvatarChatEnabled then arg1.voiceTimedOutBinding:map(function(arg2)
            return arg1:shouldRenderPlayerButtonsNew(arg2)
        end) else var12:map(function<T>(arg2: T): T
            return arg2
        end),
        Size = UDim2.fromOffset(500, 200),
        SizeOffset = Vector2.new(0, 0.5),
        StudsOffset = var14 + Vector3.new(0, chatSettings.VerticalStudsOffset, 0),
        StudsOffsetWorldSpace = arg1.offset,
        ResetOnSpawn = false,
        MaxDistance = if var6 then Roact.joinBindings({
            renderDistance = arg1.renderDistanceBinding,
            borderlessDistanceTransparency = arg1.borderlessDistanceTransparency,
            borderlessBillboardMaxDistance = arg1.borderlessBillboardMaxDistance
        }):map(
            function(arg2)
                return if arg2.renderDistance or arg2.borderlessDistanceTransparency < 1 then arg2.borderlessBillboardMaxDistance else 0
            end
        ) else arg1.renderDistanceBinding:map(function(arg2): number
            return if arg2 then math.huge else 0
        end)
    }

    return createElement(str1, tbl4, tbl3)
end

function var2.didUpdate(arg1, _, arg2)
    if FFlagExpChatUseProximityStore then
        if (not arg1.state.filteredMessages or #arg1.state.filteredMessages == 0) and not arg1.renderDistanceBinding:getValue() then
            arg1.onLastBubbleFadeOut()
        end
    elseif (not arg1.state.filteredMessages or #arg1.state.filteredMessages == 0) and not arg1.state.isInsideRenderDistance then
        arg1.onLastBubbleFadeOut()
    end

    if arg1.state.filteredMessages and #arg1.state.filteredMessages > 0 then
        arg1.isFadingOut = false
    end

    if FFlagExpChatUseProximityStore and arg1.state.voiceStateCounter ~= arg2.voiceStateCounter then
        arg1.setVoiceTimedOutBinding(false)
    end

    arg1:checkCounterForTimeout(arg2.voiceStateCounter)
end

function var2.didMount(arg1)
    arg1.isMounted = true

    if arg1.MessagesStore then
        arg1.messagesEffect = createEffect(function(arg2)
            local userId = arg1.props.userId
            if not userId and arg1.props.partOrModel then
                userId = arg1.MessagesStore.getPartOrModelToMockUserId(arg2)[arg1.props.partOrModel]
            end

            if not userId then
                arg1:setState({ filteredMessages = {} })

                return
            end

            local var3 = arg1.MessagesStore.getUserBubbleMessages(userId)(arg2)
            local var4 = if FFlagExpChatUseChatConfigStore then GetChatConfigurationStore(false).getBubbleChatSettings(arg2) else arg1.props.chatSettings
            local maxBubbles = var4.MaxBubbles
            local var5 = var4.BubbleDuration * 1000
            local filteredMessages = if isBorderlessBubbleChatEnabled() then getDisplayedBubbleMessages(var3, var5, maxBubbles, getServerTimeNowMillis()) else getRecentMessages(var3, var5, maxBubbles)
            arg1:setState({ filteredMessages = filteredMessages })
        end)
    end
    if FFlagExpChatUseChatConfigStore then
        arg1.chatConfigEffect = createEffect(function(arg2)
            local savedChatSettings = GetChatConfigurationStore(false).getBubbleChatSettings(arg2)
            arg1:setState({ savedChatSettings = savedChatSettings })
        end)
    end

    local offsetGoal = arg1:getVerticalOffset()
    arg1.offsetGoal = offsetGoal
    arg1.offsetMotor:setGoal(Otter.instant(offsetGoal))
    if FFlagExpChatUseAdorneeStore then
        local context = ExpChatShared.context
        local adorneeStore = context and context.adorneeStore
        local num3 = if Players.LocalPlayer then Players.LocalPlayer.UserId else -1
        if adorneeStore and arg1.props.userId and createEffect then
            arg1.adorneeEffect = createEffect(function(arg2)
                local effectiveAdornee = arg1:getEffectiveAdornee(arg2)
                arg1.updateAdorneeBinding(effectiveAdornee)
            end)

            if FFlagEasierUnmuting then
                local adornee = adorneeStore.getAdornee(num3)
                if adornee then
                    arg1.localAdorneeEffect = createEffect(function(arg2)
                        local var3 = adornee(arg2)
                        arg1.updateLocalAdorneeBinding(var3)
                    end)
                end
            end
        end
    end

    if FFlagExpChatUseProximityStore and arg1.ProximityStore and arg1.props.userId then
        arg1.proximityEffect = createEffect(function(arg2)
            local var3 = arg1.ProximityStore.getUserProximityState(arg1.props.userId)(arg2)

            arg1.updateRenderDistanceBinding(var3.isInsideRenderDistance)
            arg1.updateMaximizeDistanceBinding(var3.isInsideMaximizeDistance)
        end)
    end

    arg1.heartbeatConn = RunService.Heartbeat:Connect(function(deltaTime: number)
        if arg1.props.billboardUpdateFrequency > 0 then
            arg1.lastDistanceUpdate += deltaTime
            if arg1.lastDistanceUpdate < arg1.props.billboardUpdateFrequency then
                return
            end
            arg1.lastDistanceUpdate = 0
        elseif not arg1.props.tests_skipHeartbeatCheck then
            if arg1.heartbeatCount < num1 then
                local var3 = arg1
                var3.heartbeatCount += 1
                return
            end

            arg1.heartbeatCount = 0
        end

        local adorneeInstance = if FFlagExpChatUseAdorneeStore then getAdorneeInstance(arg1.adorneeBinding:getValue(), arg1.state.savedChatSettings.AdorneeName) else getAdorneeInstance(arg1.props.adornee or arg1.props.partOrModel, arg1.state.savedChatSettings.AdorneeName)

        if CurrentCamera and adorneeInstance then
            local var3 = if adorneeInstance:IsA("Attachment") then adorneeInstance.WorldPosition else adorneeInstance.Position
            local magnitude = (CurrentCamera.CFrame.Position - var3).Magnitude
            local isInsideRenderDistance = magnitude < arg1.state.savedChatSettings.MaxDistance
            local isInsideMaximizeDistance = magnitude < arg1.state.savedChatSettings.MinimizeDistance

            if FFlagExpChatUseProximityStore and arg1.ProximityStore then
                if not arg1._lastProximityState
                    or arg1._lastProximityState.isInsideRenderDistance ~= isInsideRenderDistance
                    or arg1._lastProximityState.isInsideMaximizeDistance ~= isInsideMaximizeDistance
                then
                    arg1.ProximityStore.updateProximity(arg1.props.userId, isInsideRenderDistance, isInsideMaximizeDistance)

                    arg1._lastProximityState = {
                        isInsideRenderDistance = isInsideRenderDistance,
                        isInsideMaximizeDistance = isInsideMaximizeDistance
                    }
                end
            elseif isInsideMaximizeDistance ~= arg1.state.isInsideMaximizeDistance
                or isInsideRenderDistance ~= arg1.state.isInsideRenderDistance
            then
                arg1:setState({ isInsideRenderDistance = isInsideRenderDistance, isInsideMaximizeDistance = isInsideMaximizeDistance })
            end

            if isBorderlessBubbleChatEnabled() then
                arg1:setBorderlessDistanceVisible(magnitude < getBorderlessBubbleChatRenderDistance(arg1.state.savedChatSettings))
            end
        end

        local verticalOffset = arg1:getVerticalOffset()
        if math.abs(verticalOffset - arg1.offsetGoal) > 0.5 then
            arg1.offsetGoal = verticalOffset
            arg1.offsetMotor:setGoal(Otter.spring(verticalOffset, tbl1))
        end

        local var3 = if isBorderlessBubbleChatEnabled() then getServerTimeNowMillis() else workspace:GetServerTimeNow() * 1000
        local var4 = arg1.state.savedChatSettings.BubbleDuration * 1000
        for _, value in arg1.state.filteredMessages do
            local var5 = if isBorderlessBubbleChatEnabled() then getBubbleDurationInMillis(value, var4) else var4
            local var6 = if isBorderlessBubbleChatEnabled() then getBubbleChatStartTimeMillis(value) else value.timestamp.UnixTimestampMillis

            if not (var5 <= var3 - var6) then
                continue
            end

            arg1:setState(function(arg2)
                local filteredMessages = {}
                for _, value2 in ipairs(arg2.filteredMessages) do
                    local var7 = if isBorderlessBubbleChatEnabled() then getBubbleDurationInMillis(value2, var4) else var4
                    local var8 = if isBorderlessBubbleChatEnabled() then getBubbleChatStartTimeMillis(value2) else value2.timestamp.UnixTimestampMillis

                    if var3 - var8 < var7 then
                        table.insert(filteredMessages, value2)
                    end
                end
                return { filteredMessages = filteredMessages }
            end)

            return
        end
    end)

    arg1:checkCounterForTimeout(nil)
end

function var2.willUnmount(arg1)
    var1:trace("Unmounting billboards for {}", arg1.state.shortId)
    arg1.isMounted = false
    if arg1.characterConn then
        arg1.characterConn:Disconnect()
        arg1.characterConn = nil
    end
    if arg1.heartbeatConn then
        arg1.heartbeatConn:Disconnect()
        arg1.heartbeatConn = nil
    end
    if arg1.humanoidDiedConn then
        arg1.humanoidDiedConn:Disconnect()
        arg1.humanoidDiedConn = nil
    end
    if arg1.selfViewConnection then
        arg1.selfViewConnection:disconnect()
        arg1.selfViewConnection = nil
    end

    if arg1.adorneeEffect then
        arg1.adorneeEffect()
        arg1.adorneeEffect = nil
    end
    if arg1.localAdorneeEffect then
        arg1.localAdorneeEffect()
        arg1.localAdorneeEffect = nil
    end
    if FFlagExpChatUseProximityStore and arg1.proximityEffect then
        arg1.proximityEffect()
        arg1.proximityEffect = nil
    end

    if arg1.messagesEffect then
        arg1.messagesEffect()
        arg1.messagesEffect = nil
    end

    if FFlagExpChatUseChatConfigStore and arg1.chatConfigEffect then
        arg1.chatConfigEffect()
        arg1.chatConfigEffect = nil
    end

    if isBorderlessBubbleChatEnabled() then
        arg1:cancelBorderlessDistanceFade()
    end

    arg1.offsetMotor:destroy()
end

function var2.getDerivedStateFromProps(arg1, arg2)
    local shortId = "..." .. string.sub(tostring(arg1.userId), -4)
    local var3, var4, voiceState

    if arg2.lastVoiceState == arg1.voiceState then
        var3 = nil
        var4 = nil
        voiceState = nil
    else
        var3 = (arg2.voiceStateCounter or 0) + 1

        voiceState = arg1.voiceState
        var4 = false
    end

    local filteredMessages = arg2.filteredMessages
    local bool4

    if isBorderlessBubbleChatEnabled() then
        local var5 = filteredMessages[#filteredMessages]
        if var5 then
            bool4 = isBorderlessBubbleChatMessage(var5)
        else
            bool4 = arg2.isShowingBorderlessBubbleChat == true
        end
    else
        bool4 = nil
    end

    return {
        savedChatSettings = arg1.chatSettings,
        shortId = shortId,
        filteredMessages = filteredMessages,
        voiceStateCounter = var3,
        voiceTimedOut = var4,
        lastVoiceState = voiceState,
        isShowingBorderlessBubbleChat = bool4
    }
end

local function mapStateToProps(arg1, arg2)
    local var3 = arg1.Messages.messagesBySenderId[arg2.userId]
    local var4 = if var3 == nil then nil else var3[#var3]
    local var5 = if Players.LocalPlayer then tostring(Players.LocalPlayer.UserId) else ""
    return {
        chatSettings = if arg2.isTextChatServiceOn then if FFlagExpChatUseChatConfigStore then GetChatConfigurationStore(false).getBubbleChatSettings(false) else arg1.BubbleChatSettings else getSettingsForMessage(arg1.LegacyBubbleChatSettings, var4),
        adornee = if FFlagExpChatUseAdorneeStore then nil else arg1.Adornees[arg2.userId] or arg2.partOrModel,
        localAdornee = if FFlagExpChatUseAdorneeStore or not FFlagEasierUnmuting then nil else arg1.Adornees[var5],
        clientSettings = arg1.ClientSettings,
        isVoiceUIVisible = arg1.Voice.isVoiceUIVisible
    }
end

if FFlagExpChatUseAdorneeStore then
    local var3 = RoactRodux.connect(mapStateToProps)(var2)
    if bool2 then
        return React.memo(var3)
    end
    return var3
elseif bool2 then
    return React.memo(RoactRodux.connect(mapStateToProps)(var2))
else
    return RoactRodux.connect(mapStateToProps)(var2)
end
