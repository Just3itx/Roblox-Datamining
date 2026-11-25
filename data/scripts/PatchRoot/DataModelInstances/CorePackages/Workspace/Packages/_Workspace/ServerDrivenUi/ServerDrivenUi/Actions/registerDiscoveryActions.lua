-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:00:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUi = script:FindFirstAncestor("ServerDrivenUi")
local ServerDrivenUiParent = ServerDrivenUi.Parent

local FFlagLuaAppSduiUpdateUserSettingsAction = require(ServerDrivenUiParent.SharedFlags).FFlagLuaAppSduiUpdateUserSettingsAction

local FFlagMoveSduiUpdateUserSettingsToAccountManagement = require(ServerDrivenUiParent.SharedFlags).FFlagMoveSduiUpdateUserSettingsToAccountManagement
local FFlagSduiOpenSearchResultsTabAction = require(ServerDrivenUiParent.SharedFlags).FFlagSduiOpenSearchResultsTabAction
local FFlagLuaAppSduiOpenExternalLinkAction = require(ServerDrivenUiParent.SharedFlags).FFlagLuaAppSduiOpenExternalLinkAction

local SduiCoreSystem = require(ServerDrivenUiParent.SduiCoreSystem)
local SduiActionType = SduiCoreSystem.SduiActionType
local getSduiActionHandlerRegistry = SduiCoreSystem.getSduiActionHandlerRegistry

local FFlagSduiActionsUpdateFiresOwnTelemetry = require(ServerDrivenUiParent.SharedFlags).FFlagSduiActionsUpdateFiresOwnTelemetry
local FFlagSduiCommunitySectionSupport = require(ServerDrivenUiParent.SharedFlags).FFlagSduiCommunitySectionSupport
local FFlagSduiDevStoreSeeAllSupport = require(ServerDrivenUiParent.SharedFlags).FFlagSduiDevStoreSeeAllSupport
local FFlagSduiChartsSortDetailGenreFilter = require(ServerDrivenUiParent.SharedFlags).FFlagSduiChartsSortDetailGenreFilter
local FFlagSduiAiOverviewEnabled = require(ServerDrivenUiParent.SharedFlags).FFlagSduiAiOverviewEnabled
local FFlagSduiPinShortcutAction = require(ServerDrivenUiParent.SharedFlags).FFlagSduiPinShortcutAction
local FFlagLuaAppSduiHomePageSupport = require(ServerDrivenUiParent.SharedFlags).FFlagLuaAppSduiHomePageSupport
local FFlagLuaAppSduiGameTileFeedback = require(ServerDrivenUiParent.SharedFlags).FFlagLuaAppSduiGameTileFeedback

