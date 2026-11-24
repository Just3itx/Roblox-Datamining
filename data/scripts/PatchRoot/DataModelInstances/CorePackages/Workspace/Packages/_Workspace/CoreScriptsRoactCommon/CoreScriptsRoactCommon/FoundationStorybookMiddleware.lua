-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T01:30:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreScriptsRoactCommonParent = script:FindFirstAncestor("CoreScriptsRoactCommon").Parent

local Foundation = require(CoreScriptsRoactCommonParent.Foundation)
local React = require(CoreScriptsRoactCommonParent.React)
local ReactRoblox = require(CoreScriptsRoactCommonParent.ReactRoblox)

local FoundationProvider = Foundation.FoundationProvider

local tbl1 = {
    Default = Foundation.Enums.ColorMode.Dark,
    Light = Foundation.Enums.ColorMode.Light,
    Dark = Foundation.Enums.ColorMode.Dark
}

local tbl2 = { Default = "Desktop", Desktop = "Desktop", Console = "Console" }

local useStyleSheet = Foundation.Hooks.useStyleSheet

local function StyleLinkPortal(tbl3)
    if not (useStyleSheet() and tbl3.overlay) then
        return nil
    end

    return ReactRoblox.createPortal(nil, tbl3.overlay)
end

local function useCreateOverlay(tbl3)
    local var1 = React.useRef(Instance.new("Frame"))

    if var1.current.Parent ~= tbl3.focus then
        var1.current.Parent = tbl3.focus
    end

    React.useEffect(function()
        var1.current.Size = UDim2.fromScale(1, 1)
        var1.current.BackgroundTransparency = 1

        return function()
            var1.current:Destroy()
        end
    end, {})

    return var1.current
end

local function FoundationStorybookMiddleware(arg1)
    return function(tbl3)
        local current = useCreateOverlay(tbl3)
        local colorMode = tbl1[tbl3.theme]
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
                        colorMode = colorMode,
                        device = tbl2[tbl3.platform],
                        preferences = tbl3.settings,
                        scale = tbl3.settings and tbl3.settings.scale,
                        overlayGui = current
                    },
                    {
                        Child = React.createElement(arg1, tbl3),
                        StyleLink = React.createElement(StyleLinkPortal, { overlay = current })
                    }
                )
            }
        )
    end
end

return FoundationStorybookMiddleware
