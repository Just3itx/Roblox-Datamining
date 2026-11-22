-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:21:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCommon = script:FindFirstAncestor("MomentsCommon")
local MomentsCommonParent = MomentsCommon.Parent

local React = require(MomentsCommonParent.React)
local Signals = require(MomentsCommonParent.Signals)
local SignalsReact = require(MomentsCommonParent.SignalsReact)
local Foundation = require(MomentsCommonParent.Foundation)

local _MediaTypes = require(MomentsCommon.Media.MediaTypes)
local MediaSurfaceContext = require(MomentsCommon.Media.Components.MediaSurfaceContext)
local useMomentMediaController = require(MomentsCommon.Media.Components.useMomentMediaController)
local useHasPresentedFrame = require(MomentsCommon.Media.useHasPresentedFrame)
local getSmartFillScaleType = require(MomentsCommon.Utils.getSmartFillScaleType)
local FFlagMomentsSmartVideoFill = require(MomentsCommon.Flags.FFlagMomentsSmartVideoFill)

local Skeleton = Foundation.Skeleton
local View = Foundation.View
local useSignalState = SignalsReact.useSignalState
local useSignalBinding = SignalsReact.useSignalBinding

local var1 = table.freeze({})

local function MomentMediaView(tbl1)
    local momentId = tbl1.momentId
    local var2 = useMomentMediaController(momentId)

    local var3 = React.useMemo(function()
        return (Signals.createSignal(Enum.ScaleType.Crop))
    end, {})

    local var4 = tbl1.getScaleType or var3
    local cornerRadius = React.useContext(MediaSurfaceContext).cornerRadius

    local var5 = React.useMemo(function()
        local get, set = Signals.createSignal(Vector2.zero)
        return { get = get, set = set }
    end, {})

    local onAbsoluteSizeChanged = React.useCallback(function(arg1)
        var5.set(arg1.AbsoluteSize)
    end, { var5 })

    if FFlagMomentsSmartVideoFill then
        local var7 = var4

        var4 = React.useMemo(function()
            return Signals.createComputed(function(arg1)
                local var8 = var7(arg1)
                if var2 == nil then
                    return var8
                end
                return getSmartFillScaleType(var8, var5.get(arg1), var2.getState(arg1).resolution)
            end)
        end, { var7, var2 or false, var5 })
    end
    local var7 = useSignalBinding(var4)

    local bool1 = tbl1.suppressTapToToggle == true
    local var8 = React.useCallback(function()
        if var2 ~= nil then
            var2.toggle()
        end
    end, { var2 })

    local var9 = React.useMemo(function()
        return Signals.createComputed(function(arg1)
            if var2 == nil then
                return "Idle"
            end

            return var2.getState(arg1).readiness
        end)
    end, { var2 })
    local var10 = useSignalState(var9)
    local bool2 = var10 == "Ready"
    local hasVideoPreview = not (var2 == nil) and var2.getHasVideoPreview()

    local var11 = React.useMemo(function()
        return Signals.createComputed(function(arg1): boolean
            return not hasVideoPreview or var9(arg1) == "Ready"
        end)
    end, { hasVideoPreview, var9 })
    local var12 = useSignalBinding(var11)

    local var13 = useHasPresentedFrame(var2, tbl1.holdPosterUntilPlaying)
    local bool3 = if tbl1.holdPosterUntilPlaying then not var13 else not bool2

    local var14 = React.useMemo(function()
        return Signals.createComputed(function(arg1)
            if var2 == nil then
                return var1
            end
            return var2.getVisualLayers(arg1)
        end)
    end, { var2 })
    local var15 = useSignalState(var14)

    local var16 = React.useMemo(function()
        local result = ({})
        if var2 ~= nil then
            for _, value in var15 do
                local id = value.id
                local tbl2 = {
                    getItemSize = var5.get,
                    getPlaybackPosition = var2.getPosition,
                    getResolution = 0,
                    setSurface = 0,
                    scaleType = 0,
                    getScaleType = 0,
                    cornerRadius = 0
                }

                function tbl2.getResolution(arg1)
                    return var2.getState(arg1).resolution
                end
                function tbl2.setSurface(arg1)
                    var2.setSurface(id, arg1)
                end
                tbl2.scaleType = var7
                tbl2.getScaleType = var4
                tbl2.cornerRadius = cornerRadius

                local str1 = `layer_{id}`
                result[str1] = React.createElement(
                    View,
                    {
                        tag = "size-full",
                        Visible = if string.sub(id, 1, 5) == "text:" then var12 else nil,
                        ZIndex = value.zIndex + 2
                    },
                    {
                        Surface = value.render(tbl2)
                    }
                )
            end
        end

        return result
    end, {
        var2,
        var15,
        var5,
        var7,
        var4,
        cornerRadius or false,
        var12
    })

    local bool4 = tbl1.showLoadingSkeleton == true and var10 ~= "Ready"
    local var17 = table.clone(var16)
    if bool4 then
        var17.LoadingSkeleton = React.createElement(
            View,
            { tag = "size-full", ZIndex = 100 },
            {
                Shimmer = React.createElement(Skeleton, { Size = UDim2.fromScale(1, 1) })
            }
        )
    elseif tbl1.posterContent ~= nil then
        var17.Poster = React.createElement("ImageLabel", {
            BackgroundTransparency = 1,
            Size = UDim2.fromScale(1, 1),
            ScaleType = var7,
            ImageContent = tbl1.posterContent,
            Visible = bool3,
            ZIndex = 100
        }, {
            Corner = if tbl1.cornerRadius ~= nil then React.createElement("UICorner", { CornerRadius = UDim.new(0, tbl1.cornerRadius) }) elseif cornerRadius == nil then nil else React.createElement("UICorner", { CornerRadius = cornerRadius })
        })
    end

    local bool5 = not (var2 == nil) and not bool1
    local createElement = React.createElement
    local var18 = View
    local tbl2 = {
        tag = tbl1.tag or "size-full clip",
        LayoutOrder = tbl1.LayoutOrder,
        onActivated = 0,
        stateLayer = 0,
        onAbsoluteSizeChanged = 0
    }

    if not bool5 then
        var8 = nil
    end

    tbl2.onActivated = var8

    tbl2.stateLayer = bool5 and {
        affordance = Foundation.Enums.StateLayerAffordance.None
    } or nil
    tbl2.onAbsoluteSizeChanged = onAbsoluteSizeChanged
    return createElement(var18, tbl2, var17)
end

return MomentMediaView
