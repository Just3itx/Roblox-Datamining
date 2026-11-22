-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T08:21:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local scriptParentParent = script.Parent.Parent
local ReactRoblox = require(scriptParentParent.ReactRoblox)
local React = require(scriptParentParent.React)

local NotificationModalBase = require(script.Parent.Components.NotificationModalBase)

local root = nil
local tbl1 = {}

local function UpdateRoot(arg1) -- Luacid: Inlined by compiler; 3 call sites recovered
    if tbl1 and tbl1.ModalKey ~= arg1.ModalKey and tbl1.Params and tbl1.Params.CloseCallback then
        tbl1.Params.CloseCallback()
    end

    tbl1 = arg1
    root:render(React.createElement(NotificationModalBase, arg1))
end

local function CloseModal(modalKey: string) -- Luacid: Inlined by compiler; 1 call site recovered
    if root and modalKey == tbl1.ModalKey then
        UpdateRoot({})
    end
end

return {
    OpenModal = function(modalKey: string, component, params): boolean
        if not root then
            local notificationModals = Instance.new("Folder")
            notificationModals.Name = "NotificationModals"
            notificationModals.Parent = game:GetService("CoreGui")
            root = ReactRoblox.createRoot(notificationModals)
        end

        UpdateRoot({
            ModalKey = modalKey,
            Component = component,
            Params = params,
            CloseModal = function()
                CloseModal(modalKey)
            end
        })

        return true
    end,
    CloseModal = CloseModal
}
