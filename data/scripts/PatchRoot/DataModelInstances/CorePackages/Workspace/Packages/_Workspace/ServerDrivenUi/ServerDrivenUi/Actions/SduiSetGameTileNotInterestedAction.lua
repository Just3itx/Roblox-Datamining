-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:10:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUiParent = script:FindFirstAncestor("ServerDrivenUi").Parent

local GameTile = require(ServerDrivenUiParent.GameTile)
local Localization = require(ServerDrivenUiParent.Localization)
local SduiCoreSystem = require(ServerDrivenUiParent.SduiCoreSystem)

local SduiActionType = SduiCoreSystem.SduiActionType
local SduiErrorType = SduiCoreSystem.SduiErrors.SduiErrorType
local activateGameNotInterested = GameTile.activateGameNotInterested
local getGameTileHiddenStore = GameTile.getGameTileHiddenStore
local localizeStrings = Localization.localizeStrings

local function reportInvalidParam(arg1, message: string, propName: string?) -- Luacid: Inlined by compiler; 3 call sites recovered
    arg1.dependencies.logger.reportError(
        SduiErrorType.InvalidActionParams,
        {
            name = SduiActionType.SetGameTileNotInterested,
            message = message,
            propName = propName
        },
        arg1.appPage
    )
end

local function SduiSetGameTileNotInterestedAction(arg1, _, arg2)
    local actionParams = if arg1 then arg1.actionParams else nil

    if actionParams == nil then
        reportInvalidParam(arg2, "Missing actionParams", nil)
        return
    end

    local universeId = actionParams.universeId
    if typeof(universeId) ~= "string" or universeId == "" then
        reportInvalidParam(arg2, "Missing or invalid actionParam: universeId", "universeId")
        return
    end

    local collectionId = actionParams.collectionId
    if typeof(collectionId) ~= "string" or collectionId == "" then
        reportInvalidParam(arg2, "Missing or invalid actionParam: collectionId", "collectionId")
        return
    end

    local localizedStrings = localizeStrings(arg2.dependencies.localization, {
        checkboxListTitle = "Feature.GameDetails.Message.HidingExperienceQuestion",
        dialogText = "Feature.GameDetails.Message.HelpImproveExperience",
        dialogTitle = "Feature.GameDetails.Label.ProvideFeedbackTitle",
        dontLikeGame = "Feature.GameDetails.Label.DontLikeGame",
        dontLikeImage = "Feature.GameDetails.Label.DontLikeImage",
        inappropriateContent = "Feature.GameDetails.Label.InappropriateContent",
        somethingElse = "Feature.GameDetails.Label.SomethingElse",
        tooRepetitive = "Feature.GameDetails.Label.TooRepetitive"
    })

    local isSponsored = if typeof(actionParams.isSponsored) == "boolean" then actionParams.isSponsored else nil

    activateGameNotInterested({
        appPage = arg2.appPage,
        collectionId = collectionId,
        dispatch = arg2.dependencies.dispatch,
        isSponsored = isSponsored,
        localizedStrings = localizedStrings,
        networking = arg2.dependencies.networking,
        placeId = actionParams.placeId,
        setGameHidden = getGameTileHiddenStore(collectionId).setGameHidden,
        universeId = universeId
    })
end

return SduiSetGameTileNotInterestedAction
