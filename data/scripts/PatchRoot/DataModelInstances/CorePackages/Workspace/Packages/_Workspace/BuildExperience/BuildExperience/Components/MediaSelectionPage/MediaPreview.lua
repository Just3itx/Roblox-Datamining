-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:01:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RunService = game:GetService("RunService")

local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local React = require(BuildExperienceParent.React)
local Foundation = require(BuildExperienceParent.Foundation)

local Image = Foundation.Image
local Skeleton = Foundation.Skeleton
local View = Foundation.View
local Icon = Foundation.Icon
local IconButton = Foundation.IconButton
local Progress = Foundation.Progress

local IconName = Foundation.Enums.IconName
local IconSize = Foundation.Enums.IconSize
local InputSize = Foundation.Enums.InputSize
local ProgressShape = Foundation.Enums.ProgressShape
local ProgressSize = Foundation.Enums.ProgressSize

local useTokens = Foundation.Hooks.useTokens

local _types = require(script.Parent.types)

local function MediaPreview(tbl1)
    local var1 = useTokens()
    local playing, var3 = React.useState(true)
    local ref = React.useRef(nil)
    local value, var6 = React.useBinding(0)

    local aspectRatio = if tbl1.isIcon then 1 else 16 / 9

    local onActivated = React.useCallback(function()
        var3(not playing)
    end, { playing })

    React.useEffect(function()
        if tbl1.mediaType ~= "video" then
            return nil
        end

        if not ref.current then
            return nil
        end

        local connection = RunService.RenderStepped:Connect(function()
            local current = ref.current
            if current and current.TimeLength > 0 then
                var6(100 * current.TimePosition / current.TimeLength)
            end
        end)

        return function()
            connection:Disconnect()
        end
    end, { tbl1.mediaType })

    if tbl1.isLoading then
        return React.createElement(View, {
            Size = UDim2.fromScale(1, 1),
            LayoutOrder = tbl1.LayoutOrder,
            aspectRatio = {
                AspectRatio = aspectRatio,
                AspectType = Enum.AspectType.FitWithinMaxSize,
                DominantAxis = Enum.DominantAxis.Width
            }
        }, {
            LoadingSkeleton = React.createElement(Skeleton, { radius = Foundation.Enums.Radius.Medium, Size = UDim2.fromScale(1, 1) })
        })
    end

    if not (tbl1.assetSource or tbl1.imageContent) then
        return React.createElement(View, {
            tag = "align-x-center align-y-center radius-large clip bg-surface-200",
            Size = UDim2.fromScale(1, 1),
            LayoutOrder = tbl1.LayoutOrder,
            aspectRatio = {
                AspectRatio = aspectRatio,
                AspectType = Enum.AspectType.FitWithinMaxSize,
                DominantAxis = Enum.DominantAxis.Width
            }
        }, {
            PlaceholderIcon = React.createElement(Icon, { name = IconName.Image, size = IconSize.XLarge, tag = "auto-xy content-default" })
        })
    end

    if tbl1.mediaType ~= "video" then
        local createElement = React.createElement
        local var8 = View
        local tbl2 = {
            tag = "align-x-center align-y-center radius-large clip bg-surface-200",
            Size = UDim2.fromScale(1, 1),
            LayoutOrder = tbl1.LayoutOrder,
            aspectRatio = {
                AspectRatio = aspectRatio,
                AspectType = Enum.AspectType.FitWithinMaxSize,
                DominantAxis = Enum.DominantAxis.Width
            }
        }
        local tbl3 = { PreviewImage = 0 }
        local element

        if tbl1.imageContent then
            element = React.createElement(
                "ImageLabel",
                {
                    BackgroundTransparency = 1,
                    ImageContent = tbl1.imageContent,
                    ScaleType = Enum.ScaleType.Crop,
                    Size = UDim2.fromScale(1, 1)
                },
                {
                    UICorner = React.createElement("UICorner", { CornerRadius = UDim.new(0, 12) })
                }
            )
        else
            element = React.createElement(
                Image,
                {
                    Image = tbl1.assetSource,
                    tag = "size-full radius-large",
                    ScaleType = Enum.ScaleType.Crop
                }
            )
        end

        tbl3.PreviewImage = element
        return createElement(var8, tbl2, tbl3)
    end

    local createElement = React.createElement
    local var8 = View
    local tbl2 = {
        Size = UDim2.fromScale(1, 1),
        aspectRatio = {
            AspectRatio = aspectRatio,
            AspectType = Enum.AspectType.FitWithinMaxSize,
            DominantAxis = Enum.DominantAxis.Width
        },
        LayoutOrder = tbl1.LayoutOrder
    }
    local tbl3 = { Video = 0, ProgressBar = 0 }
    local createElement2 = React.createElement
    local str1 = "VideoFrame"
    local tbl4 = {
        Size = UDim2.fromScale(1, 1),
        Video = tbl1.assetSource,
        VideoContent = tbl1.imageContent,
        Playing = playing,
        Looped = true,
        Volume = 0,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ref = ref
    }
    local tbl5 = {
        UICorner = React.createElement("UICorner", { CornerRadius = UDim.new(0, 12) }),
        PlayPauseButton = React.createElement(IconButton, {
            Position = UDim2.new(0, 0, 1, -var1.Gap.XSmall),
            AnchorPoint = Vector2.new(0, 1),
            icon = if playing then IconName.PauseSmall else IconName.PlaySmall,
            size = InputSize.Small,
            onActivated = onActivated
        })
    }
    tbl3.Video = createElement2(str1, tbl4, tbl5)

    tbl3.ProgressBar = React.createElement(
        Progress,
        {
            Position = UDim2.new(0, 0, 1, var1.Gap.Medium),
            value = value,
            shape = ProgressShape.Bar,
            size = ProgressSize.Medium
        }
    )
    return createElement(var8, tbl2, tbl3)
end

return MediaPreview
