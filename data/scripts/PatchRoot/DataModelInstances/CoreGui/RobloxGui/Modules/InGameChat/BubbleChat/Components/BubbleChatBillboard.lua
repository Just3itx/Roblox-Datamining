-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:01:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local RobloxGui = CoreGui:WaitForChild("RobloxGui")
local StarterGui = game:GetService("StarterGui")
local VRService = game:GetService("VRService")

local var1 = require(script.Parent.Parent.Logger)(script.Name)

local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)
local t = require(CorePackages.Packages.t)
local Otter = require(CorePackages.Packages.Otter)

local BubbleChatList = require(script.Parent.BubbleChatList)
local ChatBubbleDistant = require(script.Parent.ChatBubbleDistant)
local VoiceBubble = require(script.Parent.VoiceBubble)
local VoiceIndicator = require(RobloxGui.Modules.VoiceChat.Components.VoiceIndicator)
local Types = require(script.Parent.Parent.Types)
local Constants = require(script.Parent.Parent.Constants)
local getSettingsForMessage = require(script.Parent.Parent.Helpers.getSettingsForMessage)
local selfViewVisibilityUpdatedSignal = require(RobloxGui.Modules.SelfView.selfViewVisibilityUpdatedSignal)
local ChromeEnabled = require(CorePackages.Workspace.Packages.Chrome).Enabled
local Constants2 = require(RobloxGui.Modules.VoiceChat.Constants)

local default = require(RobloxGui.Modules.VoiceChat.VoiceChatServiceManager).default
local GetFFlagMicConnectingToast = require(RobloxGui.Modules.Flags.GetFFlagMicConnectingToast)
local GetFFlagBubbleChatInexistantAdorneeFix = require(RobloxGui.Modules.Flags.GetFFlagBubbleChatInexistantAdorneeFix)
local publicApi = require(RobloxGui.Modules.SelfView.publicApi)

local num1 = game:DefineFastInt("BubbleVoiceTimeoutMillis", 1000)

local bool1 = game:DefineFastFlag("DebugAllowControlButtonsNoVoiceChat", false)

local IXPServiceWrapper = require(CorePackages.Workspace.Packages.IxpServiceWrapper).IXPServiceWrapper
local bool2 = game:DefineFastFlag("EasierUnmuting3", false)
local bool3 = game:DefineFastFlag("EasierUnmutingBasedOnCamera", false)
local bool4 = game:DefineFastFlag("EasierUnmutingHideIfMuted", false)
local num2 = game:DefineFastInt("EasierUnmutingDisplayDistance", 20)
local str1 = game:DefineFastString("EasierUnmutingIXPLayerName", "Voice.UserAgency")
local str2 = game:DefineFastString("EasierUnmutingIXPLayerValue", "VoiceUserAgencyEnabled")

local var2 = Roact.PureComponent:extend("BubbleChatBillboard")

local tbl1 = { dampingRatio = 1, frequency = 4 }

var2.validateProps = t.strictInterface({
    userId = t.string,
    onFadeOut = t.optional(t.callback),
    voiceEnabled = t.optional(t.boolean),
    bubbleChatEnabled = t.optional(t.boolean),
    chatSettings = Types.IChatSettings,
    messageIds = t.optional(t.array(t.string)),
    lastMessage = t.optional(Types.IMessage),
    voiceState = t.optional(t.string)
})

function getEasierUnmutingDistance(arg1)
    if not arg1 then
        return nil
    end
    local humanoidRootPart = Players.LocalPlayer
        and Players.LocalPlayer.Character
        and Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

    local humanoidRootPartCFramePosition = humanoidRootPart and humanoidRootPart.CFrame and humanoidRootPart.CFrame.Position

    local currentCameraCFramePosition = workspace.CurrentCamera and workspace.CurrentCamera.CFrame.Position

    return if bool3 or not humanoidRootPartCFramePosition then if currentCameraCFramePosition then (arg1 - currentCameraCFramePosition).Magnitude else nil else (arg1 - humanoidRootPartCFramePosition).Magnitude
end

