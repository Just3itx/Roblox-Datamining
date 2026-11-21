-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T19:50:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameJoinCard = script:FindFirstAncestor("GameJoinCard")
local GameJoinCardParent = GameJoinCard.Parent

local React = require(GameJoinCardParent.React)
local Foundation = require(GameJoinCardParent.Foundation)
local RobloxAppEnums = require(GameJoinCardParent.RobloxAppEnums)
local SocialCommon = require(GameJoinCardParent.SocialCommon)
local useDispatch = require(GameJoinCardParent.RoactUtils).Hooks.RoactRodux.useDispatch
local goToBuild = require(GameJoinCardParent.BuildExperiencePlaytestLaunch.goToBuild)
local UserCtaAction = require(GameJoinCardParent.UserCtaCommon).Enums.UserCtaAction
local AppGuiService = require(GameJoinCardParent.RoactServiceTags).AppGuiService
local useLocalization = require(GameJoinCardParent.Localization).Hooks.useLocalization
local useNavigation = require(GameJoinCardParent.Navigation).useNavigation
local useRoactService = require(GameJoinCardParent.RobloxAppHooks).useRoactService
local useAppPolicy = require(GameJoinCardParent.UniversalAppPolicy).useAppPolicy
local FFlagEnableSplitPane = require(GameJoinCardParent.SharedFlags).FFlagEnableSplitPane
local FFlagSocialCarouselBuildPresence = require(GameJoinCardParent.SharedFlags).FFlagSocialCarouselBuildPresence

local AnalyticsConstants = require(GameJoinCard.Analytics.AnalyticsConstants)
local useGameJoinCardAnalytics = require(GameJoinCard.Analytics.useGameJoinCardAnalytics)

local _Types = require(GameJoinCard.Components.Actions.Types)
local TextKeys = require(GameJoinCard.Components.Actions.TextKeys)
local ViewProfileLink = require(GameJoinCard.Components.Actions.ViewProfileLink)
local _Types2 = require(script.Parent.Types)

local ButtonVariant = Foundation.Enums.ButtonVariant
local InputSize = Foundation.Enums.InputSize
local AppPage = RobloxAppEnums.AppPage
local NotificationType = RobloxAppEnums.NotificationType
local ChatEntryPointNames = SocialCommon.Enums.ChatEntryPointNames
local EnteredChatFromEntryPoint = SocialCommon.Actions.EnteredChatFromEntryPoint

local uDim = UDim.new(1, 0)
local GameJoinCardButtonAction = AnalyticsConstants.GameJoinCardButtonAction

local function logBuildCardButton(num1: number, friendId: string) -- Luacid: Inlined by compiler; 3 call sites recovered
    useGameJoinCardAnalytics.logGameJoinCardButtonEvent(num1, {
        friendId = friendId,
        cardType = if FFlagSocialCarouselBuildPresence then AnalyticsConstants.JoinCardType.Build else nil
    })
end

local function renderViewProfileLink(arg1, layoutOrder: number)
    return React.createElement(ViewProfileLink, { text = arg1.text, onActivated = arg1.onActivated, LayoutOrder = layoutOrder })
end

local function useBuildJoinCardViewModel(arg1)
    local userId = arg1.userId
    local var1 = useNavigation()
    local var2 = useRoactService(AppGuiService)
    local var3 = if FFlagSocialCarouselBuildPresence then useDispatch() else nil

    local var4 = useAppPolicy(function(arg2)
        return arg2.getCanUsePlatformChat()
    end)
    local var5 = useLocalization({
        createInBuild = "Feature.Profile.Action.CreateInBuild",
        chat = TextKeys[UserCtaAction.Chat],
        viewProfile = TextKeys[UserCtaAction.ViewProfile]
    })
    local var6 = if FFlagEnableSplitPane then var1.push else var1.navigate

    local tbl1 = {
        id = UserCtaAction.GoToBuild,
        text = var5.createInBuild,
        variant = ButtonVariant.Emphasis,
        inputSize = InputSize.Medium,
        width = uDim,
        keepOpenOnActivate = true,
        onActivated = function()
            logBuildCardButton(GameJoinCardButtonAction.CreateInBuild, userId)
            arg1.onClose()
            goToBuild(false, var1)
        end
    }
    local tbl2 = {
        id = UserCtaAction.Chat,
        text = var5.chat,
        variant = ButtonVariant.Standard,
        inputSize = InputSize.Medium,
        width = uDim,
        keepOpenOnActivate = arg1.keepsOpenOnNavigation,
        onActivated = function()
            logBuildCardButton(GameJoinCardButtonAction.Chat, userId)
            if FFlagSocialCarouselBuildPresence then
                var3(EnteredChatFromEntryPoint(ChatEntryPointNames.BuildJoinCard))
            end
            var2:BroadcastNotification(userId, NotificationType.LAUNCH_CONVERSATION)
        end
    }
    local tbl3 = {
        id = UserCtaAction.ViewProfile,
        text = var5.viewProfile,
        keepOpenOnActivate = arg1.keepsOpenOnNavigation,
        render = renderViewProfileLink,
        onActivated = function()
            logBuildCardButton(GameJoinCardButtonAction.OpenProfileFromViewProfile, userId)
            var6(AppPage.ProfilePlatform, { detail = userId })
        end
    }

    local actions = { tbl1 }
    if var4 then
        table.insert(actions, tbl2)
    end
    table.insert(actions, tbl3)

    return { actions = actions }
end

return useBuildJoinCardViewModel
