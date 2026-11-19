-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:21:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")

local Roact = require(CorePackages.Packages.Roact)

local RobloxGui = CoreGui:WaitForChild("RobloxGui")
local CaptureNotification = require(RobloxGui.Modules.CaptureNotification)
local shouldSaveScreenshotToAlbum = require(RobloxGui.Modules.shouldSaveScreenshotToAlbum)

local tbl1 = {}
tbl1.__index = tbl1

function tbl1.new()
    local result = {}
    setmetatable(result, tbl1)
    result.init = false
    result.captureEvent = Instance.new("BindableEvent")
    result.permissionEvent = Instance.new("BindableEvent")
    if shouldSaveScreenshotToAlbum() then
        result.captureNotification = Roact.createElement(CaptureNotification, { permissionEvent = result.permissionEvent })
    end

    return result
end

function tbl1:Start()
    if self.init then
        return
    end

    self.init = true
    if shouldSaveScreenshotToAlbum() then
        self.captureNotificationInstance = Roact.mount(self.captureNotification, CoreGui, "RobloxCaptureNotificationGui")
    end
end

local var1 = tbl1.new()

function tbl1:DismissNotification()
    if not self.init then
        var1:Start()
        return
    end

    if not shouldSaveScreenshotToAlbum() then
        return
    end

    Roact.update(
        self.captureNotificationInstance,
        Roact.createElement(CaptureNotification, {
            permissionEvent = self.permissionEvent,
            forceDismissToast = {
                onDismissed = function()
                    Roact.update(
                        self.captureNotificationInstance,
                        Roact.createElement(CaptureNotification, { permissionEvent = self.permissionEvent, forceDismissToast = nil })
                    )
                end
            }
        })
    )
end

function tbl1:ShowPermissionToast()
    if not self.init then
        var1:Start()
    end
    self.permissionEvent:Fire()
end

function tbl1:Capture()
    self:DismissNotification()
    self.captureEvent:Fire()
end

return var1