function var2.init(arg1)
    local selfViewOpen = publicApi.getSelfViewIsOpenAndVisible()
    local selfViewEnabled = StarterGui:GetCoreGuiEnabled(Enum.CoreGuiType.SelfView)

    local tbl2 = {
        adornee = nil,
        isInsideRenderDistance = false,
        isInsideMaximizeDistance = false,
        savedChatSettings = arg1.props.chatSettings,
        voiceTimedOut = false,
        voiceStateCounter = 0,
        lastVoiceState = nil,
        selfViewOpen = selfViewOpen,
        selfViewEnabled = selfViewEnabled,
        isInsideEasierUnmutingDistance = not bool2 and nil,
        isMuted = not (bool2 and bool4) and nil,
        isInEasierUnmutingTreatment = not bool2 and nil,
        haveLoggedUserExposure = not bool2 and nil
    }
    arg1:setState(tbl2)

    arg1.isMounted = false
    local offset, updateOffset = Roact.createBinding(Vector3.new())
    arg1.offset = offset
    arg1.updateOffset = updateOffset
    arg1.offsetMotor = Otter.createSingleMotor(0)
    arg1.offsetMotor:onStep(function(y: number?)
        arg1.updateOffset(Vector3.new(0, y, 0))
    end)
    arg1.offsetGoal = 0

    function arg1.onSelfViewVisibilityUpdated()
        arg1:setState({ selfViewOpen = publicApi.getSelfViewIsOpenAndVisible() })
    end

    function arg1.onLastBubbleFadeOut()
        if arg1.props.onFadeOut and not arg1.isFadingOut then
            arg1.isFadingOut = true
            arg1.props.onFadeOut(arg1.props.userId)
        end

        if arg1.state.hasMessage and arg1.isMounted then
            arg1:setState({ hasMessage = false })
        end
    end

    if arg1.props.voiceEnabled then
        local onClicked = arg1.props.userId == tostring(Players.LocalPlayer.UserId) and function()
            if arg1.props.voiceState == Constants.VOICE_STATE.ERROR then
                default:RejoinPreviousChannel()
            elseif GetFFlagMicConnectingToast() and arg1.props.voiceState == Constants.VOICE_STATE.CONNECTING then
                default:ShowVoiceChatLoadingMessage()
            else
                default:ToggleMic("LegacyBubbleChat")
            end
        end or function()
            default:ToggleMutePlayer(
                tonumber(arg1.props.userId),
                if arg1:isShowingDueToEasierUnmuting() then Constants2.VOICE_CONTEXT_TYPE.EASIER_UNMUTING else Constants2.VOICE_CONTEXT_TYPE.BUBBLE_CHAT
            )
        end

        local userId = arg1.props.userId

        local userId2 = Players.LocalPlayer.UserId
        local iconStyle = if userId == tostring(userId2) then "MicDark" else "SpeakerDark"

        function arg1.renderInsert()
            return Roact.createElement(VoiceIndicator, { onClicked = onClicked, userId = userId, iconStyle = iconStyle })
        end

        arg1.insertSize = Vector2.new(28, 28)
    end

    function arg1.onCoreGuiChanged()
        local coreGuiEnabled = StarterGui:GetCoreGuiEnabled(Enum.CoreGuiType.SelfView)
        if arg1.state.selfViewOpen ~= coreGuiEnabled then
            arg1:setState({ selfViewOpen = coreGuiEnabled })
        end
    end

    arg1.selfViewVisibilityUpdatedSignal = selfViewVisibilityUpdatedSignal:connect(function()
        arg1:setState({ selfViewOpen = publicApi.getSelfViewIsOpenAndVisible() })
    end)

    if bool2 then
        local success, result = pcall(function()
            return IXPServiceWrapper:GetLayerData(str1)
        end)

        if success and result and result[str2] then
            arg1:setState({ isInEasierUnmutingTreatment = true })
        end
    end

    if not bool2 or not arg1.state.isInEasierUnmutingTreatment or not bool4 then
        return
    end
    arg1.participantsUpdateConnection = default.participantsUpdate.Event:Connect(function(arg2)
        local var5 = arg2[arg1.props.userId]

        if not var5 then
            return
        end

        if var5.isMuted ~= arg1.state.isMuted then
            arg1:setState({ isMuted = var5.isMuted })
        end
    end)
