-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:50:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)

local Icon = Foundation.Icon
local IconButton = Foundation.IconButton
local Image = Foundation.Image
local Slider = Foundation.Slider
local FoundationText = Foundation.Text
local View = Foundation.View

local ButtonVariant = Foundation.Enums.ButtonVariant
local IconName = Foundation.Enums.IconName
local IconSize = Foundation.Enums.IconSize
local InputSize = Foundation.Enums.InputSize

local function formatTime(num1: number): string
    local num2 = math.max(0, math.floor(num1))
    local num3 = num2 / 60
    return `{math.floor(num3)}:{string.format("%02d", num2 % 60)}`
end

local function formatRemaining(num1: number): string -- Luacid: Inlined by compiler; 1 call site recovered
    local num2 = math.ceil(num1 - 0.001)
    if num2 <= 0 then
        return `{0}:{string.format("%02d", 0)}`
    end

    local num3 = math.max(0, math.floor(num2))
    local num4 = num3 / 60
    return `-{`{math.floor(num4)}:{string.format("%02d", num3 % 60)}`}`
end

local function LibraryAudioPlayerContentView(tbl1)
    local var1 = Foundation.Hooks.useTokens()
    local var2 = Foundation.Hooks.useScaledValue(168)
    local fill = tbl1.isCompact == true
    local value = tbl1.elapsed:map(function(num1: number): number
        if tbl1.duration <= 0 then
            return 0
        end
        return math.clamp(num1 / tbl1.duration, 0, 1)
    end)

    local createElement = React.createElement
    local var4 = View
    local tbl2 = {
        LayoutOrder = tbl1.LayoutOrder,
        tag = {
            ["col align-x-center size-full-0 auto-y"] = true,
            ["gap-small"] = fill,
            ["gap-xxlarge"] = not fill
        },
        testId = "Library.AudioPlayer"
    }

    local tbl3 = { Song = 0, Controls = 0 }
    local createElement2 = React.createElement
    local var5 = View
    local tbl4 = {
        LayoutOrder = 1,
        tag = {
            ["gap-medium"] = true,
            ["row align-y-center size-full-0 auto-y"] = fill,
            ["col align-x-center auto-xy"] = not fill
        }
    }
    local tbl5 = { Artwork = 0, Info = 0 }
    local createElement3 = React.createElement
    local var6 = View
    local tbl6 = {
        LayoutOrder = 1,
        Size = if fill then UDim2.fromOffset(var1.Size.Size_1600, var1.Size.Size_1600) else UDim2.fromOffset(var2, var2),
        testId = "Library.AudioPlayer.Artwork",
        tag = "align-x-center align-y-center radius-large clip bg-shift-200"
    }

    local tbl7 = { Media = 0 }
    local element

    if tbl1.thumbnail ~= nil and tbl1.thumbnail ~= "" then
        element = React.createElement(Image, { Image = tbl1.thumbnail, ScaleType = Enum.ScaleType.Fit, tag = "size-full" })
    else
        element = React.createElement(Icon, { name = IconName.MusicNote, size = IconSize.XLarge, style = var1.Color.Content.Emphasis })
    end

    tbl7.Media = element
    tbl5.Artwork = createElement3(var6, tbl6, tbl7)

    tbl5.Info = React.createElement(
        View,
        {
            LayoutOrder = 2,
            tag = {
                ["col auto-y"] = true,
                fill = fill,
                ["align-x-center size-full-0"] = not fill
            }
        },
        {
            Title = React.createElement(FoundationText, {
                LayoutOrder = 1,
                Text = tbl1.title,
                tag = {
                    ["size-full-0 auto-y text-heading-small content-emphasis"] = true,
                    ["text-align-x-left text-truncate-end"] = fill,
                    ["text-wrap text-align-x-center"] = not fill
                }
            }),
            Artist = React.createElement(FoundationText, {
                LayoutOrder = 2,
                Text = tbl1.artist,
                tag = {
                    ["size-full-0 auto-y text-body-large text-truncate-end content-default"] = true,
                    ["text-align-x-left"] = fill,
                    ["text-align-x-center"] = not fill
                }
            })
        }
    )
    tbl3.Song = createElement2(var5, tbl4, tbl5)

    local createElement4 = React.createElement
    local var7 = View
    local tbl8 = {
        LayoutOrder = 2,
        tag = {
            ["col align-x-center size-full-0 auto-y"] = true,
            ["gap-small"] = fill,
            ["gap-medium"] = not fill
        }
    }

    local tbl9 = {
        Timeline = React.createElement(
            View,
            {
                LayoutOrder = 1,
                tag = "col gap-xsmall size-full-0 auto-y",
                testId = "Library.AudioPlayer.Timeline"
            },
            {
                Slider = React.createElement(Slider, {
                    LayoutOrder = 1,
                    value = value,
                    onValueChanged = tbl1.onSeek,
                    onDragStarted = tbl1.onSeekStarted,
                    onDragEnded = tbl1.onSeekEnded,
                    isDisabled = tbl1.onSeek == nil or tbl1.duration <= 0,
                    size = InputSize.XSmall,
                    knobVisibility = Foundation.Enums.Visibility.Always,
                    variant = Foundation.Enums.SliderVariant.Emphasis,
                    testId = "Library.AudioPlayer.Timeline.Slider"
                }),
                Times = React.createElement(View, {
                    LayoutOrder = 2,
                    tag = "row size-full-0 auto-y"
                }, {
                    Elapsed = React.createElement(FoundationText, {
                        LayoutOrder = 1,
                        Text = tbl1.elapsed:map(formatTime),
                        tag = "fill auto-y text-caption-large text-align-x-left content-default"
                    }),
                    Remaining = React.createElement(FoundationText, {
                        LayoutOrder = 2,
                        Text = tbl1.elapsed:map(function(num1: number): string
                            return formatRemaining(tbl1.duration - num1)
                        end),
                        tag = "auto-xy text-caption-large content-default"
                    })
                })
            }
        ),
        PlayerControls = 0
    }

    local createElement5 = React.createElement
    local var8 = View
    local tbl10 = { LayoutOrder = 2, tag = "row align-x-center align-y-center auto-xy" }

    local tbl11 = {
        Playback = React.createElement(IconButton, {
            LayoutOrder = 1,
            icon = if tbl1.isPlaying then IconName.PauseLarge else IconName.PlayLarge,
            isCircular = true,
            onActivated = tbl1.onTogglePlayback,
            size = InputSize.Large,
            testId = "Library.AudioPlayer.Playback",
            variant = ButtonVariant.Emphasis
        })
    }
    tbl9.PlayerControls = createElement5(var8, tbl10, tbl11)
    tbl3.Controls = createElement4(var7, tbl8, tbl9)
    return createElement(var4, tbl2, tbl3)
end

return LibraryAudioPlayerContentView
