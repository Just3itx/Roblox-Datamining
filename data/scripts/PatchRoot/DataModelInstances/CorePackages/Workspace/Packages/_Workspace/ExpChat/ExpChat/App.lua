-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T07:30:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TextChatService = game:GetService("TextChatService")

local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent
local Roact = require(ExpChatParent.Roact)
local RoactRodux = require(ExpChatParent.RoactRodux)
local ExpChatShared = require(ExpChatParent.ExpChatShared)

local Localization = require(script.Parent.Localization)
local GameLocalization = require(script.Parent.GameLocalization)
local AppContainer = require(script.Parent.AppContainer)
local createStore = require(script.Parent.createStore)

local GetPresetChatStore = require(ExpChat.Stores.GetPresetChatStore)
local Constants = require(ExpChat.PresetChat.Constants)
local FFlagExpChatPresetChatEnabled = ExpChatShared.Flags.FFlagExpChatPresetChatEnabled
local FFlagExpChatUniverseChatPresetEnabled = require(ExpChat.Flags.FFlagExpChatUniverseChatPresetEnabled)
local num1 = game:DefineFastInt("ExpChatPresetChatLoadAnalyticsTimeoutMs", 20000)

local bool1 = game:DefineFastFlag("ExpChatReconcileOnAgeVerifiedChange", false)
local ExpChatEventReceiver = if bool1 then require(script.Parent.ExpChatEventReceiver) else nil
local FriendsChatEventReceiverConnector = require(script.Parent.FriendsChatEventReceiverConnector)

local ShortcutNavReceiver = require(script.Parent.ShortcutNav.ShortcutNavReceiver)

local ExpChatPresetChatEmojiTabExperimentation = require(ExpChatParent.SocialExperiments).ExpChatPresetChatEmojiTabExperimentation
local PresetChatEmojiTabExposureLogger = if ExpChatPresetChatEmojiTabExperimentation.isExperimentEnabled then require(script.Parent.PresetChat.PresetChatEmojiTabExposureLogger) else nil
local getFFlagExpChatTelemetryEventTrigger = require(ExpChat.Flags.getFFlagExpChatTelemetryEventTrigger)

local function computePresetBitmap(arg1)
    local presetChatStore = GetPresetChatStore(false)

    if not presetChatStore.getIsEnabled() or presetChatStore.getAccessLevel() ~= Constants.AccessLevel.Enabled then
        return 0
    end

    local num2 = 0
    for k in pairs(arg1) do
        if k == "RBXSystem" then
            continue
        end
        if k == "RBXGeneral" then
            num2 = bit32.bor(num2, 1)
        else
            num2 = bit32.bor(num2, 4)
        end
    end

    if FFlagExpChatUniverseChatPresetEnabled and TextChatService:HasAllocatedUniverseChatContext("global") then
        num2 = bit32.bor(num2, 2)
    end

    return num2
end

local var1 = Roact.Component:extend("App")

var1.defaultProps = {
    isChatWindowVisible = true,
    isChatInputBarVisible = true,
    isChannelBarVisible = false,
    isDefaultChatEnabled = true,
    isSpatialUIEnabled = false,
    store = createStore(),
    translator = {
        FormatByKey = function(_, arg1): string
            return tostring(arg1)
        end
    },
    gameTranslator = {
        TranslateGameText = function<T>(_, _, arg1: T): T
            return arg1
        end
    }
}

function var1.render(arg1)
    local isDefaultChatEnabled = arg1.props.isDefaultChatEnabled

    if isDefaultChatEnabled then
        local createElement = Roact.createElement
        local storeProvider = RoactRodux.StoreProvider
        local tbl1 = {
            store = arg1.props.store
        }
        local tbl2 = { localization = 0 }
        local createElement2 = Roact.createElement
        local provider = Localization.Provider
        local tbl3 = {
            value = arg1.props.translator
        }
        local tbl4 = {
            gameLocalization = Roact.createElement(GameLocalization.Provider, {
                value = arg1.props.gameTranslator
            }, {
                eventReceiver = if bool1 then Roact.createElement(ExpChatEventReceiver) else nil,
                friendsChatEventReceiver = Roact.createElement(FriendsChatEventReceiverConnector),
                shortcutNavReceiver = Roact.createElement(ShortcutNavReceiver),
                presetChatEmojiTabExposureLogger = if ExpChatPresetChatEmojiTabExperimentation.isExperimentEnabled then Roact.createElement(PresetChatEmojiTabExposureLogger) else nil,
                container = Roact.createElement(AppContainer, {
                    isChatInputBarVisible = arg1.props.isChatInputBarVisible,
                    isChatWindowVisible = arg1.props.isChatWindowVisible,
                    isChannelBarVisible = arg1.props.isChannelBarVisible,
                    getIconVoiceIndicator = arg1.props.getIconVoiceIndicator,
                    onClickedVoiceIndicator = arg1.props.onClickedVoiceIndicator,
                    onClickedCameraIndicator = arg1.props.onClickedCameraIndicator,
                    selfViewListenerChanged = arg1.props.selfViewListenerChanged,
                    getPermissions = arg1.props.getPermissions,
                    displayCameraDeniedToast = arg1.props.displayCameraDeniedToast,
                    isCamEnabledForUserAndPlace = arg1.props.isCamEnabledForUserAndPlace,
                    isCameraOnlyUser = arg1.props.isCameraOnlyUser,
                    isVoiceServiceInitialized = arg1.props.isVoiceServiceInitialized,
                    isSpatialUIEnabled = arg1.props.isSpatialUIEnabled
                })
            })
        }
        tbl2.localization = createElement2(provider, tbl3, tbl4)
        isDefaultChatEnabled = createElement(storeProvider, tbl1, tbl2)
    end

    return isDefaultChatEnabled
end

if getFFlagExpChatTelemetryEventTrigger() then
    function var1.didMount(arg1)
        local expChatLoadStartTime = arg1.props.expChatLoadStartTime
        if not expChatLoadStartTime then
            return
        end

        if not FFlagExpChatPresetChatEnabled then
            TextChatService:SendExpChatLoadSuccess(os.clock() - expChatLoadStartTime)
            return
        end

        local loadingLatency = os.clock() - expChatLoadStartTime
        local presetChatStore = GetPresetChatStore(false)
        task.spawn(function()
            local startTime = os.clock()

            while presetChatStore.getIsLoading() and os.clock() - startTime < num1 / 1000 do
                task.wait()
            end
            local state = arg1.props.store:getState()
            local var2 = state.TextChannels and state.TextChannels.allTextChannels or {}
            TextChatService:SendExpChatLoadSuccess(loadingLatency, { preset_bitmap = computePresetBitmap(var2) })
        end)
    end
end

return var1