end

function var2.isShowingDueToEasierUnmuting(arg1)
    local isInEasierUnmutingTreatment = bool2 and arg1.state.isInEasierUnmutingTreatment

    if isInEasierUnmutingTreatment then
        if arg1.props.voiceState == Constants.VOICE_STATE.LOCAL_MUTED then
            isInEasierUnmutingTreatment = arg1.state.isInsideEasierUnmutingDistance
            isInEasierUnmutingTreatment = isInEasierUnmutingTreatment and not (bool4 and arg1.state.isMuted)
        else
            isInEasierUnmutingTreatment = false
        end
    end

    return isInEasierUnmutingTreatment
end

function var2.checkCounterForTimeout(arg1, voiceStateCounter)
    local userId = arg1.props.userId

    if userId == tostring(Players.LocalPlayer.UserId)
        or arg1.state.lastVoiceState == Constants.VOICE_STATE.TALKING
        or arg1.state.voiceStateCounter == voiceStateCounter
    then
        return
    end
    local voiceStateCounter2 = arg1.state.voiceStateCounter
    delay(num1 / 1000, function()
        if arg1.state.voiceStateCounter == voiceStateCounter2 and arg1.isMounted then
            arg1:setState({ voiceTimedOut = true })
        end
    end)
end

function var2.checkCounterForTimeoutWithEasierUnmuting(arg1, arg2)
    local voiceStateCounter = if arg2 then arg2.voiceStateCounter else nil

    if not (bool2 and arg1.state.isInEasierUnmutingTreatment) then
        return arg1:checkCounterForTimeout(voiceStateCounter)
    end

    local bool5 = arg1.props.userId ~= tostring(Players.LocalPlayer.UserId)
    local bool6 = arg1.state.voiceStateCounter ~= voiceStateCounter
    local bool7 = not (arg1.state.lastVoiceState == Constants.VOICE_STATE.TALKING)
        and arg1.state.lastVoiceState ~= Constants.VOICE_STATE.LOCAL_MUTED

    if not bool5 or not bool6 or not bool7 then
        return
    end

    local voiceStateCounter2 = arg1.state.voiceStateCounter

    delay(num1 / 1000, function()
        if arg1.state.voiceStateCounter == voiceStateCounter2 and arg1.isMounted then
            arg1:setState({ voiceTimedOut = true })
        end
    end)
end

