-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:41:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local Localization = require(BuildExperienceParent.Localization)
local React = require(BuildExperienceParent.React)

local LocalizationStrings = require(BuildExperience.LocalizationStrings)

local useLocalization = Localization.Hooks.useLocalization

local function useCaptureToChat<T>(callback: (...any) -> (...any), callback2: ((...any) -> (...any))?)
    local captureToAttach, var2 = React.useState(nil)
    local var3 = useLocalization({ addImages = LocalizationStrings.CHAT_CAPTURE_GALLERY_TITLE })

    local var4 = React.useCallback(function()
        callback2({
            toastAction = {
                text = var3.addImages,
                onActivated = function(arg1)
                    var2(arg1)
                    callback()
                end
            }
        })
    end, { callback, callback2, var3.addImages })
    local onCaptureAttached = React.useCallback(function()
        var2(nil)
    end, {})

    local tbl1 = {
        captureToAttach = captureToAttach,
        onCaptureActivated = 0,
        onCaptureAttached = 0
    }

    if callback2 == nil then
        var4 = nil
    end

    tbl1.onCaptureActivated = var4
    tbl1.onCaptureAttached = onCaptureAttached
    return tbl1
end

return useCaptureToChat
