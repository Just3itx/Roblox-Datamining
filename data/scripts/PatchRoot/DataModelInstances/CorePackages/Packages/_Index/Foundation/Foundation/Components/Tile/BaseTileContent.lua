-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T05:50:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local getTestIdTag = require(Foundation.Utility.getTestIdTag)
local useTokens = require(Foundation.Providers.Style.useTokens)

local uDim2 = UDim2.fromScale(1, 0)

local function slotFrame(layoutOrder: number, arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    return React.createElement("Frame", {
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        LayoutOrder = layoutOrder,
        Size = uDim2
    }, arg1)
end

return React.memo(function(tbl1) -- name: BaseTileContent
    local var1 = useTokens()
    local bool1 = tbl1.contentAction ~= nil
    local small = var1.Gap.Small
    local paddingTop = UDim.new(0, if tbl1.isContained then var1.Padding.Medium else var1.Padding.Small)
    local var3 = if tbl1.isContained then paddingTop else nil
    local size1200 = var1.Size.Size_1200
    local title = slotFrame(1, tbl1.title)
    local metadata = if tbl1.metadata == nil then nil else slotFrame(2, tbl1.metadata)
    local element

    if tbl1.footer == nil then
        element = nil
    else
        element = React.createElement(
            "Frame",
            {
                AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                LayoutOrder = 3,
                Size = uDim2,
                [React.Tag] = getTestIdTag(`{tbl1.testId}--footer`)
            },
            {
                Padding = React.createElement("UIPadding", { PaddingTop = UDim.new(0, small) }),
                Content = tbl1.footer
            }
        )
    end
    local tbl2 = {
        Padding = React.createElement(
            "UIPadding",
            {
                PaddingTop = paddingTop,
                PaddingBottom = var3,
                PaddingLeft = var3,
                PaddingRight = var3
            }
        ),
        Layout = React.createElement(
            "UIListLayout",
            {
                FillDirection = Enum.FillDirection.Vertical,
                SortOrder = Enum.SortOrder.LayoutOrder
            }
        ),
        Footer = element
    }

    if bool1 then
        local createElement = React.createElement
        local tbl3 = {
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            LayoutOrder = 1,
            Size = uDim2
        }
        local tbl4 = {
            Layout = React.createElement("UIListLayout", {
                FillDirection = Enum.FillDirection.Horizontal,
                Padding = UDim.new(0, small),
                SortOrder = Enum.SortOrder.LayoutOrder,
                VerticalAlignment = Enum.VerticalAlignment.Top
            }),
            Text = React.createElement("Frame", {
                AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                LayoutOrder = 1,
                Size = UDim2.new(1, -(size1200 + small), 0, 0)
            }, {
                Layout = React.createElement(
                    "UIListLayout",
                    {
                        FillDirection = Enum.FillDirection.Vertical,
                        SortOrder = Enum.SortOrder.LayoutOrder
                    }
                ),
                Title = title,
                Metadata = metadata
            }),
            ContentAction = React.createElement("Frame", {
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                LayoutOrder = 2,
                Size = UDim2.fromOffset(size1200, var1.Size.Size_800),
                [React.Tag] = getTestIdTag(`{tbl1.testId}--content-action`)
            }, {
                Content = tbl1.contentAction
            })
        }
        tbl2.Header = createElement("Frame", tbl3, tbl4)
    else
        tbl2.Title = title
        tbl2.Metadata = metadata
    end

    return React.createElement("Frame", {
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        LayoutOrder = tbl1.LayoutOrder,
        Size = uDim2,
        [React.Change.AbsoluteSize] = tbl1.onAbsoluteSizeChanged,
        [React.Tag] = getTestIdTag(`{tbl1.testId}--content`)
    }, tbl2)
end)
