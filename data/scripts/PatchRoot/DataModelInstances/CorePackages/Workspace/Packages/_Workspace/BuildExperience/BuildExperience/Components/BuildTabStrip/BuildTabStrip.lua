-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:30:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)

local FoundationText = Foundation.Text
local View = Foundation.View

local useTokens = Foundation.Hooks.useTokens

local function BuildTabStrip(tbl1)
    local var1 = useTokens()
    local testId = tbl1.testId or "BuildTabStrip"
    local onActivated = tbl1.onActivated

    local tabsLen = #tbl1.tabs
    local var2 = nil
    local tbl2 = ({})
    for layoutOrder, tab in tbl1.tabs do
        if tab.id == tbl1.activeTabId then
            var2 = layoutOrder - 1
        end
        local id = tab.id
        local str1 = tostring(id)
        local createElement = React.createElement
        local var3 = View
        local tbl3 = {
            LayoutOrder = layoutOrder,
            tag = "fill size-0-1000 auto-y",
            selection = {
                Selectable = tab.isDisabled ~= true
            },
            isDisabled = tab.isDisabled,
            onActivated = 0,
            testId = 0
        }

        function tbl3.onActivated()
            if onActivated ~= nil then
                onActivated(id)
            end
        end
        tbl3.testId = `{testId}.Tab.{id}`
        local tbl4 = { Text = 0 }
        local createElement2 = React.createElement
        local var4 = View

        local tbl5 = {
            Label = React.createElement(
                FoundationText,
                {
                    Text = tab.text,
                    tag = "position-center-center anchor-center-center auto-xy text-label-medium content-emphasis"
                }
            )
        }
        tbl4.Text = createElement2(var4, { tag = "size-full-full padding-x-medium padding-y-small" }, tbl5)
        tbl2[str1] = createElement(var3, tbl3, tbl4)
    end

    local createElement = React.createElement
    local var3 = View
    local tbl3 = {
        LayoutOrder = tbl1.LayoutOrder,
        tag = "size-full-0 auto-y",
        testId = testId
    }

    local tbl4 = {
        Divider = React.createElement(View, {
            Size = UDim2.new(1, 0, 0, var1.Stroke.Thick),
            tag = "position-bottom-left anchor-bottom-left",
            backgroundStyle = var1.Color.Stroke.Default,
            testId = `{testId}.Divider`
        }),
        Tabs = React.createElement(View, { ZIndex = 2, tag = "row size-full-0 auto-y" }, tbl2),
        Underline = React.createElement(View, {
            Visible = not (var2 == nil) and tabsLen > 0,
            Size = UDim2.new(1 / math.max(tabsLen, 1), 0, 0, var1.Stroke.Thick),
            Position = if tbl1.activeOffset then tbl1.activeOffset:map(function(num1: number): UDim2
                return UDim2.fromScale(num1 / math.max(tabsLen, 1), 1)
            end) else UDim2.fromScale((var2 or 0) / math.max(tabsLen, 1), 1),
            ZIndex = 3,
            tag = "anchor-bottom-left bg-system-contrast",
            testId = `{testId}.Underline`
        })
    }

    return createElement(var3, tbl3, tbl4)
end

return BuildTabStrip
