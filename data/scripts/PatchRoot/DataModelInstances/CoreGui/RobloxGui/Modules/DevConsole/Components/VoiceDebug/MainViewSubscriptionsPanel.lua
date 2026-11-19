-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:51:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Roact = require(CorePackages.Packages.Roact)

local Components = script.Parent.Parent.Parent.Components
local CellLabel = require(Components.CellLabel)

local Constants = require(script.Parent.Parent.Parent.Constants)

local CollapsibleSection = require(script.Parent.CollapsibleSection)

local _VoiceDebugData = require(script.Parent.VoiceDebugData)

local uDim = UDim.new(0.13, 0)
local uDim2 = UDim.new(0.11, 0)
local uDim3 = UDim.new(0.11, 0)
local uDim4 = UDim.new(0.12, 0)
local uDim5 = UDim.new(0.11, 0)
local uDim6 = UDim.new(0.14, 0)
local uDim7 = UDim.new(0.1, 0)
local uDim8 = UDim.new(0.09, 0)
local uDim9 = UDim.new(0.09, 0)

local x = uDim + uDim2
local x2 = x + uDim3
local x3 = x2 + uDim4
local x4 = x3 + uDim5
local x5 = x4 + uDim6
local x6 = x5 + uDim7
local x7 = x6 + uDim8

local TextBoxGray = Constants.Color.TextBoxGray

local function formatHexSsrc(audioSsrc: number?): string -- Luacid: Inlined by compiler; 1 call site recovered
    if type(audioSsrc) ~= "number" or audioSsrc ~= audioSsrc or audioSsrc % 1 ~= 0 then
        return "—"
    end
    return string.format("0x%08X", audioSsrc)
end

local function formatOrDash(arg1): string -- Luacid: Inlined by compiler; 5 call sites recovered
    if arg1 == nil or arg1 == "" then
        return "—"
    end
    return tostring(arg1)
end

local function formatBool(bool1: boolean?): string -- Luacid: Inlined by compiler; 3 call sites recovered
    return if type(bool1) == "boolean" then if bool1 then "Yes" else "No" else "—"
end

local function formatBitrate(arg1): string -- Luacid: Inlined by compiler; 1 call site recovered
    if arg1.culled == true then
        return "—"
    end
    local incomingBitrateKbps = arg1.incomingBitrateKbps
    if type(incomingBitrateKbps) ~= "number" then
        return "—"
    end
    return string.format("%.2f kbps", incomingBitrateKbps)
end

