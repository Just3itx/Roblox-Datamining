-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:51:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local NavigateIntoChat = require(AppChat.Actions.NavigateIntoChat)
local Thunks = require(AppChatParent.NavigationRodux).Thunks
local AppPage = require(AppChatParent.RobloxAppEnums).AppPage
local EnumScreens = require(AppChat.EnumScreens)
local NetworkingSquads = require(AppChatParent.SquadsCore.Http).NetworkingSquads
local getDeepValue2 = require(AppChat.Utils.getDeepValue2)
local FFlagEnableSquadDeeplinkWithChatId = require(AppChatParent.SharedFlags).FFlagEnableSquadDeeplinkWithChatId
local FFlagSignalsNavP3Dispatch = require(AppChatParent.SharedFlags).FFlagSignalsNavP3Dispatch
local NavigationCommands = if FFlagSignalsNavP3Dispatch then require(AppChatParent.RobloxAppNavigation).NavigationCommands else nil
local tbl1 = {{
    name = AppPage.Chat
}}

return function(tbl2, bool1: boolean)
    return function(tbl3)
        local conversationId = if FFlagEnableSquadDeeplinkWithChatId then tbl2.conversationId else nil
        local partyId = nil
        local state = tbl3:getState()
        local deepValue2 = getDeepValue2(state, "Squad.Squad.currentSquad")
        local squadId = deepValue2 and deepValue2.squadId

        local var1 = FFlagEnableSquadDeeplinkWithChatId and function()
            if FFlagSignalsNavP3Dispatch then
                NavigationCommands.to(NavigationCommands.fromLegacyPage(tbl1[#tbl1]), bool1)
            else
                tbl3:dispatch(Thunks.NavigateToRoute(tbl1, bool1))
            end
            if not conversationId or conversationId == "" then
                return
            end
            if partyId and partyId ~= "" then
                tbl3:dispatch(
                    NavigateIntoChat({
                        screen = EnumScreens.SquadLobby,
                        params = {
                            conversationId = conversationId,
                            squadId = if squadId and squadId ~= partyId then partyId else nil
                        }
                    })
                )
                return
            end

            tbl3:dispatch(NavigateIntoChat({ screen = EnumScreens.ChatConversation, params = { conversationId = conversationId } }))
        end or nil

        if FFlagEnableSquadDeeplinkWithChatId then
            if tbl2.partyId and tbl2.partyId ~= "" then
                tbl3:dispatch(NetworkingSquads.GetSquadFromSquadId.API({ squadId = tbl2.partyId })):andThen(function(arg1)
                    if getDeepValue2(arg1, "responseBody.groupUp.parentChannelId") then
                        partyId = tbl2.partyId
                        conversationId = arg1.responseBody.groupUp.parentChannelId
                    end

                    var1()
                end):catch(function(_)
                    var1()
                end)
            else
                var1()
            end

            return
        end

        tbl3:dispatch(NetworkingSquads.GetSquadFromSquadId.API({ squadId = tbl2.partyId })):andThen(function(arg1)
            if not getDeepValue2(arg1, "responseBody.groupUp.parentChannelId") then
                return
            end

            local params = {
                conversationId = arg1.responseBody.groupUp.parentChannelId,
                squadId = if squadId and squadId ~= tbl2.partyId then tbl2.partyId else nil
            }

            if FFlagSignalsNavP3Dispatch then
                NavigationCommands.to(NavigationCommands.fromLegacyPage(tbl1[#tbl1]), bool1)
            else
                tbl3:dispatch(Thunks.NavigateToRoute(tbl1, bool1))
            end
            tbl3:dispatch(NavigateIntoChat({ screen = EnumScreens.SquadLobby, params = params }))
        end):catch(function(_) end)
    end
end
