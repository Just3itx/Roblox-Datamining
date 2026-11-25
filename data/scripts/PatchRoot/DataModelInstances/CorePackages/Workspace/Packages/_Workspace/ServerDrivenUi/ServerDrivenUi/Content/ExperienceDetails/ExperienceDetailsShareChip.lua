-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:21:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUi = script:FindFirstAncestor("ServerDrivenUi")
local ServerDrivenUiParent = ServerDrivenUi.Parent

local React = require(ServerDrivenUiParent.React)
local Foundation = require(ServerDrivenUiParent.Foundation)
local SignalsReact = require(ServerDrivenUiParent.SignalsReact)

local Game = require(ServerDrivenUiParent.DataHydration).Game
local SduiSharedContent = require(ServerDrivenUiParent.SduiSharedContent)
local Localization = require(ServerDrivenUiParent.Localization)

local SduiChip = SduiSharedContent.SduiChip
local useLocalization = Localization.Hooks.useLocalization
local useExperienceDetailsShare = require(ServerDrivenUi.Content.ExperienceDetails.Hooks.useExperienceDetailsShare)

return React.memo(function(tbl1) -- name: ExperienceDetailsShareChip
    local layoutOrder = tbl1.layoutOrder
    local universeId = tbl1.universeId

    local var1 = useLocalization({ share = "Feature.SocialShare.Action.Share" })

    local var2 = SignalsReact.useSignalState(Game.getGameInfoStore(false).getAndFetchGameInfo(universeId).data)
    local rootPlaceId = var2 and var2.rootPlaceId or nil

    local onActivated = useExperienceDetailsShare(universeId, rootPlaceId, "ExperienceDetailsShareChip")

    return React.createElement(SduiChip, {
        text = var1.share,
        leadingIconName = Foundation.Enums.IconName.ArrowThickToRight,
        onActivated = onActivated,
        layoutOrder = layoutOrder
    })
end)
