-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T06:01:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local Foundation = require(scriptParentParentParent.Foundation)
local React = require(scriptParentParentParent.React)

local ButtonSize = Foundation.Enums.ButtonSize
local IconButton = Foundation.IconButton
local FoundationText = Foundation.Text
local View = Foundation.View

local function formatTime(num1: number): string -- Luacid: Inlined by compiler; 2 call sites recovered
    local num2 = math.floor(num1 / 60)
    local num3 = math.floor(num1 % 60)
    return string.format("%02d:%02d", num2, num3)
end

local function ProgressBar(tbl1)
    local xScale = tbl1.timePosition / tbl1.timeLength
    local str1 = formatTime(tbl1.timePosition)
    local str2 = formatTime(tbl1.timeLength)
    local ref = React.useRef(nil)
    local var2, var3 = React.useState(0)

    React.useEffect(function()
        if not ref or not ref.current then
            return
        end

        local connection = ref.current.InputBegan:Connect(function(input: InputObject)
            var3(input.Position.X)
        end)

        return function()
            connection:Disconnect()
        end
    end, {})

    local onActivated = React.useCallback(function()
        if not (ref and ref.current) then
            return
        end

        local absolutePositionX = ref.current.AbsolutePosition.X
        local absoluteSizeX = ref.current.AbsoluteSize.X

        tbl1.onProgressBarActivated((var2 - absolutePositionX) / absoluteSizeX)
    end, { var2, tbl1.onProgressBarActivated })

    local createElement = React.createElement
    local var5 = View
    local tbl2 = {
        tag = {
            ["align-x-center align-y-center col size-full-1400"] = true,
            ["padding-medium"] = tbl1.isFullScreen,
            ["padding-x-medium"] = not tbl1.isFullScreen
        }
    }
    local tbl3 = {
        ProgressBarContainer = React.createElement(
            View,
            {
                LayoutOrder = 1,
                onActivated = onActivated,
                ref = ref,
                tag = "radius-small bg-over-media-0 size-full-200"
            },
            {
                Progress = React.createElement(View, { Size = UDim2.fromScale(xScale, 1), tag = "radius-small bg-system-neutral" })
            }
        ),
        CTAContainer = React.createElement(
            View,
            {
                LayoutOrder = 2,
                isDisabled = true,
                tag = "row flex-between align-x-center align-y-center size-full-1000"
            },
            {
                PlayButton = React.createElement(IconButton, {
                    icon = if tbl1.isPlaying then "icons/controls/media-pause-medium" else "icons/controls/media-play-medium",
                    isDisabled = false,
                    LayoutOrder = 1,
                    onActivated = tbl1.onPlayButtonActivated,
                    size = ButtonSize.Medium
                }),
                TimeText = if tbl1.isTimeHidden then nil else React.createElement(
                    FoundationText,
                    {
                        LayoutOrder = 2,
                        Text = string.format("%s / %s", str1, str2),
                        tag = "auto-xy text-body-large"
                    }
                ),
                MuteButton = React.createElement(IconButton, {
                    icon = if tbl1.isMuted then "icons/controls/speakerMute" else "icons/controls/speaker",
                    isDisabled = false,
                    LayoutOrder = 3,
                    onActivated = tbl1.onMuteButtonActivated,
                    size = ButtonSize.Medium
                })
            }
        )
    }
    return createElement(var5, tbl2, tbl3)
end

return ProgressBar