function var2.didMount(arg1)
    arg1.isMounted = true
    local adornee = arg1.props.lastMessage and arg1.props.lastMessage.adornee
    arg1:setState({ adornee = adornee })

    local offsetGoal = arg1:getVerticalOffset(adornee)
    arg1.offsetGoal = offsetGoal
    arg1.offsetMotor:setGoal(Otter.instant(offsetGoal))

    local var3 = nil
    if adornee then
        var3 = Players:GetPlayerFromCharacter(adornee)
    elseif tonumber(arg1.props.userId) then
        var3 = Players:GetPlayerByUserId(arg1.props.userId)
    end

    if var3 then
        if var3.Character then
            coroutine.wrap(function()
                arg1:onCharacterAdded(var3, var3.Character)
            end)()
        end
        arg1.characterConn = var3.CharacterAdded:Connect(function(character: Model)
            arg1:onCharacterAdded(var3, character)
        end)
    end

    arg1.heartbeatConn = RunService.Heartbeat:Connect(function()
        local adorneeInstance = arg1:getAdorneeInstance(arg1.state.adornee)
        if workspace.CurrentCamera and adorneeInstance then
            local var4 = adorneeInstance:IsA("Attachment") and adorneeInstance.WorldPosition or adorneeInstance.Position
            local magnitude = (workspace.CurrentCamera.CFrame.Position - var4).Magnitude
            local isInsideRenderDistance = magnitude < arg1.state.savedChatSettings.MaxDistance
            local isInsideMaximizeDistance = magnitude < arg1.state.savedChatSettings.MinimizeDistance
            local bool7 = false

            if bool2 and arg1.state.isInEasierUnmutingTreatment then
                local easierUnmutingDistance = getEasierUnmutingDistance(var4)

                if easierUnmutingDistance ~= nil then
                    bool7 = easierUnmutingDistance < num2
                end
            end

            if isInsideMaximizeDistance ~= arg1.state.isInsideMaximizeDistance
                or isInsideRenderDistance ~= arg1.state.isInsideRenderDistance
                or bool2 and arg1.state.isInEasierUnmutingTreatment and bool7 ~= arg1.state.isInsideEasierUnmutingDistance
            then
                arg1:setState({
                    isInsideRenderDistance = isInsideRenderDistance,
                    isInsideMaximizeDistance = isInsideMaximizeDistance,
                    isInsideEasierUnmutingDistance = bool7
                })
            end
        end

        local verticalOffset = arg1:getVerticalOffset(arg1.state.adornee)
        if math.abs(verticalOffset - arg1.offsetGoal) > Constants.BILLBOARD_OFFSET_EPSILON then
            arg1.offsetGoal = verticalOffset
            arg1.offsetMotor:setGoal(Otter.spring(verticalOffset, tbl1))
        end
    end)

    if bool2 and arg1.state.isInEasierUnmutingTreatment then
        arg1:checkCounterForTimeoutWithEasierUnmuting(nil)
    else
        arg1:checkCounterForTimeout(nil)
    end
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
    arg1.offsetMotor:destroy()

    if arg1.selfViewVisibilityUpdatedSignal then
        arg1.selfViewVisibilityUpdatedSignal:disconnect()
        arg1.selfViewVisibilityUpdatedSignal = nil
    end
    if bool2 and arg1.state.isInEasierUnmutingTreatment and bool4 and arg1.participantsUpdateConnection then
        arg1.participantsUpdateConnection:Disconnect()
        arg1.participantsUpdateConnection = nil
    end
end

local function waitForFirst(...)
    local bindableEvent = Instance.new("BindableEvent")
    local tbl2 = { ... }

    local function fire(...)
        for i = 1, #tbl2 do
            tbl2[i]:Disconnect()
        end

        return bindableEvent:Fire(...)
    end

    for i = 1, #tbl2 do
        tbl2[i] = tbl2[i]:Connect(fire)
    end

    return bindableEvent.Event:Wait()
end

local function findFirstChildByNameAndClass(character, name: string, str3: string)
    for _, child in ipairs(character:GetChildren()) do
        if child.Name == name and child:IsA(str3) then
            return child
        end
    end
end

function var2.onCharacterAdded(arg1, arg2, character)
    if not character.Parent then
        waitForFirst(character.AncestryChanged, arg2.CharacterAdded)
    end
    if arg2.Character ~= character or not character.Parent then
        var1:debug("Mismatched or unparented character in onCharacterAdded for {}", arg1.state.shortId)
        return
    end

    local humanoid = character:FindFirstChildOfClass("Humanoid")
    while character:IsDescendantOf(game) and not humanoid do
        waitForFirst(character.ChildAdded, character.AncestryChanged, arg2.CharacterAdded)
        humanoid = character:FindFirstChildOfClass("Humanoid")
    end

    if arg2.Character ~= character or not character:IsDescendantOf(game) then
        var1:debug("Mismatched or unparented character in onCharacterAdded for {}", arg1.state.shortId)
        return
    end

    local var3 = if GetFFlagBubbleChatInexistantAdorneeFix() then character.PrimaryPart else character:FindFirstChild("HumanoidRootPart")

    while character:IsDescendantOf(game) and not var3 do
        waitForFirst(character.ChildAdded, character.AncestryChanged, arg2.CharacterAdded)
        if GetFFlagBubbleChatInexistantAdorneeFix() then
            var3 = character.PrimaryPart
        else
            var3 = character:FindFirstChild("HumanoidRootPart")
        end
    end

    if not var3 or not character:IsDescendantOf(game) or arg2.Character ~= character or not arg1.isMounted then
        return
    end

    local firstChildByNameAndClass = findFirstChildByNameAndClass(character, "Head", "BasePart")
    arg1:setState({ adornee = humanoid.Health == 0 and firstChildByNameAndClass or character })

    if arg1.humanoidDiedConn then
        arg1.humanoidDiedConn:Disconnect()
        arg1.humanoidDiedConn = nil
    end
    arg1.humanoidDiedConn = humanoid.Died:Connect(function()
        arg1:setState({ adornee = findFirstChildByNameAndClass(character, "Head", "BasePart") or character })
    end)
