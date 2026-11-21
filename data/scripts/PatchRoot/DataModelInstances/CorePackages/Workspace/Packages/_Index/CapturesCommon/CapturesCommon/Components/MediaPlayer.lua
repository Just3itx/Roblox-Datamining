-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T06:01:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RunService = game:GetService("RunService")

local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local Foundation = require(scriptParentParentParent.Foundation)
local React = require(scriptParentParentParent.React)

local ButtonSize = Foundation.Enums.ButtonSize
local Enums = Foundation.Enums
local IconButton = Foundation.IconButton
local StateLayerAffordance = Enums.StateLayerAffordance
local Image = Foundation.Image
local FoundationText = Foundation.Text
local View = Foundation.View

local LoadableVideo = require(scriptParentParent.Components.LoadableVideo)
local ProgressBar = require(scriptParentParent.Components.ProgressBar)

local function getCurrent(videoRef) -- Luacid: Inlined by compiler; 7 call sites recovered
    return if typeof(videoRef) == "table" and videoRef.current ~= nil then videoRef.current else nil
end

local function MediaPlayer(tbl1)
    local timePosition, var2 = React.useState(0)
    local timeLength, var4 = React.useState(0)
    local var5, var6 = React.useState(false)
    local isMuted, var8 = React.useState(false)
    local var9, var10 = React.useState(false)
    local var11, var12 = React.useState(true)

    React.useEffect(function()
        local current = getCurrent(tbl1.videoRef)
        if not current then
            return
        end

        local connection = current.Played:Connect(function()
            var6(false)
        end)

        local connection2 = current.Ended:Connect(function()
            var6(true)
        end)

        local connection3 = RunService.RenderStepped:Connect(function()
            var2(current.TimePosition)
        end)

        return function()
            connection3:Disconnect()
            connection:Disconnect()
            connection2:Disconnect()
        end
    end, { tbl1.videoRef, var11, var5 })

    local onLoaded = React.useCallback(function(arg1)
        local current = getCurrent(tbl1.videoRef)
        if not current then
            return
        end

        var4(current.TimeLength)
        tbl1.onLoaded(arg1)
    end, { tbl1.onLoaded, tbl1.videoRef })

    local onActivated = React.useCallback(function()
        var12(not var11)
    end, { var11 })

    local onPlayButtonActivated = React.useCallback(function()
        local current = getCurrent(tbl1.videoRef)
        if not current then
            return
        end

        if not var5 then
            current:Pause()
            var6(true)
            return
        end
        if math.abs(timePosition - timeLength) <= 0.1 then
            current.TimePosition = 0
        end
        current:Play()
        var6(false)
    end, {
        var5,
        tbl1.videoRef,
        timePosition,
        timeLength
    })
    local var1 = React.useCallback(function()
        if tbl1.onExpandCallback then
            tbl1.onExpandCallback()
        end

        var10(not var9)
    end, { var9, tbl1.onExpandCallback })

    local onProgressBarActivated = React.useCallback(function(arg1)
        local current = getCurrent(tbl1.videoRef)
        if not current then
            return
        end

        current.TimePosition = current.TimeLength * arg1
    end, { tbl1.videoRef })

    local onMuteButtonActivated = React.useCallback(function()
        if tbl1.onMuteCallback then
            tbl1.onMuteCallback()
        end

        local current = getCurrent(tbl1.videoRef)
        if not current then
            return
        end

        current.Volume = if isMuted then 1 else 0
        var8(not isMuted)
    end, { isMuted, tbl1.onMuteCallback, tbl1.videoRef })

    local bool1 = not tbl1.Playing

    if bool1 then
        if tbl1.thumbnailImage == nil then
            bool1 = false
        else
            bool1 = tbl1.thumbnailImage ~= ""
        end
    end

    local var19 = (tbl1.Video or tbl1.VideoContent) and (tbl1.Playing ~= nil and tbl1.Playing or not tbl1.thumbnailImage)

    local createElement = React.createElement
    local var20 = View
    local tbl2 = {
        tag = "shrink size-full",
        onActivated = onActivated,
        stateLayer = {
            affordance = StateLayerAffordance.None
        },
        ZIndex = tbl1.ZIndex
    }
    local tbl3 = {
        HeaderBarContainer = 0,
        VideoPreview = 0,
        ProgressBarContainer = 0,
        ShadowBlock = 0,
        ThumbnailImage = 0
    }
    local element

    if getCurrent(tbl1.videoRef) == nil or not tbl1.onExpandCallback or tbl1.isZooming or var11 or tbl1.isOverlayDisabled then
        element = nil
    else
        element = React.createElement(
            View,
            {
                tag = "anchor-top-center position-top-center size-full-0 auto-y padding-medium row align-x-right",
                ZIndex = 3
            },
            {
                ExpandButton = React.createElement(IconButton, {
                    icon = if var9 then "icons/actions/previewShrink" else "icons/actions/previewExpand",
                    isDisabled = false,
                    LayoutOrder = 1,
                    onActivated = var1,
                    size = ButtonSize.Medium
                })
            }
        )
    end

    tbl3.HeaderBarContainer = element
    local element2

    if var19 then
        element2 = React.createElement(LoadableVideo, {
            AnchorPoint = tbl1.AnchorPoint,
            BackgroundTransparency = tbl1.BackgroundTransparency,
            cornerRadius = tbl1.cornerRadius,
            Looped = tbl1.Looped,
            onLoaded = onLoaded,
            Playing = tbl1.Playing,
            Position = tbl1.Position,
            renderOnFailed = tbl1.renderOnFailed,
            scaleType = tbl1.scaleType,
            Size = tbl1.Size,
            Video = tbl1.Video,
            VideoContent = tbl1.VideoContent,
            videoRef = tbl1.videoRef
        })
    else
        element2 = React.createElement(
            View,
            { tag = "align-x-center align-y-center auto-xy items-center gap-medium" },
            {
                Text = React.createElement(FoundationText, { Text = "No video to display", tag = "auto-xy" })
            }
        )
    end

    tbl3.VideoPreview = element2
    local element3

    if getCurrent(tbl1.videoRef) == nil or tbl1.isZooming or var11 or tbl1.isOverlayDisabled then
        element3 = nil
    else
        element3 = React.createElement(
            View,
            { tag = "anchor-bottom-center position-bottom-center size-full-0 auto-y", ZIndex = 3 },
            {
                ProgressBar = React.createElement(ProgressBar, {
                    isMuted = isMuted,
                    isPlaying = not var5,
                    isTimeHidden = tbl1.isTimeHidden,
                    onMuteButtonActivated = onMuteButtonActivated,
                    onPlayButtonActivated = onPlayButtonActivated,
                    onProgressBarActivated = onProgressBarActivated,
                    timePosition = timePosition,
                    timeLength = timeLength
                })
            }
        )
    end

    tbl3.ProgressBarContainer = element3

    tbl3.ShadowBlock = if var11 or tbl1.isOverlayDisabled then nil else React.createElement(View, {
        backgroundStyle = {
            Color3 = Color3.fromRGB(0, 0, 0),
            Transparency = 0.4
        },
        stateLayer = {
            affordance = Foundation.Enums.StateLayerAffordance.None
        },
        tag = "size-full-full",
        ZIndex = 2
    })
    local element4 = if bool1 then React.createElement(
        Image,
        {
            Image = tbl1.thumbnailImage,
            Size = UDim2.fromScale(1, 1),
            ZIndex = 2
        },
        {
            UICorner = if tbl1.cornerRadius then React.createElement("UICorner", { CornerRadius = UDim.new(0, tbl1.cornerRadius) }) else nil
        }
    ) else nil
    tbl3.ThumbnailImage = element4
    return createElement(var20, tbl2, tbl3)
end

return MediaPlayer
