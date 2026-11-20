-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T05:51:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local Dash = require(FoundationParent.Dash)
local React = require(FoundationParent.React)

local Logger = require(Foundation.Utility.Logger)

local Button = require(Foundation.Components.Button)
local Image = require(Foundation.Components.Image)
local Text = require(Foundation.Components.Text)
local _Types = require(Foundation.Components.Types)
local View = require(Foundation.Components.View)
local useCursor = require(Foundation.Providers.Cursor.useCursor)
local useScaledValue = require(Foundation.Utility.useScaledValue)
local useTokens = require(Foundation.Providers.Style.useTokens)
local withCommonProps = require(Foundation.Utility.withCommonProps)
local withDefaults = require(Foundation.Utility.withDefaults)

local _ButtonVariant = require(Foundation.Enums.ButtonVariant)
local FillBehavior = require(Foundation.Enums.FillBehavior)
local InputSize = require(Foundation.Enums.InputSize)

local tbl1 = { testId = "--foundation-toast" }

return React.memo(React.forwardRef(function(arg1, ref) -- name: Toast
    local var1 = withDefaults(arg1, tbl1)
    local var2 = useTokens()
    local selectionImageObject = useCursor({ radius = UDim.new(0, var2.Radius.Medium), offset = var2.Size.Size_200, borderWidth = var2.Stroke.Thicker })

    local actions = var1.actions
    local var4 = React.useMemo(function()
        local result = {}
        if actions then
            for k, action in actions do
                if k > 2 then
                    Logger:warning(`Toast only supports up to {2} actions`)
                    return result
                end

                local tbl2 = {
                    LayoutOrder = #actions - k,
                    size = InputSize.Medium,
                    fillBehavior = FillBehavior.Fill
                }
                local var4 = Dash.union(action, tbl2)
                result["ToastButton" .. k] = React.createElement(Button, var4)
            end
        end
        return result
    end, { actions })

    local var5 = var1.icon and var1.icon ~= ""
    local var6 = var1.title and var1.title ~= ""
    local var7 = var1.text and var1.text ~= ""

    local x = var1.width or UDim.new(0, useScaledValue(400))

    local createElement = React.createElement
    local var8 = View
    local var9 = withCommonProps(var1, {
        Size = UDim2.new(x, UDim.new()),
        Position = UDim2.fromScale(0.5, 0.1),
        selection = { Selectable = false, SelectionImageObject = selectionImageObject },
        tag = "row gap-small auto-y padding-medium radius-medium bg-over-media-0",
        ref = ref
    })
    local tbl2 = {
        Media = if var5 then React.createElement(
            Image,
            {
                LayoutOrder = 1,
                Image = var1.icon,
                tag = "size-1200-1200",
                testId = `{var1.testId}--media`
            }
        ) else nil,
        Content = React.createElement(View, {
            LayoutOrder = 2,
            tag = {
                ["fill self-center auto-y"] = true,
                ["col gap-xxsmall"] = var6 or var7
            },
            testId = `{var1.testId}--content`
        }, {
            Header = if var6 then React.createElement(Text, {
                LayoutOrder = 1,
                Text = var1.title,
                tag = "size-full-0 auto-y text-title-small text-align-x-left text-truncate-end content-emphasis",
                testId = `{var1.testId}--header`
            }) else nil,
            Body = if var7 then React.createElement(Text, {
                LayoutOrder = 2,
                Text = var1.text,
                tag = "size-full-0 auto-y text-body-small text-wrap text-align-x-left content-default",
                testId = `{var1.testId}--body`
            }) else nil,
            Actions = if actions and #actions > 0 then React.createElement(View, {
                LayoutOrder = 3,
                tag = {
                    ["row gap-small size-full-0 auto-y"] = true,
                    ["padding-top-small"] = var6 or var7
                },
                testId = `{var1.testId}--actions`
            }, var4) else nil
        })
    }
    return createElement(var8, var9, tbl2)
end))
