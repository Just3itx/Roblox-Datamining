-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:01:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreation = script:FindFirstAncestor("MomentsCreation")
local MomentsCreationParent = MomentsCreation.Parent

local Foundation = require(MomentsCreationParent.Foundation)
local React = require(MomentsCreationParent.React)
local Signals = require(MomentsCreationParent.Signals)
local SignalsReact = require(MomentsCreationParent.SignalsReact)

local View = Foundation.View

local useEffect = React.useEffect
local useMemo = React.useMemo
local useState = React.useState
local useTokens = Foundation.Hooks.useTokens
local useSignalBinding = SignalsReact.useSignalBinding
local useSignalState = SignalsReact.useSignalState

local getCaptureVideoContent = require(MomentsCreation.Capture.getCaptureVideoContent)
local sampleVideoFrames = require(MomentsCreation.Capture.sampleVideoFrames)
local useTimelineSeekController = require(MomentsCreation.Hooks.useTimelineSeekController)
local FFlagMomentsTTSScrubberDragInOverlay = require(MomentsCreation.Flags.FFlagMomentsTTSScrubberDragInOverlay)
local FFlagMomentsScrubberSeekOnRelease = require(MomentsCreation.Flags.FFlagMomentsScrubberSeekOnRelease)

local _CreationFlowTypes = require(MomentsCreation.Types.CreationFlowTypes)

local function VideoTimeline(tbl1)
    local playback = tbl1.playback
    local var1 = useTokens()
    local height = tbl1.height or 50
    local interactive = not (tbl1.interactive == nil) and tbl1.interactive
    local var2 = useSignalState(playback.getDuration)
    local var3 = useSignalState(playback.getRegion)

    local var4 = useTimelineSeekController(playback, tbl1.onSeek, interactive, tbl1.dragOnly == true)
    local containerRef = var4.containerRef
    local dragDetectorRef = var4.dragDetectorRef
    local playheadDragDetectorRef = var4.playheadDragDetectorRef

    local var5, var6 = useState({})
    useEffect(function()
        if tbl1.capture == nil or var2 <= 0 then
            return
        end
        local captureVideoContent = getCaptureVideoContent(tbl1.capture)
        if captureVideoContent == nil and typeof(tbl1.capture) ~= "table" then
            local success, result = pcall(Content.fromObject, tbl1.capture)
            if success then
                captureVideoContent = result
            end
        end

        if captureVideoContent ~= nil then
            local var7 = if var3 == nil then 0 else var3.startTime
            sampleVideoFrames(captureVideoContent, var2, var6, var7)
        end
    end, { tbl1.capture, var2, var3 })

    local var7 = useMemo(function()
        local result = ({})
        local num1 = math.floor(var2)

        for layoutOrder = 1, math.max(1, num1) do
            local var7 = var5[layoutOrder]
            local str1 = "frame_" .. layoutOrder
            local createElement = React.createElement
            local var8 = View

            local tbl2 = {
                content = React.createElement("ImageLabel", {
                    BackgroundTransparency = 1,
                    Size = UDim2.fromScale(1, 1),
                    ImageContent = var7 and var7.Image,
                    ScaleType = Enum.ScaleType.Crop
                })
            }
            result[str1] = createElement(var8, { LayoutOrder = layoutOrder, tag = "shrink size-full-full bg-system-neutral" }, tbl2)
        end

        return result
    end, { var2, var5 })

    local var8 = useMemo(function()
        return Signals.createComputed(function(arg1)
            if FFlagMomentsScrubberSeekOnRelease and var4.getDragFraction ~= nil then
                local dragFraction = var4.getDragFraction(arg1)
                if dragFraction ~= nil then
                    return math.clamp(dragFraction, 0, 1)
                end
            end
            local duration = playback.getDuration(arg1)
            if duration <= 0 then
                return 0
            end
            return math.clamp(playback.getPosition(arg1) / duration, 0, 1)
        end)
    end, { playback, var4.getDragFraction })
    local var9 = useSignalBinding(var8)
    local var10

    if tbl1.playheadPosition ~= nil then
        local fromScale = UDim2.fromScale
        local var11 = if var2 > 0 then math.clamp(tbl1.playheadPosition / var2, 0, 1) else 0
        var10 = fromScale(var11, 0.5)
    else
        var10 = var9:map(function(xScale: number): UDim2
            return UDim2.fromScale(xScale, 0.5)
        end)
    end
    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {
        LayoutOrder = tbl1.layoutOrder,
        Size = UDim2.new(1, 0, 0, height),
        BackgroundTransparency = 1,
        ref = containerRef
    }
    local tbl3 = {
        DragDetector = if interactive then React.createElement("UIDragDetector", {
            DragStyle = Enum.UIDragDetectorDragStyle.TranslateLine,
            ResponseStyle = Enum.UIDragDetectorResponseStyle.CustomScale,
            ref = dragDetectorRef
        }) else nil,
        FilmStrip = React.createElement(
            "CanvasGroup",
            {
                BackgroundTransparency = 1,
                Size = UDim2.fromScale(1, 1),
                ZIndex = 1
            },
            {
                Corner = React.createElement("UICorner", { CornerRadius = UDim.new(0, var1.Radius.Medium) }),
                FrameLayout = React.createElement(View, {
                    layout = {
                        FillDirection = Enum.FillDirection.Horizontal,
                        Padding = UDim.new(0, var1.Size.Size_50),
                        SortOrder = Enum.SortOrder.LayoutOrder
                    },
                    tag = "size-full-full"
                }, var7)
            }
        ),
        Overlays = if tbl1.children then React.createElement(React.Fragment, nil, tbl1.children) else nil,
        Playhead = React.createElement(View, {
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = var10,
            Size = UDim2.new(0, 4, 1, 20),
            ZIndex = 3,
            cornerRadius = UDim.new(0, 2),
            backgroundStyle = var1.Color.System.Contrast
        }),
        PlayheadDragHandle = 0
    }
    local element

    if interactive and FFlagMomentsTTSScrubberDragInOverlay then
        element = React.createElement("Frame", {
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundTransparency = 1,
            Position = var10,
            Size = UDim2.new(0, 24, 1, 20),
            ZIndex = 3
        }, {
            DragDetector = React.createElement("UIDragDetector", {
                DragStyle = Enum.UIDragDetectorDragStyle.TranslateLine,
                ResponseStyle = Enum.UIDragDetectorResponseStyle.CustomScale,
                ref = playheadDragDetectorRef
            })
        })
    else
        element = nil
    end

    tbl3.PlayheadDragHandle = element
    return createElement(str1, tbl2, tbl3)
end

return VideoTimeline
