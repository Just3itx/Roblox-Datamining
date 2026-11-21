-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T10:01:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DictationCoreParent = script:FindFirstAncestor("DictationCore").Parent

local React = require(DictationCoreParent.React)

local WaveformAudio = require(script.Parent.WaveformAudio)
local useTickClock = require(script.Parent.useTickClock).useTickClock

local BAR_WIDTH = WaveformAudio.BAR_WIDTH
local ITEM_WIDTH = WaveformAudio.ITEM_WIDTH
local RENDER_INTERVAL = WaveformAudio.RENDER_INTERVAL

local tbl1 = { itemIdx = 0, height = 0.2, age = nil }

return React.memo(function(tbl2) -- name: Waveform
    local var1 = tbl2.normalize == nil or tbl2.normalize
    local bindBarStyle = tbl2.bindBarStyle
    local onSample = tbl2.onSample

    local var2, var3 = React.useState(0)
    local var4 = if tbl2.isActive and var2 > 0 then math.ceil(var2 / ITEM_WIDTH) + 1 else 0
    local var5, var6 = React.useBinding(0)
    local var7, var8 = React.useBinding(0)

    local var9 = WaveformAudio.useAudioAnalyzer(tbl2.audioDeviceInput)
    local var10 = React.useRef(0)
    local var11 = React.useRef({})

    React.useEffect(function()
        table.clear(var11.current)
        var10.current = 0
        var6(0)
        var8(0)
    end, {
        tbl2.isActive,
        var4,
        var6,
        var8
    })
    useTickClock({
        intervalSec = RENDER_INTERVAL,
        enabled = tbl2.isActive and var4 > 0,
        onTick = function()
            local var12 = var5:getValue() + 1
            local height = 0.2 + WaveformAudio.sampleVolume(var9.current, var10, var1) * 0.8

            local current = var11.current
            current[var12] = { height = height }
            current[var12 - var4] = nil

            var6(var12)

            if onSample then
                onSample(var12, height)
            end
        end,
        onFrame = function(arg1)
            var8(arg1)
        end
    })

    local var12 = React.useMemo(function()
        local result = ({})
        local current = var11.current
        for i = 1, var4 do
            local age = var4 - i
            local var12 = (i - 1) * ITEM_WIDTH

            local var13 = var5:map(function(num2: number)
                local itemIdx = num2 - age
                if itemIdx <= 0 then
                    return tbl1
                end
                local var13 = current[itemIdx]
                return if var13 == nil then tbl1 else {
                    itemIdx = itemIdx,
                    height = var13.height,
                    age = age
                }
            end)

            local var14 = bindBarStyle(var13)

            local str1 = "Bar" .. i
            local createElement = React.createElement

            local tbl3 = {
                Position = var7:map(function(num2: number): UDim2
                    return UDim2.new(0, var12 - num2 * ITEM_WIDTH, 0.5, 0)
                end),
                AnchorPoint = Vector2.new(0, 0.5),
                Size = var13:map(function(tbl3): UDim2
                    return UDim2.new(0, BAR_WIDTH, tbl3.height, 0)
                end),
                BackgroundColor3 = var14:map(function(tbl3)
                    return tbl3.color
                end),
                BackgroundTransparency = var14:map(function(tbl3)
                    return tbl3.transparency
                end),
                BorderSizePixel = 0
            }

            local tbl4 = {
                Corner = React.createElement("UICorner", { CornerRadius = UDim.new(1, 0) })
            }
            result[str1] = createElement("Frame", tbl3, tbl4)
        end

        return result
    end, {
        var4,
        var5,
        var7,
        bindBarStyle
    })
    local createElement = React.createElement
    local tbl3 = {
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ClipsDescendants = true
    }

    tbl3[React.Change.AbsoluteSize] = function(arg1)
        local absoluteSizeX = arg1.AbsoluteSize.X

        var3(absoluteSizeX)
    end

    return createElement("Frame", tbl3, var12)
end)
