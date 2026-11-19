-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T08:50:54Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local Icon = require(Foundation.Components.Icon)
local Text = require(Foundation.Components.Text)
local View = require(Foundation.Components.View)

local _InputPlatform = require(Foundation.Enums.InputPlatform)

local keyDisplay = require(script.Parent.keyDisplay)
local _useShortcutVariants = require(script.Parent.useShortcutVariants)

local function KeyCap(tbl1)
    local variantProps = tbl1.variantProps
    local var1 = keyDisplay.resolveKey(tbl1.keyCode, tbl1.platform)
    if var1 == nil then
        return nil
    end

    if var1.kind == "GamepadIcon" then
        return React.createElement(
            View,
            {
                tag = variantProps.capless.tag,
                LayoutOrder = tbl1.LayoutOrder,
                testId = tbl1.testId
            },
            {
                Content = React.createElement(Icon, {
                    name = var1.icon,
                    size = variantProps.gamepadIcon.size,
                    style = variantProps.gamepadIcon.style,
                    testId = `{tbl1.testId}--icon`
                })
            }
        )
    end

    local bool1 = var1.kind == "Text" and (utf8.len(var1.text) or 0) > 1
    local createElement = React.createElement
    local var2 = View
    local tbl2 = {
        tag = variantProps.cap.tag,
        padding = bool1 and {
            left = UDim.new(0, variantProps.capWide.padding),
            right = UDim.new(0, variantProps.capWide.padding)
        }
            or nil,
        LayoutOrder = tbl1.LayoutOrder,
        testId = tbl1.testId
    }
    local tbl3 = { Content = 0 }
    local element

    if var1.kind == "Icon" then
        element = React.createElement(Icon, {
            name = var1.icon,
            size = variantProps.icon.size,
            style = variantProps.icon.style,
            testId = `{tbl1.testId}--icon`
        })
    else
        element = React.createElement(Text, { Text = var1.text, tag = variantProps.text.tag, testId = `{tbl1.testId}--text` })
    end

    tbl3.Content = element
    return createElement(var2, tbl2, tbl3)
end

return KeyCap
