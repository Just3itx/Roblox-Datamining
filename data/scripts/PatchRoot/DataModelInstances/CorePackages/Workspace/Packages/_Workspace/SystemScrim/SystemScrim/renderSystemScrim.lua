-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T18:40:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")

local SystemScrim = script:FindFirstAncestor("SystemScrim")
local SystemScrimParent = SystemScrim.Parent
local React = require(SystemScrimParent.React)
local ReactRoblox = require(SystemScrimParent.ReactRoblox)

local SystemScrim2 = require(SystemScrim.SystemScrim)
local SystemScrimSignalStore = require(SystemScrim["data-model"].SystemScrimSignalStore)

local function renderSystemScrim()
    local store = SystemScrimSignalStore(false)

    local systemScrim = Instance.new("ScreenGui")
    systemScrim.Name = "SystemScrim"
    systemScrim.DisplayOrder = -2147483648
    systemScrim.IgnoreGuiInset = true
    systemScrim.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    systemScrim.ClipToDeviceSafeArea = false
    systemScrim.ScreenInsets = Enum.ScreenInsets.None
    systemScrim.SafeAreaCompatibility = Enum.SafeAreaCompatibility.None
    systemScrim.Parent = CoreGui

    local element = React.createElement(SystemScrim2, { store = store })

    local root = ReactRoblox.createRoot(systemScrim)
    root:render(element)

    return { root = root, store = store }
end

return renderSystemScrim
