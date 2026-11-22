-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T19:50:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialServerDrivenUi = script:FindFirstAncestor("SocialServerDrivenUi")
local SocialServerDrivenUiParent = SocialServerDrivenUi.Parent
local SduiCoreSystem = require(SocialServerDrivenUiParent.SduiCoreSystem)
local SduiActionType = SduiCoreSystem.SduiActionType
local getSduiActionHandlerRegistry = SduiCoreSystem.getSduiActionHandlerRegistry

local FFlagLuaAppSduiVerificationUpsellActions = require(SocialServerDrivenUiParent.SharedFlags).FFlagLuaAppSduiVerificationUpsellActions
local FFlagEditProfileFramesEnabled = require(SocialServerDrivenUiParent.SharedFlags).FFlagEditProfileFramesEnabled
local FFlagAddSDUIEditProfileFramesAction = require(SocialServerDrivenUiParent.SharedFlags).FFlagAddSDUIEditProfileFramesAction

local FFlagAppChatConversationTrustedFriendUpsellBanner = require(SocialServerDrivenUiParent.SharedFlags).FFlagAppChatConversationTrustedFriendUpsellBanner

local FFlagLuaAppExperienceLeaderboardSeeAllEnabled = require(SocialServerDrivenUiParent.SharedFlags).FFlagLuaAppExperienceLeaderboardSeeAllEnabled

local function registerSocialActions()
    local tbl1 = {
        [SduiActionType.OpenFacialAgeEstimation] = not FFlagLuaAppSduiVerificationUpsellActions and {
            lazyHandler = function()
                return require(SocialServerDrivenUi.Actions.SduiOpenFacialAgeEstimationAction)
            end
        } or nil,
        [SduiActionType.OpenAddConnectionsPage] = {
            lazyHandler = function()
                return require(SocialServerDrivenUi.Actions.SduiOpenAddConnectionsPageAction)
            end
        },
        [SduiActionType.OpenMarketplace] = {
            lazyHandler = function()
                return require(SocialServerDrivenUi.Actions.SduiOpenMarketplaceAction)
            end
        },
        [SduiActionType.HideProfileCompletion] = {
            lazyHandler = function()
                return require(SocialServerDrivenUi.Actions.SduiHideProfileCompletionAction)
            end
        },
        [SduiActionType.RequestFriendship] = {
            lazyHandler = function()
                return require(SocialServerDrivenUi.Actions.SduiRequestFriendshipAction)
            end,
            skipUnifiedLogging = true
        },
        [SduiActionType.OpenProfileFramesEditor] = FFlagEditProfileFramesEnabled and FFlagAddSDUIEditProfileFramesAction and {
            lazyHandler = function()
                return require(SocialServerDrivenUi.Actions.SduiOpenProfileFramesEditorAction)
            end
        } or nil,
        [SduiActionType.OpenTrustedFriendsUpsellModal] = FFlagAppChatConversationTrustedFriendUpsellBanner and {
            lazyHandler = function()
                return require(SocialServerDrivenUi.Actions.SduiOpenTrustedFriendsUpsellModalAction)
            end
        } or nil,
        [SduiActionType.RecordPartyChatConversationUpsellAcknowledgement] = FFlagAppChatConversationTrustedFriendUpsellBanner and {
            lazyHandler = function()
                return require(SocialServerDrivenUi.Actions.SduiRecordPartyChatConversationUpsellAcknowledgementAction)
            end,
            skipUnifiedLogging = true
        } or nil,
        [SduiActionType.OpenExperienceLeaderboardSeeAll] = FFlagLuaAppExperienceLeaderboardSeeAllEnabled and {
            lazyHandler = function()
                return require(SocialServerDrivenUi.Actions.SduiOpenExperienceLeaderboardSeeAllAction)
            end
        } or nil
    }

    getSduiActionHandlerRegistry().registerActionHandlerConfigs(tbl1)
end

return registerSocialActions
