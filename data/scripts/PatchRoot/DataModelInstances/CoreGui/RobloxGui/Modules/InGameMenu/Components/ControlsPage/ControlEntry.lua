-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:20:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local InGameMenuDependencies = require(CorePackages.Packages.InGameMenuDependencies)
local Roact = InGameMenuDependencies.Roact
local t = InGameMenuDependencies.t
local UIBlox = InGameMenuDependencies.UIBlox

local scriptParentParentParent = script.Parent.Parent.Parent

local GlobalConfig = require(scriptParentParentParent.GlobalConfig)

local ThemedTextLabel = require(scriptParentParentParent.Components.ThemedTextLabel)
local KeyLabel = UIBlox.App.Menu.KeyLabel
local PointerLabel = require(scriptParentParentParent.Components.PointerLabel)
local Divider = require(scriptParentParentParent.Components.Divider)

local withLocalization = require(scriptParentParentParent.Localization.withLocalization)

local var1 = t.strictInterface({
    actionDescription = t.string,
    inputs = t.table,
    isList = t.optional(t.boolean),
    hasDivider = t.boolean,
    LayoutOrder = t.integer
})

local function renderHorizontalSpacer(text: string, layoutOrder: number, arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    local uDim2 = arg1 and UDim2.new(0, 19, 0, 24) or UDim2.new(0, 19, 0, 16)
    local bottom = arg1 and Enum.TextYAlignment.Bottom

    return Roact.createElement(ThemedTextLabel, {
        themeKey = "TextEmphasis",
        fontKey = "Header1",
        Text = text,
        Size = uDim2,
        TextYAlignment = bottom,
        LayoutOrder = layoutOrder
    })
end

local function renderKey(enumItem, layoutOrder: number)
    if enumItem.EnumType == Enum.KeyCode then
        return Roact.createElement(KeyLabel, { keyCode = enumItem, textThemeKey = "TextEmphasis", LayoutOrder = layoutOrder })
    end

    return Roact.createElement(PointerLabel, { input = enumItem, LayoutOrder = layoutOrder })
end

local function renderInputIconContainer(inputs, isList)
    local tbl1 = {
        ListLayout = Roact.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Horizontal,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            HorizontalAlignment = Enum.HorizontalAlignment.Right,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, if isList then 0 else 7)
        })
    }
    local num1 = 1
    for i, input in ipairs(inputs) do
        if typeof(input) ~= "table" then
            tbl1["input" .. i] = renderKey(input, num1)
            num1 += 1

            if isList and i == #inputs then
                tbl1.Elipses = renderHorizontalSpacer("...", num1, true)
            end
        else
            for i2, value in ipairs(input) do
                local str1 = string.format("%d_%d", i, i2)
                tbl1["groupedInput" .. str1] = renderKey(value, num1)
                num1 += 1

                if i2 < #input then
                    tbl1["groupedDivider" .. str1] = renderHorizontalSpacer("+", num1, nil)
                    num1 += 1
                end
            end
        end

        if not isList and i < #inputs then
            tbl1["divider" .. i] = renderHorizontalSpacer("/", num1, nil)
            num1 += 1
        end
    end

    return Roact.createElement(
        "Frame",
        {
            BackgroundTransparency = 1,
            Size = UDim2.new(0, 0, 1, 0),
            Position = UDim2.new(1, 0, 0, 0)
        },
        tbl1
    )
end

local function ControlEntry(arg1)
    if GlobalConfig.propValidation then
        assert(var1(arg1))
    end

    return withLocalization({ actionDescription = arg1.actionDescription })(function(arg2)
        return Roact.createElement(
            "Frame",
            {
                LayoutOrder = arg1.LayoutOrder,
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 0, 50)
            },
            {
                ActionLabel = Roact.createElement(ThemedTextLabel, {
                    fontKey = "Header2",
                    themeKey = "TextEmphasis",
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Size = UDim2.new(0, 200, 0, 22),
                    AnchorPoint = Vector2.new(0, 0.5),
                    Position = UDim2.new(0, 0, 0.5, 0),
                    Text = arg2.actionDescription
                }),
                Divider = arg1.hasDivider and Roact.createElement(Divider, { Size = UDim2.new(1, 0, 0, 1), Position = UDim2.new(0, 0, 1, -1) }),
                Inputs = renderInputIconContainer(arg1.inputs, arg1.isList)
            }
        )
    end)
end
return ControlEntry
