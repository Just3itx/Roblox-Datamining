-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T21:20:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local CoreGui = game:GetService("CoreGui")

local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent

local React = require(scriptParentParent.React)
local ReactRoblox = require(scriptParentParent.ReactRoblox)
local Foundation = require(scriptParentParent.Foundation)

local _AccountSettingsPage = require(scriptParent.AccountSettingsPage)
local AccountSettingsQrDialog = require(scriptParent.AccountSettingsQrDialog)

local var1 = nil

local function hide() -- Luacid: Inlined by compiler; 2 call sites recovered
    local var2 = var1
    if not var2 then
        return
    end
    var1 = nil
    var2.root:unmount()
    var2.container:Destroy()
    if var2.onClosed then
        var2.onClosed()
    end
end

return {
    show = function(page, onClosed: ((...any) -> (...any))?)
        hide()
        local accountSettingsQrCode = Instance.new("Folder")
        accountSettingsQrCode.Name = "AccountSettingsQrCode"
        accountSettingsQrCode.Parent = CoreGui

        local root = ReactRoblox.createRoot(accountSettingsQrCode)
        local tbl1 = { root = root, container = accountSettingsQrCode, onClosed = onClosed }
        var1 = tbl1

        root:render(
            React.createElement(Foundation.FoundationProvider, {
                colorMode = Foundation.Enums.ColorMode.Dark
            }, {
                QrDialog = React.createElement(AccountSettingsQrDialog, {
                    page = page,
                    onClose = function()
                        task.defer(function()
                            if var1 == tbl1 then
                                hide()
                            end
                        end)
                    end
                })
            })
        )
    end,
    hide = hide
}
