-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:21:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUiParent = script:FindFirstAncestor("ServerDrivenUi").Parent

local React = require(ServerDrivenUiParent.React)
local Foundation = require(ServerDrivenUiParent.Foundation)
local SignalsReact = require(ServerDrivenUiParent.SignalsReact)

local Game = require(ServerDrivenUiParent.DataHydration).Game
local SduiSharedContent = require(ServerDrivenUiParent.SduiSharedContent)
local RoactUtils = require(ServerDrivenUiParent.RoactUtils)
local UniversalAppPolicy = require(ServerDrivenUiParent.UniversalAppPolicy)
local SharedFlags = require(ServerDrivenUiParent.SharedFlags)
local CentralOverlay = require(ServerDrivenUiParent.CentralOverlay)
local Localization = require(ServerDrivenUiParent.Localization)

local SduiChip = SduiSharedContent.SduiChip
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local useAppPolicy = UniversalAppPolicy.useAppPolicy
local CloseCentralOverlay = CentralOverlay.Thunks.CloseCentralOverlay
local useLocalization = Localization.Hooks.useLocalization
local AbuseVector = require(ServerDrivenUiParent.GenericAbuseReporting.AbuseVector)
local OpenDynamicAbuseReport = require(ServerDrivenUiParent.GenericAbuseReporting.OpenDynamicAbuseReport)

local FFlagAddThumbnailSelectorReport = SharedFlags.FFlagAddThumbnailSelectorReport

return React.memo(function(tbl1) -- name: ExperienceDetailsReportChip
    local layoutOrder = tbl1.layoutOrder
    local universeId = tbl1.universeId
    local var1 = useDispatch()

    local var2 = useAppPolicy(function(arg1)
        return arg1.getGameReportingDisabled()
    end)

    local var3 = useLocalization({ report = "Feature.GameDetails.Action.Report" })

    local var4 = SignalsReact.useSignalState(Game.getGameInfoStore(false).getAndFetchGameInfo(universeId).data)
    local rootPlaceId = var4 and var4.rootPlaceId

    local onActivated = React.useCallback(function()
        if not rootPlaceId then
            return
        end
        var1(
            OpenDynamicAbuseReport({
                abuseVector = AbuseVector.Place,
                targetId = rootPlaceId,
                custom = FFlagAddThumbnailSelectorReport and { universeId = universeId } or nil,
                onClose = function()
                    var1(CloseCentralOverlay())
                end
            })
        )
    end, { universeId, rootPlaceId, var1 })

    if var2 then
        return nil
    end

    return React.createElement(SduiChip, {
        text = var3.report,
        leadingIconName = Foundation.Enums.IconName.Flag,
        onActivated = onActivated,
        layoutOrder = layoutOrder
    })
end)
