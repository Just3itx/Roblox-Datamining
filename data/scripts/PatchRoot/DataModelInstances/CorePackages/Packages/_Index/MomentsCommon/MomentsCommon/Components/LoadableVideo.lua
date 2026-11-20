-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T10:01:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCommon = script:FindFirstAncestor("MomentsCommon")
local MomentsCommonParent = MomentsCommon.Parent

local ContentProvider = game:GetService("ContentProvider")

local Foundation = require(MomentsCommonParent.Foundation)
local React = require(MomentsCommonParent.React)

local Skeleton = Foundation.Skeleton
local View = Foundation.View

local LoadingState = require(MomentsCommon.Enums.LoadingState)
local getCropSize = require(MomentsCommon.Utils.getCropSize)
local getFitSize = require(MomentsCommon.Utils.getFitSize)

return function(tbl1)
    local var1, var2 = React.useState(Vector2.new(0, 0))
    local var3, var4 = React.useState(LoadingState.Loading)
    local var5, var6 = React.useState(Vector2.new(0, 0))

    React.useEffect(function()
        if tbl1.Video == nil or tbl1.Video == "" then
            return
        end

        local connection = ContentProvider:GetAssetFetchStatusChangedSignal(tbl1.Video):Connect(function(assetFetchStatus)
            if assetFetchStatus == Enum.AssetFetchStatus.Failure then
                var4(LoadingState.Failed)
            end
        end)

        return function()
            connection:Disconnect()
            var4(LoadingState.Loading)
        end
    end, { tbl1.Video })

    local onAbsoluteSizeChanged = React.useCallback(function(arg1)
        var2(arg1.AbsoluteSize)

        if tbl1.onAbsoluteSizeChanged then
            tbl1.onAbsoluteSizeChanged(arg1)
        end
    end, { tbl1.onAbsoluteSizeChanged, var2 })

    local var8 = React.useCallback(function(arg1)
        local resolution = arg1.Resolution
        var6(resolution)

        if tbl1.onResolutionChanged then
            tbl1.onResolutionChanged(resolution)
        end
    end, { tbl1.onResolutionChanged, var6 })

    local var9 = React.useCallback(function(arg1)
        if var3 == LoadingState.Loading then
            var4(LoadingState.Finished)
        end

        tbl1.onLoaded(arg1)
    end, { var3, tbl1.onLoaded })

    if var3 == LoadingState.Failed then
        return tbl1.renderOnFailed()
    end

    local createElement = React.createElement
    local var10 = View
    local tbl2 = {
        AnchorPoint = tbl1.AnchorPoint,
        BackgroundTransparency = tbl1.BackgroundTransparency,
        ClipsDescendants = tbl1.ClipsDescendants ~= false,
        isDisabled = true,
        onAbsoluteSizeChanged = onAbsoluteSizeChanged,
        Position = tbl1.Position,
        Size = tbl1.Size,
        ZIndex = tbl1.ZIndex
    }
    local tbl3 = {
        VideoFrame = React.createElement("VideoFrame", {
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundTransparency = 1,
            Looped = tbl1.Looped == nil or tbl1.Looped,
            Playing = tbl1.Playing,
            Position = UDim2.fromScale(0.5, 0.5),
            ref = tbl1.videoRef,
            Size = if tbl1.scaleType == Enum.ScaleType.Fit then getFitSize(var1, var5) else getCropSize(var1, var5),
            Video = tbl1.Video,
            VideoContent = tbl1.VideoContent,
            Visible = var5.X > 0 and var5.Y > 0,
            [React.Change.Resolution] = var8,
            [React.Event.Loaded] = var9
        }, {
            Corner = if tbl1.cornerRadius then React.createElement("UICorner", { CornerRadius = UDim.new(0, tbl1.cornerRadius) }) else nil
        }),
        Shimmer = if var3 == LoadingState.Finished then nil else React.createElement(Skeleton, { Size = UDim2.fromScale(1, 1), ZIndex = 2 })
    }
    return createElement(var10, tbl2, tbl3)
end
