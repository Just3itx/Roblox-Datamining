-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:50:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Roact = require(CorePackages.Packages.Roact)

local Components = script.Parent.Parent.Parent.Components
local CellLabel = require(Components.CellLabel)
local BannerButton = require(Components.BannerButton)

local Constants = require(script.Parent.Parent.Parent.Constants)

local IceCandidateParser = require(script.Parent.IceCandidateParser)
local CollapsibleSection = require(script.Parent.CollapsibleSection)

local _VoiceDebugData = require(script.Parent.VoiceDebugData)

local GetFFlagVoiceDebugConsoleV2 = require(script.Parent.GetFFlagVoiceDebugConsoleV2)

local MainRowPadding = Constants.GeneralFormatting.MainRowPadding

local uDim = UDim.new(0.55, 0)
local uDim2 = UDim.new(0.25, 0)
local uDim3 = UDim.new(0.2, 0)
local uDim4 = UDim.new(0.4, 0)
local uDim5 = UDim.new(0.3, 0)

local HoverGreen = Constants.Color.HoverGreen
local WarningYellow = Constants.Color.WarningYellow
local ErrorRed = Constants.Color.ErrorRed
local UnselectedGray = Constants.Color.UnselectedGray

local tbl1 = { complete = true, completed = true, connected = true, stable = true }
local tbl2 = { checking = true, connecting = true, new = true }
local tbl3 = { failed = true, disconnected = true, closed = true }

local tbl4 = {
    host = {
        background = Color3.fromRGB(13, 39, 64),
        text = Color3.fromRGB(95, 184, 255)
    },
    srflx = {
        background = Color3.fromRGB(42, 26, 48),
        text = Color3.fromRGB(176, 122, 240)
    },
    relay = {
        background = Color3.fromRGB(42, 32, 16),
        text = Color3.fromRGB(224, 176, 64)
    },
    prflx = {
        background = Color3.fromRGB(16, 42, 32),
        text = Color3.fromRGB(96, 200, 160)
    }
}
local tbl5 = {
    background = Color3.fromRGB(28, 28, 28),
    text = Color3.fromRGB(107, 111, 117)
}

local uDim6 = UDim.new(0.17, 0)
local uDim7 = UDim.new(0.14, 0)
local uDim8 = UDim.new(0.25, 0)
local uDim9 = UDim.new(0.14, 0)
local uDim10 = UDim.new(0.17, 0)
local uDim11 = UDim.new(0.13, 0)

local function richTextEscape(str1: string) -- Luacid: Inlined by compiler; 4 call sites recovered
    return (string.gsub(str1, "[<>&\"']", { ["<"] = "&lt;", [">"] = "&gt;", ["&"] = "&amp;", ["\""] = "&quot;", ["'"] = "&apos;" }))
end

local function GroupHeader(arg1)
    local var1 = richTextEscape(arg1.title)
    local subtitle = arg1.subtitle

    local str1 = string.format("<b>%s</b>", var1)
    if subtitle then
        str1 ..= string.format("  <font color=\"#%s\">%s</font>", "B8B8B8", (richTextEscape(subtitle)))
    end

    return Roact.createElement(
        CellLabel,
        {
            text = str1,
            richText = true,
            layoutOrder = arg1.layoutOrder,
            size = UDim2.new(1, 0, 0, 20),
            pos = UDim2.new()
        }
    )
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

local function formatLegState(str1: string?): string -- Luacid: Inlined by compiler; 8 call sites recovered
    return if str1 == nil or str1 == "" then "—" else str1
end

local function statusDotColor(str1: string?) -- Luacid: Inlined by compiler; 2 call sites recovered
    if str1 ~= nil then
        if tbl1[str1] then
            return HoverGreen
        end

        if tbl2[str1] then
            return WarningYellow
        end

        if tbl3[str1] then
            return ErrorRed
        end
    end
    return UnselectedGray
end

local function isAlertColor(color3: Color3?): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return color3 == WarningYellow or color3 == ErrorRed
end

