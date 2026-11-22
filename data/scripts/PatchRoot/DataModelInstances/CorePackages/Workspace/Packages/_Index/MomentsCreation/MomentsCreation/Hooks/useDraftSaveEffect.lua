-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:21:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreation = script:FindFirstAncestor("MomentsCreation")
local MomentsCreationParent = MomentsCreation.Parent

local React = require(MomentsCreationParent.React)
local Signals = require(MomentsCreationParent.Signals)
local MomentsCommon = require(MomentsCreationParent.MomentsCommon)

local GetCreationFlowStore = require(MomentsCreation.Stores.GetCreationFlowStore)
local MomentsDraftStorage = require(MomentsCreation.Storage.MomentsDraftStorage)
local isAvatarMoment = require(MomentsCreation.Utils.isAvatarMoment)
local fireAnalyticsEvent = require(MomentsCreation.Analytics.fireAnalyticsEvent)
local FFlagMomentsCommentsCreatorControl = require(MomentsCreation.Flags.FFlagMomentsCommentsCreatorControl)
local FFlagMomentsCreateAvatarPosts = require(MomentsCreationParent.SharedFlags).FFlagMomentsCreateAvatarPosts

local EventNames = MomentsCommon.Analytics.EventNames

local function useDraftSaveEffect(bool1: boolean?)
    local creationFlowStore = GetCreationFlowStore(false)

    React.useEffect(function()
        if bool1 then
            return nil
        end

        return Signals.createEffect(function(arg1)
            local selectedCapture = creationFlowStore.getSelectedCapture(arg1)
            local description = creationFlowStore.getDescription(arg1)
            local commentsEnabled = if FFlagMomentsCommentsCreatorControl then creationFlowStore.getCommentsEnabled(arg1) else nil
            local edits = creationFlowStore.getEditsMap(arg1)

            if selectedCapture ~= nil
                and not (FFlagMomentsCreateAvatarPosts and isAvatarMoment(selectedCapture)
                    or MomentsDraftStorage.save({
                        captureRef = {
                            localId = selectedCapture.LocalId,
                            captureType = selectedCapture.CaptureType
                        },
                        description = description,
                        commentsEnabled = commentsEnabled,
                        edits = edits
                    }))
            then
                fireAnalyticsEvent(EventNames.DraftSaveFailedEvent, {})
            end
        end)
    end, { creationFlowStore, bool1 })
end

return useDraftSaveEffect
