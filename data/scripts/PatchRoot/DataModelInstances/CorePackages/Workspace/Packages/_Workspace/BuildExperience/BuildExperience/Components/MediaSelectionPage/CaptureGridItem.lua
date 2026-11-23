-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:00:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local React = require(BuildExperienceParent.React)
local Foundation = require(BuildExperienceParent.Foundation)

local Checkbox = Foundation.Checkbox
local View = Foundation.View

local useTokens = Foundation.Hooks.useTokens

local function getCaptureContent(capture): Content -- Luacid: Inlined by compiler; 1 call site recovered
    if typeof(capture) == "Object" then
        return Content.fromObject(capture)
    end
    return Content.none
end

return React.memo(function(tbl1) -- name: CaptureGridItem
    local var1 = useTokens()

    local var2 = React.useCallback(function()
        tbl1.onActivated(tbl1.capture)
    end, { tbl1.capture, tbl1.onActivated })

    local content = if tbl1.imageContentEnabled ~= false then getCaptureContent(tbl1.capture) else Content.none
    local createElement = React.createElement
    local str1 = "ImageButton"
    local tbl2 = {
        AutoButtonColor = false,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        Image = "",
        ImageContent = content,
        LayoutOrder = tbl1.LayoutOrder,
        ScaleType = Enum.ScaleType.Crop,
        Size = UDim2.fromScale(1, 1),
        [React.Event.Activated] = var2,
        [React.Tag] = if tbl1.testId == nil then "bg-shift-200" else `bg-shift-200 data-testid={tbl1.testId}`
    }
    local tbl3 = {
        Corner = React.createElement("UICorner", { CornerRadius = UDim.new(0, var1.Size.Size_200) }),
        SelectedStroke = if tbl1.isSelected then React.createElement("UIStroke", {
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
            BorderStrokePosition = Enum.BorderStrokePosition.Inner,
            Color = var1.Color.Content.Emphasis.Color3,
            Thickness = var1.Stroke.Thick
        }) else nil,
        SelectionOverlay = 0
    }
    local element

    if tbl1.isSelected then
        element = React.createElement(View, { tag = "size-full padding-small", ZIndex = 3 }, {
            SelectedIndicator = React.createElement(Checkbox, {
                AnchorPoint = Vector2.new(1, 0),
                isChecked = true,
                label = "",
                onActivated = function()
                    var2()
                end,
                Position = UDim2.fromScale(1, 0),
                size = Foundation.Enums.InputSize.Small
            })
        })
    else
        element = nil
    end

    tbl3.SelectionOverlay = element
    return createElement(str1, tbl2, tbl3)
end)
