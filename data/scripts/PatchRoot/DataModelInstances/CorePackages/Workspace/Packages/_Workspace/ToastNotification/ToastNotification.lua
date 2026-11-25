-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T19:31:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
return {
    dependencies = require(script.dependencies),
    ["jest.config"] = script["jest.config"],
    renderToastNotificationContainer = require(script.renderToastNotification),
    ToastNotificationWrapper = require(script.ToastNotificationWrapper),
    AppToastNotificationContainer = require(script.AppToastNotificationContainer),
    ToastNotificationSnoozeManager = require(script.ToastNotificationSnoozeManager),
    ToastNotificationTypeModule = require(script.type),
    LifecycleEvents = require(script.utils.LifecycleEvents),
    Signals = require(script.Signals),
    ToastNotificationConstants = require(script.constants),
    NotificationGroups = require(script.NotificationGroups)
}
