-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T02:20:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserList = script:FindFirstAncestor("UserList")
local UserListParent = UserList.Parent

local React = require(UserListParent.React)
local Foundation = require(UserListParent.Foundation)
local DataHydration = require(UserListParent.DataHydration)
local RoactUtils = require(UserListParent.RoactUtils)
local Enums = require(UserList.Common.Enums)

local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local useLocalUserId = require(UserListParent.RobloxAppHooks).useLocalUserId
local NavigateDown = require(UserListParent.NavigationRodux).Thunks.NavigateDown
local FFlagSignalsNavP3Dispatch = require(UserListParent.SharedFlags).FFlagSignalsNavP3Dispatch
local FFlagUserListCtaAnalyticsEnabled = require(UserListParent.SharedFlags).FFlagUserListCtaAnalyticsEnabled
local FFlagGameJoinCardSourceAttribution = require(UserListParent.SharedFlags).FFlagGameJoinCardSourceAttribution
local FFlagUserListSurfaceExtensions = require(UserListParent.SharedFlags).FFlagUserListSurfaceExtensions
local FFlagUserListCanonicalCtaAnalytics = require(UserList.Flags.FFlagUserListCanonicalCtaAnalytics)
local FFlagUserListViewCtaAnalytics = require(UserList.Flags.FFlagUserListViewCtaAnalytics)
local FFlagUserListRowViewCta = require(UserList.Flags.FFlagUserListRowViewCta)
local mapClientActionsToRowCta = if FFlagUserListRowViewCta then require(UserList.Cta.mapClientActionsToRowCta) else nil
local reportCtaActivated = require(UserList.Analytics.reportCtaActivated)
local reportViewCta = require(UserList.Analytics.reportViewCta)
local NavigationCommands = require(UserListParent.RobloxAppNavigation).NavigationCommands
local AppPage = require(UserListParent.RobloxAppEnums).AppPage

local DataStatus = DataHydration.DataStatus
local ButtonTypes = Enums.ButtonTypes
local ButtonVariant = Foundation.Enums.ButtonVariant

local mapServerActionsToRowCta = require(UserList.Cta.mapServerActionsToRowCta)
local _Types = require(UserList.Common.Types)

local tbl1 = { primaryCta = nil, secondaryCta = nil, isLoading = true }

local function buildJoinCta(primaryCta, tbl2, onActivated: (...any) -> (...any)) -- Luacid: Inlined by compiler; 1 call site recovered
    local var1 = table.clone(primaryCta)
    var1.onActivated = onActivated
    var1.isDisabled = not tbl2.isInExperience
    var1.isLoading = tbl2.isLoading
    return var1
end

local function useCtaForRow(arg1, notReady: string?, arg2, str1: string, arg3, tbl2, num1: number?)
    local var1 = useDispatch()
    local var2 = useLocalUserId()

    local var3 = React.useCallback(function(userId: string, joinSource)
        local tbl3 = {
            name = AppPage.GameJoinCard,
            userId = userId,
            joinSource = 0
        }

        if not FFlagGameJoinCardSourceAttribution then
            joinSource = nil
        end

        tbl3.joinSource = joinSource

        if FFlagSignalsNavP3Dispatch then
            NavigationCommands.down(NavigationCommands.fromLegacyPage(tbl3))
            return
        end
        var1(NavigateDown(tbl3))
    end, { var1 })

    local var4 = React.useCallback(function()
        local tbl3 = {
            name = AppPage.ProfilePlatform,
            detail = str1,
            extraProps = {
                profileType = Enums.EntityType.User
            }
        }

        if FFlagSignalsNavP3Dispatch then
            NavigationCommands.down(NavigationCommands.fromLegacyPage(tbl3))
            return
        end
        var1(NavigateDown(tbl3))
    end, { var1, str1 })

    local useMemo = React.useMemo
    local function func1()
        if arg3 and arg3.showSelfProfileCta and str1 == var2 then
            local func2 = var4
            if FFlagUserListViewCtaAnalytics then
                local analytics = arg3.analytics
                func2 = function()
                    reportViewCta(analytics)
                    var4()
                end
            end
            return {
                primaryCta = {
                    type = ButtonTypes.View,
                    onActivated = func2,
                    variant = ButtonVariant.Standard,
                    minWidth = arg3.primaryCtaMinWidth,
                    maxWidth = arg3.primaryCtaMaxWidth
                },
                secondaryCta = nil
            }
        end

        if FFlagUserListRowViewCta then
            local var5 = mapClientActionsToRowCta(arg2, str1, str1 == var2, arg3, if FFlagUserListCanonicalCtaAnalytics then num1 else nil)

            if var5 ~= nil then
                return var5
            end
        end

        if notReady == nil or notReady == DataStatus.NotReady then
            return tbl1
        end

        local var5 = mapServerActionsToRowCta(arg1, arg2, str1, arg3, if FFlagUserListCanonicalCtaAnalytics then num1 else nil)

        local primaryCta = var5.primaryCta

        return if primaryCta and primaryCta.type == ButtonTypes.Join and tbl2 then {
            primaryCta = buildJoinCta(primaryCta, tbl2, function()
                if FFlagUserListCtaAnalyticsEnabled then
                    local onCtaActivated = if arg3 then arg3.onCtaActivated else nil

                    if onCtaActivated ~= nil then
                        onCtaActivated({ buttonType = ButtonTypes.Join, userId = str1 })
                    end
                end

                local analytics = if arg3 then arg3.analytics else nil

                if FFlagUserListCanonicalCtaAnalytics then
                    reportCtaActivated(analytics, ButtonTypes.Join, str1, num1)
                end
                if FFlagUserListSurfaceExtensions and arg3 and arg3.join then
                    arg3.join.onActivated(str1)
                    return
                end
                local var6 = var3
                local str2 = str1

                if not FFlagGameJoinCardSourceAttribution then
                    analytics = nil
                end

                var6(str2, analytics)
            end),
            secondaryCta = var5.secondaryCta
        } else var5
    end

    local var5 = if FFlagUserListCanonicalCtaAnalytics then num1 else nil
    return useMemo(func1, { arg1, notReady, arg2, str1, arg3, tbl2, var3, var2, var4, var5 })
end

return useCtaForRow
