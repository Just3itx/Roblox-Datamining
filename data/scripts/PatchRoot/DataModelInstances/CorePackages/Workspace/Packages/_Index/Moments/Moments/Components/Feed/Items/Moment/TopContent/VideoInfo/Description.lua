-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:21:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local Foundation = require(MomentsParent.Foundation)
local React = require(MomentsParent.React)
local SignalsReact = require(MomentsParent.SignalsReact)

local FoundationText = Foundation.Text
local View = Foundation.View

local useTokens = Foundation.Hooks.useTokens
local useSignalBinding = SignalsReact.useSignalBinding

local MomentContext = require(script.Parent.Parent.Parent.MomentContext)
local getColorStyleWithTransparency = require(Moments.Utils.getColorStyleWithTransparency)

return React.memo(function(tbl1) -- name: Description
    local var1 = useTokens()
    local var2 = MomentContext.useMoment()

    local var3 = useSignalBinding(var2.store.getIsModerated)
    local animationRatio = var2.animationRatio

    local description = var2.store.getData(false).description
    if not description or description == "" then
        return nil
    end

    return React.createElement(View, {
        LayoutOrder = tbl1.LayoutOrder,
        tag = "size-full-0 auto-y",
        Visible = var3:map(function(bool1: boolean): boolean
            return not bool1
        end)
    }, {
        DescriptionText = React.createElement(FoundationText, {
            tag = "auto-xy text-body-large text-wrap text-align-x-left text-align-y-top text-truncate-split content-emphasis",
            Text = description,
            textStyle = animationRatio:map(function(num1: number)
                return getColorStyleWithTransparency(var1.Color.Content.Emphasis, num1)
            end)
        })
    })
end)
