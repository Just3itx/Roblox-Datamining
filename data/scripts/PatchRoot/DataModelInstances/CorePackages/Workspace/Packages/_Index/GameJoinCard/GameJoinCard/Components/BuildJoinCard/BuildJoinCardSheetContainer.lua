-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T19:50:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameJoinCard = script:FindFirstAncestor("GameJoinCard")
local GameJoinCardParent = GameJoinCard.Parent

local React = require(GameJoinCardParent.React)
local Navigation = require(GameJoinCardParent.Navigation)
local useLocalization = require(GameJoinCardParent.Localization).Hooks.useLocalization

local MobileGameJoinCard = require(GameJoinCard.Components.MobileGameJoinCard.MobileGameJoinCard)
local BuildJoinCardMedia = require(script.Parent.BuildJoinCardMedia)
local useBuildJoinCardViewModel = require(script.Parent.useBuildJoinCardViewModel)
local usePlayerName = require(GameJoinCard.Hooks.usePlayerName)

local function noop(_) end

local function BuildJoinCardSheetContainer()
    local var1 = Navigation.useNavigation()
    local userId = var1.getParam("userId")
    assert(type(userId) == "string" and userId ~= "", "BuildJoinCard route needs a userId param")
    local var2 = usePlayerName(userId)
    local isNavigationFocused = Navigation.useNavigationFocus()
    local onClose = React.useCallback(function()
        var1.goBack()
    end, { var1 })

    local var5 = useBuildJoinCardViewModel({ userId = userId, onClose = onClose, keepsOpenOnNavigation = true })

    local var6 = useLocalization({ subtitle = "Feature.Profile.Label.IsMakingGameInBuild" })

    local content = {
        media = React.createElement(BuildJoinCardMedia, { userId = userId, slot = "Banner" }),
        title = var2,
        subtitle = var6.subtitle
    }
    return React.createElement(MobileGameJoinCard, {
        isNavigationFocused = isNavigationFocused,
        onClose = onClose,
        onJoin = noop,
        onViewExperienceDetails = noop,
        onChat = noop,
        canUsePlatformChat = false,
        userId = userId,
        universeId = "",
        playerName = var2,
        experienceName = "",
        isLoading = false,
        isInExperience = false,
        actions = var5.actions,
        content = content
    })
end

return BuildJoinCardSheetContainer