end

function var2.getVerticalOffset(arg1, arg2)
    if not (arg2 and arg2:IsA("Model")) then
        if arg2 and arg2:IsA("BasePart") then
            return arg2.Size.Y / 2
        end

        return 0
    end

    local var3, var4 = arg2:GetBoundingBox()
    local adorneeInstance = arg1:getAdorneeInstance(arg2)
    if not adorneeInstance then
        return var4.Y / 2
    end

    if not adorneeInstance:IsA("BasePart") then
        return 0
    end

    local var5 = var3:PointToObjectSpace(adorneeInstance.Position)
    return var4.Y / 2 - var5.Y
end

function var2.getAdorneeInstance(arg1, arg2)
    if not arg2 then
        return
    end

    if not arg2:IsA("Model") then
        if arg2:IsA("BasePart") or arg2:IsA("Attachment") then
            return arg2
        end

        return
    end

    local var3 = arg2:FindFirstChild(arg1.state.savedChatSettings.AdorneeName, true)
    if GetFFlagBubbleChatInexistantAdorneeFix() then
        var3 = var3 or arg2.PrimaryPart
    end
    if not var3 or var3:IsA("BasePart") or var3:IsA("Attachment") then
        return var3
    end
end

function var2.getRenderVoiceAndCameraBubble(arg1)
    if not (arg1.props.voiceEnabled or bool1) then
        return false
    end

    if arg1.props.userId == tostring(Players.LocalPlayer.UserId) then
        if VRService.VREnabled or ChromeEnabled() then
            return false
        end

        return not arg1.state.selfViewOpen
    end

    return arg1.props.voiceEnabled and not arg1.state.voiceTimedOut
end

function var2.shouldRenderCarat(arg1)
    return arg1.props.chatSettings.TailVisible and not arg1:getRenderVoiceAndCameraBubble()
end

