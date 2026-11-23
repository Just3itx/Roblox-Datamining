-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:31:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)

local CaptureGridItem = require(BuildExperience.Components.MediaSelectionPage.CaptureGridItem)

local Button = Foundation.Button
local FoundationText = Foundation.Text
local View = Foundation.View

local ButtonVariant = Foundation.Enums.ButtonVariant
local FillBehavior = Foundation.Enums.FillBehavior
local InputSize = Foundation.Enums.InputSize

local uDim2 = UDim2.new(0.25, -3, 0, 1)

local function renderTile(layoutOrder: number, content)
    return React.createElement(View, {
        LayoutOrder = layoutOrder,
        Size = uDim2,
        testId = `ChatCaptureGrid.Tile.{layoutOrder}`,
        aspectRatio = {
            AspectRatio = 1,
            AspectType = Enum.AspectType.ScaleWithParentSize,
            DominantAxis = Enum.DominantAxis.Width
        }
    }, { Content = content })
end

local function renderEmptyState(text: string) -- Luacid: Inlined by compiler; 1 call site recovered
    return React.createElement(
        FoundationText,
        {
            LayoutOrder = 1,
            Text = text,
            tag = "size-full-0 auto-y text-body-medium text-align-x-center content-muted"
        }
    )
end

return React.memo(function(tbl1) -- name: ChatCaptureGrid
    local var1, var2 = React.useState(function(): number
        return if tbl1.shouldProgressivelyLoad then 0 else #tbl1.captures
    end)
    local var3 = React.useRef(var1)

    React.useEffect(function()
        if tbl1.isLoading then
            var3.current = 0
            var2(0)
            return
        end
        if not tbl1.shouldProgressivelyLoad then
            var3.current = #tbl1.captures
            var2(#tbl1.captures)
            return
        end

        local bool1 = false
        task.spawn(function()
            task.wait(0.3)
            for current = var3.current + 1, #tbl1.captures do
                task.wait()
                if bool1 then
                    return
                end
                var3.current = current
                var2(current)
            end
        end)

        return function()
            bool1 = true
        end
    end, { tbl1.isLoading, tbl1.shouldProgressivelyLoad, #tbl1.captures })

    local tbl2 = ({})
    if tbl1.isLoading then
        for i = 1, 8 do
            local str1 = `Placeholder-{i}`
            local func1 = renderTile

            local createElement = React.createElement
            local var4 = View
            local tbl3 = {
                tag = "size-full radius-medium bg-shift-200",
                testId = `ChatCaptureGrid.Placeholder.{i}`
            }
            tbl2[str1] = func1(i, createElement(var4, tbl3))
        end
    else
        for value, capture in tbl1.captures do
            local str1 = `Capture-{value}`
            local func1 = renderTile

            local createElement = React.createElement
            local var4 = CaptureGridItem
            local tbl3 = {
                capture = capture,
                imageContentEnabled = value <= var1,
                isSelected = tbl1.isSelected(capture),
                onActivated = tbl1.onCaptureToggled,
                testId = `ChatCaptureGrid.Capture.{value}`
            }
            tbl2[str1] = func1(value, createElement(var4, tbl3))
        end
    end

    return React.createElement(View, { tag = "col gap-medium size-full-0 auto-y" }, {
        EmptyState = if #tbl1.captures == 0 and not tbl1.isLoading then renderEmptyState(tbl1.emptyText) else nil,
        Grid = if #tbl1.captures > 0 or tbl1.isLoading then React.createElement(
            View,
            { LayoutOrder = 1, tag = "row wrap gap-xsmall size-full-0 auto-y" },
            {
                Captures = React.createElement(React.Fragment, nil, tbl2)
            }
        ) else nil,
        ShowMore = if tbl1.isFinished or tbl1.isLoading then nil else React.createElement(Button, {
            LayoutOrder = 2,
            fillBehavior = FillBehavior.Fill,
            onActivated = tbl1.onShowMore,
            size = InputSize.Medium,
            text = tbl1.showMoreText,
            variant = ButtonVariant.Standard,
            testId = "ChatCaptureGrid.ShowMore"
        })
    })
end)
