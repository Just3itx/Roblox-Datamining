-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T07:31:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")
local VoiceChatService = game:GetService("VoiceChatService")

local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent
local IXPServiceWrapper = require(ExpChat.IXPServiceWrapper)

local ExpChatShared = require(ExpChatParent.ExpChatShared)
local Roact = require(ExpChatParent.Roact)
local React = require(ExpChatParent.React)
local RoactRodux = require(ExpChatParent.RoactRodux)
local Dictionary = require(ExpChatParent.llama).Dictionary
local None = require(ExpChatParent.llama).None
local SharedFlags = require(ExpChatParent.SharedFlags)

local var1 = ExpChatShared.Logger:new("ExpChat/" .. script.Name)

local BubbleChat = script:FindFirstAncestor("BubbleChat")

local withSignalsData = require(script.Parent.withSignalsData)

local Permissions = require(ExpChat.Config).Permissions
local GlobalFlags = require(ExpChat.GlobalFlags)
local getFFlagUseCharacterStore = ExpChatShared.Flags.getFFlagUseCharacterStore

local bool1 = game:DefineFastFlag("ExpChatRemoveBubbleChatAppUserMessagesState", false)
local bool2 = game:DefineFastFlag("MemoizeBubbleChatApp", false)
local GetFFlagExpChatUseVoiceParticipantsStore = SharedFlags.GetFFlagExpChatUseVoiceParticipantsStore

local bool3 = game:DefineFastFlag("ExpChatBubbleChatRerenderOnAncestryChange", false)

local var2 = Roact.PureComponent:extend("BubbleChatApp")

local GetFStringVoicePerformanceIXPLayerName = require(ExpChat.Flags.GetFStringVoicePerformanceIXPLayerName)

local str1 = game:DefineFastString("BillboardUpdateFrequencyIXPLayerValue", "BillboardUpdateFrequency")
local BillboardGui = require(BubbleChat.BillboardGui)

if not bool1 then
    function var2.getDerivedStateFromProps(arg1, arg2)
        return {
            userMessages = Dictionary.join(arg2.userMessages or {}, arg1.userMessages)
        }
    end
end

function var2.init(arg1)
    var1:debug("Initializing")
    arg1:setState(
        {
            userMessages = not bool1 and {} or nil,
            localPlayerVoiceEnabled = false,
            billboardUpdateFrequency = -1
        }
    )

    function arg1.onBillboardFadeOut(arg2)
        if bool1 then
            return
        end

        arg1:setState({ userMessages = Dictionary.join(arg1.state.userMessages, { [arg2] = None }) })
    end

    function arg1.setCameraPermissionStateFromControl(hasCameraPermissions: boolean)
        arg1:setState({ hasCameraPermissions = hasCameraPermissions })
    end

    if bool3 then
        arg1.isMounted = false
        arg1.ancestryConnections = {}
        function arg1.onTrackedAncestryChanged()
            if not arg1.isMounted then
                return
            end

            arg1:setState(function(arg2)
                return {
                    ancestryRerenderToken = (arg2.ancestryRerenderToken or 0) + 1
                }
            end)
        end
    end

    local success, result = pcall(function()
        return IXPServiceWrapper:GetLayerData(GetFStringVoicePerformanceIXPLayerName())
    end)

    if success and result and result[str1] then
        arg1:setState({ billboardUpdateFrequency = result[str1] })
    end
end

function var2.getPermissions(arg1)
    local function func1(hasCameraPermissions, hasMicPermissions)
        arg1:setState({ hasCameraPermissions = hasCameraPermissions, hasMicPermissions = hasMicPermissions })
    end

    if arg1.props.getPermissions then
        arg1.props.getPermissions(func1)
    end
end

function var2.getMicPermission(arg1)
    local function func1(_, hasMicPermissions)
        arg1:setState({ hasMicPermissions = hasMicPermissions })
    end

    if arg1.props.getPermissions then
        arg1.props.getPermissions(func1, Permissions.MICROPHONE_ACCESS)
    end
end

function var2.getCameraPermissionWithoutRequest(arg1)
    local function func1(hasCameraPermissions, _)
        arg1:setState({ hasCameraPermissions = hasCameraPermissions })
    end

    if arg1.props.getPermissions then
        arg1.props.getPermissions(func1, Permissions.CAMERA_ACCESS, true)
    end
end

function var2.updateTrackedAncestryConnections(arg1)
    local tbl1 = ({})
    if arg1.props.characters then
        for _, character in pairs(arg1.props.characters) do
            if character then
                tbl1[character] = true
            end
        end
    end
    if arg1.props.mockUserIdToPartOrModel then
        for _, value in pairs(arg1.props.mockUserIdToPartOrModel) do
            if value then
                tbl1[value] = true
            end
        end
    end

    for k in pairs(tbl1) do
        if not arg1.ancestryConnections[k] then
            arg1.ancestryConnections[k] = k.AncestryChanged:Connect(arg1.onTrackedAncestryChanged)
        end
    end

    for k, ancestryConnection in pairs(arg1.ancestryConnections) do
        if not tbl1[k] then
            ancestryConnection:Disconnect()
            arg1.ancestryConnections[k] = nil
        end
    end
end

