-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:31:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent
local Localization = require(BuildExperienceParent.Localization)
local React = require(BuildExperienceParent.React)
local SignalsReact = require(BuildExperienceParent.SignalsReact)

local _ChatCaptureGalleryView = require(script.Parent.ChatCaptureGalleryView)
local _ChatCaptureToolbarIllustration = require(script.Parent.ChatCaptureToolbarIllustration)
local LocalizationStrings = require(BuildExperience.LocalizationStrings)

local FFlagBuildExperienceChatCaptureGalleryEmptyEducationEnabled = require(BuildExperience.Flags.FFlagBuildExperienceChatCaptureGalleryEmptyEducationEnabled)
local Display = if FFlagBuildExperienceChatCaptureGalleryEmptyEducationEnabled then require(BuildExperienceParent.Display) else nil
local useLocalization = Localization.Hooks.useLocalization

local function cloneCaptures(initialCaptures)
    return table.clone(initialCaptures)
end

local function getToolbarLayout(displaySize, vector2: Vector2): string -- Luacid: Inlined by compiler; 1 call site recovered
    if displaySize == nil or displaySize == Enum.DisplaySize.Small then
        if vector2.X > vector2.Y then
            return "sideRail"
        end

        return "bottomBar"
    end

    return "floating"
end

local function useChatCaptureGalleryViewModel(tbl1)
    local var1 = SignalsReact.useSignalState(tbl1.captureSource.getCaptures)
    local isFinished = SignalsReact.useSignalState(tbl1.captureSource.getIsFinished)
    local captures = React.useMemo(function()
        local result = {}
        for _, value in var1 do
            if value.CaptureType == Enum.CaptureType.Screenshot then
                table.insert(result, value)
            end
        end
        return result
    end, { var1 })
    local var4, var5 = React.useState(function()
        return cloneCaptures(tbl1.initialCaptures)
    end)
    local var6 = React.useRef(tbl1.isOpen)
    local var7 = useLocalization({
        add = LocalizationStrings.CHAT_CAPTURE_GALLERY_ADD,
        empty = LocalizationStrings.CHAT_CAPTURE_GALLERY_EMPTY,
        selectionCount = {
            LocalizationStrings.CHAT_CAPTURE_GALLERY_SELECTION_COUNT,
            SELECTED_COUNT = #var4,
            MAX_SELECTIONS = tbl1.maxSelections
        },
        showMore = LocalizationStrings.CHAT_CAPTURE_GALLERY_SHOW_MORE,
        title = LocalizationStrings.CHAT_CAPTURE_GALLERY_TITLE
    })

    React.useEffect(function()
        if tbl1.isOpen and not var6.current then
            var5(cloneCaptures(tbl1.initialCaptures))
        end
        var6.current = tbl1.isOpen
    end, { tbl1.isOpen, tbl1.initialCaptures })

    local isSelected = React.useCallback(function(arg1): boolean
        return table.find(var4, arg1) ~= nil
    end, { var4 })

    local onCaptureToggled = React.useCallback(function(arg1)
        var5(function(arg2)
            local var9 = table.find(arg2, arg1)
            if var9 ~= nil then
                local var10 = table.clone(arg2)
                table.remove(var10, var9)
                return var10
            end
            if #arg2 >= tbl1.maxSelections then
                return arg2
            end
            local var10 = table.clone(arg2)
            table.insert(var10, arg1)
            return var10
        end)
    end, { tbl1.maxSelections })

    local onConfirm = React.useCallback(function()
        tbl1.onConfirm(var4)
    end, { tbl1.onConfirm, var4 })

    local tbl2

    if FFlagBuildExperienceChatCaptureGalleryEmptyEducationEnabled then
        local displayStore = Display.GetDisplayStore(false)
        local displaySize = SignalsReact.useSignalState(displayStore.getDisplaySize)
        local var11 = SignalsReact.useSignalState(displayStore.getViewportSize)
        local var12 = useLocalization({
            description = LocalizationStrings.CHAT_CAPTURE_GALLERY_EMPTY_DESCRIPTION,
            dismiss = LocalizationStrings.CHAT_CAPTURE_GALLERY_EMPTY_DISMISS,
            step1 = LocalizationStrings.CHAT_CAPTURE_GALLERY_HOW_TO_STEP_1,
            step2 = LocalizationStrings.CHAT_CAPTURE_GALLERY_HOW_TO_STEP_2,
            step3 = LocalizationStrings.CHAT_CAPTURE_GALLERY_HOW_TO_STEP_3
        })
        tbl2 = {
            descriptionText = var12.description,
            dismissText = var12.dismiss,
            howToSteps = { var12.step1, var12.step2, var12.step3 },
            isShown = isFinished and #captures == 0,
            toolbarLayout = getToolbarLayout(displaySize, var11)
        }
    else
        tbl2 = nil
    end

    return {
        addText = var7.add,
        captures = captures,
        education = tbl2,
        emptyText = var7.empty,
        isFinished = isFinished,
        isLoading = #var1 == 0 and not isFinished,
        isOpen = tbl1.isOpen,
        maxSelections = tbl1.maxSelections,
        selectedCount = #var4,
        selectionCountText = var7.selectionCount,
        showMoreText = var7.showMore,
        titleText = var7.title,
        isSelected = isSelected,
        onCaptureToggled = onCaptureToggled,
        onClose = tbl1.onClose,
        onConfirm = onConfirm,
        onShowMore = tbl1.captureSource.fetchMore,
        shouldProgressivelyLoad = tbl1.shouldProgressivelyLoad
    }
end

return useChatCaptureGalleryViewModel
