-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:51:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Roact = require(CorePackages.Packages.Roact)

local Constants = require(script.Parent.Parent.Parent.Constants)
local VoiceDebugSource = require(script.Parent.VoiceDebugSource)

local tbl1 = {
    {
        source = VoiceDebugSource.InExperience,
        label = "In-experience"
    },
    {
        source = VoiceDebugSource.Party,
        label = "Party voice"
    }
}

local uDim = UDim.new(0, 8)

local function resolveActivatedSource(source: string, source2: string): string? -- Luacid: Inlined by compiler; 1 call site recovered
    return if source == source2 then nil else source2
end

local function Segment(tbl2: {label: string, source: any}, bool1: boolean, layoutOrder: number, func1: (...any) -> (...any))
    local textColor3 = bool1 and Constants.Color.Text or Constants.Color.BorderGray

    return Roact.createElement("TextButton", {
        Text = tbl2.label,
        AutomaticSize = Enum.AutomaticSize.X,
        Size = UDim2.new(0, 0, 0, 20),
        LayoutOrder = layoutOrder,
        Font = Constants.Font.MainWindow,
        TextSize = Constants.DefaultFontSize.MainWindow + -2,
        TextColor3 = textColor3,
        BackgroundTransparency = 1,
        AutoButtonColor = false,
        [Roact.Event.Activated] = func1
    }, {
        Padding = Roact.createElement("UIPadding", { PaddingLeft = uDim, PaddingRight = uDim }),
        Underline = bool1
            and Roact.createElement("Frame", {
                AnchorPoint = Vector2.new(0.5, 1),
                Position = UDim2.new(0.5, 0, 1, 0),
                Size = UDim2.new(1, -8, 0, 2),
                BackgroundColor3 = Constants.Color.SelectedBlue,
                BorderSizePixel = 0
            })
            or nil
    })
end

local function VoiceSourceToggle(tbl2)
    local tbl3 = {
        UIListLayout = Roact.createElement(
            "UIListLayout",
            {
                FillDirection = Enum.FillDirection.Horizontal,
                SortOrder = Enum.SortOrder.LayoutOrder
            }
        )
    }
    for value, value2 in tbl1 do
        tbl3[value2.source] = Segment(value2, tbl2.source == value2.source, value, function()
            local var1 = resolveActivatedSource(tbl2.source, value2.source)
            if var1 then
                tbl2.onSourceChanged(var1)
            end
        end)
    end

    return Roact.createElement("Frame", {
        AutomaticSize = Enum.AutomaticSize.X,
        Size = UDim2.new(0, 0, 0, 20),
        BackgroundTransparency = 1,
        LayoutOrder = tbl2.layoutOrder
    }, tbl3)
end

return VoiceSourceToggle