local function registerDiscoveryActions()
    local tbl1 = {
        [SduiActionType.DismissDialog] = {
            lazyHandler = function()
                return require(ServerDrivenUi.Actions.SduiDismissDialogAction)
            end,
            skipUnifiedLogging = false
        },
        [SduiActionType.Link] = {
            lazyHandler = function()
                return require(ServerDrivenUi.Actions.SduiLinkAction)
            end,
            skipUnifiedLogging = false
        },
        [SduiActionType.OpenFaeTrialUpsell] = {
            lazyHandler = function()
                return require(ServerDrivenUi.Actions.SduiOpenFaeTrialUpsellAction)
            end,
            skipUnifiedLogging = false
        },
        [SduiActionType.OpenAbuseReport] = {
            lazyHandler = function()
                return require(ServerDrivenUi.Actions.SduiOpenAbuseReportAction)
            end,
            skipUnifiedLogging = false
        },
        [SduiActionType.OpenGameDetails] = {
            lazyHandler = function()
                return require(ServerDrivenUi.Actions.SduiOpenGameDetailsAction)
            end,
            skipUnifiedLogging = not not FFlagSduiActionsUpdateFiresOwnTelemetry
        },
        [SduiActionType.OpenBadgeDetails] = {
            lazyHandler = function()
                return require(ServerDrivenUi.Actions.SduiOpenBadgeDetailsAction)
            end,
            skipUnifiedLogging = false
        },
        [SduiActionType.OpenBadgesSeeAll] = {
            lazyHandler = function()
                return require(ServerDrivenUi.Actions.SduiOpenBadgesSeeAllAction)
            end,
            lazyTelemetryHandler = function()
                return require(ServerDrivenUi.Actions.TelemetryHandlers.SduiGameDetailsSubpageTelemetryHandler)
            end
        },
        [SduiActionType.OpenExperienceStoreSeeAll] = {
            lazyHandler = function()
                return require(ServerDrivenUi.Actions.SduiOpenExperienceStoreSeeAllAction)
            end,
            lazyTelemetryHandler = function()
                return require(ServerDrivenUi.Actions.TelemetryHandlers.SduiGameDetailsSubpageTelemetryHandler)
            end
        },
        [SduiActionType.OpenProfile] = {
            lazyHandler = function()
                return require(ServerDrivenUi.Actions.SduiOpenProfileAction)
            end,
            skipUnifiedLogging = false
        },
        [SduiActionType.OpenJoinFriends] = {
            lazyHandler = function()
                return require(ServerDrivenUi.Actions.SduiOpenJoinFriendsAction)
            end,
            skipUnifiedLogging = false
        },
        [SduiActionType.OpenSeeAll] = {
            lazyHandler = function()
                return require(ServerDrivenUi.Actions.SduiOpenSeeAllAction)
            end,
            skipUnifiedLogging = not not FFlagSduiActionsUpdateFiresOwnTelemetry
        },
        [SduiActionType.OpenSearchResultsTab] = FFlagSduiOpenSearchResultsTabAction and {
            lazyHandler = function()
                return require(ServerDrivenUi.Actions.SduiOpenSearchResultsTabAction)
            end,
            skipUnifiedLogging = false
        } or nil,
        [SduiActionType.OpenSearchResultsWithQuery] = {
            lazyHandler = function()
                return require(ServerDrivenUi.Actions.SduiOpenSearchResultsWithQueryAction)
            end,
            lazyTelemetryHandler = function()
                return require(ServerDrivenUi.Actions.TelemetryHandlers.SduiOpenSearchResultsWithQueryTelemetryHandler)
            end,
            skipUnifiedLogging = true
        },
        [SduiActionType.OpenExternalLink] = FFlagLuaAppSduiOpenExternalLinkAction and {
            lazyHandler = function()
                return require(ServerDrivenUi.Actions.SduiOpenExternalLinkAction)
            end,
            skipUnifiedLogging = false
        } or nil,
        [SduiActionType.OpenSocialLink] = {
            lazyHandler = function()
                return require(ServerDrivenUi.Actions.SduiOpenSocialLinkAction)
            end,
            lazyTelemetryHandler = function()
                return require(ServerDrivenUi.Actions.TelemetryHandlers.SduiLeavingRobloxTelemetryHandler)
            end,
            skipUnifiedLogging = true
        },
        [SduiActionType.OpenSongDetail] = {
            lazyHandler = function()
                return require(ServerDrivenUi.Actions.SduiOpenSongDetailAction)
            end,
            skipUnifiedLogging = false
        },
        [SduiActionType.OpenAmpWizard] = {
            lazyHandler = function()
                return require(ServerDrivenUi.Actions.SduiOpenAmpWizardAction)
            end,
            skipUnifiedLogging = false
        },
        [SduiActionType.ToggleExperienceFavorite] = {
            lazyHandler = function()
                return require(ServerDrivenUi.Actions.SduiToggleExperienceFavoriteAction)
            end
        },
        [SduiActionType.ToggleExperienceFollow] = {
            lazyHandler = function()
                return require(ServerDrivenUi.Actions.SduiToggleExperienceFollowAction)
            end
        },
        [SduiActionType.ToggleExperienceVote] = {
            lazyHandler = function()
                return require(ServerDrivenUi.Actions.SduiToggleExperienceVoteAction)
            end
        },
        [SduiActionType.DismissGameFeedback] = {
            lazyHandler = function()
                return require(ServerDrivenUi.Actions.SduiDismissGameFeedbackAction)
            end
        },
        [SduiActionType.OpenGameFeedbackForm] = {
            lazyHandler = function()
                return require(ServerDrivenUi.Actions.SduiOpenGameFeedbackFormAction)
            end
        },
        [SduiActionType.AiOverviewFeedback] = FFlagSduiAiOverviewEnabled and {
            lazyHandler = function()
                return require(ServerDrivenUi.Actions.SduiAiOverviewFeedbackAction)
            end,
            skipUnifiedLogging = true
        } or nil,
        [SduiActionType.OpenSponsoredTooltip] = {
            lazyHandler = function()
                return require(ServerDrivenUi.Actions.SduiOpenSponsoredTooltipAction)
            end,
            skipUnifiedLogging = false
        },
        [SduiActionType.SetGameTileNotInterested] = FFlagLuaAppSduiGameTileFeedback and {
            lazyHandler = function()
                return require(ServerDrivenUi.Actions.SduiSetGameTileNotInterestedAction)
            end,
            skipUnifiedLogging = true
        } or nil,
        [SduiActionType.UndoGameTileNotInterested] = FFlagLuaAppSduiGameTileFeedback and {
            lazyHandler = function()
                return require(ServerDrivenUi.Actions.SduiUndoGameTileNotInterestedAction)
            end,
            skipUnifiedLogging = true
        } or nil,
        [SduiActionType.OpenMarketplaceTryOn] = {
            lazyHandler = function()
                return require(ServerDrivenUi.Actions.SduiOpenMarketplaceTryOnAction)
            end,
            skipUnifiedLogging = false
        },
        [SduiActionType.UpdateUserSettings] = FFlagLuaAppSduiUpdateUserSettingsAction
            and not FFlagMoveSduiUpdateUserSettingsToAccountManagement
            and {
                lazyHandler = function()
                    return require(ServerDrivenUiParent.SettingsSdui).getSduiUpdateUserSettingsAction()
                end,
                skipUnifiedLogging = false
            }
            or nil,
        [SduiActionType.PlayButtonClick] = {
            lazyHandler = function()
                return nil
            end,
            skipUnifiedLogging = not not FFlagSduiActionsUpdateFiresOwnTelemetry
        },
        [SduiActionType.OpenTooltip] = {
            lazyHandler = function()
                return require(ServerDrivenUi.Actions.SduiOpenTooltipAction)
            end,
            skipUnifiedLogging = false
        },
        [SduiActionType.RemoveBadgeFromInventory] = {
            lazyHandler = function()
                return require(ServerDrivenUi.Actions.SduiRemoveBadgeFromInventoryAction)
            end,
            skipUnifiedLogging = false
        },
        [SduiActionType.RsvpToEvent] = {
            lazyHandler = function()
                return require(ServerDrivenUi.Actions.SduiRsvpToEventAction)
            end,
            skipUnifiedLogging = false
        },
        [SduiActionType.OpenEventDetails] = {
            lazyHandler = function()
                return require(ServerDrivenUi.Actions.SduiOpenEventDetailsAction)
            end,
            firesOwnTelemetry = false
        },
        [SduiActionType.OpenGameInvite] = {
            lazyHandler = function()
                return require(ServerDrivenUi.Actions.SduiOpenGameInviteAction)
            end,
            skipUnifiedLogging = true
        },
        [SduiActionType.LaunchExperience] = {
            lazyHandler = function()
                return require(ServerDrivenUi.Actions.SduiLaunchExperienceAction)
            end,
            firesOwnTelemetry = false
        },
        [SduiActionType.OpenChartsSortDetail] = {
            lazyHandler = function()
                return require(ServerDrivenUi.Actions.SduiOpenChartsSortDetailAction)
            end,
            skipUnifiedLogging = false
        },
        [SduiActionType.OpenPurchasePrompt] = {
            lazyHandler = function()
                return require(ServerDrivenUi.Actions.OpenPurchasePrompt.SduiOpenPurchasePromptAction)
            end
        },
        [SduiActionType.OpenSubscriptionPurchasePage] = FFlagSduiDevStoreSeeAllSupport and {
            lazyHandler = function()
                return require(ServerDrivenUi.Actions.SduiOpenSubscriptionPurchasePageAction)
            end
        } or nil,
        [SduiActionType.OpenSduiOverlay] = {
            lazyHandler = function()
                return require(ServerDrivenUi.Actions.SduiOpenSduiOverlayAction)
            end,
            firesOwnTelemetry = false
        },
        [SduiActionType.ApplyChartsFilter] = {
            lazyHandler = function()
                return require(ServerDrivenUi.Actions.SduiApplyChartsFilterAction)
            end,
            skipUnifiedLogging = false
        },
        [SduiActionType.RefreshGamePasses] = {
            lazyHandler = function()
                return require(ServerDrivenUi.Actions.SduiRefreshGamePassesAction)
            end
        },
        [SduiActionType.RefreshPlayability] = {
            lazyHandler = function()
                return require(ServerDrivenUi.Actions.SduiRefreshPlayabilityAction)
            end
        },
        [SduiActionType.EnableEventNotifications] = {
            lazyHandler = function()
                return require(ServerDrivenUi.Actions.SduiEnableEventNotificationsAction)
            end,
            skipUnifiedLogging = false
        },
        [SduiActionType.DismissEventNotificationsModal] = {
            lazyHandler = function()
                return require(ServerDrivenUi.Actions.SduiDismissEventNotificationsModalAction)
            end,
            skipUnifiedLogging = false
        },
        [SduiActionType.ReportSurfaceLoadTimeMilestone] = {
            lazyHandler = function()
                return require(ServerDrivenUi.Actions.SduiReportSurfaceLoadTimeMilestoneAction)
            end,
            skipUnifiedLogging = true
        },
        [SduiActionType.RefreshOmniRecommendationFeedItem] = {
            lazyHandler = function()
                return require(ServerDrivenUi.Actions.SduiRefreshOmniRecommendationFeedItemAction)
            end,
            skipUnifiedLogging = false
        },
        [SduiActionType.RefreshHome] = FFlagLuaAppSduiHomePageSupport and {
            lazyHandler = function()
                return require(ServerDrivenUi.Actions.SduiRefreshHomeAction)
            end,
            skipUnifiedLogging = false
        } or nil,
        [SduiActionType.RefreshChartsSortDetail] = FFlagSduiChartsSortDetailGenreFilter and {
            lazyHandler = function()
                return require(ServerDrivenUi.Actions.SduiRefreshChartsSortDetailAction)
            end,
            skipUnifiedLogging = false
        } or nil,
        [SduiActionType.PinExperienceShortcut] = FFlagSduiPinShortcutAction and {
            lazyHandler = function()
                return require(ServerDrivenUi.Actions.SduiPinShortcutAction)
            end,
            skipUnifiedLogging = false
        } or nil,
        [SduiActionType.JoinCommunity] = FFlagSduiCommunitySectionSupport and {
            lazyHandler = function()
                return require(ServerDrivenUi.Actions.SduiJoinCommunityAction)
            end,
            skipUnifiedLogging = false
        } or nil
    }

    getSduiActionHandlerRegistry().registerActionHandlerConfigs(tbl1)
end

return registerDiscoveryActions
