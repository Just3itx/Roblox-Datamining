-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T14:50:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local RobloxSubscriptionPurchaseApp = script:FindFirstAncestor("RobloxSubscriptionPurchaseApp")
local RobloxSubscriptionPurchaseAppParent = RobloxSubscriptionPurchaseApp.Parent

local React = require(RobloxSubscriptionPurchaseAppParent.React)
local ReactRoblox = require(RobloxSubscriptionPurchaseAppParent.ReactRoblox)

local RobloxSubscriptionHeadlessListenerHost = require(RobloxSubscriptionPurchaseApp.Components.RobloxSubscriptionHeadlessListenerHost)
local RobloxSubscriptionStore = require(RobloxSubscriptionPurchaseApp.Store.RobloxSubscriptionStore)

local var1 = nil

return {
    render = function()
        local var2 = RobloxSubscriptionStore.get()
        var2.triggerUnmountUI()

        local robloxSubscriptionPurchaseHeadlessOverlay = Instance.new("Folder")
        robloxSubscriptionPurchaseHeadlessOverlay.Name = "RobloxSubscriptionPurchaseHeadlessOverlay"
        robloxSubscriptionPurchaseHeadlessOverlay.Parent = game:GetService("CoreGui")

        local root = ReactRoblox.createRoot(robloxSubscriptionPurchaseHeadlessOverlay)
        root:render(React.createElement(RobloxSubscriptionHeadlessListenerHost))

        local function cleanup()
            root:unmount()
            robloxSubscriptionPurchaseHeadlessOverlay:Destroy()
        end

        var1 = cleanup
        var2.setOnUnmountUI(cleanup)

        return cleanup
    end,
    close = function()
        if var1 then
            var1()
            var1 = nil
        end
    end
}
