-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:01:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local Localization = require(BuildExperienceParent.Localization)
local React = require(BuildExperienceParent.React)
local SignalsReact = require(BuildExperienceParent.SignalsReact)
local LocalizationStrings = require(BuildExperience.LocalizationStrings)

local FFlagBuildExperienceLocalizeCaptureShowMore = require(BuildExperience.Flags.FFlagBuildExperienceLocalizeCaptureShowMore)

local useLocalization = Localization.Hooks.useLocalization

local function useCaptureSelectionViewModel(tbl1)
    local captures = SignalsReact.useSignalState(tbl1.captureSource.getCaptures)
    local isFinished = SignalsReact.useSignalState(tbl1.captureSource.getIsFinished)
    local selectedCapture, var4 = React.useState(nil)
    local var5 = if FFlagBuildExperienceLocalizeCaptureShowMore then useLocalization({ showMore = LocalizationStrings.MEDIA_SELECTION_SHOW_MORE }) else nil

    return {
        captures = captures,
        selectedCapture = selectedCapture,
        previewContent = React.useMemo(function()
            if selectedCapture ~= nil and typeof(selectedCapture) == "Object" then
                return Content.fromObject(selectedCapture)
            end
            return nil
        end, { selectedCapture }),
        isFinished = isFinished,
        onCaptureSelected = React.useCallback(function(arg1)
            var4(arg1)
        end, {}),
        onConfirm = React.useCallback(function()
            if selectedCapture ~= nil then
                tbl1.onCaptureConfirmed(selectedCapture)
            end
        end, { selectedCapture, tbl1.onCaptureConfirmed }),
        onShowMore = tbl1.captureSource.fetchMore,
        showMoreText = if FFlagBuildExperienceLocalizeCaptureShowMore then var5.showMore else nil
    }
end

return useCaptureSelectionViewModel
