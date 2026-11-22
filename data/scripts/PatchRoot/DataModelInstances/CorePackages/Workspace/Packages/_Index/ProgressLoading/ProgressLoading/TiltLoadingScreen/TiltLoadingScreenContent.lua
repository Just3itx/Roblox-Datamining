-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T12:40:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProgressLoading = script:FindFirstAncestor("ProgressLoading")
local ProgressLoadingParent = ProgressLoading.Parent

local React = require(ProgressLoadingParent.React)

local TiltLoadingScreenView = require(script.Parent.TiltLoadingScreenView)
local useTiltLoadingScreenViewModel = require(script.Parent.Hooks.useTiltLoadingScreenViewModel)
local useLoadingScreenAnimation = require(script.Parent.Hooks.useLoadingScreenAnimation)
local useScreenSize = require(script.Parent.Hooks.useScreenSize)
local useViewportSettled = require(script.Parent.Hooks.useViewportSettled)

local FFlagLoadingScreenMilestones = require(ProgressLoadingParent.SharedFlags).FFlagLoadingScreenMilestones
local _Types = require(ProgressLoading.LoadingScreenMilestones.Types)
local ContentId = require(ProgressLoading.LoadingScreenMilestones.Constants).ContentId

local _Types2 = require(script.Parent.Types)

return React.memo(function(arg1) -- name: TiltLoadingScreenContent
    local var1 = useScreenSize()
    local var2 = useTiltLoadingScreenViewModel(arg1.placeId, var1, arg1.destinationUniverseId)
    local showContent = useViewportSettled(var1)
    local var4, var5

    if FFlagLoadingScreenMilestones then
        var4, var5 = React.useState(nil)
    else
        var4 = nil
        var5 = nil
    end
    local var6 = FFlagLoadingScreenMilestones and showContent and not arg1.isDismissing
    local bool1 = not (var2.gameData == nil) and var2.gameData.name ~= ""
    local bool2 = not (var2.gameData == nil) and var2.gameData.creator ~= ""
    local bool3 = not (var4 == nil) and var4 == var2.thumbnailUrl

    local onContentRevealComplete = if FFlagLoadingScreenMilestones then React.useCallback(function(arg2)
        local milestones = arg1.milestones
        local bool4 = arg2 == ContentId.Title and bool1 or arg2 == ContentId.Creator and bool2

        if not bool4 then
            if arg2 == ContentId.Thumbnail then
                bool4 = bool3
            else
                bool4 = false
            end
        end

        if bool4 and var6 and milestones then
            milestones.contentVisible(arg2)
        end
    end, {
        var6,
        bool1,
        bool2,
        bool3,
        arg1.milestones
    }) else nil

    local animation = useLoadingScreenAnimation({
        reducedMotion = arg1.reducedMotion,
        contentReady = not (var2.gameData == nil) and showContent,
        isDismissing = arg1.isDismissing,
        onEnterComplete = arg1.onEnterComplete,
        onContentRevealComplete = onContentRevealComplete
    })

    if FFlagLoadingScreenMilestones then
        React.useEffect(function()
            if animation.title.reveal:getValue() == 1 and onContentRevealComplete then
                onContentRevealComplete(ContentId.Title)
            end
            if animation.creator.reveal:getValue() == 1 and onContentRevealComplete then
                onContentRevealComplete(ContentId.Creator)
            end
            if animation.keyart.coverTransparency:getValue() == 1 and onContentRevealComplete then
                onContentRevealComplete(ContentId.Thumbnail)
            end
        end, { animation, onContentRevealComplete })
    end

    local createElement = React.createElement
    local var9 = TiltLoadingScreenView
    local tbl1 = {
        isMobile = var2.isMobile,
        isDirectionalInput = arg1.isDirectionalInput,
        gamepadCancelIcon = arg1.gamepadCancelIcon,
        chromeReveal = arg1.chromeReveal,
        animation = animation,
        gameData = var2.gameData,
        thumbnailUrl = var2.thumbnailUrl,
        onThumbnailLoaded = 0,
        isAutoTranslated = 0,
        statusPanel = 0,
        onCancel = 0,
        safeAreaInsets = 0,
        showContent = 0
    }

    if not FFlagLoadingScreenMilestones then
        var5 = nil
    end

    tbl1.onThumbnailLoaded = var5
    tbl1.isAutoTranslated = var2.isAutoTranslated
    tbl1.statusPanel = var2.statusPanel
    tbl1.onCancel = arg1.onCancel
    tbl1.safeAreaInsets = arg1.safeAreaInsets
    tbl1.showContent = showContent
    return createElement(var9, tbl1)
end)