local function LegCell(tbl6)
    local color = tbl6.color
    local text = tbl6.text
    local size = tbl6.size
    local pos = tbl6.pos

    local xOffset = if color then 12 else 0

    return Roact.createElement("Frame", { Size = size, Position = pos, BackgroundTransparency = 1 }, {
        Dot = color
            and Roact.createElement("Frame", {
                AnchorPoint = Vector2.new(0, 0.5),
                Position = UDim2.new(0, 0, 0.5, 0),
                Size = UDim2.new(0, 7, 0, 7),
                BackgroundColor3 = color,
                BorderSizePixel = 0
            }, {
                Corner = Roact.createElement("UICorner", { CornerRadius = UDim.new(1, 0) })
            })
            or nil,
        Value = Roact.createElement(CellLabel, { text = text, size = UDim2.new(1, -xOffset, 1, 0), pos = UDim2.new(0, xOffset, 0, 0) })
    })
end

local function formatSelectedCandidatePair(str1: string?, str2: string?, str3: string?)
    if str1 == nil or str1 == "" or str2 == nil or str2 == "" then
        return nil
    elseif str3 and str3 ~= "" then
        return string.format("%s ↔ %s (%s)", str1, str2, str3)
    end
    return string.format("%s ↔ %s", str1, str2)
end

