-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:00:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local React = require(AppChatParent.React)
local LuaAppNavigationContext = require(script.Parent.LuaAppNavigationContext)
local EnumScreens = require(script.Parent.EnumScreens)
local var1 = require(AppChatParent.Loggers).Logger:new(script.Name)
local EventNames = require(AppChat.Analytics.EventNames)
local useAnalytics = require(AppChat.Analytics.useAnalytics)

local OpenUnfilteredThreadsLearnMoreLink = require(AppChat.Conversations.Thunks.OpenUnfilteredThreadsLearnMoreLink)

local ChatPlacementContext = require(AppChat.Contexts.ChatPlacementContext)
local useChatPlacementContext = ChatPlacementContext.useChatPlacementContext
local isPlacementInExperience = ChatPlacementContext.isPlacementInExperience

function generateNavigateToGroups(navigateToLuaAppPages, callback: ((...any) -> (...any))?)
    return function()
        if callback then
            callback()
        end

        if navigateToLuaAppPages == nil then
            return
        end

        local var2 = navigateToLuaAppPages[EnumScreens.Groups]
        if var2 then
            var1:info("Navigate To Groups from App Chat")
            var2()
            return
        end
        var1:warning("Groups page was not set in navigateToLuaAppPages")
    end
end

local function generateNavigateToUnfilteredThreadsLearnMore(callback, bool1: boolean?) -- Luacid: Inlined by compiler; 1 call site recovered
    return function(callback2: (...any) -> (...any))
        if not callback then
            return
        end

        if bool1 then
            if callback2 then
                callback2(EnumScreens.LearnMorePartialModal, {}, true)
            end
        else
            callback(OpenUnfilteredThreadsLearnMoreLink())
        end
    end
end

function LuaAppNavigationContextProvider(tbl1)
    local var2 = React.useRef(function() end)

    local chatPlacement = useChatPlacementContext().chatPlacement
    local var3 = isPlacementInExperience(chatPlacement)

    local var4 = useAnalytics()
    if var4 then
        function var2.current()
            var4.fireAnalyticsEvent(EventNames.ChatLandingGroupsBtnClicked)
        end
    end

    return React.createElement(LuaAppNavigationContext.Provider, {
        value = {
            navigateToGroups = generateNavigateToGroups(tbl1.navigateToLuaAppPages, var2.current),
            navigateToUnfilteredThreadsLearnMore = generateNavigateToUnfilteredThreadsLearnMore(tbl1.dispatch, var3)
        }
    }, tbl1.children)
end

return LuaAppNavigationContextProvider
