-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:50:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local Cryo = require(CorePackages.Packages.Cryo)
local Foundation = require(CorePackages.Packages.Foundation)
local React = require(CorePackages.Packages.React)
local ReactRoblox = require(CorePackages.Packages.ReactRoblox)

local View = Foundation.View
local useStyleSheet = Foundation.Hooks.useStyleSheet

local function PortalWithFoundationStylelink(tbl1)
    local styleSheet = useStyleSheet()
    local var2 = Cryo.Dictionary.join({ StyleLink = React.createElement("StyleLink", { StyleSheet = styleSheet }) }, tbl1.children)

    return ReactRoblox.createPortal(React.createElement(View, { tag = "auto-xy" }, var2), tbl1.parent)
end

return PortalWithFoundationStylelink
