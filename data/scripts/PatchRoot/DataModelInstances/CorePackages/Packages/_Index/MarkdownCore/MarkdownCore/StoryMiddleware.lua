-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:40:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local Foundation = require(scriptParentParent.Foundation)

local React = require(scriptParentParent.React)

local FoundationProvider = Foundation.FoundationProvider
local Theme = Foundation.Enums.Theme
local Device = Foundation.Enums.Device

local function StoryMiddleware(arg1)
    return function(tbl1)
        local theme = Theme[tbl1.theme]
        return React.createElement(
            "Frame",
            {
                AutomaticSize = Enum.AutomaticSize.Y,
                Size = UDim2.fromScale(1, 0),
                BackgroundTransparency = 1
            },
            {
                UIPadding = React.createElement("UIPadding", {
                    PaddingTop = UDim.new(0, 10),
                    PaddingBottom = UDim.new(0, 10),
                    PaddingLeft = UDim.new(0, 10),
                    PaddingRight = UDim.new(0, 10)
                }),
                FoundationContext = React.createElement(
                    FoundationProvider,
                    {
                        theme = theme,
                        device = Device[tbl1.platform],
                        preferences = tbl1.settings
                    },
                    {
                        Child = React.createElement(arg1, tbl1)
                    }
                )
            }
        )
    end
end

return StoryMiddleware
