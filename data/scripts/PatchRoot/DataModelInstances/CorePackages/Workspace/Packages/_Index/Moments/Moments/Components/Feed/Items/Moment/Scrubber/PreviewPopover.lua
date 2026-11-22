-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:20:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local Foundation = require(MomentsParent.Foundation)
local React = require(MomentsParent.React)
local ReactUtils = require(MomentsParent.ReactUtils)
local SignalsReact = require(MomentsParent.SignalsReact)
local MomentsCommon = require(MomentsParent.MomentsCommon)

local previewPopoverMath = require(script.Parent.previewPopoverMath)
local _useMomentProgress = require(script.Parent.Parent.Hooks.useMomentProgress)
local useVideoScrubPreview = require(script.Parent.useVideoScrubPreview)
local MomentContext = require(script.Parent.Parent.MomentContext)
local TimeLabel = require(script.Parent.TimeLabel)
local VideoPreview = require(script.Parent.VideoPreview)

local View = Foundation.View
local useTokens = Foundation.Hooks.useTokens
local useScreenSize = MomentsCommon.Hooks.useScreenSize
local useDeviceInsets = MomentsCommon.Hooks.useDeviceInsets
local useSignalState = SignalsReact.useSignalState

local SCRUB_FADE_SECONDS = MomentContext.SCRUB_FADE_SECONDS

return React.memo(function(tbl1) -- name: PreviewPopover
    local var1 = useTokens()
    local var2 = MomentContext.useMoment()
    local var3 = useScreenSize()
    local var4 = useDeviceInsets()
    local nextOrder = ReactUtils.createNextOrder()

    local controller = var2.controller
    local var5 = useSignalState(var2.store.getIsScrubbing)

    local var6 = React.useMemo(function()
        if controller ~= nil then
            return (controller.getVideoPreviewSource())
        end

        return nil
    end, { controller })
    local preview = useVideoScrubPreview(var6, var5, var2.store.getScrubPosition)

    local var8, var9 = React.useState(false)
    React.useEffect(function()
        if var5 then
            var9(true)
            return
        end

        local bool1 = false
        task.delay(SCRUB_FADE_SECONDS, function()
            if not bool1 then
                var9(false)
            end
        end)
        return function()
            bool1 = true
        end
    end, { var5 })

    local ref = React.useRef(nil)
    local var7 = React.useRef(nil)

    local var12, var13 = React.useBinding({ position = 0, width = 0 })

    local var14, var15 = React.useBinding(0)

    React.useEffect(function()
        local current = ref.current
        if current == nil then
            return
        end

        local function update() -- Luacid: Inlined by compiler; 1 call site recovered
            var13({ position = current.AbsolutePosition.X, width = current.AbsoluteSize.X })
        end

        update()
        local connection = current:GetPropertyChangedSignal("AbsolutePosition"):Connect(update)
        local connection2 = current:GetPropertyChangedSignal("AbsoluteSize"):Connect(update)
        return function()
            connection:Disconnect()
            connection2:Disconnect()
        end
    end, {})

    React.useEffect(function()
        local current = var7.current
        if current == nil then
            return
        end

        local function update() -- Luacid: Inlined by compiler; 1 call site recovered
            var15(current.AbsoluteSize.X)
        end

        update()
        local connection = current:GetPropertyChangedSignal("AbsoluteSize"):Connect(update)
        return function()
            connection:Disconnect()
        end
    end, { var8 })

    local size100 = var1.Size.Size_100

    local var16 = React.joinBindings({ tbl1.progressRatio, var12, var14 }):map(function(tbl2): UDim2
        local ratio = tbl2[1]
        local var17 = tbl2[2]
        local popoverWidth = tbl2[3]

        local centerOffsetX = previewPopoverMath.getCenterOffsetX({
            ratio = ratio,
            containerPosition = var17.position,
            containerWidth = var17.width,
            popoverWidth = popoverWidth,
            screenWidth = var3.X,
            insetLeft = var4.left,
            insetRight = var4.right,
            margin = size100
        })

        return UDim2.new(0, centerOffsetX, 0, -var1.Size.Size_600)
    end)

    local createElement = React.createElement
    local var17 = View
    local tbl2 = { tag = "size-full", ref = ref }
    local tbl3 = { MovingContainer = 0 }
    local element

    if var8 then
        element = React.createElement(
            View,
            {
                tag = "col align-x-center gap-medium anchor-bottom-center auto-xy",
                ref = var7,
                Position = var16
            },
            {
                VideoPreview = if controller == nil or not controller.getHasVideoPreview() then nil else React.createElement(
                    VideoPreview,
                    {
                        preview = preview,
                        animationRatio = var2.animationRatio,
                        LayoutOrder = nextOrder()
                    }
                ),
                TimeLabel = React.createElement(
                    TimeLabel,
                    {
                        progress = tbl1.progress,
                        animationRatio = var2.animationRatio,
                        LayoutOrder = nextOrder()
                    }
                )
            }
        )
    else
        element = nil
    end

    tbl3.MovingContainer = element
    return createElement(var17, tbl2, tbl3)
end)
