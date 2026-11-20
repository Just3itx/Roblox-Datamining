-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:51:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}
module.__index = module

function module.new()
    local bindableEvent = Instance.new("BindableEvent")

    local tbl1 = {
        broadcasts = {},
        NativeClose = {
            Connect = function(_, arg1): RBXScriptConnection
                return bindableEvent.Event:Connect(arg1)
            end
        },
        MenuIsOpen = false,
        openedMenus = {}
    }
    setmetatable(tbl1, { __index = module })

    return tbl1
end

function module:SetMenuIsOpen(arg1, arg2)
    if arg1 then
        table.insert(self.openedMenus, arg2)
    else
        local var1 = table.find(self.openedMenus, arg2)
        if var1 then
            table.remove(self.openedMenus, var1)
        end
    end

    self.MenuIsOpen = #self.openedMenus > 0
end

function module:BroadcastNotification(arg1, notification)
    table.insert(self.broadcasts, { data = arg1, notification = notification })
end

function module.GetNotificationTypeList(_)
    return { NATIVE_EXIT = 35, RESTART_APP = 41 }
end

return module
