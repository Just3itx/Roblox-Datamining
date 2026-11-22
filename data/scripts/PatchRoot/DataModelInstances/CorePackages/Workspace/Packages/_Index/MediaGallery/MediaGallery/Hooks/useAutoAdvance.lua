-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T02:51:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MediaGallery = script:FindFirstAncestor("MediaGallery")
local MediaGalleryParent = MediaGallery.Parent

local React = require(MediaGalleryParent.React)

local MediaGalleryConstants = require(MediaGallery.MediaGalleryConstants)
local useGuiObjectVisibility = require(MediaGallery.Hooks.useGuiObjectVisibility)

local function useAutoAdvance(tbl1)
    local var1 = tbl1.intervalSeconds or MediaGalleryConstants.AUTO_ADVANCE_DURATION_SECONDS

    local elapsedTimeBinding, var3 = React.useBinding(0)
    local progressBinding, onVideoProgressChanged = React.useBinding(0)

    local resetProgress = React.useCallback(function()
        var3(0)
        onVideoProgressChanged(0)
    end, {})

    local onVideoEnded = React.useCallback(function()
        if not tbl1.enabled then
            return
        end
        tbl1.scrollRight()
    end, { tbl1.enabled, tbl1.scrollRight })

    local var8 = React.useCallback(function(num1: number)
        local var8 = elapsedTimeBinding:getValue() + num1

        if var1 <= var8 then
            var3(0)
            onVideoProgressChanged(0)
            tbl1.scrollRight()
            return
        end
        var3(var8)
        onVideoProgressChanged(var8 / var1)
    end, { elapsedTimeBinding, tbl1.scrollRight, var1 })

    local var9 = tbl1.enabled and not (tbl1.isMediaGalleryOccluded or tbl1.isAutoAdvanceTimerSuspended)

    useGuiObjectVisibility(tbl1.galleryRef, var9, var8, resetProgress)

    return {
        elapsedTimeBinding = elapsedTimeBinding,
        progressBinding = progressBinding,
        resetProgress = resetProgress,
        onVideoEnded = onVideoEnded,
        onVideoProgressChanged = onVideoProgressChanged
    }
end

return useAutoAdvance
