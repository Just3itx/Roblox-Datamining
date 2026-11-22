-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T22:40:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Squads = script:FindFirstAncestor("Squads")

local SquadsParent = Squads.Parent
local AppTopBanner = require(SquadsParent.AppTopBanner)

local AppTopBannerType = AppTopBanner.Enums.AppTopBannerType
local SetAppTopBanner = AppTopBanner.Actions.SetAppTopBanner
local GetAppTopBannerStore = AppTopBanner.GetAppTopBannerStore

local dependencies = require(Squads.dependencies)

local Cryo = dependencies.Cryo
local React = dependencies.React
local SharedFlags = dependencies.SharedFlags
local Hooks = require(SquadsParent.SquadsCore.Hooks)
local EventNames = require(SquadsParent.SquadsCore.EventNames)

local SquadExternalContractContext = require(SquadsParent.SquadsCore.SquadExternalContractProvider).SquadExternalContractContext
local SquadViewFlags = require(SquadsParent.SquadsCore.SquadExternalContractProvider).SquadViewFlags
local SquadRootViewType = require(SquadsParent.SquadsCore.Enums).SquadRootViewType
local encodeSquadMembers = require(SquadsParent.SquadsCore.encodeSquadMembers)
local useCurrentSquadId = Hooks.useCurrentSquadId
local useCurrentSquadMembers = Hooks.useCurrentSquadMembers
local useCurrentSquadParentChannelId = Hooks.useCurrentSquadParentChannelId
local useDispatch = dependencies.Hooks.useDispatch
local useCanAccessParty = require(Squads.Hooks.useCanAccessParty)

local FFlagEnableSquadTopBannerWideMode = SharedFlags.FFlagEnableSquadTopBannerWideMode
local FFlagUseSignalsForAppTopBanner = SharedFlags.FFlagUseSignalsForAppTopBanner

local FFlagIntroduceTopBannerPartyStates = require(Squads.Flags.FFlagIntroduceTopBannerPartyStates)

local bool1 = game:DefineFastFlag("FixSquadTopBannerMemo", false)

return function()
    local var1 = useDispatch()

    local var2 = React.useContext(SquadExternalContractContext)
    local squadId = useCurrentSquadId()
    local var4 = useCurrentSquadParentChannelId()
    local var5 = if FFlagIntroduceTopBannerPartyStates then useCurrentSquadMembers() else nil

    local var6 = if bool1 then React.useMemo(function()
        if FFlagIntroduceTopBannerPartyStates and var5 then
            return (Cryo.List.map(var5, function(arg1)
                return arg1.userId
            end))
        end

        return {}
    end, { if FFlagIntroduceTopBannerPartyStates then var5 else nil }) else not (FFlagIntroduceTopBannerPartyStates and var5) and {} or Cryo.List.map(var5, function(arg1)
        return arg1.userId
    end)

    local var7 = if FFlagIntroduceTopBannerPartyStates then React.useRef(os.clock()) else nil
    local useCallback = React.useCallback

    local function func1()
        if var2.navigateIntoSquadLobby and var4 then
            var1(var2.navigateIntoSquadLobby({ conversationId = var4 }, true))
        end

        if not FFlagIntroduceTopBannerPartyStates then
            return
        end

        local squadMembers = encodeSquadMembers(var5)
        var2.fireSquadAnalytics(EventNames.SquadTopBannerClicked, {
            squadId = squadId,
            parentChannelId = var4,
            squadMembers = squadMembers,
            timePassedSinceLastStateUpdatedInSec = os.clock() - var7.current
        })
    end

    local var8 = if FFlagIntroduceTopBannerPartyStates then squadId else nil
    local navigateIntoSquadLobby = var2.navigateIntoSquadLobby
    local fireSquadAnalytics = if FFlagIntroduceTopBannerPartyStates then var2.fireSquadAnalytics else nil
    local var9 = if FFlagIntroduceTopBannerPartyStates then var5 else nil
    local var10 = useCallback(func1, { var8, var4, var1, navigateIntoSquadLobby, fireSquadAnalytics, var9 })

    local var11 = var2.useGetConversationFromId(var4)
    local type = var11 and var11.type
    local participants = var11 and var11.participants

    local var12 = useCanAccessParty()

    local var13 = var2.useSquadRootView()
    if FFlagEnableSquadTopBannerWideMode then
        local var14 = var2.useSquadTopBannerDisabled()
        local useEffect = React.useEffect

        local function func2()
            local var15 = squadId and (not var14 or var13 == SquadRootViewType.None)

            if not var12 or not var15 then
                if FFlagUseSignalsForAppTopBanner then
                    GetAppTopBannerStore(false).setAppTopBanner(false, AppTopBannerType.None, nil)
                else
                    var1(SetAppTopBanner(false, AppTopBannerType.None, nil))
                end

                return
            end

            if FFlagIntroduceTopBannerPartyStates then
                var7.current = os.clock()
            end

            if FFlagUseSignalsForAppTopBanner then
                GetAppTopBannerStore(false).setAppTopBanner(
                    true,
                    AppTopBannerType.ActiveSquad,
                    FFlagIntroduceTopBannerPartyStates
                        and {
                            squadMemberList = var6,
                            parentChannelType = type,
                            parentChannelParticipants = participants
                        }
                        or nil,
                    var10
                )
                return
            end

            var1(
                SetAppTopBanner(
                    true,
                    AppTopBannerType.ActiveSquad,
                    FFlagIntroduceTopBannerPartyStates
                        and {
                            squadMemberList = var6,
                            parentChannelType = type,
                            parentChannelParticipants = participants
                        }
                        or nil,
                    var10
                )
            )
        end

        local var15 = if FFlagIntroduceTopBannerPartyStates then var6 else nil
        useEffect(func2, { squadId, var15, var1, var10, type, participants, var14, var13 })
    else
        local var14 = var2.useSquadViewFlags()
        local useEffect = React.useEffect

        local function func2()
            local bool2 = squadId and (bit32.band(var14, SquadViewFlags.SquadLobby) == 0 or var13 == SquadRootViewType.None)

            if not var12 or not bool2 then
                if FFlagUseSignalsForAppTopBanner then
                    GetAppTopBannerStore(false).setAppTopBanner(false, AppTopBannerType.None, nil)
                else
                    var1(SetAppTopBanner(false, AppTopBannerType.None, nil))
                end

                return
            end

            if FFlagIntroduceTopBannerPartyStates then
                var7.current = os.clock()
            end

            if FFlagUseSignalsForAppTopBanner then
                GetAppTopBannerStore(false).setAppTopBanner(
                    true,
                    AppTopBannerType.ActiveSquad,
                    FFlagIntroduceTopBannerPartyStates
                        and {
                            squadMemberList = var6,
                            parentChannelType = type,
                            parentChannelParticipants = participants
                        }
                        or nil,
                    var10
                )
                return
            end

            var1(
                SetAppTopBanner(
                    true,
                    AppTopBannerType.ActiveSquad,
                    FFlagIntroduceTopBannerPartyStates
                        and {
                            squadMemberList = var6,
                            parentChannelType = type,
                            parentChannelParticipants = participants
                        }
                        or nil,
                    var10
                )
            )
        end

        local var15 = if FFlagIntroduceTopBannerPartyStates then var6 else nil
        useEffect(func2, { squadId, var15, var1, var10, var14, type, participants, var13 })
    end

    return nil
end
