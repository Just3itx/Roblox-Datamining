-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:41:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceProfilePictureEditor = script:FindFirstAncestor("AvatarExperienceProfilePictureEditor")
local AvatarExperienceProfilePictureEditorParent = AvatarExperienceProfilePictureEditor.Parent

local Constants = require(AvatarExperienceProfilePictureEditor.Constants)
local computeCutoutFieldOfViewDeg = require(AvatarExperienceProfilePictureEditor.Shared.computeCutoutFieldOfViewDeg)
local RobloxAppHooks = require(AvatarExperienceProfilePictureEditorParent.RobloxAppHooks)
local useDeviceOrientation = RobloxAppHooks.useDeviceOrientation
local useScreenSize = RobloxAppHooks.useScreenSize
local FFlagSplitPaneProfileEditFillPane = require(AvatarExperienceProfilePictureEditorParent.SharedFlags).FFlagSplitPaneProfileEditFillPane

local function computeVisiblePeekabooPreviewHeight(num1: number, num2: number) -- Luacid: Inlined by compiler; 1 call site recovered
    return num1 + num2 + Constants.StackedPreviewBottomMargin
end

local function computeEditProfileImageLayout(arg1)
    local mode = if arg1.deviceOrientation == "Landscape" then "split" else "stacked"
    local safeWidth = arg1.screenSize.X - arg1.guiInset.left - arg1.guiInset.right
    local var2 = arg1.screenSize.Y - arg1.guiInset.top - arg1.guiInset.bottom
    local var3 = if mode == "split" then math.floor(safeWidth * Constants.SplitControlsPaneWidthScale + 0.5) else 0
    local previewWidth = safeWidth - var3
    local num1 = math.floor(math.min(previewWidth * (2 / 3), var2 * 0.375) + 0.5)
    local var5 = arg1.guiInset.top + (if mode == "split" then 72 else 36)
    local closeButtonTopOffset = arg1.guiInset.top + 12

    return {
        mode = mode,
        safeWidth = safeWidth,
        previewWidth = previewWidth,
        previewHeight = var2,
        visiblePreviewHeight = if mode == "split" then var2 else computeVisiblePeekabooPreviewHeight(var5, num1),
        cutoutSize = num1,
        cutoutTopOffset = var5,
        closeButtonTopOffset = closeButtonTopOffset,
        cutoutFieldOfViewDeg = computeCutoutFieldOfViewDeg({ viewportHeightPix = var2, cutoutTopOffsetPix = var5, cutoutDiameterPix = num1 })
    }
end

return {
    useEditProfileImageLayout = function(tbl1)
        local var1 = useDeviceOrientation()
        local screenSize = useScreenSize()

        if not FFlagSplitPaneProfileEditFillPane then
            return (computeEditProfileImageLayout({ guiInset = tbl1.guiInset, deviceOrientation = var1, screenSize = screenSize }))
        end

        local containerSize = tbl1.containerSize
        if containerSize then
            var1 = if containerSize.X > containerSize.Y then "Landscape" else nil
        end
        return (computeEditProfileImageLayout(
            {
                guiInset = tbl1.guiInset,
                deviceOrientation = var1,
                screenSize = containerSize or screenSize
            }
        ))
    end,
    computeEditProfileImageLayout = computeEditProfileImageLayout
}
