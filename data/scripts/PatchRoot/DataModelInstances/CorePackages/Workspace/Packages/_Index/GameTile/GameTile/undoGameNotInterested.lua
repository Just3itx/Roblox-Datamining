-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T22:31:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameTile = script:FindFirstAncestor("GameTile")
local GameTileParent = GameTile.Parent

local Loggers = require(GameTileParent.Loggers)
local LoggingProtocol = require(GameTileParent.LoggingProtocol)
local RobloxAppToastsRodux = require(GameTileParent.RobloxAppToastsRodux)
local UserSignals = require(GameTileParent.UserSignals)

local default = LoggingProtocol.default
local PostSendUserSignal = UserSignals.PostSendUserSignal
local SetNetworkingErrorToast = RobloxAppToastsRodux.Thunks.SetNetworkingErrorToast
local UserSignalTypes = UserSignals.UserSignalTypes
local mutedError = Loggers.mutedError

local NotInterestedUserSignalTelemetryEventConfigs = require(GameTile.NotInterestedUserSignalTelemetryEventConfigs)

local function undoGameNotInterested(tbl1): boolean
    if not tbl1.appPage then
        default:logRobloxTelemetryCounter(NotInterestedUserSignalTelemetryEventConfigs.NotInterestedMissingAppPage, 1)

        tbl1.dispatch(SetNetworkingErrorToast())
        return false
    end

    tbl1.setGameHidden(tbl1.universeId, false)
    if tbl1.onOptimisticUnhide then
        tbl1.onOptimisticUnhide()
    end

    local success, result = pcall(function()
        local var1 = PostSendUserSignal
        local networking = tbl1.networking
        local tbl2 = { boolValue = false }

        local tbl3 = {
            id = tbl1.universeId,
            assetType = if tbl1.isSponsored then UserSignalTypes.AssetType.SponsoredGame else UserSignalTypes.AssetType.Game,
            signalOrigin = {
                productSurface = tbl1.appPage,
                topicId = tbl1.collectionId or "",
                subIds = { tbl1.collectionId or "" }
            }
        }

        var1(networking, tbl2, tbl3, UserSignalTypes.SignalValueType.Bool, UserSignalTypes.SignalType.NotInterested):catch(
            function(arg1)
                tbl1.setGameHidden(tbl1.universeId, true)
                tbl1.dispatch(SetNetworkingErrorToast(arg1))
                default:logRobloxTelemetryCounter(NotInterestedUserSignalTelemetryEventConfigs.NotInterestedUserSignalFailed, 1)
            end
        )
    end)

    if not success then
        tbl1.setGameHidden(tbl1.universeId, true)
        mutedError(result)
    end

    return true
end

return undoGameNotInterested
