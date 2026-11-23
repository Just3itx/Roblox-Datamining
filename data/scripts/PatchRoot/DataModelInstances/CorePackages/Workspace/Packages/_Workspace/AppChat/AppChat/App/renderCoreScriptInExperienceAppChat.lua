-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:01:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")

local AppChat = script:FindFirstAncestor("AppChat")

local AppChatParent = AppChat.Parent
local FocusNavigationUtils = require(AppChatParent.FocusNavigationUtils)
local React = require(AppChatParent.React)
local ReactFocusNavigation = require(AppChatParent.ReactFocusNavigation)
local ReactRoblox = require(AppChatParent.ReactRoblox)
local Rodux = require(AppChatParent.Rodux)

local Provider = FocusNavigationUtils.FocusNavigableSurfaceRegistry.Provider

local AppChatReducer = require(AppChat.App.AppChatReducer)
local InExperienceAppChat = require(AppChat.App.InExperienceAppChat)
local InExperienceAppChatProviders = require(AppChat.App.InExperienceAppChatProviders)

local FFlagAppChatSignalsMessageStore = require(AppChat.Flags.FFlagAppChatSignalsMessageStore)
local FFlagAppChatConversationStore = require(AppChat.Flags.FFlagAppChatConversationStore)
local FFlagUseSignalsForSquadExperienceInvite = require(AppChatParent.SharedFlags).FFlagUseSignalsForSquadExperienceInvite
local ChatModerationStatusHydrationMiddleware = require(AppChat.Middleware.ChatModerationStatusHydrationMiddleware)
local SignalsConversationMiddleware = require(AppChat.Middleware.SignalsConversationMiddleware)
local SignalsMessageIngestionMiddleware = require(AppChat.Middleware.SignalsMessageIngestionMiddleware)
local SignalsUnreadMessageCountMiddleware = require(AppChat.Middleware.SignalsUnreadMessageCountMiddleware)
local FFlagAppChatSignalsActionHandlers = require(AppChat.Flags.FFlagAppChatSignalsActionHandlers)

local FFlagAppChatPerfTracking = require(AppChat.Flags.FFlagAppChatPerfTracking)
local AppChatPerfTracker = require(AppChat.Telemetry.AppChatPerfTracker)
local ChatPlacementContext = require(AppChat.Contexts.ChatPlacementContext)

return function(apolloClient, parentContainerContext, updateAppChatUnreadMessagesCount)
    local appChat = Instance.new("Folder")
    appChat.Name = "AppChat"
    appChat.Parent = CoreGui

    if FFlagAppChatPerfTracking then
        AppChatPerfTracker.setSharedContext({ placement = ChatPlacementContext.Enum.InExperienceDefault })
    end

    local root = ReactRoblox.createRoot(appChat)
    local tbl1 = { Rodux.thunkMiddleware }

    if FFlagAppChatSignalsMessageStore then
        table.insert(tbl1, SignalsMessageIngestionMiddleware)
    end
    if FFlagAppChatConversationStore then
        table.insert(tbl1, SignalsConversationMiddleware)
    end
    table.insert(tbl1, require(AppChat.Middleware.SignalsFriendsChatSettingsMiddleware))

    table.insert(tbl1, ChatModerationStatusHydrationMiddleware)
    table.insert(tbl1, SignalsUnreadMessageCountMiddleware)
    if FFlagUseSignalsForSquadExperienceInvite then
        table.insert(tbl1, require(AppChatParent.SquadsCore.Middleware).SignalsSquadMiddleware)
    end
    if FFlagAppChatSignalsActionHandlers then
        local signalsMiddleware = require(AppChatParent.SignalsMiddleware)
        local var1 = signalsMiddleware.ActionHandlers.create()
        require(AppChat.Handlers.registerAppChatSignalsActionHandlers)(var1)
        table.insert(tbl1, signalsMiddleware.createSignalsMiddleware(var1))
    end
    local store = Rodux.Store.new(AppChatReducer, nil, tbl1)

    local focusNavigationService = ReactFocusNavigation.FocusNavigationService.new(ReactFocusNavigation.EngineInterface.CoreGui)

    root:render(((function() -- name: AppChatMainWithFocusRoot
        return React.createElement(ReactFocusNavigation.FocusNavigationContext.Provider, {
            value = focusNavigationService
        }, {
            FocusNavigationRegistryProvider = React.createElement(Provider, nil, {
                InExperienceAppChatProviders = React.createElement(
                    InExperienceAppChatProviders,
                    {
                        store = store,
                        updateAppChatUnreadMessagesCount = updateAppChatUnreadMessagesCount,
                        parentContainerContext = parentContainerContext,
                        apolloClient = apolloClient
                    },
                    {
                        appChat = React.createElement(InExperienceAppChat)
                    }
                )
            })
        })
    end)()))

    return root
end
