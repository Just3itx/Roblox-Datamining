-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T04:11:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VideoUtilsParent = script:FindFirstAncestor("VideoUtils").Parent

local React = require(VideoUtilsParent.React)

local BuilderIcons = require(VideoUtilsParent.BuilderIcons)
local Icon = BuilderIcons.Icon
local IconVariant = BuilderIcons.IconVariant

local maybeForceDarkTheme = require(VideoUtilsParent.CollectionViews).maybeForceDarkTheme

local Foundation = require(VideoUtilsParent.Foundation)
local IconButton = Foundation.IconButton
local IconSize = Foundation.Enums.IconSize
local useTokens = Foundation.Hooks.useTokens

local Responsive = require(VideoUtilsParent.Responsive)
local useBreakpointXOrSmaller = Responsive.useBreakpointXOrSmaller

local VideoProgressBar = require(script.Parent.VideoProgressBar)

local FFlagLuaAppEdpMediaGalleryFullScreen = require(VideoUtilsParent.SharedFlags).FFlagLuaAppEdpMediaGalleryFullScreen

local function VideoPlayerBottomOverlay(tbl1)
    local var1 = useTokens()

    local var2 = tbl1.muteButtonConfig ~= nil
        or FFlagLuaAppEdpMediaGalleryFullScreen and (tbl1.playButtonConfig ~= nil or tbl1.progressBarConfig ~= nil)

    local var3 = useBreakpointXOrSmaller(Responsive.Keys.Small)

    local xxLarge = var1.Padding.XXLarge
    local offset = if var3 then 0 else var1.Padding.Medium
    local medium = var1.Padding.Medium
    local size1000 = var1.Size.Size_1000
    local size100 = var1.Size.Size_100
    local xSmall = var1.Padding.XSmall
    local element

    if tbl1.muteButtonConfig then
        element = React.createElement(IconButton, {
            icon = {
                name = if tbl1.muteButtonConfig.muted then Icon.SpeakerSlash else Icon.Speaker,
                variant = IconVariant.Filled
            },
            iconSize = IconSize.Medium,
            onActivated = tbl1.muteButtonConfig.onMuteButtonActivated or nil,
            AnchorPoint = Vector2.new(1, 1),
            Position = UDim2.fromScale(1, 1),
            Selectable = false
        })
    else
        element = nil
    end

    local tbl2

    if FFlagLuaAppEdpMediaGalleryFullScreen then
        tbl2 = {
            Layout = React.createElement(
                "UIListLayout",
                {
                    FillDirection = Enum.FillDirection.Vertical,
                    Padding = UDim.new(0, xSmall),
                    SortOrder = Enum.SortOrder.LayoutOrder
                }
            ),
            Padding = React.createElement("UIPadding", {
                PaddingTop = UDim.new(0, xxLarge),
                PaddingBottom = UDim.new(0, offset),
                PaddingLeft = UDim.new(0, medium),
                PaddingRight = UDim.new(0, medium)
            }),
            ProgressBar = if tbl1.progressBarConfig then React.createElement(
                VideoProgressBar,
                {
                    progressBinding = tbl1.progressBarConfig.progressBinding,
                    Size = UDim2.new(1, 0, 0, size100),
                    LayoutOrder = 1
                }
            ) else nil,
            ButtonsContainer = 0
        }

        local createElement = React.createElement
        local str1 = "Frame"
        local tbl3 = {
            Size = UDim2.new(1, 0, 0, size1000),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            LayoutOrder = 2
        }

        local tbl4 = { PlayButton = 0, MuteButton = 0 }
        local element2

        if tbl1.playButtonConfig then
            element2 = React.createElement(IconButton, {
                icon = {
                    name = if tbl1.playButtonConfig.isVideoPlaying then Icon.PauseLarge else Icon.PlayLarge,
                    variant = IconVariant.Filled
                },
                iconSize = IconSize.Medium,
                onActivated = tbl1.playButtonConfig.onPlayButtonActivated,
                AnchorPoint = Vector2.new(0, 1),
                Position = UDim2.fromScale(0, 1),
                Selectable = false
            })
        else
            element2 = nil
        end

        tbl4.PlayButton = element2

        tbl4.MuteButton = if tbl1.muteButtonConfig then element else nil
        tbl2.ButtonsContainer = createElement(str1, tbl3, tbl4)
    else
        tbl2 = nil
    end

    local yOffset = React.useMemo(function()
        local var4 = xxLarge + offset

        if tbl1.muteButtonConfig or FFlagLuaAppEdpMediaGalleryFullScreen and tbl1.playButtonConfig then
            var4 += size1000
        end

        if FFlagLuaAppEdpMediaGalleryFullScreen and tbl1.progressBarConfig then
            var4 += size100 + xSmall
        end

        return var4
    end, {
        tbl1.muteButtonConfig,
        if FFlagLuaAppEdpMediaGalleryFullScreen then tbl1.playButtonConfig else nil,
        if FFlagLuaAppEdpMediaGalleryFullScreen then tbl1.progressBarConfig else nil,
        xxLarge,
        offset,
        size1000,
        size100,
        xSmall
    })

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl3 = {
        AnchorPoint = Vector2.new(0, 1),
        Position = UDim2.fromScale(0, 1),
        Size = UDim2.new(1, 0, 0, yOffset),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ZIndex = tbl1.ZIndex
    }
    local tbl4 = {
        GradientOverlay = React.createElement("Frame", {
            Size = UDim2.fromScale(1, 1),
            BackgroundColor3 = var1.Color.Extended.Black.Black_100.Color3,
            BorderSizePixel = 0,
            ZIndex = 1
        }, {
            Gradient = React.createElement("UIGradient", {
                Rotation = 90,
                Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 0.2) })
            }),
            UICorner = if tbl1.cornerRadius then React.createElement("UICorner", { CornerRadius = UDim.new(0, tbl1.cornerRadius) }) else nil
        }),
        UserControls = 0
    }
    local var4

    if tbl1.videoLoaded and var2 then
        local var5 = maybeForceDarkTheme
        local createElement2 = React.createElement
        local str2 = "Frame"
        local tbl5 = {
            Size = UDim2.fromScale(1, 1),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            ZIndex = 10
        }

        if not FFlagLuaAppEdpMediaGalleryFullScreen then
            tbl2 = {
                Padding = React.createElement("UIPadding", {
                    PaddingTop = UDim.new(0, xxLarge),
                    PaddingBottom = UDim.new(0, offset),
                    PaddingLeft = UDim.new(0, medium),
                    PaddingRight = UDim.new(0, medium)
                }),
                MuteButton = 0
            }

            if not tbl1.muteButtonConfig then
                element = nil
            end

            tbl2.MuteButton = element
        end

        var4 = var5(createElement2(str2, tbl5, tbl2), true)
    else
        var4 = nil
    end

    tbl4.UserControls = var4
    return createElement(str1, tbl3, tbl4)
end

return VideoPlayerBottomOverlay