function var2.didMount(arg1)
    if bool3 then
        arg1.isMounted = true
        arg1:updateTrackedAncestryConnections()
    end

    if GlobalFlags.AvatarChatEnabled or GlobalFlags.ChromeEnabled then
        if arg1.props.isVoiceServiceInitialized then
            arg1.props.isVoiceServiceInitialized():andThen(function()
                arg1:getMicPermission()
            end):catch(function()
                var1:debug("VoiceChatServiceManager failed to initialize inside TextChatService bubblechat")
            end)
        else
            arg1:getMicPermission()
        end
        arg1:getCameraPermissionWithoutRequest()
    end

    task.spawn(function()
        local success, result = pcall(function()
            if Players.LocalPlayer then
                return VoiceChatService:IsVoiceEnabledForUserIdAsync(Players.LocalPlayer.UserId)
            end
            return false
        end)

        if not success then
            var1:debug("Unable to get voice enabled status: ", result)
        elseif result then
            arg1:setState({ localPlayerVoiceEnabled = true })

            IXPServiceWrapper:LogUserLayerExposure(GetFStringVoicePerformanceIXPLayerName())
        end
    end)
end

function var2.didUpdate(arg1)
    if bool3 then
        arg1:updateTrackedAncestryConnections()
    end
end

function var2.willUnmount(arg1)
    if not bool3 then
        return
    end

    arg1.isMounted = false
    for k, ancestryConnection in pairs(arg1.ancestryConnections) do
        ancestryConnection:Disconnect()
        arg1.ancestryConnections[k] = nil
    end
end

function var2.render(arg1)
    local tbl1 = ({})
    if arg1.props.characters then
        for k, character in pairs(arg1.props.characters) do
            if character and character:IsDescendantOf(workspace) then
                tbl1[k] = false
            end
        end
    end

    if arg1.props.mockUserIdToPartOrModel then
        for k, value in pairs(arg1.props.mockUserIdToPartOrModel) do
            if value and value:IsDescendantOf(workspace) then
                tbl1[k] = false
            end
        end
    end

    if arg1.props.voiceParticipants then
        for k, voiceParticipant in pairs(arg1.props.voiceParticipants) do
            if voiceParticipant ~= "Hidden" then
                tbl1[k] = true
            end
        end
    end

    if GlobalFlags.AvatarChatEnabled and arg1.state.hasCameraPermissions and Players.LocalPlayer then
        local userId = Players.LocalPlayer.UserId
        tbl1[tostring(userId)] = true
    end

    return Roact.createElement("ScreenGui", { ResetOnSpawn = false }, Dictionary.map(tbl1, function(arg2, userId)
        return Roact.createElement(BillboardGui, {
            userId = userId,
            onFadeOut = arg1.onBillboardFadeOut,
            voiceEnabled = arg1.props.voiceEnabled and arg2,
            getIconVoiceIndicator = arg1.props.getIconVoiceIndicator,
            onClickedVoiceIndicator = arg1.props.onClickedVoiceIndicator,
            onClickedCameraIndicator = arg1.props.onClickedCameraIndicator,
            selfViewListenerChanged = arg1.props.selfViewListenerChanged,
            hasCameraPermissions = arg1.state.hasCameraPermissions,
            hasMicPermissions = arg1.state.hasMicPermissions,
            displayCameraDeniedToast = arg1.props.displayCameraDeniedToast,
            isCamEnabledForUserAndPlace = arg1.props.isCamEnabledForUserAndPlace,
            isCameraOnlyUser = arg1.props.isCameraOnlyUser,
            setCameraPermissionStateFromControl = arg1.setCameraPermissionStateFromControl,
            getPermissions = arg1.props.getPermissions,
            voiceState = arg1.props.voiceParticipants[userId],
            partOrModel = arg1.props.mockUserIdToPartOrModel[userId],
            isTextChatServiceOn = arg1.props.isTextChatServiceOn,
            billboardUpdateFrequency = arg1.state.billboardUpdateFrequency
        }), "BubbleChat_" .. userId
    end))
end

local function mapStateToProps(arg1, arg2)
    local mockUserIdToPartOrModel = arg1.Messages.mockUserIdToPartOrModel
    if arg2.mockUserIdToPartOrModel then
        mockUserIdToPartOrModel = arg2.mockUserIdToPartOrModel
    else
        local context = ExpChatShared.context
        local messagesStore = context and context.messagesStore
        if messagesStore then
            mockUserIdToPartOrModel = messagesStore.getMockUserIdToPartOrModel(false)
        end
    end

    return {
        userMessages = if bool1 then nil else arg1.Messages.messagesBySenderId,
        voiceEnabled = arg1.Voice.isEnabled,
        characters = if getFFlagUseCharacterStore() then nil else arg1.Players.charactersByUserId,
        voiceParticipants = if GetFFlagExpChatUseVoiceParticipantsStore() then nil else arg1.Voice.participants,
        mockUserIdToPartOrModel = mockUserIdToPartOrModel
    }
end

if getFFlagUseCharacterStore() or GetFFlagExpChatUseVoiceParticipantsStore() then
    local var3 = RoactRodux.connect(mapStateToProps)(var2)
    if bool2 then
        return (React.memo(withSignalsData(var3)))
    end

    return (withSignalsData(var3))
elseif bool2 then
    return (React.memo(RoactRodux.connect(mapStateToProps)(var2)))
else
    return (RoactRodux.connect(mapStateToProps)(var2))
end