local function formatCodec(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    if arg1.culled == true then
        return "—"
    end
    return formatOrDash(arg1.codecName)
end

local function HeaderCell(arg1)
    return Roact.createElement("TextLabel", {
        Text = string.upper(arg1.text),
        Size = arg1.size,
        Position = arg1.pos,
        Font = Constants.Font.MainWindowHeader,
        TextSize = Constants.DefaultFontSize.MainWindowHeader,
        TextColor3 = Constants.Color.BorderGray,
        TextXAlignment = Enum.TextXAlignment.Left,
        BackgroundTransparency = 1
    })
end

local function SubscriptionsTable(tbl1)
    local var1 = tbl1.subscriptions or {}
    local layoutOrder = tbl1.layoutOrder

    local tbl2 = {}
    for value, value2 in var1 do
        local bool1 = value2.culled == true
        local var2 = "subscription" .. value

        local createElement = Roact.createElement
        local tbl3 = {
            Size = UDim2.new(1, 0, 0, 20),
            LayoutOrder = value,
            BackgroundColor3 = TextBoxGray,
            BackgroundTransparency = if bool1 then 0.6 else 1,
            BorderSizePixel = 0
        }
        local tbl4 = {
            AudioSsrc = Roact.createElement(
                CellLabel,
                {
                    text = formatHexSsrc(value2.audioSsrc),
                    size = UDim2.new(uDim, UDim.new(1, 0)),
                    pos = UDim2.new(0, 0, 0, 0)
                }
            ),
            FeedId = Roact.createElement(CellLabel, {
                text = formatOrDash(value2.feedReferenceId),
                size = UDim2.new(uDim2, UDim.new(1, 0)),
                pos = UDim2.new(uDim, UDim.new(0, 0))
            }),
            UserId = Roact.createElement(
                CellLabel,
                {
                    text = formatOrDash(value2.userId),
                    size = UDim2.new(uDim3, UDim.new(1, 0)),
                    pos = UDim2.new(x, UDim.new(0, 0))
                }
            ),
            AudioMid = Roact.createElement(CellLabel, {
                text = formatOrDash(value2.audioMid),
                size = UDim2.new(uDim4, UDim.new(1, 0)),
                pos = UDim2.new(x2, UDim.new(0, 0)),
                textTruncate = Enum.TextTruncate.AtEnd
            }),
            Bitrate = Roact.createElement(
                CellLabel,
                {
                    text = formatBitrate(value2),
                    size = UDim2.new(uDim5, UDim.new(1, 0)),
                    pos = UDim2.new(x3, UDim.new(0, 0))
                }
            ),
            Codec = Roact.createElement(CellLabel, {
                text = formatCodec(value2),
                size = UDim2.new(uDim6, UDim.new(1, 0)),
                pos = UDim2.new(x4, UDim.new(0, 0)),
                textTruncate = Enum.TextTruncate.AtEnd
            }),
            Culled = Roact.createElement(
                CellLabel,
                {
                    text = formatBool(value2.culled),
                    size = UDim2.new(uDim7, UDim.new(1, 0)),
                    pos = UDim2.new(x5, UDim.new(0, 0))
                }
            ),
            Muted = Roact.createElement(
                CellLabel,
                {
                    text = formatBool(value2.isMuted),
                    size = UDim2.new(uDim8, UDim.new(1, 0)),
                    pos = UDim2.new(x6, UDim.new(0, 0))
                }
            ),
            MutedLocally = Roact.createElement(CellLabel, {
                text = formatBool(value2.isMutedLocally),
                size = UDim2.new(uDim9, UDim.new(1, 0)),
                pos = UDim2.new(x7, UDim.new(0, 0))
            })
        }
        tbl2[var2] = createElement("Frame", tbl3, tbl4)
    end

    if next(tbl2) == nil then
        tbl2.placeholder = Roact.createElement(CellLabel, { text = "—", layoutOrder = 1, size = UDim2.new(1, 0, 0, 20), pos = UDim2.new() })
    end

    local header = Roact.createElement(
        "Frame",
        {
            Size = UDim2.new(1, 0, 0, 20),
            LayoutOrder = 1,
            BackgroundTransparency = 1
        },
        {
            AudioSsrc = Roact.createElement(
                HeaderCell,
                {
                    text = "Audio Ssrc",
                    size = UDim2.new(uDim, UDim.new(1, 0)),
                    pos = UDim2.new(0, 0, 0, 0)
                }
            ),
            FeedId = Roact.createElement(
                HeaderCell,
                {
                    text = "Feed ID",
                    size = UDim2.new(uDim2, UDim.new(1, 0)),
                    pos = UDim2.new(uDim, UDim.new(0, 0))
                }
            ),
            UserId = Roact.createElement(
                HeaderCell,
                {
                    text = "User ID",
                    size = UDim2.new(uDim3, UDim.new(1, 0)),
                    pos = UDim2.new(x, UDim.new(0, 0))
                }
            ),
            AudioMid = Roact.createElement(
                HeaderCell,
                {
                    text = "Audio Mid",
                    size = UDim2.new(uDim4, UDim.new(1, 0)),
                    pos = UDim2.new(x2, UDim.new(0, 0))
                }
            ),
            Bitrate = Roact.createElement(
                HeaderCell,
                {
                    text = "Bitrate",
                    size = UDim2.new(uDim5, UDim.new(1, 0)),
                    pos = UDim2.new(x3, UDim.new(0, 0))
                }
            ),
            Codec = Roact.createElement(
                HeaderCell,
                {
                    text = "Codec",
                    size = UDim2.new(uDim6, UDim.new(1, 0)),
                    pos = UDim2.new(x4, UDim.new(0, 0))
                }
            ),
            Culled = Roact.createElement(
                HeaderCell,
                {
                    text = "Culled",
                    size = UDim2.new(uDim7, UDim.new(1, 0)),
                    pos = UDim2.new(x5, UDim.new(0, 0))
                }
            ),
            Muted = Roact.createElement(
                HeaderCell,
                {
                    text = "Muted",
                    size = UDim2.new(uDim8, UDim.new(1, 0)),
                    pos = UDim2.new(x6, UDim.new(0, 0))
                }
            ),
            MutedLocally = Roact.createElement(
                HeaderCell,
                {
                    text = "Muted Locally",
                    size = UDim2.new(uDim9, UDim.new(1, 0)),
                    pos = UDim2.new(x7, UDim.new(0, 0))
                }
            )
        }
    )
    return Roact.createElement("Frame", {
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        LayoutOrder = layoutOrder
    }, {
        UIListLayout = Roact.createElement("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder }),
        Header = header,
        Rows = Roact.createElement(
            "Frame",
            {
                Size = UDim2.new(1, 0, 0, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                LayoutOrder = 2,
                BackgroundTransparency = 1
            },
            {
                UIListLayout = Roact.createElement("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder }),
                Rows = Roact.createFragment(tbl2)
            }
        )
    })
end

local function SubscriptionsPanel(tbl1)
    local subscriptions = tbl1.subscriptions
    local layoutOrder = tbl1.layoutOrder

    return Roact.createElement(
        CollapsibleSection,
        { title = "Subscriptions", layoutOrder = layoutOrder },
        {
            Table = Roact.createElement(SubscriptionsTable, { subscriptions = subscriptions, layoutOrder = 1 })
        }
    )
end

return SubscriptionsPanel
