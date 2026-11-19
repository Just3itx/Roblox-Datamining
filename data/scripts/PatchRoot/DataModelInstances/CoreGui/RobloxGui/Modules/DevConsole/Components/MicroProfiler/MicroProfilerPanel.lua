-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:31:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local BoxButton = require(script.Parent.Parent.BoxButton)
local Constants = require(script.Parent.Parent.Parent.Constants)
local Immutable = require(script.Parent.Parent.Parent.Immutable)
local Roact = require(CorePackages.Packages.Roact)

local var1 = Roact.Component:extend("MicroProfilerPanel")

function var1.createTabSelector(arg1, arg2)
    local size = arg2.Size
    local var2 = arg2.Position or UDim2.new(0, 0, 0, 0)
    local buttonSize = arg2.ButtonSize
    local layoutOrder = arg2.LayoutOrder

    local function createHighlight(currentSection: string, num1: number)
        if arg1.state.CurrentSection ~= currentSection then
            return nil
        end

        return (Roact.createElement("Frame", {
            Size = UDim2.new(0, Constants.MicroProfilerFormatting.TabButtonWidth, 0, Constants.MicroProfilerFormatting.TabButtonPad),
            Position = UDim2.new(
                0,
                Constants.MicroProfilerFormatting.TabButtonWidth * (num1 - 1),
                0,
                Constants.MicroProfilerFormatting.TabsHeight - Constants.MicroProfilerFormatting.TabButtonPad
            ),
            BorderSizePixel = 0,
            BackgroundColor3 = Constants.Color.HighlightBlue,
            ZIndex = 10
        }))
    end
    local tbl1 = ({})
    for k, section in arg1.props.Sections do
        local str1 = `Button_{string.format("%02d", k)}`
        local createElement = Roact.createElement
        local var3 = BoxButton
        local tbl2 = {
            text = section.Name,
            size = buttonSize,
            pos = UDim2.new(0, (k - 1) * buttonSize.X.Offset, 0, 0),
            onClicked = 0
        }

        function tbl2.onClicked()
            arg1:setState({ CurrentSection = section.Name })
        end

        tbl1[str1] = createElement(var3, tbl2)

        tbl1[`ButtonHighlight_{string.format("%02d", k)}`] = createHighlight(section.Name, k)
    end

    return Roact.createElement(
        "Frame",
        { Size = size, Position = var2, BackgroundTransparency = 1, LayoutOrder = layoutOrder },
        tbl1
    )
end

function var1.init(arg1)
    assert(arg1.props.Sections[1] ~= nil, "MicroProfilerPanel requires at least one section.")

    arg1.state = {
        CurrentSection = arg1.props.Sections[1].Name
    }
end

function var1.render(arg1)
    assert(arg1.props.Sections[1] ~= nil, "MicroProfilerPanel requires at least one section.")

    local sections = arg1.props.Sections

    local tbl1 = {}
    for _, section in sections do
        tbl1[section.Name] = {}
        for k, row in section.Rows do
            local var2 = tbl1[section.Name]
            local str1 = `Row_{string.format("%02d", k)}`
            var2[str1] = Roact.createElement("Frame", {
                Size = UDim2.new(1, 0, 0, Constants.MicroProfilerFormatting.OptionRowHeight),
                BackgroundTransparency = 1,
                LayoutOrder = k * 2
            }, row)

            if not (k < #section.Rows) then
                continue
            end

            local var3 = tbl1[section.Name]
            local str2 = `HorizontalLine_{string.format("%02d", k)}`
            var3[str2] = Roact.createElement(
                "Frame",
                {
                    Size = UDim2.new(1, 0, 0, 1),
                    BackgroundColor3 = Color3.new(1, 1, 1),
                    BorderSizePixel = 0,
                    LayoutOrder = k * 2 + 1
                }
            )
        end
    end

    return Roact.createElement("Frame", {
        Size = UDim2.new(1, 0, 0, 0),
        BackgroundTransparency = 1,
        LayoutOrder = arg1.props.LayoutOrder,
        AutomaticSize = Enum.AutomaticSize.Y
    }, {
        UIListLayout = Roact.createElement("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            VerticalAlignment = Enum.VerticalAlignment.Top
        }),
        Title = Roact.createElement("TextLabel", {
            Size = UDim2.new(1, 0, 0, Constants.MicroProfilerFormatting.PanelTitleHeight),
            BackgroundTransparency = 1,
            Text = arg1.props.Title,
            TextXAlignment = Enum.TextXAlignment.Left,
            Font = Constants.Font.MainWindowBold,
            TextSize = Constants.MicroProfilerFormatting.TextSizePanelTitle,
            TextColor3 = Color3.new(1, 1, 1),
            LayoutOrder = 1
        }),
        Tabs = if #sections > 1 then arg1:createTabSelector({
            Size = UDim2.new(1, 0, 0, Constants.MicroProfilerFormatting.TabsHeight),
            Position = UDim2.new(0, 0, 0, 0),
            LayoutOrder = 2,
            ButtonSize = UDim2.new(0, Constants.MicroProfilerFormatting.TabButtonWidth, 1, 0)
        }) else nil,
        [`Table_{arg1.state.CurrentSection}`] = Roact.createElement(
            "Frame",
            {
                Size = UDim2.new(1, 0, 0, 0),
                BackgroundTransparency = 1,
                LayoutOrder = 3,
                AutomaticSize = Enum.AutomaticSize.Y
            },
            Immutable.JoinDictionaries({
                UIListLayout = Roact.createElement("UIListLayout", {
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    HorizontalAlignment = Enum.HorizontalAlignment.Left,
                    VerticalAlignment = Enum.VerticalAlignment.Top
                }),
                UIStroke = Roact.createElement(
                    "UIStroke",
                    {
                        Color = Color3.new(1, 1, 1),
                        Thickness = 1,
                        BorderStrokePosition = Enum.BorderStrokePosition.Inner
                    }
                )
            }, tbl1[arg1.state.CurrentSection])
        )
    })
end

return var1