local function TransportStateTable(tbl6)
    local connectivity = tbl6.connectivity or {}
    local layoutOrder = tbl6.layoutOrder
    local fFlagVoiceDebugConsoleV2 = GetFFlagVoiceDebugConsoleV2()

    local tbl7 = {
        {
            label = "ICE gathering",
            publish = connectivity.iceGatheringStatePublish,
            subscribe = connectivity.iceGatheringStateSubscribe
        },
        {
            label = "ICE connection",
            publish = connectivity.iceConnectionStatePublish,
            subscribe = connectivity.iceConnectionStateSubscribe
        },
        {
            label = "Signaling",
            publish = connectivity.signalingStatePublish,
            subscribe = connectivity.signalingStateSubscribe
        }
    }

    local tbl8 = {}
    for value, value2 in tbl7 do
        local color = if fFlagVoiceDebugConsoleV2 then statusDotColor(value2.publish) or nil else nil
        local var1 = if fFlagVoiceDebugConsoleV2 then statusDotColor(value2.subscribe) or nil else nil
        local var3 = fFlagVoiceDebugConsoleV2 and (isAlertColor(color) or isAlertColor(var1))

        local var4 = "row" .. value
        local createElement = Roact.createElement
        local str1 = "Frame"
        local tbl9 = {
            Size = UDim2.new(1, 0, 0, 20),
            LayoutOrder = value,
            BackgroundTransparency = 1
        }
        local tbl10 = {
            Accent = if fFlagVoiceDebugConsoleV2 then Roact.createElement("Frame", {
                Position = UDim2.new(0, 0, 0, 0),
                Size = UDim2.new(0, 2, 1, 0),
                BackgroundColor3 = Constants.Color.WarningYellow,
                BackgroundTransparency = if var3 then 0 else 1,
                BorderSizePixel = 0
            })
                or nil else nil,
            Label = Roact.createElement(CellLabel, {
                text = value2.label,
                size = UDim2.new(uDim4, UDim.new(1, 0)),
                pos = UDim2.new(0, 0, 0, 0),
                textTruncate = Enum.TextTruncate.AtEnd
            }),
            Publish = Roact.createElement(LegCell, {
                text = formatLegState(value2.publish),
                color = color,
                size = UDim2.new(uDim5, UDim.new(1, 0)),
                pos = UDim2.new(uDim4, UDim.new(0, 0))
            }),
            Subscribe = Roact.createElement(LegCell, {
                text = formatLegState(value2.subscribe),
                color = var1,
                size = UDim2.new(uDim5, UDim.new(1, 0)),
                pos = UDim2.new(uDim4 + uDim5, UDim.new(0, 0))
            })
        }
        tbl8[var4] = createElement(str1, tbl9, tbl10)
    end

    local var1 = if connectivity.rebootCount then tostring(connectivity.rebootCount) or nil else nil
    tbl8.restartRow = Roact.createElement(
        "Frame",
        {
            Size = UDim2.new(1, 0, 0, 20),
            LayoutOrder = #tbl7 + 1,
            BackgroundTransparency = 1
        },
        {
            Label = Roact.createElement(CellLabel, {
                text = "ICE restarts (this session)",
                size = UDim2.new(uDim4, UDim.new(1, 0)),
                pos = UDim2.new(0, 0, 0, 0),
                textTruncate = Enum.TextTruncate.AtEnd
            }),
            Publish = Roact.createElement(
                LegCell,
                {
                    text = formatLegState(var1),
                    size = UDim2.new(uDim5, UDim.new(1, 0)),
                    pos = UDim2.new(uDim4, UDim.new(0, 0))
                }
            ),
            Subscribe = Roact.createElement(
                LegCell,
                {
                    text = formatLegState(var1),
                    size = UDim2.new(uDim5, UDim.new(1, 0)),
                    pos = UDim2.new(uDim4 + uDim5, UDim.new(0, 0))
                }
            )
        }
    )
    local var2 = if connectivity.timeToConnectedMs and connectivity.timeToConnectedMs > 0 then string.format("%.0f ms", connectivity.timeToConnectedMs) else nil
    tbl8.timeToConnectedRow = Roact.createElement(
        "Frame",
        {
            Size = UDim2.new(1, 0, 0, 20),
            LayoutOrder = #tbl7 + 2,
            BackgroundTransparency = 1
        },
        {
            Label = Roact.createElement(CellLabel, {
                text = "Time to connected",
                size = UDim2.new(uDim4, UDim.new(1, 0)),
                pos = UDim2.new(0, 0, 0, 0),
                textTruncate = Enum.TextTruncate.AtEnd
            }),
            Publish = Roact.createElement(
                LegCell,
                {
                    text = formatLegState(var2),
                    size = UDim2.new(uDim5, UDim.new(1, 0)),
                    pos = UDim2.new(uDim4, UDim.new(0, 0))
                }
            ),
            Subscribe = Roact.createElement(
                LegCell,
                {
                    text = formatLegState(var2),
                    size = UDim2.new(uDim5, UDim.new(1, 0)),
                    pos = UDim2.new(uDim4 + uDim5, UDim.new(0, 0))
                }
            )
        }
    )
    local var3 = formatSelectedCandidatePair(
        connectivity.selectedCandidatePairLocalTypePublish,
        connectivity.selectedCandidatePairRemoteTypePublish,
        connectivity.selectedCandidatePairLocalProtocolPublish
    )
    local var4 = formatSelectedCandidatePair(
        connectivity.selectedCandidatePairLocalTypeSubscribe,
        connectivity.selectedCandidatePairRemoteTypeSubscribe,
        connectivity.selectedCandidatePairLocalProtocolSubscribe
    )
    tbl8.selectedCandidatePairRow = Roact.createElement(
        "Frame",
        {
            Size = UDim2.new(1, 0, 0, 20),
            LayoutOrder = #tbl7 + 3,
            BackgroundTransparency = 1
        },
        {
            Label = Roact.createElement(CellLabel, {
                text = "Selected candidate pair",
                size = UDim2.new(uDim4, UDim.new(1, 0)),
                pos = UDim2.new(0, 0, 0, 0),
                textTruncate = Enum.TextTruncate.AtEnd
            }),
            Publish = Roact.createElement(
                LegCell,
                {
                    text = formatLegState(var3),
                    size = UDim2.new(uDim5, UDim.new(1, 0)),
                    pos = UDim2.new(uDim4, UDim.new(0, 0))
                }
            ),
            Subscribe = Roact.createElement(
                LegCell,
                {
                    text = formatLegState(var4),
                    size = UDim2.new(uDim5, UDim.new(1, 0)),
                    pos = UDim2.new(uDim4 + uDim5, UDim.new(0, 0))
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
        Title = fFlagVoiceDebugConsoleV2
            and Roact.createElement(
                GroupHeader,
                {
                    title = "Transport state",
                    subtitle = "publish / subscribe compared",
                    layoutOrder = 1
                }
            )
            or Roact.createElement(
                CellLabel,
                {
                    text = "Transport state",
                    bold = true,
                    layoutOrder = 1,
                    size = UDim2.new(1, 0, 0, 20),
                    pos = UDim2.new()
                }
            ),
        Header = Roact.createElement(
            "Frame",
            {
                Size = UDim2.new(1, 0, 0, 20),
                LayoutOrder = 2,
                BackgroundTransparency = 1
            },
            fFlagVoiceDebugConsoleV2
                and {
                    Label = Roact.createElement(CellLabel, { text = "", size = UDim2.new(uDim4, UDim.new(1, 0)), pos = UDim2.new(0, 0, 0, 0) }),
                    Publish = Roact.createElement(
                        HeaderCell,
                        {
                            text = "Publish",
                            size = UDim2.new(uDim5, UDim.new(1, 0)),
                            pos = UDim2.new(uDim4, UDim.new(0, 0))
                        }
                    ),
                    Subscribe = Roact.createElement(
                        HeaderCell,
                        {
                            text = "Subscribe",
                            size = UDim2.new(uDim5, UDim.new(1, 0)),
                            pos = UDim2.new(uDim4 + uDim5, UDim.new(0, 0))
                        }
                    )
                }
                or {
                    Label = Roact.createElement(CellLabel, { text = "", size = UDim2.new(uDim4, UDim.new(1, 0)), pos = UDim2.new(0, 0, 0, 0) }),
                    Publish = Roact.createElement(
                        CellLabel,
                        {
                            text = "PUBLISH",
                            bold = true,
                            size = UDim2.new(uDim5, UDim.new(1, 0)),
                            pos = UDim2.new(uDim4, UDim.new(0, 0))
                        }
                    ),
                    Subscribe = Roact.createElement(CellLabel, {
                        text = "SUBSCRIBE",
                        bold = true,
                        size = UDim2.new(uDim5, UDim.new(1, 0)),
                        pos = UDim2.new(uDim4 + uDim5, UDim.new(0, 0))
                    })
                }
        ),
        Rows = Roact.createElement(
            "Frame",
            {
                Size = UDim2.new(1, 0, 0, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                LayoutOrder = 3,
                BackgroundTransparency = 1
            },
            {
                UIListLayout = Roact.createElement("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder }),
                Rows = Roact.createFragment(tbl8)
            }
        )
    })
end

local function formatMLineIndex(arg1): string -- Luacid: Inlined by compiler; 2 call sites recovered
    local sdpMLineIndex = arg1.sdpMLineIndex
    if sdpMLineIndex == nil then
        return "—"
    end
    return tostring(sdpMLineIndex)
end

local function formatOrDash(str1: string?): string -- Luacid: Inlined by compiler; 5 call sites recovered
    return if str1 == nil or str1 == "" then "—" else str1
end

local function TypePill(arg1)
    local candidateType = arg1.candidateType
    local var1 = candidateType and tbl4[candidateType] or tbl5

    local createElement = Roact.createElement
    local tbl6 = {
        Size = arg1.size,
        Position = arg1.pos,
        BackgroundTransparency = 1
    }

    local createElement2 = Roact.createElement
    local tbl7 = {
        AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.new(0, 0, 0.5, 0),
        Size = UDim2.new(0, 0, 0, 16),
        AutomaticSize = Enum.AutomaticSize.X,
        BackgroundColor3 = var1.background,
        BorderSizePixel = 0
    }
    local tbl8 = {
        Corner = Roact.createElement("UICorner", { CornerRadius = UDim.new(0, 8) }),
        Padding = Roact.createElement("UIPadding", { PaddingLeft = UDim.new(0, 7), PaddingRight = UDim.new(0, 7) }),
        Label = 0
    }
    local createElement3 = Roact.createElement
    local str1 = formatOrDash(candidateType)
    local tbl9 = {
        Text = 0,
        Size = 0,
        AutomaticSize = 0,
        Font = 0,
        TextSize = 0,
        TextColor3 = 0,
        TextXAlignment = 0,
        BackgroundTransparency = 1
    }
    local str2 = "TextLabel"
    local str3 = "Frame"
    local tbl10 = { Pill = 0 }
    local str4 = "Frame"
    tbl9.Text = str1
    tbl9.Size = UDim2.new(0, 0, 1, 0)
    tbl9.AutomaticSize = Enum.AutomaticSize.X
    tbl9.Font = Constants.Font.MainWindow
    tbl9.TextSize = Constants.DefaultFontSize.MainWindow - 2
    tbl9.TextColor3 = var1.text
    tbl9.TextXAlignment = Enum.TextXAlignment.Center
    tbl8.Label = createElement3(str2, tbl9)
    tbl10.Pill = createElement2(str3, tbl7, tbl8)
    return createElement(str4, tbl6, tbl10)
end

local tbl6 = ({})
local function parseIceCandidateCached(candidate: string?) -- Luacid: Inlined by compiler; 1 call site recovered
    if not candidate then
        return IceCandidateParser(candidate)
    end
    local var1 = tbl6[candidate]
    if var1 == nil then
        var1 = IceCandidateParser(candidate)
        tbl6[candidate] = var1
    end
    return var1
end

local function CandidateTable(tbl7)
    local title = tbl7.title
    local candidates = tbl7.candidates or {}
    local layoutOrder = tbl7.layoutOrder
    local fFlagVoiceDebugConsoleV2 = GetFFlagVoiceDebugConsoleV2()

    local tbl8 = {}
    for value, value2 in candidates do
        if fFlagVoiceDebugConsoleV2 then
            local var1 = parseIceCandidateCached(value2.candidate)
            local var2 = "candidate" .. value
            local createElement = Roact.createElement
            local tbl9 = {
                Size = UDim2.new(1, 0, 0, 20),
                LayoutOrder = value,
                BackgroundTransparency = 1
            }
            local tbl10 = {
                Type = Roact.createElement(
                    TypePill,
                    {
                        candidateType = var1.candidateType,
                        size = UDim2.new(uDim6, UDim.new(1, 0)),
                        pos = UDim2.new(0, 0, 0, 0)
                    }
                ),
                Proto = Roact.createElement(
                    CellLabel,
                    {
                        text = formatOrDash(var1.protocol),
                        size = UDim2.new(uDim7, UDim.new(1, 0)),
                        pos = UDim2.new(uDim6, UDim.new(0, 0))
                    }
                ),
                Priority = Roact.createElement(CellLabel, {
                    text = formatOrDash(var1.priority),
                    size = UDim2.new(uDim8, UDim.new(1, 0)),
                    pos = UDim2.new(uDim6 + uDim7, UDim.new(0, 0))
                }),
                Comp = Roact.createElement(CellLabel, {
                    text = formatOrDash(var1.component),
                    size = UDim2.new(uDim9, UDim.new(1, 0)),
                    pos = UDim2.new(uDim6 + uDim7 + uDim8, UDim.new(0, 0))
                }),
                Mid = Roact.createElement(CellLabel, {
                    text = formatOrDash(value2.sdpMid),
                    size = UDim2.new(uDim10, UDim.new(1, 0)),
                    pos = UDim2.new(uDim6 + uDim7 + uDim8 + uDim9, UDim.new(0, 0)),
                    textTruncate = Enum.TextTruncate.AtEnd
                }),
                Idx = Roact.createElement(CellLabel, {
                    text = formatMLineIndex(value2),
                    size = UDim2.new(uDim11, UDim.new(1, 0)),
                    pos = UDim2.new(uDim6 + uDim7 + uDim8 + uDim9 + uDim10, UDim.new(0, 0))
                })
            }
            tbl8[var2] = createElement("Frame", tbl9, tbl10)
        else
            local var1 = "candidate" .. value
            local createElement = Roact.createElement
            local tbl9 = {
                Size = UDim2.new(1, 0, 0, 20),
                LayoutOrder = value,
                BackgroundTransparency = 1
            }
            local tbl10 = {
                Candidate = Roact.createElement(CellLabel, {
                    text = value2.candidate,
                    size = UDim2.new(uDim, UDim.new(1, 0)),
                    pos = UDim2.new(0, 0, 0, 0),
                    textTruncate = Enum.TextTruncate.AtEnd
                }),
                SdpMid = Roact.createElement(CellLabel, {
                    text = value2.sdpMid,
                    size = UDim2.new(uDim2, UDim.new(1, 0)),
                    pos = UDim2.new(uDim, UDim.new(0, 0)),
                    textTruncate = Enum.TextTruncate.AtEnd
                }),
                SdpMLineIndex = Roact.createElement(CellLabel, {
                    text = formatMLineIndex(value2),
                    size = UDim2.new(uDim3, UDim.new(1, 0)),
                    pos = UDim2.new(uDim + uDim2, UDim.new(0, 0))
                })
            }
            tbl8[var1] = createElement("Frame", tbl9, tbl10)
        end
    end

    if next(tbl8) == nil then
        tbl8.placeholder = Roact.createElement(CellLabel, { text = "—", layoutOrder = 1, size = UDim2.new(1, 0, 0, 20), pos = UDim2.new() })
    end

    local element

    if fFlagVoiceDebugConsoleV2 then
        element = Roact.createElement(
            "Frame",
            {
                Size = UDim2.new(1, 0, 0, 20),
                LayoutOrder = 2,
                BackgroundTransparency = 1
            },
            {
                Type = Roact.createElement(HeaderCell, { text = "Type", size = UDim2.new(uDim6, UDim.new(1, 0)), pos = UDim2.new(0, 0, 0, 0) }),
                Proto = Roact.createElement(
                    HeaderCell,
                    {
                        text = "Proto",
                        size = UDim2.new(uDim7, UDim.new(1, 0)),
                        pos = UDim2.new(uDim6, UDim.new(0, 0))
                    }
                ),
                Priority = Roact.createElement(
                    HeaderCell,
                    {
                        text = "Priority",
                        size = UDim2.new(uDim8, UDim.new(1, 0)),
                        pos = UDim2.new(uDim6 + uDim7, UDim.new(0, 0))
                    }
                ),
                Comp = Roact.createElement(
                    HeaderCell,
                    {
                        text = "Comp",
                        size = UDim2.new(uDim9, UDim.new(1, 0)),
                        pos = UDim2.new(uDim6 + uDim7 + uDim8, UDim.new(0, 0))
                    }
                ),
                Mid = Roact.createElement(HeaderCell, {
                    text = "Mid",
                    size = UDim2.new(uDim10, UDim.new(1, 0)),
                    pos = UDim2.new(uDim6 + uDim7 + uDim8 + uDim9, UDim.new(0, 0))
                }),
                Idx = Roact.createElement(HeaderCell, {
                    text = "Idx",
                    size = UDim2.new(uDim11, UDim.new(1, 0)),
                    pos = UDim2.new(uDim6 + uDim7 + uDim8 + uDim9 + uDim10, UDim.new(0, 0))
                })
            }
        )
    else
        element = Roact.createElement(
            "Frame",
            {
                Size = UDim2.new(1, 0, 0, 20),
                LayoutOrder = 2,
                BackgroundTransparency = 1
            },
            {
                Candidate = Roact.createElement(
                    CellLabel,
                    {
                        text = "CANDIDATE",
                        bold = true,
                        size = UDim2.new(uDim, UDim.new(1, 0)),
                        pos = UDim2.new(0, 0, 0, 0)
                    }
                ),
                SdpMid = Roact.createElement(
                    CellLabel,
                    {
                        text = "SDP MID",
                        bold = true,
                        size = UDim2.new(uDim2, UDim.new(1, 0)),
                        pos = UDim2.new(uDim, UDim.new(0, 0))
                    }
                ),
                SdpMLineIndex = Roact.createElement(CellLabel, {
                    text = "SDP MLINE INDEX",
                    bold = true,
                    size = UDim2.new(uDim3, UDim.new(1, 0)),
                    pos = UDim2.new(uDim + uDim2, UDim.new(0, 0))
                })
            }
        )
    end
    return Roact.createElement("Frame", {
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        LayoutOrder = layoutOrder
    }, {
        UIListLayout = Roact.createElement("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder }),
        Title = fFlagVoiceDebugConsoleV2
            and Roact.createElement(GroupHeader, { title = title, subtitle = string.format("%d local", #candidates), layoutOrder = 1 })
            or Roact.createElement(
                CellLabel,
                {
                    text = title,
                    bold = true,
                    layoutOrder = 1,
                    size = UDim2.new(1, 0, 0, 20),
                    pos = UDim2.new()
                }
            ),
        Header = element,
        Rows = Roact.createElement(
            "Frame",
            {
                Size = UDim2.new(1, 0, 0, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                LayoutOrder = 3,
                BackgroundTransparency = 1
            },
            {
                UIListLayout = Roact.createElement("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder }),
                Rows = Roact.createFragment(tbl8)
            }
        )
    })
end

local function toRichTextSdp(str1: string?) -- Luacid: Inlined by compiler; 1 call site recovered
    if str1 == nil then
        return nil
    end

    return (string.gsub(richTextEscape(str1), "redacted", string.format("<font color=\"#%s\">redacted</font>", "6B6F75")))
end

local var1 = Roact.PureComponent:extend("SdpSection")

function var1.init(arg1)
    arg1.state = { expanded = false }

    function arg1.onButtonPress()
        arg1:setState(function(arg2)
            return {
                expanded = not arg2.expanded
            }
        end)
    end
end

function var1.render(arg1)
    local label = arg1.props.label

    local sdp = arg1.props.sdp
    local layoutOrder = arg1.props.layoutOrder
    local richText = GetFFlagVoiceDebugConsoleV2()
    local isExpandable = not (sdp == nil) and sdp ~= ""

    if richText and isExpandable then
        sdp = toRichTextSdp(sdp) or sdp
    end
    local createElement = Roact.createElement
    local str1 = "Frame"
    local tbl7 = {
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        LayoutOrder = layoutOrder
    }
    local tbl8 = {
        UIListLayout = Roact.createElement("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder }),
        Button = Roact.createElement(BannerButton, {
            size = UDim2.new(1, 0, 0, 20),
            isExpanded = arg1.state.expanded,
            isExpandable = isExpandable,
            hideLines = true,
            onButtonPress = if isExpandable then arg1.onButtonPress or nil else nil,
            layoutOrder = 1
        }, {
            Label = Roact.createElement(CellLabel, {
                text = isExpandable and label or string.format("%s: —", label),
                size = UDim2.new(1, -20, 1, 0),
                pos = UDim2.new(0, 20, 0, 0)
            })
        }),
        Content = 0
    }
    local element

    if isExpandable and arg1.state.expanded then
        element = Roact.createElement("TextLabel", {
            Text = sdp,
            RichText = richText,
            TextSize = richText and Constants.DefaultFontSize.MainWindow - 3 or Constants.DefaultFontSize.MainWindow,
            TextColor3 = Constants.Color.Text,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Top,
            TextWrapped = true,
            Font = Constants.Font.MainWindow,
            BackgroundTransparency = 1,
            LayoutOrder = 2,
            Size = UDim2.new(1, -20, 0, 0),
            Position = UDim2.new(0, 20, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y
        })
            or nil
    else
        element = nil
    end

    tbl8.Content = element
    return createElement(str1, tbl7, tbl8)
end

local function ConnectivityPanel(tbl7)
    local connectivity = tbl7.connectivity or {}
    local layoutOrder = tbl7.layoutOrder
    local fFlagVoiceDebugConsoleV2 = GetFFlagVoiceDebugConsoleV2()

    local tbl8 = {
        TransportState = if fFlagVoiceDebugConsoleV2 then Roact.createElement(TransportStateTable, { connectivity = connectivity, layoutOrder = 1 }) or nil else nil,
        PublishCandidates = Roact.createElement(
            CandidateTable,
            {
                title = "Publish ICE candidates",
                candidates = connectivity.icePublishCandidates,
                layoutOrder = 2
            }
        ),
        SubscribeCandidates = Roact.createElement(
            CandidateTable,
            {
                title = "Subscribe ICE candidates",
                candidates = connectivity.iceSubscribeCandidates,
                layoutOrder = 3
            }
        ),
        SessionDescriptionsHeader = fFlagVoiceDebugConsoleV2
            and Roact.createElement(GroupHeader, { title = "Session descriptions", subtitle = "addresses redacted", layoutOrder = 4 })
            or nil,
        PublishOffer = Roact.createElement(var1, { label = "Publish offer", sdp = connectivity.sdpPublishOffer, layoutOrder = 5 }),
        PublishRemoteAnswer = Roact.createElement(
            var1,
            {
                label = "Publish remote answer",
                sdp = connectivity.sdpPublishRemoteAnswer,
                layoutOrder = 6
            }
        ),
        SubscribeRemoteOffer = Roact.createElement(
            var1,
            {
                label = "Subscribe remote offer",
                sdp = connectivity.sdpSubscribeRemoteOffer,
                layoutOrder = 7
            }
        ),
        SubscribeAnswer = Roact.createElement(var1, { label = "Subscribe answer", sdp = connectivity.sdpSubscribeAnswer, layoutOrder = 8 })
    }

    if fFlagVoiceDebugConsoleV2 then
        return Roact.createElement(CollapsibleSection, { title = "Connectivity", layoutOrder = layoutOrder }, tbl8)
    end

    tbl8.UIListLayout = Roact.createElement("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, MainRowPadding) })

    tbl8.SectionHeader = Roact.createElement(
        CellLabel,
        {
            text = "CONNECTIVITY",
            bold = true,
            layoutOrder = 0,
            size = UDim2.new(1, 0, 0, 20),
            pos = UDim2.new()
        }
    )
    return Roact.createElement("Frame", {
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        LayoutOrder = layoutOrder
    }, tbl8)
end

return ConnectivityPanel