function var2.render(arg1)
    local adornee = arg1:getAdorneeInstance(arg1.state.adornee)
    local bool5 = arg1.props.userId == tostring(Players.LocalPlayer.UserId)
    local savedChatSettings = arg1.state.savedChatSettings

    if not adornee then
        var1:trace("No adornee for {}", arg1.state.shortId)
        return
    end

    if not arg1.state.isInsideRenderDistance then
        var1:trace("Not in range for {}", arg1.state.shortId)
        return
    end

    if bool2
        and arg1.state.isInEasierUnmutingTreatment
        and arg1.props.voiceState == Constants.VOICE_STATE.LOCAL_MUTED
        and (not arg1.state.isInsideEasierUnmutingDistance or bool4 and arg1.state.isMuted)
    then
        var1:trace("Unmute toggle not applicable for {}", arg1.state.shortId)
        return
    end

    local tbl2 = {}

    local var3 = arg1.props.voiceEnabled and not arg1.state.voiceTimedOut

    if (VRService.VREnabled or ChromeEnabled()) and bool5 then
        var3 = false
    end

    if var3 and (not arg1.props.bubbleChatEnabled or not arg1.props.messageIds or #arg1.props.messageIds == 0) then
        tbl2.VoiceBubble = Roact.createElement(VoiceBubble, {
            chatSettings = savedChatSettings,
            renderInsert = arg1.renderInsert,
            insertSize = arg1.insertSize,
            isDistant = not arg1.state.isInsideMaximizeDistance
        })
    end

    if arg1.state.hasMessage then
        if arg1.state.isInsideMaximizeDistance then
            tbl2.BubbleChatList = Roact.createElement(BubbleChatList, {
                userId = arg1.props.userId,
                isVisible = arg1.state.isInsideMaximizeDistance,
                onLastBubbleFadeOut = arg1.onLastBubbleFadeOut,
                chatSettings = savedChatSettings,
                renderFirstInsert = if var3 then arg1.renderInsert else nil,
                insertSize = arg1.insertSize,
                showCarat = arg1:shouldRenderCarat()
            })
        else
            tbl2.DistantBubble = Roact.createElement(ChatBubbleDistant, {
                fadingOut = not arg1.props.messageIds or #arg1.props.messageIds == 0,
                onFadeOut = arg1.onLastBubbleFadeOut,
                chatSettings = savedChatSettings,
                renderInsert = var3 and arg1.renderInsert,
                insertSize = arg1.insertSize
            })
        end
    end

    local var4 = if bool5 then savedChatSettings.LocalPlayerStudsOffset or Vector3.new(0, 1, 0.1) else Vector3.new(0, 1, 0.1)
    return Roact.createElement("BillboardGui", {
        Adornee = adornee,
        Active = var3,
        Size = UDim2.fromOffset(500, 200),
        SizeOffset = Vector2.new(0, 0.5),
        StudsOffset = var4 + Vector3.new(0, savedChatSettings.VerticalStudsOffset, 0),
        StudsOffsetWorldSpace = arg1.offset,
        ResetOnSpawn = false
    }, tbl2)
end

function var2.didUpdate(arg1, _, arg2)
    if (not arg1.props.messageIds or #arg1.props.messageIds == 0) and not arg1.state.isInsideRenderDistance then
        arg1.onLastBubbleFadeOut()
    end

    if arg1.props.messageIds and #arg1.props.messageIds > 0 then
        arg1.isFadingOut = false
    end

    if bool2 and arg1.state.isInEasierUnmutingTreatment then
        arg1:checkCounterForTimeoutWithEasierUnmuting(arg2)
    else
        arg1:checkCounterForTimeout(arg2.voiceStateCounter)
    end

    local bool5 = arg1.props.userId == tostring(Players.LocalPlayer.UserId)

    if bool2
        and bool5
        and not arg1.state.haveLoggedUserExposure
        and (arg1.props.voiceState == Constants.VOICE_STATE.INACTIVE
            or arg1.props.voiceState == Constants.VOICE_STATE.TALKING
            or arg1.props.voiceState == Constants.VOICE_STATE.MUTED)
    then
        IXPServiceWrapper:LogUserLayerExposure(str1)
        arg1:setState({ haveLoggedUserExposure = true })
    end
end

function var2.getDerivedStateFromProps(arg1, arg2)
    local shortId = "..." .. string.sub(tostring(arg1.userId), -4)

    local hasMessage = not arg2.hasMessage and arg1.messageIds and #arg1.messageIds > 0
    local var4, var5, voiceState

    if arg2.lastVoiceState == arg1.voiceState then
        var4 = nil
        var5 = nil
        voiceState = nil
    else
        var4 = (arg2.voiceStateCounter or 0) + 1

        voiceState = arg1.voiceState
        var5 = false
    end

    return {
        hasMessage = hasMessage or nil,
        savedChatSettings = arg1.lastMessage and arg1.chatSettings,
        shortId = shortId,
        voiceStateCounter = var4,
        voiceTimedOut = var5,
        lastVoiceState = voiceState
    }
end

return RoactRodux.connect(function(arg1, arg2) -- name: mapStateToProps
    local messageIds = arg1.userMessages[arg2.userId]
    local var4 = messageIds and #messageIds >= 1 and messageIds[#messageIds]
    local lastMessage = var4 and arg1.messages[var4]
    local voiceState = arg1.voiceState[arg2.userId]
    return {
        chatSettings = getSettingsForMessage(arg1.chatSettings, lastMessage),
        messageIds = messageIds,
        lastMessage = lastMessage,
        voiceState = voiceState
    }
end)(var2)
