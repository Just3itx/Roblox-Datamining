-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:11:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)

local FoundationText = Foundation.Text
local View = Foundation.View
local useTokens = Foundation.Hooks.useTokens

local function hasChildren(children) -- Luacid: Inlined by compiler; 1 call site recovered
    if children == nil then
        return false
    end
    if typeof(children) ~= "table" then
        return true
    end
    for _, child in children do
        if child ~= nil then
            return true
        end
    end
    return false
end

return React.memo(function(tbl1) -- name: SubagentStatus
    local var1 = useTokens()
    local testId = tbl1.testId or "subagent-status"
    local isDisabled = tbl1.isDisabled == true
    local bool2 = hasChildren(tbl1.children)
    local background = var1.Color.ActionStandard.Background
    local foreground = var1.Color.ActionStandard.Foreground

    local createElement = React.createElement
    local var2 = View
    local tbl2 = {
        LayoutOrder = tbl1.layoutOrder,
        backgroundStyle = background,
        cursor = {
            radius = UDim.new(0, var1.Radius.Circle),
            offset = var1.Size.Size_200,
            borderWidth = math.floor(var1.Stroke.Thicker)
        },
        GroupTransparency = if isDisabled then 0.5 else 0,
        isDisabled = isDisabled,
        onActivated = tbl1.onActivated,
        selection = {
            Selectable = not isDisabled
        },
        tag = "row align-x-center align-y-center size-0-800 auto-x radius-circle clip",
        testId = testId
    }
    local tbl3 = {
        Text = React.createElement(FoundationText, {
            LayoutOrder = 1,
            Text = tbl1.text,
            padding = {
                left = UDim.new(0, var1.Padding.Medium),
                right = if bool2 then nil else UDim.new(0, var1.Padding.Medium)
            },
            tag = "shrink size-0-full auto-x text-label-medium text-truncate-end",
            textStyle = foreground,
            testId = `{testId}-text`
        }),
        Trailing = if bool2 then React.createElement(View, {
            LayoutOrder = 2,
            tag = "row align-x-center align-y-center auto-xy padding-left-small padding-right-medium",
            testId = `{testId}-trailing`
        }, tbl1.children) else nil
    }
    return createElement(var2, tbl2, tbl3)
end)
