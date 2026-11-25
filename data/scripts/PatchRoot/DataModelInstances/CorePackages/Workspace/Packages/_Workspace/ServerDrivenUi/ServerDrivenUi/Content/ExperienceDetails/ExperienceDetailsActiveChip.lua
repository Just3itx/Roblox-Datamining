-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:20:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUi = script:FindFirstAncestor("ServerDrivenUi")
local ServerDrivenUiParent = ServerDrivenUi.Parent
local Players = game:GetService("Players")

local React = require(ServerDrivenUiParent.React)
local Foundation = require(ServerDrivenUiParent.Foundation)
local SignalsReact = require(ServerDrivenUiParent.SignalsReact)

local DataHydration = require(ServerDrivenUiParent.DataHydration)
local SduiSharedContent = require(ServerDrivenUiParent.SduiSharedContent)
local GameTile = require(ServerDrivenUiParent.GameTile)
local Localization = require(ServerDrivenUiParent.Localization)
local DiscoveryAnalytics = require(ServerDrivenUiParent.DiscoveryAnalytics)

local SduiChip = SduiSharedContent.SduiChip
local usePlayerCountText = GameTile.usePlayerCountText
local useLocalization = Localization.Hooks.useLocalization
local gameDetailsSubpage = DiscoveryAnalytics.Events.gameDetailsSubpage
local useNavigateToServers = require(ServerDrivenUi.Content.ExperienceDetails.Hooks.useNavigateToServers)

return React.memo(function(tbl1) -- name: ExperienceDetailsActiveCountChip
    local layoutOrder = tbl1.layoutOrder
    local universeId = tbl1.universeId

    local var1 = SignalsReact.useSignalState(DataHydration.Game.getGameInfoStore(false).getAndFetchGameInfo(universeId).data)

    local numActivePlayers = usePlayerCountText(var1 and var1.playerCount or 0)

    local var3 = useLocalization(
        {
            numActivePlayers = {
                "Feature.GameDetails.Label.LowercaseNumberPlaying",
                numActivePlayers = numActivePlayers
            }
        }
    )
    local var4 = useNavigateToServers(universeId)

    local onActivated = React.useCallback(function()
        local rootPlaceId = var1 and var1.rootPlaceId
        if rootPlaceId then
            local userId = Players.LocalPlayer and Players.LocalPlayer.UserId
            gameDetailsSubpage({
                uid = tostring(userId),
                universeId = universeId,
                placeId = tostring(rootPlaceId),
                subpage = "Servers",
                action = "open",
                ctx = "ExperienceDetailsActiveCountChip"
            }, "ExperienceDetailsActiveCountChip")
        end

        var4()
    end, { universeId, var1, var4 })

    return React.createElement(SduiChip, {
        text = var3.numActivePlayers,
        layoutOrder = layoutOrder,
        leadingIconName = Foundation.Enums.IconName.TwoPeople,
        onActivated = onActivated
    })
end)
