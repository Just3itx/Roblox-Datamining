-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:31:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommon = script:FindFirstAncestor("AuthCommon")
local AuthCommonParent = AuthCommon.Parent

local React = require(AuthCommonParent.React)
local useDispatch = require(AuthCommonParent.RoactUtils).Hooks.RoactRodux.useDispatch
local useRoactService = require(AuthCommonParent.RobloxAppHooks).useRoactService
local useAppPolicy = require(AuthCommonParent.UniversalAppPolicy).useAppPolicy

local AppLinking = require(AuthCommonParent.RoactServiceTags).AppLinking
local NavigateDown = require(AuthCommonParent.NavigationRodux).Thunks.NavigateDown
local SharedFlags = require(AuthCommonParent.SharedFlags)
local FFlagEnablePioneerLandingPageLayout = SharedFlags.FFlagEnablePioneerLandingPageLayout
local FFlagSignalsNavP3Dispatch = SharedFlags.FFlagSignalsNavP3Dispatch
local NavigationCommands = if FFlagSignalsNavP3Dispatch then require(AuthCommonParent.RobloxAppNavigation).NavigationCommands else nil
local AppPage = require(AuthCommonParent.RobloxAppEnums).AppPage
local UrlBuilder = require(AuthCommonParent.UrlBuilder).UrlBuilder
local AuthAnalytics = require(AuthCommonParent.AuthAnalytics)
local authFormInteraction = AuthAnalytics.Events.authFormInteraction
local EventStreamConstants = AuthAnalytics.EventStreamConstants
local OpenExternalBrowser = require(AuthCommon.Thunks.OpenExternalBrowser)
local TransitionAnimation = require(AuthCommon.Enums.TransitionAnimation)

local function useOpenDisclaimerLinks(tbl1)
    local var1 = useDispatch()
    local var2 = useRoactService(AppLinking)
    local var3 = useAppPolicy(function(arg1)
        return arg1.shouldUseExternalBrowserForDisclaimerLinks()
    end)
    local var4 = if FFlagEnablePioneerLandingPageLayout then if tbl1 then tbl1.disableExternalLinks == true else false else nil

    local function openLink(detail: string, tbl2)
        if var3 and not var4 then
            OpenExternalBrowser(var2, detail)
            return
        end

        local tbl3 = {
            name = AppPage.GenericWebPage,
            detail = detail,
            extraProps = {
                title = if not tbl2 or tbl2.title == nil then "" else tbl2.title,
                transitionAnimation = if tbl2 and tbl2.transitionAnimation ~= nil then tbl2.transitionAnimation else TransitionAnimation.SlideInFromRight
            }
        }

        if FFlagSignalsNavP3Dispatch then
            NavigationCommands.down(NavigationCommands.fromLegacyPage(tbl3))
            return
        end
        var1(NavigateDown(tbl3))
    end

    local useCallback = React.useCallback
    local var5 = if FFlagEnablePioneerLandingPageLayout then var4 else nil
    local var6 = useCallback(openLink, { var3, var2, var1, var5 })
    local ctx = if tbl1 then tbl1.ctx else nil
    local state = if tbl1 then tbl1.state else nil
    local origin = if tbl1 then tbl1.origin else nil

    local openTerms = React.useCallback(function()
        if ctx then
            authFormInteraction(ctx, EventStreamConstants.Field.TermsOfService, state, origin)
        end
        var6(UrlBuilder.static.about.terms())
    end, {
        var6,
        ctx,
        state,
        origin
    })
    local openPrivacy = React.useCallback(function()
        if ctx then
            authFormInteraction(ctx, EventStreamConstants.Field.PrivacyPolicy, state, origin)
        end
        var6(UrlBuilder.static.about.privacy())
    end, {
        var6,
        ctx,
        state,
        origin
    })

    return React.useMemo(function()
        return { openTerms = openTerms, openPrivacy = openPrivacy, openLink = var6 }
    end, { openTerms, openPrivacy, var6 })
end

return useOpenDisclaimerLinks
