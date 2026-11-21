-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T19:50:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameJoinCard = script:FindFirstAncestor("GameJoinCard")
local GameJoinCardParent = GameJoinCard.Parent

local React = require(GameJoinCardParent.React)
local useLocalization = require(GameJoinCardParent.Localization).Hooks.useLocalization

local DesktopGameJoinCard = require(GameJoinCard.Components.DesktopGameJoinCard.DesktopGameJoinCard)
local BuildJoinCardMedia = require(script.Parent.BuildJoinCardMedia)
local useBuildJoinCardViewModel = require(script.Parent.useBuildJoinCardViewModel)

local function noop(_) end

local function BuildJoinCardPopoverContainer(tbl1)
    local var1 = useBuildJoinCardViewModel({ userId = tbl1.userId, onClose = tbl1.onClose, keepsOpenOnNavigation = false })

    local var2 = useLocalization({ isMakingGameIn = "Feature.Profile.Label.IsMakingGameIn", build = "CommonUI.Features.NavBar.Build" })

    local content = {
        media = React.createElement(BuildJoinCardMedia, { userId = tbl1.userId, slot = "Icon" }),
        activityText = var2.isMakingGameIn
    }
    return React.createElement(DesktopGameJoinCard, {
        layoutOrder = 1,
        playerName = tbl1.playerName,
        experienceName = var2.build,
        gameIconUrl = "",
        isLoading = false,
        onJoin = noop,
        onViewExperienceDetails = noop,
        anchorRef = tbl1.anchorRef,
        isOpen = tbl1.isOpen,
        onClose = tbl1.onClose,
        isConsole = false,
        consolePlatformLabel = "",
        actions = var1.actions,
        content = content
    })
end

return BuildJoinCardPopoverContainer
