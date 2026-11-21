-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:20:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatUIPrimitives = script:FindFirstAncestor("ChatUIPrimitives")

local ChatUIPrimitivesParent = ChatUIPrimitives.Parent
local React = require(ChatUIPrimitivesParent.React)
local ReactRoblox = require(ChatUIPrimitivesParent.ReactRoblox)
local Foundation = require(ChatUIPrimitivesParent.Foundation)

local FoundationProvider = Foundation.FoundationProvider
local useStyleSheet = Foundation.Hooks.useStyleSheet

local function StyleLinkPortal(tbl1)
    local styleSheet = useStyleSheet()
    return ReactRoblox.createPortal(React.createElement("StyleLink", { StyleSheet = styleSheet }), tbl1.overlay)
end

return {
    name = ChatUIPrimitives.Name,
    roact = React,
    reactRoblox = ReactRoblox,
    storyRoots = { ChatUIPrimitives },
    mapStory = function(arg1)
        return function(arg2)
            local var1 = React.useRef(Instance.new("Frame"))
            local focus = arg2 and arg2.focus
            if focus ~= nil and var1.current.Parent ~= focus then
                var1.current.Parent = focus
            end

            React.useLayoutEffect(function()
                var1.current.Size = UDim2.fromScale(1, 1)
                var1.current.BackgroundTransparency = 1
            end, {})

            return React.createElement(FoundationProvider, {
                colorMode = arg2 and arg2.theme,
                device = arg2 and arg2.platform,
                overlayGui = if focus == nil then nil else var1.current
            }, {
                Child = React.createElement(arg1, arg2),
                StyleLink = if focus == nil then nil else React.createElement(StyleLinkPortal, { overlay = var1.current })
            })
        end
    end
}
