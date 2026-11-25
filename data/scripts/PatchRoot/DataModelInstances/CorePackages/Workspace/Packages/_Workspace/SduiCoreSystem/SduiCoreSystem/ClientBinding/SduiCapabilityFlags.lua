-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T09:51:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiCoreSystemParent = script:FindFirstAncestor("SduiCoreSystem").Parent
local Foundation = require(SduiCoreSystemParent.Foundation)
local SharedFlags = require(SduiCoreSystemParent.SharedFlags)

local function isPinShortcutServiceEnabled(): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return game:GetEngineFeature("PinShortcutServiceEnabled")
end

return {
    CAPABILITY_SUPPORTS_HYDRATION_CLIENT_HINTS = true,
    CAPABILITY_SUPPORTS_GAME_TILE_ACTIVE_FRIENDS_TREATMENT = SharedFlags.FFlagSduiActiveFriendsFooterTreatment,
    CAPABILITY_SUPPORTS_MULTI_SIZE_POOL = SharedFlags.FFlagSduiPerSectionPoolSizing,
    CAPABILITY_SUPPORTS_EDP_PERSISTENT_ACTION_BAR_PLAY_BUTTON = SharedFlags.FFlagSduiEdpPersistentActionBarPlayButton,
    CAPABILITY_SUPPORTS_EDP_COMMUNITY_SECTION = SharedFlags.FFlagSduiCommunitySectionSupport,
    CAPABILITY_SUPPORTS_EDP_BUILD_TAG = SharedFlags.FFlagLuaAppEdpShowBuildTag,
    CAPABILITY_SUPPORTS_OPEN_EXPERIENCE_STORE_SEE_ALL_WITH_WEBVIEW_FALLBACK_ACTION = SharedFlags.FFlagSduiCapabilityDevStoreSeeAllWebviewFallback,
    CAPABILITY_SUPPORTS_PIN_SHORTCUT_ACTION = (function(): boolean -- name: isPinShortcutAvailable
        if not SharedFlags.FFlagSduiPinShortcutAction then
            return false
        end

        if not isPinShortcutServiceEnabled() then
            return false
        end
        local PinShortcutService = nil

        pcall(function()
            PinShortcutService = game:GetService("PinShortcutService")
        end)
        if PinShortcutService == nil then
            return false
        end
        local success, result = pcall(function()
            return PinShortcutService:IsAvailable()
        end)
        return if success then result == true else false
    end)(),
    CAPABILITY_SUPPORTS_EVENT_RSVP_FACE_PILE = SharedFlags.FFlagSduiEventRsvpFacePile,
    CAPABILITY_SUPPORTS_SCALED_PLAY_BUTTON_AND_IMAGE_SIZES = SharedFlags.FFlagSduiScalePlayButtonAndImageSizes,
    CAPABILITY_SUPPORTS_EXTENDED_CLIENT_CAPABILITIES = SharedFlags.FFlagSduiAdvertiseRuntimeSupportSets,
    CAPABILITY_SUPPORTS_PREFERRED_TEXT_SIZE_LINE_BUDGETS = SharedFlags.FFlagSduiPreferredTextSizeLineBudgets,
    CAPABILITY_SUPPORTS_CONTAINER_QUERIES = SharedFlags.FFlagSduiContainerQueries,
    CAPABILITY_SUPPORTS_EDP_EARLY_ACCESS_UPSELL = SharedFlags.FFlagEnableGameJoinEarlyAccess,
    CAPABILITY_SUPPORTS_LEADERBOARD = SharedFlags.FFlagSduiLeaderboardCapability,
    CAPABILITY_SUPPORTS_EDP_INFO_TABLE_STABLE_ITEM_KEYS = SharedFlags.FFlagInfoTableStableItemKeys,
    CAPABILITY_SUPPORTS_VIDEO_PLAYER_ACCESS_CONTEXT = SharedFlags.FFlagLuaAppHomeMomentVideoFallback and SharedFlags.FFlagLuaAppVideoPlayerTrimAndMusic,
    CAPABILITY_SUPPORTS_GROUP_ANNOUNCEMENTS = SharedFlags.FFlagGroupAnnouncementsSdui,
    CAPABILITY_SUPPORTS_GROUP_CONTENT_REACTIONS = SharedFlags.FFlagSduiReactionsComponent,
    CAPABILITY_SUPPORTS_GROUP_FORUM_POST_TEMPLATE = SharedFlags.FFlagGroupForumPostTemplate and SharedFlags.FFlagSduiMarkdownTextComponentEnabled,
    CAPABILITY_SUPPORTS_FOUNDATION_BADGE_OVERMEDIA_LIGHT = Foundation.Utility.Flags.FoundationBadgeOverMediaAdaptive,
    CAPABILITY_SUPPORTS_FOUNDATION_BADGE_SHAPE = SharedFlags.FFlagSduiBadgeShape,
    CAPABILITY_SUPPORTS_EDP_MEDIA_GALLERY_MOMENT_VIDEO = SharedFlags.FFlagLuaAppEdpMomentVideo and SharedFlags.FFlagLuaAppVideoPlayerTrimAndMusic,
    CAPABILITY_SUPPORTS_SAFETY_RESOURCE_BANNER = SharedFlags.FFlagSafetyResourceBannerTelemetry and SharedFlags.FFlagLuaAppSduiOpenExternalLinkAction,
    CAPABILITY_SUPPORTS_LAUNCH_EXPERIENCE_PLAYABILITY_CHECK = SharedFlags.FFlagSduiLaunchExperienceCheckPlayabilityBeforeLaunch,
    CAPABILITY_SUPPORTS_UNIVERSE_ITEM_CONNECTIONS_PLAYED = SharedFlags.FFlagSduiUniverseItemConnectionsPlayed,
    CAPABILITY_SUPPORTS_GAME_TILE_FOOTER_TRAILING_COMPONENT = SharedFlags.FFlagLuaAppSduiGameTileFooterTrailingComponent
}
