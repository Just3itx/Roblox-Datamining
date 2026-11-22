-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T17:01:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialCards = script:FindFirstAncestor("SocialCards")
local SocialCardsParent = SocialCards.Parent

local Cryo = require(SocialCardsParent.Cryo)

local Foundation = require(SocialCardsParent.Foundation)
local Http = require(SocialCardsParent.Http)
local LuauPolyfill = require(SocialCardsParent.LuauPolyfill)
local React = require(SocialCardsParent.React)
local SquadExternalContractProvider = require(SocialCardsParent.SquadsCore.SquadExternalContractProvider)
local useCurrentSquadSelector = require(SocialCardsParent.RoduxSquads).Hooks.useCurrentSquadSelector
local useDispatch = require(SocialCardsParent.RoactUtils).Hooks.RoactRodux.useDispatch
local useLocalUserId = require(SocialCardsParent.RobloxAppHooks).useLocalUserId
local useNavigationFocus = require(SocialCardsParent.Navigation).useNavigationFocus

local NetworkingSquads = require(SocialCardsParent.SquadsCore.Http).NetworkingSquads
local SquadExternalContractContext = SquadExternalContractProvider.SquadExternalContractContext
local SquadViewFlags = SquadExternalContractProvider.SquadViewFlags

local clearInterval = LuauPolyfill.clearInterval
local setInterval = LuauPolyfill.setInterval

local SquadStartedCard = require(SocialCards.Components.SquadCard.SquadStartedCard)
local SquadEndedCard = require(SocialCards.Components.SquadCard.SquadEndedCard)

local function SquadCard(tbl1)
    local var1 = useDispatch()
    local var2 = useLocalUserId()

    local var3 = React.useContext(SquadExternalContractContext)
    local var4 = useCurrentSquadSelector()
    local bool1 = if var4 then var4.squadId == tbl1.group_up_id else false

    local var5 = React.useCallback(function(tbl2)
        if not bool1 then
            return Cryo.List.filter(tbl2, function(num1: number): boolean
                return tostring(num1) ~= var2
            end)
        end

        local result = {}
        for _, member in ipairs(var4.members) do
            table.insert(result, member.userId)
        end
        return result
    end, { bool1, var4, var2 })

    local var6, var7 = React.useState(tbl1.is_alive)
    local participantUserIds, var9 = React.useState(var5(tbl1.participant_user_ids))

    local var10 = useNavigationFocus()
    local var11 = bool1 and var10
    React.useEffect(function()
        if var11 then
            var3.updateSquadViewFlags(SquadViewFlags.SquadSystemMessage, true)
        end
        return function()
            if var11 then
                var3.updateSquadViewFlags(SquadViewFlags.SquadSystemMessage, false)
            end
        end
    end, { var3.updateSquadViewFlags, var11 })

    React.useEffect(function()
        var9(var5(tbl1.participant_user_ids))
    end, { var9, tbl1.participant_user_ids, var5 })

    local var12 = React.useCallback(function(squadId: string)
        var1(NetworkingSquads.GetSquadFromSquadId.API({ squadId = squadId })):andThen(function(arg1)
            if not arg1 or not arg1.responseBody or not arg1.responseBody.groupUp or not arg1.responseBody.groupUp.members then
                return
            end
            local tbl2 = {}
            for _, member in ipairs(arg1.responseBody.groupUp.members) do
                table.insert(tbl2, member.userId)
            end
            var9(tbl2)
        end):catch(function(arg1)
            if arg1.StatusCode == Http.StatusCodes.NOT_FOUND then
                var7(false)
                return
            end
            warn("Unsupported error type")
        end)
    end, { var1 })

    React.useEffect(function()
        local var13 = if var6 and not bool1 then setInterval(function()
            var12(tbl1.group_up_id)
        end, 10000) else nil

        return function()
            if var13 then
                clearInterval(var13)
            end
        end
    end, {
        var12,
        var6,
        bool1,
        tbl1.group_up_id
    })
    local var13 = React.useMemo(function()
        if var6 then
            return (React.createElement(
                SquadStartedCard,
                {
                    conversationId = tbl1.conversation_id,
                    participantUserIds = participantUserIds,
                    squadLocation = tbl1.moduleLocation
                }
            ))
        end

        return (React.createElement(SquadEndedCard, { conversationId = tbl1.conversation_id, squadLocation = tbl1.moduleLocation }))
    end, {
        var6,
        participantUserIds,
        tbl1.conversation_id,
        tbl1.group_up_id
    })
    return React.createElement(Foundation.View, { AutomaticSize = Enum.AutomaticSize.Y, Size = UDim2.new(0, 280, 0, 0) }, var13)
end

return SquadCard
